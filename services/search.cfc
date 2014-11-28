<cfcomponent>

   <cffunction access="remote" name="suggestEmployee" returntype="struct" returnformat="JSON">
      <cfargument name="term" type="string" hint="what the user has enetered so far">

      <cfset local.result.success = false>

      <cfquery name="local.result.entries">
         SELECT e.emp_id as [value], e.first_name + ' ' + e.last_name as [label]
         FROM employee e
         WHERE LOWER('~' + rtrim(e.last_name)+'~'+rtrim(e.first_name)) LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%~#lcase(arguments.term)#%">
      </cfquery>

      <cfif local.result.entries.recordcount>
         <cfset local.result.success = true>
      </cfif>

      <cfreturn local.result>

   </cffunction>
   <cffunction access="remote" name="suggestCtry" returntype="struct" returnformat="JSON">
      <cfargument name="term" type="string" hint="what the user has entered so far">

      <cfset local.result.success = false>

      <cfquery name="local.result.entries">
         SELECT c.ctry_id as [value], c.ctry_name as [label]
         FROM ctry_lookup c
         WHERE c.ctry_name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.term#%">
         ORDER BY c.ctry_name
      </cfquery>

      <cfif local.result.entries.recordcount>
         <cfset local.result.success = true>
      </cfif>

      <cfreturn local.result>

   </cffunction>
   <cffunction access="remote" name="suggestSite" returntype="struct" returnformat="JSON">
      <cfargument name="term" type="string" hint="what the user has entered so far">
      <cfargument name="ctry_id" type="numeric">

      <cfset local.result.success = false>

      <cfquery name="local.result.entries">
         SELECT s.site_id as [value], s.site_name as [label]
         FROM site_lookup s
         WHERE s.site_name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.term#%">
         AND s.ctry_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ctry_id#">
         ORDER BY s.site_name
      </cfquery>

      <cfif local.result.entries.recordcount>
         <cfset local.result.success = true>
      </cfif>

      <cfreturn local.result>

   </cffunction>
   <cffunction access="remote" name="suggestSiteSearch" returntype="struct" returnformat="JSON">
      <cfargument name="term" type="string" hint="what the user has entered so far">

      <cfset local.result.success = false>

      <cfquery name="local.result.entries">
         SELECT s.site_id as [value], s.site_name as [label]
         FROM site_lookup s
         WHERE s.site_name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.term#%">
         ORDER BY s.site_name
      </cfquery>

      <cfif local.result.entries.recordcount>
         <cfset local.result.success = true>
      </cfif>

      <cfreturn local.result>

   </cffunction>
   <cffunction access="remote" name="suggestDesk" returntype="struct" returnformat="JSON">
      <cfargument name="term" type="string" hint="what the user has entered so far">
      <cfargument name="site_id" type="numeric">

      <cfset local.result.success = false>

      <cfquery name="local.result.entries">
         SELECT d.desk_location_id as [value], d.desk_location_name as [label]
         FROM desk_location_lookup d
         WHERE d.desk_location_name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.term#%">
         AND d.site_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.site_id#">
      </cfquery>

      <cfif local.result.entries.recordcount>
         <cfset local.result.success = true>
      </cfif>

      <cfreturn local.result>

   </cffunction>
   <cffunction access="remote" name="suggestDivision" returntype="struct" returnformat="JSON">
      <cfargument name="term" type="string" hint="what the user has entered so far">
      <cfargument name="site_id" type="numeric">

      <cfset local.result.success = false>

      <cfquery name="local.result.entries">
         SELECT d.division_id as [value], d.division_name as [label]
         FROM division_lookup d
         WHERE d.division_name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.term#%">
         ORDER BY d.order_to_show
      </cfquery>

      <cfif local.result.entries.recordcount>
         <cfset local.result.success = true>
      </cfif>

      <cfreturn local.result>

   </cffunction>
   <cffunction access="remote" name="suggestCompany" returnformat="JSON">
      <cfargument name="term" type="string" hint="what the user has entered so far">

      <cfset local.result.success = false>

      <cfquery name="local.result.entries">
         SELECT c.company_id as id, c.company_name as name
         FROM company_lookup c
         WHERE c.company_name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.term#%">
         ORDER BY c.company_name
      </cfquery>

      <cfif local.result.entries.recordcount>
         <cfset local.result.success = true>
      </cfif>

      <cfreturn local.result>

   </cffunction>
   <cffunction name="queryToArray" returntype="array" access="private">
      <cfargument name="q" type="query">
      <cfset local.s = []>
      <cfset local.cols = arguments.q.columnList>
      <cfset var colsLen = listLen(local.cols)>
      <cfset var recordCount = arguments.q.recordCount>
      <cfloop from="1" to="#recordCount#" index="local.i">
         <cfset local.row = {}>
         <cfloop from="1" to="#colslen#" index="local.k">
            <cfset local.row[lcase(listGetAt(local.cols, local.k))] = q[listGetAt(cols, k)][i]>
         </cfloop>
         <cfset arrayAppend(local.s, local.row)>
      </cfloop>
 
      <cfreturn s>

   </cffunction>


   <cffunction access="remote" name="suggestDept" returntype="struct" returnformat="JSON">
      <cfargument name="term" type="string" hint="what the user has entered so far">

      <cfset local.result.success = false>

      <cfquery name="local.result.entries">
         SELECT d.dept_id as [value], d.dept_name as [label]
         FROM dept_lookup d
         WHERE d.dept_name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.term#%">
         ORDER BY d.dept_name
      </cfquery>

      <cfif local.result.entries.recordcount>
         <cfset local.result.success = true>
      </cfif>

      <cfreturn local.result>

   </cffunction>

   <cffunction access="remote" name="getEmpCountByCtry" returntype="Numeric" returnformat="JSON">
      <cfargument name="ctry_id">

      <cfquery name="local.q">
         select count(*) empinctry
         from employee
         where ctry_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ctry_id#">
      </cfquery>

      <cfreturn local.q.empinctry>
   </cffunction>

   <cffunction access="remote" name="getEmpCountBySite" returntype="Numeric" returnformat="JSON">
      <cfargument name="site_id">

      <cfquery name="local.q">
         select count(*) empinsite
         from employee
         where site_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.site_id#">
      </cfquery>

      <cfreturn local.q.empinsite>
   </cffunction>
   <cffunction access="remote" name="getEmpCountByDesk" returntype="Numeric" returnformat="JSON">
      <cfargument name="desk_location_id">

      <cfquery name="local.q">
         select count(*) empindesk
         from employee
         where desk_location_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.desk_location_id#">
      </cfquery>

      <cfreturn local.q.empindesk>
   </cffunction>

   <cffunction name="resultsSummary" returntype="query">

      <cfquery name="local.entries">
         SELECT e.emp_id,e.last_name,e.first_name,e.first_name + ' ' + e.last_name AS name,
         e.extension_number,e.phone_number,e.mobile_number, s.site_name, c.ctry_dialing_code, c.ctry_id , e.job_title
         FROM employee e
         LEFT JOIN ctry_lookup c ON (e.ctry_id = c.ctry_id)
         LEFT JOIN site_lookup s ON (e.site_id = s.site_id)
         WHERE 1 = 1

         <cfif structKeyExists(arguments,"startletter") and len(arguments.startletter)>
         AND ((e.first_name+' '+e.last_name) LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.startletter#%"> OR
              (e.last_name+' '+e.first_name) LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.startletter#%">)
         </cfif>
         <cfif arguments.ctry_id>
         AND e.ctry_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ctry_id#" >
         </cfif>
         <cfif arguments.site_id>
         AND e.site_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.site_id#" >
         </cfif>
         <cfif arguments.desk_location_id>
         AND e.desk_location_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.desk_location_id#" >
         </cfif>
         <cfif arguments.company_id>
         AND EXISTS (SELECT 1 
                     FROM employee_company ec 
                     WHERE ec.emp_id = e.emp_id 
                     AND ec.company_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.company_id#" >)
         </cfif>
         <cfif arguments.dept_id>
         AND e.dept_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dept_id#" >
         </cfif>
         <cfif structkeyexists(arguments,"joiners") AND arguments.joiners>
         AND e.created_date > DATEADD(DAY,-30,GETDATE())
         </cfif>
         <cfif structkeyexists(arguments,"favs") AND LEN(arguments.favs)>
         AND e.emp_id in (<cfqueryparam cfsqltype="cf_sql_integer" list="true" value="#arguments.favs#">)
         </cfif>
         ORDER BY
         <cfif structkeyexists(arguments,"joiners") AND arguments.joiners>
         s.site_name,
         </cfif>
         e.last_name, e.first_name
      </cfquery>
      <cfreturn local.entries>

   </cffunction>

   <cffunction name="showDetail" returntype="query">
      <cfargument name="emp_id" type="numeric">
      <cfargument name="fav" type="numeric" default="0">

      <!--- TODO: validate no bad characters in the argument --->
      <cfquery name="local.entries">
         select e.emp_id,e.last_name,e.first_name,e.job_title,e.job_role, e.expertise,
                e.extension_number,e.phone_number,e.mobile_number,e.email_address,e.skype_id,
                c.ctry_name, c.ctry_dialing_code, e.ctry_id,
                d.division_name, e.division_id,
                cast('' as varchar( 1000 )) as companiesList, cast ('' as varchar( 1000)) as company_id,
                dept.dept_name,  e.dept_id,
                s.site_name, e.site_id,
                desk.desk_location_name, e.desk_location_id,
                report_to.first_name+' '+report_to.last_name as report_to,
                e.report_to_emp_id,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.fav#"> as fav,
                e.status
         from employee e
         LEFT JOIN ctry_lookup c ON (e.ctry_id = c.ctry_id)
         LEFT JOIN division_lookup d ON (e.division_id = d.division_id)
         LEFT JOIN dept_lookup dept ON (e.dept_id = dept.dept_id)
         LEFT JOIN site_lookup s ON (e.site_id = s.site_id)
         LEFT JOIN desk_location_lookup desk ON (e.desk_location_id = desk.desk_location_id)
         LEFT JOIN employee report_to ON (e.report_to_emp_id = report_to.emp_id)
         WHERE e.emp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.emp_id#">
      </cfquery>

      <!--- need to populate the multiple company names from the employee_company table --->

      <cfquery name="getemployeeCompanies">
         SELECT cl.company_name+':'+cast(ec.company_id as varchar(4)) as company, ec.company_id
         FROM employee_company ec
         JOIN company_lookup cl ON ec.company_id = cl.company_id
         WHERE ec.emp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.emp_id#">
         order by cl.company_name
      </cfquery>

      <cfset local.companiesList = "">
      <cfset local.companyIdList = "">
      <cfloop query="getemployeeCompanies">
         <cfset local.companiesList = listAppend(local.companiesList, getemployeeCompanies.company)>
         <cfset local.companyIdList = listAppend(local.companyIdList, trim(getemployeeCompanies.company_id))>
      </cfloop>
      <cfset local.companiesList = local.companiesList & ", ">
      <cfset local.companyIdList = local.companyIdList & ", ">
      
      <cfset local.entries.companiesList[1] = local.companiesList>
      <cfset local.entries.company_id[1] = local.companyIdList>
      
      <cfreturn local.entries>

   </cffunction>

   <cffunction name="getPhoto" access="remote" output="true" returntype="string" hint="I return the html for a photo" returnformat="plain">
      <cfargument name="emp_id" type="numeric">

      <cfquery name="local.getPhoto">
         select photo_image from employee
         where emp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.emp_id#">
      </cfquery>
      <cfset local.imagepath = expandPath('/imagepath')>

      <cfif local.getPhoto.recordcount AND isBinary(local.Getphoto.photo_image)>
         <cfcontent reset="true" type="image/jpeg,image/png" variable="#local.Getphoto.photo_image#" />
      <cfelse>
         <cfcontent file="#local.imagepath#\default.png" />
      </cfif>
   </cffunction>

</cfcomponent>
