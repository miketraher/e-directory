<br />
<cfsetting showdebugoutput="false">
<cfoutput>
<a href="?#framework.action#=admin.menu"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
</cfoutput>
<!--- need to setup a list of companies as header --->
<cfquery name="variables.companyNames">
  select company_id, company_name
  from company_lookup
  order by company_name
</cfquery>

<cfset variables.companyNameList = valueList(variables.companyNames.company_name)>
<cfset variables.companyIdList = valueList(variables.companyNames.company_id)>




   <cfset variables.summaryreportfilename = gettickcount()&'.csv'>
   <cffile action="write" addnewline="true" file="ram:///#variables.summaryreportfilename#" output="ctry_name,site_name,desk_location_name,division_name,dept_name,first_name,last_name,extension_number,phone_number,mobile_number,skype_id,email_address,job_title,job_role,expertise,report_to,emp_count,status,status_change_date,#variables.companyNameList#">
<cfloop query="rc.data">
  <!--- now addin a Y or N in company columns --->

  <cfquery name="getMyCompany">
    DECLARE @empCompanyListStr varchar(max);

    select @empCompanyListStr = COALESCE(@empCompanyListStr+',','') + CASE WHEN ec.company_id IS NULL THEN 'N' ELSE 'Y' END
    from company_lookup AS cl left JOIN employee_company AS ec ON cl.company_id = ec.company_id 
    AND ec.emp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#rc.data.emp_id#">
    order by cl.company_name;

    select @empCompanyListStr as companies;
  </cfquery>

   <cfset variables.csv_record =
                       REReplace(rc.data.ctry_name,","," ","all") & ',' &
                       REReplace(rc.data.site_name,","," ","all") & ',' &
                       REReplace(rc.data.desk_location_name,","," ","all") & ',' &
                       REReplace(rc.data.division_name,","," ","all") & ',' &
                       REReplace(rc.data.dept_name,","," ","all") & ',' &
                       REReplace(rc.data.first_name,","," ","all") & ',' &
  		                 REReplace(rc.data.last_name,","," ","all") & ',' &
                       REReplace(rc.data.extension_number,","," ","all") & ',' &
                       REReplace(rc.data.phone_number,","," ","all") & ',' &
                       REReplace(rc.data.mobile_number,","," ","all") & ',' &
                       REReplace(rc.data.skype_id,","," ","all") & ',' &
                       REReplace(rc.data.email_address,","," ","all") & ',' &
                       REReplace(rc.data.job_title,","," ","all") & ',' &
                       REReplace(rc.data.job_role,"[^[:alnum:]]"," ","all") & ',' &
                       REReplace(rc.data.expertise,"[^[:alnum:]]"," ","all") & ',' &
                       REReplace(rc.data.report_to,","," ","all") & ',' &
                       REReplace(rc.data.emp_count,","," ","all") & ',' &
                       REReplace(rc.data.status,","," ","all") & ',' &
                       dateformat(ReplaceNoCase(rc.data.status_change_date,","," ","all"),"dd-mmm-yyyy") & ',' & 
                       getMyCompany.companies >


   <cffile action="append" addnewline="true" file="ram:///#variables.summaryreportfilename#" output="#variables.csv_record#">
</cfloop>
<cfoutput><a href="?#framework.action#=admin.downloadcsv&filename=#variables.summaryreportfilename#">Download CSV version</a></cfoutput>


