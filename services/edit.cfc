<cfcomponent>
   <cffunction name="validateEmployee" returntype="struct" hint="I validate employee records">
      <!--- arguments match calling function --->
      <cfset local.result.error = arrayNew(1)>
      <cfset local.result.errormessage = arrayNew(1)>
      <cfset local.result.valid = true>
      <cfset local.mandatoryList = 'first_name,last_name,ctry_id'>
      <cfset local.alphaList = 'first_name,last_name,job_title'>
      <cfset local.numericList = 'phone_number,mobile_number,extension_number'>
      <cfset local.startWithZeroList = ''>
      <cfloop collection="#arguments#" item="local.item">
         <cfif NOT stripInvalidChars(arguments[local.item]) EQ arguments[local.item]>
            <cfset local.result.valid = false>
            <cfset arrayappend(local.result.error,local.item)>
            <cfset arrayappend(local.result.errormessage,local.item & " contains invalid characters ( ! & $ ## % < > \ / are not permitted)")>
         </cfif>
         <cfif listFindNoCase(local.mandatoryList,local.item)>
            <!--- mandatory so check len --->
            <cfif NOT(len(arguments[local.item]))>
	            <cfset local.result.valid = false>
               <cfset arrayappend(local.result.error,local.item)>
               <cfset arrayappend(local.result.errormessage,local.item & " is mandatory")>
            </cfif>
         <cfelse>
            <!--- not mandatory so only validate if length --->
            <cfif len(arguments[local.item])>
               <cfif local.item EQ 'email_address' AND NOT(isValid('email',arguments[local.item]))>
                  <cfset local.result.valid = false>
                  <cfset arrayappend(local.result.error,local.item)>
                  <cfset arrayappend(local.result.errormessage,local.item & " must be a valid email address")>
               </cfif>
               <cfif listFindNoCase(local.numericList,local.item) AND NOT(isNumeric(reReplace(arguments[local.item],"[\s]","","ALL")))>
                  <cfset local.result.valid = false>
                  <cfset arrayappend(local.result.error,local.item)>
                  <cfset arrayappend(local.result.errormessage,local.item & " must be numeric")>
               </cfif>
               <cfif listFindNoCase(local.startWithZeroList,local.item) AND NOT(left(arguments[local.item],1) EQ "0")>
                  <cfset local.result.valid = false>
                  <cfset arrayappend(local.result.error,local.item)>
                  <cfset arrayappend(local.result.errormessage,local.item & " must start with a zero")>
               </cfif>
            </cfif>
         </cfif>
      </cfloop>
      <cfreturn local.result>
   </cffunction>


   <cffunction name="edit" returntype="query">
      <cfargument name="emp_id" type="numeric" default="0">

      <cfinvoke component="search" method="showdetail" emp_id="#arguments.emp_id#" fav="0" returnvariable="local.entries"> 

      <!--- TODO: validate no bad characters in the argument 
      <cfquery name="local.entries">
         SELECT e.emp_id,e.last_name,e.first_name,e.job_title, e.job_role, e.expertise, e.extension_number,e.phone_number,
                e.mobile_number,e.email_address,e.skype_id, e.ctry_id, c.ctry_name, e.site_id, s.site_name,
                e.desk_location_id, d.desk_location_name, e.company_id, com.company_name, e.division_id, div.division_name, e.dept_id,dep.dept_name,
                e.report_to_emp_id, report_to.first_name+' '+report_to.last_name AS report_to, e.status, e.status_change_date
         FROM employee e
         LEFT JOIN employee report_to ON (e.report_to_emp_id = report_to.emp_id)
         LEFT JOIN ctry_lookup c ON (e.ctry_id = c.ctry_id)
         LEFT JOIN site_lookup s ON (e.site_id = s.site_id)
         LEFT JOIN desk_location_lookup d ON (e.desk_location_id = d.desk_location_id)
         LEFT JOIN division_lookup div ON (e.division_id = div.division_id)
         LEFT JOIN company_lookup com ON (e.company_id = com.company_id)
         LEFT JOIN dept_lookup dep ON (e.dept_id = dep.dept_id)
         WHERE e.emp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.emp_id#">
      </cfquery>--->
      <cfreturn local.entries>

   </cffunction>

   <cffunction name="save" returntype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.error = arrayNew(1)>
      <cfset local.result.olddata = duplicate(arguments)>
      <cfset local.result.success = true>
      <!--- check the hash value to ensure save has been called legally --->

      <cfset local.checkHash = hash(arguments.emp_id & month(now()) & session.cftoken)>
      <cfif structkeyExists(arguments,"emp_id") AND arguments.emp_id GT 0>
         <cfset local.result.mode = 'edit'>
      <cfelse>
         <cfset local.result.mode = 'insert'>
      </cfif>

      <cfif arguments.entry_check EQ local.checkHash>
         <cfset local.validArguments = validateEmployee(argumentCollection=arguments)>
         <cfif local.validArguments.valid>

		      <cfif local.result.mode EQ 'edit'>
		         <!--- then update --->
		         <cfquery name="qUpdate" >
			         UPDATE employee
			         SET
                        first_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.first_name#">,
				            last_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.last_name#">,
				            job_title  = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.job_title#">,
				            <cfif ISNUMERIC(arguments.report_to_emp_id)>
                          report_to_emp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.report_to_emp_id#">,
                        <cfelse>
                          report_to_emp_id = <cfqueryparam cfsqltype="cf_sql_integer" null="true">,
                        </cfif>
                        <cfif ISNUMERIC(arguments.division_id)>division_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.division_id#">,</cfif>
                        <!--- <cfif ISNUMERIC(arguments.company_id)>company_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.company_id#">,</cfif> --->
                        <cfif ISNUMERIC(arguments.dept_id)>
                          dept_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dept_id#">,
                        <cfelse>
                          dept_id = <cfqueryparam cfsqltype="cf_sql_integer" null="true">,
                        </cfif>
                        job_role = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.job_role#">,
                        expertise = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.expertise#">,
					         email_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email_address#">,
					         phone_number = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone_number#">,
					         extension_number = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.extension_number#">,
					         mobile_number = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mobile_number#">,
					         skype_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.skype_id#">,
					         <cfif ISNUMERIC(arguments.ctry_id)>ctry_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ctry_id#">,</cfif>
					         <cfif ISNUMERIC(arguments.site_id)>site_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.site_id#">,</cfif>
					         <cfif ISNUMERIC(arguments.desk_location_id)>desk_location_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.desk_location_id#">,</cfif>
                        <cfif arguments.status EQ 'Y'>
                           status = <cfqueryparam cfsqltype="cf_sql_varchar" value="Y">,
                           status_change_date  = getdate(),                           
                        <cfelse>
                           status = <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                           status_change_date  = <cfqueryparam cfsqltype="cf_sql_datetime" null="true">,                           
                        </cfif> 
                        updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.updated_by#">,
                        updated_date  = getdate()
			         WHERE emp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.emp_id#">
		         </cfquery>
               <!--- need to process the array of company_id --->
               
               <!--- delete existing company set and then inster new ones --->
               <cfquery name="deleteCompanies">
                  delete from employee_company where emp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.emp_id#">
               </cfquery>
               <cfif len(arguments.company_id)>   
                  <!--- loop through the comma delimited list of company_id s submitted and insert into separate table --->
                  <cfloop list="#arguments.company_id#" index="thisCompanyId">
                     <cfif IsNumeric(thisCompanyId)>
                        <cfquery name="insertCompanies">
                           insert INTO employee_company (
                              emp_id,
                              company_id
                           ) VALUES (
                              <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.emp_id#">,
                              <cfqueryparam cfsqltype="cf_sql_integer" value="#trim(thisCompanyId)#">
                           )
                        </cfquery>                     
                     </cfif>
                  </cfloop>
               </cfif>



		      <cfelse>
		         <cfquery name="qInsert" result="local.qresult" >
	              INSERT INTO employee
				           (
				            first_name
				           ,last_name
				           ,job_title
				           <cfif ISNUMERIC(arguments.report_to_emp_id)>,report_to_emp_id</cfif>
				           ,job_role
                       ,expertise
				           ,email_address
				           ,phone_number
				           ,extension_number
				           ,mobile_number
				           ,skype_id
				           <cfif ISNUMERIC(arguments.ctry_id)>,ctry_id</cfif>
				           <cfif ISNUMERIC(arguments.division_id)>,division_id</cfif>
				           <cfif ISNUMERIC(arguments.dept_id)>,dept_id</cfif>
				           <cfif ISNUMERIC(arguments.site_id)>,site_id</cfif>
				           <cfif ISNUMERIC(arguments.desk_location_id)>,desk_location_id</cfif>
				           ,user_id
				           ,created_by
				           ,created_date )
				     VALUES
				           (
				            <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.first_name#">
				           ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.last_name#">
				           ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.job_title#">
				            <cfif ISNUMERIC(arguments.report_to_emp_id)>,<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.report_to_emp_id#"></cfif>
                       ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.job_role#">
                       ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.expertise#">
				           ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email_address#">
				           ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone_number#">
				           ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.extension_number#">
				           ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mobile_number#">
				           ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.skype_id#">
				           <cfif ISNUMERIC(arguments.ctry_id)>,<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ctry_id#"></cfif>
				           <cfif ISNUMERIC(arguments.division_id)>,<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.division_id#"></cfif>
				           <cfif ISNUMERIC(arguments.dept_id)>,<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dept_id#"></cfif>
				           <cfif ISNUMERIC(arguments.site_id)>,<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.site_id#"></cfif>
				           <cfif ISNUMERIC(arguments.desk_location_id)>,<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.desk_location_id#"></cfif>
				           ,0
				           ,0
				           ,getdate())
	            </cfquery>
	            <cfset local.result.new_emp_id = local.qresult.identitycol>
                              <!--- need to process the array of company_id, --->
               <cfif len(arguments.company_id)>
                  <!--- loop through the comma delimited list of company_id s submitted and insert into separate table --->
                  <cfloop list="#arguments.company_id#" index="thisCompanyId">
                     <cfif IsNumeric(thisCompanyId)>
                        <cfquery name="insertCompanies">
                           insert INTO employee_company (
                              emp_id,
                              company_id
                           ) VALUES (
                              <cfqueryparam cfsqltype="cf_sql_integer" value="#local.result.new_emp_id#">,
                              <cfqueryparam cfsqltype="cf_sql_integer" value="#trim(thisCompanyId)#">
                           )
                        </cfquery>                     
                     </cfif>
                  </cfloop>
               </cfif>
            </cfif>
         <cfelse> <!--- not valid --->
            <cfset local.result.error = duplicate(local.validArguments.error)>
            <cfset local.result.errormessage = duplicate(local.validArguments.errormessage)>
            <cfset local.result.success = false>

         </cfif>

      <cfelse>
         <cfset arrayAppend(local.result.error,"Data tampered with")>
         <cfset local.result.errormessage = duplicate(local.result.error)>
         <cfset local.result.success = false>

      </cfif>


      <cfreturn local.result>

   </cffunction>
   <cffunction name="delete" returnetype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.error = "">
      <cfset local.result.success = true>
      <!--- check the hash value to ensure save has been called legally --->

      <cfif structkeyExists(arguments,"emp_id")>
         <!--- then update --->
         <cfquery name="qDelete">
            DELETE employee
            WHERE emp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.emp_id#">
         </cfquery>

      </cfif>




      <cfreturn local.result>

   </cffunction>


   <cffunction name="processPhoto" access="remote" output="false" returntype="struct" hint="I return image as binary data" >

      <!--- check for empty file? --->

      <cffile
         action="upload"
         destination="ram:///"
         nameconflict="overwrite"
         accept="image/*,image/jpeg,image/gif,image/png"
         filefield="fileField"
         result = "local.upload">

      <cfset local.results.filedetails = local.upload>
      <cfset local.cfeffects = createObject("component","cfimageEffects").init()>
      <cfset local.tempImagePath = expandPath('/tempImagepath')>
      <cfset local.tempImageName = createUUID() & '.' & local.upload.serverfileext>
      <cfset local.tempImage = local.tempImagePath & '/' & local.tempImageName>


      <cfset local.thisphoto = imageRead("ram:///#local.upload.serverfile#")>
      <cfset fileDelete("ram:///#local.upload.serverfile#")>
      <cfset imageWrite(local.thisphoto,local.tempImage)>
      <cfset local.results.newImage = local.tempImageName>
      <cfset local.results.newImageExt = local.upload.serverfileext>

      <cfreturn local.results>

   </cffunction>

   <cffunction name="cropPhoto" access="remote" returntype="string" hint="i crop an image and write out a new temp image" returnformat="plain">
      <cfargument name="inputImage" type="string" >
      <cfargument name="imageExt" type="string">
      <cfargument name="x" type="numeric" hint="i am the x coordinate of the top left of the crop area">
      <cfargument name="y" type="numeric" hint="i am the y coordinate of the top left of the crop area">
      <cfargument name="width" type="numeric" hint="i am the width of the crop area">
      <cfargument name="height" type="numeric" hint="i am the height of the crop area">



      <cfset local.tempImagePath = expandPath('/tempImagepath')>
      <cfif structKeyExists(arguments,"oldimage")>
         <cftry>
            <cfset fileDelete(local.tempImagePath & '/' & arguments.oldimage)>
         <cfcatch></cfcatch>
         </cftry>
      </cfif>

      <cfset local.tempImageName = createUUID() & '.' & arguments.imageExt>
      <cfset local.tempOutImage = tempImagePath &'/'& tempImageName>
      <cfset local.inputImage = local.tempImagePath &'/'&arguments.inputImage>
      <cfset local.outputImage = imageRead(local.inputImage)>

      <cfset imageCrop(local.outputImage,arguments.x,arguments.y,arguments.width,arguments.height)>
      <cfset imageResize(local.outputImage,"",150)>
      <cfset imageWrite(local.outputImage,local.tempOutImage)>

      <cfreturn local.tempImageName>

   </cffunction>
   <cffunction name="savePhoto" access="remote" returntype="void" hint="I save the cropped photo to the database">
      <cfargument name="emp_id">
      <cfargument name="imageName">
      <cfargument name="inputImage">

      <cfset local.tempImagePath = expandPath('/tempImagepath')>

      <cfset local.inputImage = local.tempImagePath &'/'&arguments.imageName>
      <cfset local.outputImage = imageRead(local.inputImage)>
      <cfquery name="local.results.qupd" >
         update employee
         set photo_image = <cfqueryparam cfsqltype="cf_sql_blob" value="#imageGetBlob(local.outputImage)#">
         ,updated_date = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
         where emp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.emp_id#">
      </cfquery>

		<cftry>
         <cfset fileDelete(local.tempImagePath & '/' & arguments.imageName)>
         <cfset fileDelete(local.tempImagePath & '/' & arguments.inputImage)>
		<cfcatch></cfcatch>
		</cftry>

   </cffunction>

   <cffunction name="stripInvalidChars" returntype="string" output="No" access="public" hint="I strip invalid characters from strings to prevent XSS attacks">
      <cfargument name="sInput"         type="String"  required="true"/>

      <cfreturn REReplaceNoCase(arguments.sInput,"[\!&\$##%<>\\/;]","","ALL")/>
   </cffunction>


</cfcomponent>
