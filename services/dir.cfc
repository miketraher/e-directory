<cfcomponent output="false">

   <cffunction name="init" access="public" returntype="dir" description="I set up initial values and return a dir object" output="false">
      <cfargument name="dsn" type="any" default="dir">

      <cfset this.dsn = arguments.dsn>
      <cfreturn this>
   </cffunction>

   <cffunction name="setCurrentEntry" hint="I set the current entryID in session scope" returntype="void" access="remote">
      <cfargument name="entryID" type="numeric" default="0">

      <cfset session.entryID = arguments.entryID>

   </cffunction>

	<cffunction name="logout" hint="I logout of admin mode" output="false" access="remote" returntype="void">
      <cfset session.admin = false>

   </cffunction>

	<cffunction name="findEntry" hint="I search for entries" output="false" access="remote" returntype="string" returnformat="plain">
		<cfargument name='startletter' required="false" hint="I hold the first few letters of the first_name or last_name"/>
		<cfargument name='office_id' required="false" default="0">
		<cfargument name='company_id' required="false" default="0">

      <cfset var l = structNew()>

      <cfset l.valid = true>
      <cfset arguments.startletter = trim(arguments.startletter)>
		<cfif refindnocase("[^a-zA-Z]+",arguments.startletter)>
		   <cfset l.valid = false>
		</cfif>
		<cfif structKeyExists(arguments,"office_id") AND (NOT isNumeric(arguments.office_id))>
		   <cfset l.valid = false>
		</cfif>
		<cfif  structKeyExists(arguments,"company_id") AND (NOT isNumeric(arguments.company_id))>
		   <cfset l.valid = false>
		</cfif>

      <cfif l.valid>
         <cfset l.result.log = "valid params">

          <cfquery name="l.getNames" datasource="#this.dsn#" result="l.theQuery">
		      SELECT
		      d.EntryId, d.last_name, d.first_name, d.EmailAddress, d.extension_number, d.phone_number,
	         d.mobile_number, d.DepartmentName, o.Office_name, d.skype_id, c.company_name,
	          d.position, d.office_id, d.company_id
		      FROM employee d
	         JOIN office_location o
	           ON (d.office_id = o.office_id)
	         JOIN company c
	           ON (d.company_id = c.company_id)
		      WHERE 1=1
	         <cfif structkeyexists(arguments,"startletter") AND len(arguments.startletter)>
	            AND lower(concat('~',rtrim(d.last_name),'~',rtrim(d.first_name))) like '%~#lcase(arguments.startletter)#%'
	         </cfif>
	         <cfif structkeyexists(arguments,"office_id") AND arguments.office_id GTE 0>
	            AND d.office_id = <cfqueryparam cfsqltype="cf_sql_smallint" value="#arguments.office_id#">
	         </cfif>
	         <cfif structkeyexists(arguments,"company_id") AND arguments.company_id GTE 0>
	            AND d.company_id = <cfqueryparam cfsqltype="cf_sql_smallint" value="#arguments.company_id#">
	         </cfif>
		      ORDER BY d.last_name
	      </cfquery>


         <cfif l.getNames.recordcount>
            <cfset l.result.success = true>
            <cfset l.result.names = l.getNames>

         <cfelse>

            <cfset l.result.success = false>
         </cfif>
      <cfelse>
         <cfset l.result.success = false>

      </cfif>

      <!--- got some sort of results now so call processEntries --->

      <cfset l.HTMLtodisplay = processEntries(l.result)>

      <cfreturn l.HTMLtodisplay>
   </cffunction>

   <cffunction name="getPhoto" access="remote" output="true" returntype="string" hint="I return the html for a photo" returnformat="plain">
      <cfargument name="emp_id" type="numeric">
      <cfset l = structNew()>

      <cfquery name="l.getPhoto" datasource="#this.dsn#">
         select photo_image from employee
         where emp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.emp_id#">
      </cfquery>

      <cfcontent reset="true" type="image/jpeg" variable="#l.Getphoto.photo#" />
   </cffunction>

   <cffunction name="updatePhoto" access="remote" output="false" returntype="string" hint="I return the html for a photo" returnformat="plain">
      <cfargument name="Entryid" type="numeric">
      <cfargument name="imageFile" type="string">
      <cfset l = structNew()>

      <cfset cfeffects = createObject("component","model.cfimageEffects").init()>

		<cfset thisphoto = imageRead("#arguments.imageFile#")>
		<cfset imageResize(thisphoto,"",200)>
	   <cfset dropImage = cfeffects.applyDropShadowEffect(thisphoto,'ffffff','333333',10,10)>
	   <cfset imageWrite(dropImage,"ram:///tempImage.jpg")>

	   <cfset thisNew = imageRead("ram:///tempImage.jpg")>
	   <cfset imageResize(thisNew,116,150)>

      <cfif arguments.entryID>
         <!--- update --->
         <cfquery name="qupd" datasource="directory_local">
            update directory_photo
            set photo_image = <cfqueryparam cfsqltype="cf_sql_blob" value="#imageGetBlob(thisNew)#">
            where entryid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.entryid#">
         </cfquery>
      <cfelse>
         <!--- insert orphan photo  --->
		   <cfquery name="qins" datasource="directory_local">
		      insert directory_photo
	         (entryid, photo_image)
	         values
	         ( <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.entryid#">
	          ,<cfqueryparam cfsqltype="cf_sql_blob" value="#imageGetBlob(thisNew)#">
	         )
		   </cfquery>
	      <cfquery name="qgetid" datasource="directory_local">
	         SELECT LAST_INSERT_ID() as photoid;
	      </cfquery>

	      <cfset session.last_photoid = qgetid.photoid>

      </cfif>

   </cffunction>

   <cffunction name="processEntries" output="false" returntype="string" hint="I construct the html to display 1 entry">
      <cfargument name="entries" type="struct">
      <cfset l = structNew()>
      <cfset l.HTML = "">

      <!--- if success then we have entries to loop over --->
      <cfif arguments.entries.success>
         <cfoutput>
         <cfloop query="arguments.entries.names">
            <cfsavecontent variable="l.thisEntry">
            <div class="entryBox">
		         <div class="leftCol">
		            <ul>
		               <li>First Name</li>
		               <li>Last Name</li>
		               <li>Office Location</li>
		               <li>Company</li>
		               <li>Position</li>
		               <li>DDI Number</li>
		               <li>extension_number</li>
		               <li>Mobile</li>
		               <li>Skype</li>
		               <li>Email</li>
		            </ul>
		         </div>
		         <form id="form#entryid#" action="" method="post">
               <input type="hidden" id="entryid" name="entryid" value="#entryid#">
		         <div class="rightCol">
		            <ul>
		               <li>&nbsp;<input id="first_name" name="first_name" value="#first_name#" disabled="disabled"></li>
		               <li>&nbsp;<input id="last_name" name="last_name" value="#last_name#" disabled="disabled"></li>
		               <li><select class="results_select" name="office_id" id="office_id" disabled="disabled">
							         <cfloop query="application.qgetoffices">
						               <cfif application.qgetoffices.office_id EQ arguments.entries.names.office_id>
						                  <cfset l.selected = "selected">
						               <cfelse>
						                  <cfset l.selected = "">
						               </cfif>
							            <option value="#application.qgetoffices.office_id#" #l.selected#>#application.qgetoffices.office_name#</option>
							         </cfloop>
							      </select>
                     </li>
		               <li><select class="results_select" name="company_id" id="company_id" disabled="disabled">
	         <option value="-99" selected>--Any Company</option>
	         <cfloop query="application.qgetcompany">
               <cfif application.qgetcompany.company_id EQ arguments.entries.names.company_id>
                  <cfset l.selected = "selected">
               <cfelse>
                  <cfset l.selected = "">
               </cfif>
	            <option value="#application.qgetcompany.company_id#" #l.selected#>#application.qgetcompany.company_name#</option>
	         </cfloop>
	      </select>
                     </li>
		              <!---  <li>&nbsp;<input id="DEPARTMENTNAME" name="departmentName" value="#departmentName#" disabled="disabled"></li> --->
		               <li>&nbsp;<input id="POSITION" name="Position" value="#Position#" disabled="disabled"></li>
		               <li>&nbsp;<input id="phone_number" name="phone_number" value="#phone_number#" disabled="disabled"></li>
		               <li>&nbsp;<input id="extension_number" name="extension_number" value="#extension_number#" disabled="disabled"></li>
		               <li>&nbsp;<input id="mobile_number" name="mobile_number" value="#mobile_number#" disabled="disabled"></li>
		               <li>&nbsp;<input id="skype_id" name="skype_id" value="#skype_id#" disabled="disabled"></li>
		               <li>&nbsp;<input id="EMAILADDRESS" name="EmailAddress" value="#EmailAddress#" disabled="disabled"></li>
		            </ul>
		         </div>
		         <div class="photo">
					   <img src="/model/dir.cfc?method=getPhoto&id=#entryid#">
                  <cfif structKeyExists(session,"admin") AND session.admin>
		            <div id="photoEdit" value="#entryid#">EDIT PHOTO</div>
		            </cfif>
               </div>
               <cfif structKeyExists(session,"admin") AND session.admin>
		         <div class="controls" id="edit">
		            <button class="edit" value="#entryid#" >edit</button><br />
		            <button class="delete" value="#entryid#" >delete</button><br />
		            <button class="save" value="#entryid#" >save</button><br />
		            <button class="reset" value="#entryid#" >reset</button>
		         </div>
               </cfif>
		         </form>
		      </div>
            </cfsavecontent>

            <cfset l.HTML &= l.thisEntry >
         </cfloop>
         </cfoutput>
      <cfelse>
      <!--- no entries so return NOT FOUND html --->
         <cfsavecontent variable="l.HTML">
            <p>No one of that name found</p>
         </cfsavecontent>

      </cfif>

      <cfreturn l.HTML>

   </cffunction>





   <cffunction name="deleteEntry">
      <cfargument name="id" type="numeric">
      <cfset l = structNew()>

      <cfquery name="l.insertdel" datasource="#this.dsn#">
         insert into deleted_entry
         select * from employee
         where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
      </cfquery>

      <cfquery name="l.del" datasource="#this.dsn#">
         delete from employee
         where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
      </cfquery>

   </cffunction>

	<cffunction name="saveEntry" access="remote" hint="I insert or update a dir entry" output="false" returntype="struct" returnformat="json">
		<cfargument name='last_name' required="true" />
		<cfargument name='first_name' required="true" />
		<cfargument name='extension_number' required="false" />
		<cfargument name='phone_number' required="true">
		<cfargument name='mobile_number' required="false">
		<cfargument name='emailaddress' required="true">
		<cfargument name='skype_id' required="false">
		<cfargument name='office_id' required="true">
		<cfargument name='company_id' required="true">
		<cfargument name='position' required="false">

		<cfset var l = structNew()>

      <cfset l.result = validateEntry(argumentCollection = arguments)>
      <cfif l.result.valid>
         <!--- entry valid so check if insert or update --->
	      <cfquery name="l.check" datasource="#this.dsn#">
	         select 1 from employee
	         where entryid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.entryid#">
	      </cfquery>
	      <cfif l.check.recordcount>
	         <!--- update --->
   	      <cfquery name="l.upd" datasource="#this.dsn#">
					UPDATE employee
					SET
					last_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.last_name#">,
					first_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.first_name#">,
					extension_number = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.extension_number#">,
					phone_number = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone_number#">,
					mobile_number = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mobile_number#">,
					emailaddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.emailaddress#">,
					skype_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.skype_id#">,
					office_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.office_id#">,
					company_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.company_id#">,
					position = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.position#">
					WHERE entryid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.entryid#">
         	</cfquery>
	      <cfelse>
	         <!--- insert --->
   	      <cfquery name="l.ins" datasource="#this.dsn#">
			      INSERT INTO employee
					( 'last_name'
					 ,'first_name'
					 ,'extension_number'
					 ,'phone_number'
					 ,'mobile_number'
					 ,'emailaddress'
					 ,'skype_id'
					 ,'office_id'
					 ,'company_id'
					 ,'position')
					VALUES
					('<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.last_name#">',
					 '<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.first_name#">',
					 '<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.extension_number#">',
					 '<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone_number#">',
					 '<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mobile_number#">',
					 '<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.emailaddress#">',
					 '<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.skype_id#">',
					 '<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.office_id#">',
					 '<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company_id#">',
					 '<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.position#">'
                )
         	</cfquery>

         	<!--- TODO: get the just inserted entryID --->

         	<!--- TODO: update the photo with the entryID --->



	      </cfif>
      <cfelse>
         <!--- entry invalid so returns errors for display --->
         <cfreturn l.result>
      </cfif>
      <cfreturn l.result>

	</cffunction>

   <cffunction name="getEmptyForm" access="remote" output="false" returntype="string" returnformat="plain"
               hint="I return an empty form for the add new function">
      <cfset var l = structNew()>
      <cfoutput>
      <cfsavecontent variable="l.theForm">
            <div class="entryBox">
		         <div class="leftCol">
		            <ul>
		               <li>Office Location</li>
		               <li>Company</li>
		               <li>Position</li>
		               <li>Last Name</li>
		               <li>First Name</li>
		               <li>DDI Number</li>
		               <li>extension_number</li>
		               <li>Mobile</li>
		               <li>Skype</li>
		               <li>Email</li>
		            </ul>
		         </div>
		         <form id="formnew" action="" method="post">
		         <div class="rightCol">
		            <ul>
		               <li>&nbsp;<select name="office_id" id="office_id">
							         <cfloop query="application.qgetoffices">
							            <option value="#application.qgetoffices.office_id#">#application.qgetoffices.office_name#</option>
							         </cfloop>
							      </select>
                     </li>
		               <li>&nbsp;	      <select name="company_id" id="company_id">
	         <option value="-99" selected>--Any Company</option>
	         <cfloop query="application.qgetcompany">

	            <option value="#application.qgetcompany.company_id#">#application.qgetcompany.company_name#</option>
	         </cfloop>
	      </select>
                     </li>
		              <!---  <li>&nbsp;<input id="DEPARTMENTNAME" name="departmentName" value="#departmentName#"></li> --->
		               <li>&nbsp;<input id="POSITION" name="Position" value=""></li>
		               <li>&nbsp;<input id="last_name" name="last_name" value=""></li>
		               <li>&nbsp;<input id="first_name" name="first_name" value=""></li>
		               <li>&nbsp;<input id="phone_number" name="phone_number" value=""></li>
		               <li>&nbsp;<input id="extension_number" name="extension_number" value=""></li>
		               <li>&nbsp;<input id="mobile_number" name="mobile_number" value=""></li>
		               <li>&nbsp;<input id="skype_id" name="skype_id" value=""></li>
		               <li>&nbsp;<input id="EMAILADDRESS" name="EmailAddress" value=""></li>
		            </ul>
		         </div>
		         <div class="photo">
					   <img src="/images/unknown.jpg">
                  <div id="photoEdit">EDIT PHOTO</div>
		         </div>
		         <div class="controls">
		            <button class="save" value="new" >save</button><br />
		         </div>
		         </form>
		      </div>
        </cfsavecontent>
        </cfoutput>
      <cfreturn l.theForm>

   </cffunction>

   <cffunction name="validateEntry" returntype="struct" hint="I validate an argument structure that it is a valid entry" output="false">
		<cfargument name='last_name' required="true" />
		<cfargument name='first_name' required="true" />
		<cfargument name='extension_number' required="false" />
		<cfargument name='phone_number' required="true">
		<cfargument name='mobile_number' required="false">
		<cfargument name='emailaddress' required="true">
		<cfargument name='skype_id' required="false">
		<cfargument name='office_id' required="true">
		<cfargument name='company_id' required="true">
		<cfargument name='position' required="false">

      <cfset var l = structNew()>
      <cfset l.result = structNew()>
      <cfset l.result.valid = true>
      <cfset l.result.errors = arrayNew(1)>
      <cfset l.mandatoryCols = "last_name,first_name,phone_number,emailAddress,office_id,company_id">
      <cfloop collection="#arguments#" item="l.col">
         <cfif listFindNoCase(l.mandatoryCols,l.col)>
            <cfset l.mandatoryCols = listDeleteAt(l.mandatoryCols,listFindNoCase(l.mandatoryCols,l.col))>
         </cfif>
      </cfloop>
      <cfif listLen(l.mandatoryCols)>
         <!--- any columns left are missing from arguments --->
         <cfset l.result.valid = false>
         <cfset l.result.wibble = "a">
         <cfset arrayAppend(l.result.errors,"The following items must be supplied "&l.mandatoryCols&" but are missing")>
      </cfif>


      <cfloop collection="#arguments#" item="l.col">
         <cfswitch expression="#l.col#">
            <cfcase value="office_id,company_id">
               <cfif not isNumeric(arguments[l.col])>
                  <cfset l.result.valid = false>
                  <cfset l.result.wibble = "b">
                  <cfset arrayAppend(l.result.errors,l.col&" must be numeric")>
               </cfif>
            </cfcase>
            <cfcase value="last_name,first_name,skype_id">
               <cfif len(arguments[l.col]) GT 100>
                  <cfset l.result.valid = false>
                  <cfset l.result.wibble = "c">
                  <cfset arrayAppend(l.result.errors,l.col&" must be no more than 100 characters")>
               </cfif>
            </cfcase>
            <cfcase value="mobile_number,phone_number">
               <cfif len(arguments[l.col]) GT 25>
                  <cfset l.result.valid = false>
                  <cfset l.result.wibble = "d">
                  <cfset arrayAppend(l.result.errors,l.col&" must be no more than 25 characters")>
               </cfif>
            </cfcase>
            <cfcase value="extension_number,entryid">
               <cfif not isNumeric(arguments[l.col]) or (arguments[l.col] GT 9999 or arguments[l.col] LT 0)>
                  <cfset l.result.valid = false>
                  <cfset l.result.wibble = "e">
                  <cfset arrayAppend(l.result.errors,l.col&" must be numeric is the range 0 - 9999")>
               </cfif>
            </cfcase>
            <cfcase value="emailaddress">
               <cfif len(arguments[l.col]) GT 150 or not isValid('email',arguments[l.col])>
                  <cfset l.result.valid = false>
                  <cfset l.result.wibble = "f">
                  <cfset arrayAppend(l.result.errors,l.col&" is not a valid email address")>
               </cfif>
            </cfcase>
            <cfcase value="position">
               <cfif len(arguments[l.col]) GT 150 >
                  <cfset l.result.valid = false>
                  <cfset l.result.wibble = "g">
                  <cfset arrayAppend(l.result.errors,l.col&" must be no more than 150 characters")>
               </cfif>
            </cfcase>
            <cfcase value="office,company">
               <!--- ignore --->
            </cfcase>
            <cfdefaultcase>
	            <cfset l.result.valid = false>
               <cfset l.result.wibble = "h"&l.col&"hhh">
	            <cfset arrayAppend(l.result.errors,l.col&" is an unexpected column")>
            </cfdefaultcase>
         </cfswitch>
      </cfloop>

      <cfreturn l.result>

   </cffunction>
</cfcomponent>