<cfcomponent hint="I am the service cfc for maintaining the lookup tables">



<!--- ctry lookup methods --->
   <cffunction name="showctry" returntype="query" hint="I get all countries to show in a summary">

      <!--- TODO: validate no bad characters in the argument --->
      <cfquery name="local.entries">
         SELECT ctry_id, ctry_name, ctry_dialing_code, 0 as emp_id
         FROM ctry_lookup
         ORDER BY ctry_name
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="editctry" returntype="query">
      <cfargument name="ctry_id">

      <cfquery name="local.entries">
         SELECT ctry_id, ctry_name, ctry_dialing_code, 0 as emp_id
         FROM ctry_lookup
         WHERE ctry_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ctry_id#">
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="savectry" returntype="struct">
      <cfargument name="ctry_id" default="-1">
      <!---  will get form as arguments --->
      <cfset local.result.message = "">
      <cfset local.result.success = true>
      <!--- return mode so we know where to redirect to --->
      <cfset local.result.mode = arguments.mode>
      <!--- check the hash value to ensure save has been called legally --->
      <cfswitch expression="#arguments.mode#">
         <cfcase value="edit">
            <cfset local.checkvalue = arguments.ctry_id & month(now()) & session.cftoken>
         </cfcase>
         <cfcase value="insert">
            <cfset local.checkvalue = month(now()) & session.cftoken>
         </cfcase>
      </cfswitch>
      <cfset local.checkHash = hash(local.checkvalue)>
      <cfif arguments.entry_check EQ local.checkHash>
         <cfif not structkeyexists(arguments,"ctry_name")>
            <cfset local.result.message = "country name is mandatory">
         </cfif>

         <cfif local.result.message EQ "">
            <cfquery name="local.qcheck">
               select 1 from ctry_lookup where ctry_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ctry_id#">
            </cfquery>
            <cfif local.qcheck.recordcount>
               <!--- then update --->
               <cfquery name="qUpdate" >
                  UPDATE ctry_lookup
                  SET   ctry_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ctry_name#">
                        ,ctry_dialing_code = <cfqueryparam cfsqltype="cf_sql_char" value="#arguments.ctry_dialing_code#">
                  WHERE ctry_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ctry_id#">
               </cfquery>


            <cfelse>
              <cfquery name="qInsert" result="local.qresult" >
                 INSERT INTO ctry_lookup
                       (
                         ctry_name
                        ,ctry_dialing_code
                       )
                 VALUES
                       (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ctry_name#">
                       ,<cfqueryparam cfsqltype="cf_sql_char" value="#arguments.ctry_dialing_code#">
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
   <cffunction name="deletectry" returnetype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.error = "">
      <cfset local.result.success = true>
      <!--- check the hash value to ensure save has been called legally --->

      <cfif structkeyExists(arguments,"ctry_id")>
         <!--- then update --->
         <cfquery name="local.qDelete">
            DELETE ctry_lookup
            WHERE ctry_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ctry_id#">
         </cfquery>

      </cfif>




      <cfreturn local.result>

   </cffunction>

<!--- site lookup methods --->
   <cffunction name="showsite" returntype="query" hint="I get all sites to show in a summary">
      <cfargument name="sortbySiteName" type="boolean" default="false">

      <!--- TODO: validate no bad characters in the argument --->
      <cfquery name="local.entries">
         SELECT s.site_id, s.ctry_id, c.ctry_name  , s.site_name, 0 as emp_id
         FROM site_lookup s JOIN ctry_lookup c
         ON s.ctry_id = c.ctry_id
         ORDER BY
         <cfif arguments.sortBySiteName>
            s.site_name
         <cfelse>
          c.ctry_name, s.site_name
         </cfif>
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="editsite" returntype="query">
      <cfargument name="site_id">

      <cfquery name="local.entries">
         SELECT site_id, ctry_id, site_name, 0 as emp_id
         FROM site_lookup
         WHERE site_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.site_id#">
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="savesite" returntype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.message = "">
      <cfset local.result.success = true>
      <!--- return mode so we know where to redirect to --->
      <cfset local.result.mode = arguments.mode>
      <!--- check the hash value to ensure save has been called legally --->
      <cfswitch expression="#arguments.mode#">
         <cfcase value="edit">
            <cfset local.checkvalue = arguments.site_id & month(now()) & session.cftoken>
         </cfcase>
         <cfcase value="insert">
            <cfset local.checkvalue = month(now()) & session.cftoken>
         </cfcase>
      </cfswitch>
      <cfset local.checkHash = hash(local.checkvalue)>
      <cfif arguments.entry_check EQ local.checkHash>
         <cfif not structkeyexists(arguments,"site_name")>
            <cfset local.result.message = "site name is mandatory">
         </cfif>
         <cfif not structkeyexists(arguments,"ctry_id")>
            <cfset local.result.message = "ctry_id is mandatory">
         </cfif>

         <cfif local.result.message EQ "">
            <cfquery name="local.qcheck">
               select 1 from site_lookup where site_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.site_id#">
            </cfquery>
            <cfif local.qcheck.recordcount>
               <!--- then update --->
               <cfquery name="qUpdate" >
                  UPDATE site_lookup
                  SET   site_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.site_name#">
                        ,ctry_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ctry_id#">
                  WHERE site_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.site_id#">
               </cfquery>


            <cfelse>
              <cfquery name="qInsert" result="local.qresult" >
                 INSERT INTO site_lookup
                       (
                        site_name
                        ,ctry_id
                       )
                 VALUES
                       (

                       <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.site_name#">
                       ,<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ctry_id#">
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
   <cffunction name="deletesite" returnetype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.error = "">
      <cfset local.result.success = true>
      <!--- check the hash value to ensure save has been called legally --->

      <cfif structkeyExists(arguments,"site_id")>
         <!--- then update --->
         <cfquery name="local.qDelete">
            DELETE site_lookup
            WHERE site_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.site_id#">
         </cfquery>

      </cfif>

      <cfreturn local.result>

   </cffunction>

<!--- desk lookup methods --->
   <cffunction name="showdesk" returntype="query" hint="I get all floor levels to show in a summary">

      <!--- TODO: validate no bad characters in the argument --->
      <cfquery name="local.entries">
         SELECT d.desk_location_id, d.site_id, s.site_name, d.desk_location_name, 0 as emp_id
         FROM desk_location_lookup d JOIN site_lookup s
         ON d.site_id = s.site_id
         ORDER BY s.site_name, d.desk_location_name
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="editdesk" returntype="query">
      <cfargument name="desk_location_id">

      <cfquery name="local.entries">
         SELECT d.desk_location_id, d.site_id, d.desk_location_name, 0 as emp_id
         FROM desk_location_lookup d
         WHERE desk_location_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.desk_location_id#">
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="savedesk" returntype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.message = "">
      <cfset local.result.success = true>
      <!--- return mode so we know where to redirect to --->
      <cfset local.result.mode = arguments.mode>
      <!--- check the hash value to ensure save has been called legally --->
      <cfswitch expression="#arguments.mode#">
         <cfcase value="edit">
            <cfset local.checkvalue = arguments.desk_location_id & month(now()) & session.cftoken>
         </cfcase>
         <cfcase value="insert">
            <cfset local.checkvalue = month(now()) & session.cftoken>
         </cfcase>
      </cfswitch>
      <cfset local.checkHash = hash(local.checkvalue)>
      <cfif arguments.entry_check EQ local.checkHash>
         <cfif not structkeyexists(arguments,"desk_location_name")>
            <cfset local.result.message = "floor level name is mandatory">
         </cfif>
         <cfif not structkeyexists(arguments,"site_id")>
            <cfset local.result.message = "site_id is mandatory">
         </cfif>

         <cfif local.result.message EQ "">
            <cfquery name="local.qcheck">
               select 1 from desk_location_lookup where desk_location_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.desk_location_id#">
            </cfquery>
            <cfif local.qcheck.recordcount>
               <!--- then update --->
               <cfquery name="qUpdate" >
                  UPDATE desk_location_lookup
                  SET   desk_location_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.desk_location_name#">
                        ,site_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.site_id#">
                  WHERE desk_location_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.desk_location_id#">
               </cfquery>


            <cfelse>
              <cfquery name="qInsert" result="local.qresult" >
                 INSERT INTO desk_location_lookup
                       (
                        desk_location_name
                        ,site_id
                       )
                 VALUES
                       (

                       <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.desk_location_name#">
                       ,<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.site_id#">
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
   <cffunction name="deletedesk" returnetype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.error = "">
      <cfset local.result.success = true>
      <!--- check the hash value to ensure save has been called legally --->

      <cfif structkeyExists(arguments,"desk_location_id")>
         <!--- then update --->
         <cfquery name="local.qDelete">
            DELETE desk_location_lookup
            WHERE desk_location_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.desk_location_id#">
         </cfquery>

      </cfif>

      <cfreturn local.result>

   </cffunction>

<!--- company lookup methods --->
   <cffunction name="showcompany" returntype="query" hint="I get all company locations to show in a summary">

      <!--- TODO: validate no bad characters in the argument --->
      <cfquery name="local.entries">
         SELECT d.company_id, d.company_name, 0 as emp_id
         FROM company_lookup d
         ORDER BY d.company_name
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="editcompany" returntype="query">
      <cfargument name="company_id">

      <cfquery name="local.entries">
         SELECT d.company_id, d.company_name, 0 as emp_id
         FROM company_lookup d
         WHERE company_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.company_id#">
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="savecompany" returntype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.message = "">
      <cfset local.result.success = true>
      <!--- return mode so we know where to redirect to --->
      <cfset local.result.mode = arguments.mode>
      <!--- check the hash value to ensure save has been called legally --->
      <cfswitch expression="#arguments.mode#">
         <cfcase value="edit">
            <cfset local.checkvalue = arguments.company_id & month(now()) & session.cftoken>
         </cfcase>
         <cfcase value="insert">
            <cfset local.checkvalue = month(now()) & session.cftoken>
         </cfcase>
      </cfswitch>
      <cfset local.checkHash = hash(local.checkvalue)>
      <cfif arguments.entry_check EQ local.checkHash>
         <cfif not structkeyexists(arguments,"company_name")>
            <cfset local.result.message = "company name is mandatory">
         </cfif>

         <cfif local.result.message EQ "">
            <cfquery name="local.qcheck">
               select 1 from company_lookup where company_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company_id#">
            </cfquery>
            <cfif local.qcheck.recordcount>
               <!--- then update --->
               <cfquery name="qUpdate" >
                  UPDATE company_lookup
                  SET   company_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company_name#">
                  WHERE company_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.company_id#">
               </cfquery>


            <cfelse>
              <cfquery name="qInsert" result="local.qresult" >
                 INSERT INTO company_lookup
                       (
                        company_name
                       )
                 VALUES
                       (

                       <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.company_name#">
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
   <cffunction name="deletecompany" returnetype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.error = "">
      <cfset local.result.success = true>
      <!--- check the hash value to ensure save has been called legally --->

      <cfif structkeyExists(arguments,"company_id")>
         <!--- then update --->
         <cfquery name="local.qDelete">
            DELETE company_lookup
            WHERE company_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.company_id#">
         </cfquery>

      </cfif>

      <cfreturn local.result>

   </cffunction>

<!--- division lookup methods --->
   <cffunction name="showdivision" returntype="query" hint="I get all division locations to show in a summary">

      <!--- TODO: validate no bad characters in the argument --->
      <cfquery name="local.entries">
         SELECT d.division_id, d.division_name, 0 as emp_id
         FROM division_lookup d
         ORDER BY d.order_to_show
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="editdivision" returntype="query">
      <cfargument name="division_id">

      <cfquery name="local.entries">
         SELECT d.division_id, d.division_name, d.order_to_show, 0 as emp_id
         FROM division_lookup d
         WHERE division_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.division_id#">
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="savedivision" returntype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.message = "">
      <cfset local.result.success = true>
      <!--- return mode so we know where to redirect to --->
      <cfset local.result.mode = arguments.mode>
      <!--- check the hash value to ensure save has been called legally --->
      <cfswitch expression="#arguments.mode#">
         <cfcase value="edit">
            <cfset local.checkvalue = arguments.division_id & month(now()) & session.cftoken>
         </cfcase>
         <cfcase value="insert">
            <cfset local.checkvalue = month(now()) & session.cftoken>
         </cfcase>
      </cfswitch>
      <cfset local.checkHash = hash(local.checkvalue)>
      <cfif arguments.entry_check EQ local.checkHash>
         <cfif not structkeyexists(arguments,"division_name")>
            <cfset local.result.message = "division name is mandatory">
         </cfif>

         <cfif local.result.message EQ "">
            <cfquery name="local.qcheck">
               select 1 from division_lookup where division_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.division_id#">
            </cfquery>
            <cfif NOT (structKeyExists(arguments,"order_to_show") AND ISNUMERIC(arguments.order_to_show))>
              <cfset arguments.order_to_show = 999>
            </cfif> 
            <cfif local.qcheck.recordcount>
               <!--- then update --->
               <cfquery name="qUpdate" >
                  UPDATE division_lookup
                  SET   division_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.division_name#">,
                        order_to_show = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.order_to_show#">
                  WHERE division_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.division_id#">
               </cfquery>


            <cfelse>
              <cfquery name="qInsert" result="local.qresult" >
                 INSERT INTO division_lookup
                       (
                        division_name,
                        order_to_show
                       )
                 VALUES
                       (

                       <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.division_name#">,
                       <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.order_to_show#">
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
   <cffunction name="deletedivision" returnetype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.error = "">
      <cfset local.result.success = true>
      <!--- check the hash value to ensure save has been called legally --->

      <cfif structkeyExists(arguments,"division_id")>
         <!--- then update --->
         <cfquery name="local.qDelete">
            DELETE division_lookup
            WHERE division_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.division_id#">
         </cfquery>

      </cfif>

      <cfreturn local.result>

   </cffunction>

<!--- department lookup methods --->
   <cffunction name="showdept" returntype="query" hint="I get all dept locations to show in a summary">

      <!--- TODO: validate no bad characters in the argument --->
      <cfquery name="local.entries">
         SELECT d.dept_id, d.dept_name, 0 as emp_id
         FROM dept_lookup d
         ORDER BY d.dept_name
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="editdept" returntype="query">
      <cfargument name="dept_id">

      <cfquery name="local.entries">
         SELECT d.dept_id, d.dept_name, 0 as emp_id
         FROM dept_lookup d
         WHERE dept_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dept_id#">
      </cfquery>
      <cfreturn local.entries>

   </cffunction>
   <cffunction name="savedept" returntype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.message = "">
      <cfset local.result.success = true>
      <!--- return mode so we know where to redirect to --->
      <cfset local.result.mode = arguments.mode>
      <!--- check the hash value to ensure save has been called legally --->
      <cfswitch expression="#arguments.mode#">
         <cfcase value="edit">
            <cfset local.checkvalue = arguments.dept_id & month(now()) & session.cftoken>
         </cfcase>
         <cfcase value="insert">
            <cfset local.checkvalue = month(now()) & session.cftoken>
         </cfcase>
      </cfswitch>
      <cfset local.checkHash = hash(local.checkvalue)>
      <cfif arguments.entry_check EQ local.checkHash>
         <cfif not structkeyexists(arguments,"dept_name")>
            <cfset local.result.message = "dept name is mandatory">
         </cfif>

         <cfif local.result.message EQ "">
            <cfquery name="local.qcheck">
               select 1 from dept_lookup where dept_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.dept_id#">
            </cfquery>
            <cfif local.qcheck.recordcount>
               <!--- then update --->
               <cfquery name="qUpdate" >
                  UPDATE dept_lookup
                  SET   dept_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.dept_name#">
                  WHERE dept_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dept_id#">
               </cfquery>


            <cfelse>
              <cfquery name="qInsert" result="local.qresult" >
                 INSERT INTO dept_lookup
                       (
                        dept_name
                       )
                 VALUES
                       (

                       <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.dept_name#">
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
   <cffunction name="deletedept" returnetype="struct">
      <!---  will get form as arguments --->
      <cfset local.result.error = "">
      <cfset local.result.success = true>
      <!--- check the hash value to ensure save has been called legally --->

      <cfif structkeyExists(arguments,"dept_id")>
         <!--- then update --->
         <cfquery name="local.qDelete">
            DELETE dept_lookup
            WHERE dept_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.dept_id#">
         </cfquery>

      </cfif>

      <cfreturn local.result>

   </cffunction>
</cfcomponent>
