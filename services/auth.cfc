<cfcomponent output="false">
   <cffunction name="testlogin" returntype="struct" >
      <cfargument name="user_id">
      <cfargument name="password">

      <cfset local.result.validlogin = false>
      <cfquery name="local.qcheck">
         SELECT admin_flag, user_id
         FROM users
         WHERE user_id =<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user_id#">
         AND user_password =<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(arguments.password)#">
      </cfquery>
      <cfif local.qcheck.recordcount>
         <cfset local.result.validlogin = true >
         <cfset local.result.admin_flag = local.qcheck.admin_flag>
         <cfset local.result.user_id = local.qcheck.user_id>
      </cfif>
      <cfreturn local.result>
   </cffunction>
</cfcomponent>