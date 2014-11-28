<cfcomponent>
   <cffunction name="showusers" returntype="query">

      <!--- TODO: validate no bad characters in the argument --->
      <cfquery name="local.entries">
         SELECT user_id, user_password, last_login_date, failed_login_attempts, isnull( admin_flag, 0) as admin_flag, 0 as emp_id
         FROM users
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="edit" returntype="query">
      <cfargument name="user_id">

      <cfquery name="local.entries">
         SELECT user_id, user_password, last_login_date, failed_login_attempts, isnull( admin_flag, 0) as admin_flag, 0 as emp_id
         FROM users
         WHERE user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user_id#">
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="save" returntype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.message = "">
      <cfset local.result.success = true>
      <!--- return mode so we know where to redirect to --->
      <cfset local.result.mode = arguments.mode>
      <!--- check the hash value to ensure save has been called legally --->
      <cfswitch expression="#arguments.mode#">
         <cfcase value="edit">
            <cfset local.checkvalue = arguments.user_id & month(now()) & session.cftoken>
         </cfcase>
         <cfcase value="insert">
            <cfset local.checkvalue = month(now()) & session.cftoken>
         </cfcase>
      </cfswitch>
      <cfset local.checkHash = hash(local.checkvalue)>
      <cfif arguments.entry_check EQ local.checkHash>
         <cfif not structkeyexists(arguments,"user_password")>
            <cfset local.result.message = "password is mandatory">
         <cfelse>
            <cfif len(arguments.user_password) LT 6>
               <cfset local.result.message = "password must be at least 6 characters long and contain letters and numbers">
            <cfelse>
               <cfif not (refindnocase("[A-Za-z]",arguments.user_password) AND refindnocase("[0-9]",arguments.user_password))>
                  <cfset local.result.message = "*password must be at least 6 characters long and contain letters and numbers #refindnocase("[A-Za-z]",arguments.user_password)#, #refindnocase("[0-9]",arguments.user_password)#">
               <cfelse>
                  <cfif arguments.user_password NEQ arguments.user_password_confirm>
                     <cfset local.result.message = "passwords do not match">
                  </cfif>
               </cfif>
            </cfif>
         </cfif>

         <cfif local.result.message EQ "">
	         <cfquery name="local.qcheck">
	            select 1 from users where user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user_id#">
	         </cfquery>
		      <cfif local.qcheck.recordcount>
		         <!--- then update --->
		         <cfquery name="qUpdate" >
			         UPDATE users
			         SET   <cfif NOT structkeyexists(arguments,"skip_password")>
                           user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(arguments.user_password)#">,
                        </cfif>
                        <cfif structKeyExists(arguments,"admin_flag")>
                           admin_flag = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
                        <cfelse>
                           admin_flag = <cfqueryparam cfsqltype="cf_sql_bit" value="0">
                        </cfif>
			         WHERE user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user_id#">
		         </cfquery>


		      <cfelse>
		        <cfquery name="qInsert" result="local.qresult" >
	              INSERT INTO users
				           (
				            user_id
				            ,user_password
	                     ,admin_flag
				           )
				     VALUES
				           (
				            <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user_id#">
				           ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(arguments.user_password)#">
				           ,<cfif structKeyExists(arguments,"admin_flag")>1<cfelse>0</cfif>
	                    )
	            </cfquery>
		      </cfif>
         </cfif>
      <cfelse>
         <cfset local.result.message = "Data tampered with">
         <cfset local.result.success = false>

      </cfif>


      <cfreturn local.result>

   </cffunction>
   <cffunction name="delete" returnetype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.error = "">
      <cfset local.result.success = true>
      <!--- check the hash value to ensure save has been called legally --->

      <cfif structkeyExists(arguments,"user_id")>
         <!--- then update --->
         <cfquery name="qDelete">
            DELETE users
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.user_id#">
         </cfquery>

      </cfif>




      <cfreturn local.result>

   </cffunction>


</cfcomponent>
