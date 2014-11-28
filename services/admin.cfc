<cfcomponent output="false">
   <cffunction name="summaryReport" returntype="query" output="false">

      <cfquery name="local.qSummaryReport">
         SELECT ctry.ctry_name, s.site_name, desk.desk_location_name, c.company_name, COUNT(*) as emp_count, emp_id =0
			FROM employee e
			LEFT JOIN ctry_lookup ctry ON (ctry.ctry_id = e.ctry_id)
			LEFT JOIN site_lookup s ON (s.site_id = e.site_id)
			LEFT JOIN desk_location_lookup desk ON (desk.desk_location_id = e.desk_location_id)
			LEFT JOIN company_lookup c ON (c.company_id = e.company_id)
			GROUP BY ctry.ctry_name, s.site_name, desk.desk_location_name, c.company_name
			ORDER BY ctry.ctry_name, s.site_name, desk.desk_location_name, c.company_name
      </cfquery>

      <cfreturn local.qSummaryReport>
   </cffunction>
   <cffunction name="dataDump" returntype="query" output="false" hint="selects all employee data with decoded id values (using view)">

      <cfquery name="local.qdataDump">
			SELECT last_name, first_name,ctry_name, site_name, desk_location_name,
                division_name, dept_name,
				    extension_number, phone_number, mobile_number,
					 skype_id,email_address,job_title, job_role, expertise, report_to, 1 as emp_count, emp_id, status, status_change_date
         FROM [Full Employee Details]
         ORDER BY ctry_name, site_name, division_name, dept_name
      </cfquery>

      <cfreturn local.qdataDump>
   </cffunction>


</cfcomponent>