<cfcomponent output="false">
   <cffunction name="stripInvalidChars" returntype="string" output="No" access="public" hint="I strip invalid characters from strings to prevent XSS attacks">
      <cfargument name="sInput"         type="String"  required="true"/>

      <cfreturn REReplaceNoCase(arguments.sInput,"[\!&\$##%<>\\/;]","","ALL")/>
   </cffunction>

   <cffunction name="formatPhoneNumber" returntype="string" output="No" access="public" hint="I format phone numbers for international dialing">
      <cfargument name="sInputNumber"         type="String"  required="false" default=""/>
      <cfargument name="ctry_id"              type="any" required="false" default="-1">

      <cfif NOT LEN(arguments.sInputNumber) or arguments.ctry_id EQ -1 >
         <cfreturn arguments.sInputNumber>
      </cfif>

      <!--- strip all but digits  --->
      <cfset local.workNumber = rereplace(arguments.sInputNumber,'[^[:digit:]]','','ALL')>
      <cfif left(local.workNumber,1) EQ '0'>
         <!--- strip leading zero  --->
         <cfset local.workNumber = right(local.workNumber,len(local.workNumber) - 1)>
      </cfif>
      <cfset local.dialingCode = getDialingCodeByCtryID(arguments.ctry_id)>


      <cfreturn trim(local.dialingCode) & trim(local.workNumber)>
   </cffunction>

   <cffunction name="getDialingCodeByCtryID" returntype="string" output="No" access="private" hint="I get the international dialing code for the given ctry_id">
      <cfargument name="ctry_id"         type="numeric"  required="true"/>

      <cfquery name="local.qgetcode">
         SELECT ctry_dialing_code
         FROM ctry_lookup
         WHERE ctry_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ctry_id#">
      </cfquery>

      <cfreturn trim(local.qgetcode.ctry_dialing_code)>
   </cffunction>



</cfcomponent>