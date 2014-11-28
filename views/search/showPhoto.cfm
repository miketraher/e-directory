   <cfquery name="qgetphoto" datasource="directory_local">
      select photo
      from employee
      where entryid = <cfqueryparam cfsqltype="cf_sql_integer" value="#rc.emp_id#">
   </cfquery>

   <cfcontent reset="true" type="image/jpeg" variable="#qGetphoto.photo#" />