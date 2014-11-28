
<cfspreadsheet action="read" src="#expandPath('data.xls')#" sheetname="data" query="qdata" headerrow="1" rows="2-9999" columns="2,3,5,7,8,9,11,13,15,16,17,18,19,20"/>





<cfquery datasource="dir_sqlserver">
   delete from employee where last_name != 'Meeting Room'
</cfquery>

<cfloop query="qdata">
   <cfquery datasource="dir_sqlserver" result="qresult">
              INSERT INTO employee
                    (
                     first_name
                    ,last_name
                    ,email_address
                    ,phone_number
                    ,extension_number
                    ,mobile_number
                    ,skype_id
                    <cfif ISNUMERIC(qdata.ctry_id)>,ctry_id</cfif>
                    <cfif ISNUMERIC(qdata.division_id)>,division_id</cfif>
                    <cfif ISNUMERIC(qdata.company_id)>,company_id</cfif>
                    <cfif ISNUMERIC(qdata.dept_id)>,dept_id</cfif>
                    <cfif ISNUMERIC(qdata.site_id)>,site_id</cfif>
                    <cfif ISNUMERIC(qdata.desk_location_id)>,desk_location_id</cfif>
                    ,user_id
                    ,created_by
                    ,created_date )
              VALUES
                    (
                     <cfqueryparam cfsqltype="cf_sql_varchar" value="#qdata.first_name#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#qdata.last_name#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#qdata.email_address#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#qdata.phone_number#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#qdata.extension_number#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#qdata.mobile_number#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#qdata.skype_id#">
                    <cfif ISNUMERIC(qdata.ctry_id)>,<cfqueryparam cfsqltype="cf_sql_integer" value="#qdata.ctry_id#"></cfif>
                    <cfif ISNUMERIC(qdata.division_id)>,<cfqueryparam cfsqltype="cf_sql_integer" value="#qdata.division_id#"></cfif>
                    <cfif ISNUMERIC(qdata.company_id)>,<cfqueryparam cfsqltype="cf_sql_integer" value="#qdata.company_id#"></cfif>
                    <cfif ISNUMERIC(qdata.dept_id)>,<cfqueryparam cfsqltype="cf_sql_integer" value="#qdata.dept_id#"></cfif>
                    <cfif ISNUMERIC(qdata.site_id)>,<cfqueryparam cfsqltype="cf_sql_integer" value="#qdata.site_id#"></cfif>
                    <cfif ISNUMERIC(qdata.desk_location_id)>,<cfqueryparam cfsqltype="cf_sql_integer" value="#qdata.desk_location_id#"></cfif>
                    ,0
                    ,0
                    ,getdate())
   </cfquery>
</cfloop>


