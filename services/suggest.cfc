<cfcomponent hint="I am the service cfc for sending the suggestions">



<!--- ctry lookup methods --->
   <cffunction name="sendSuggest" returntype="any" hint="I send any valid suggestions get all countries to show in a summary">




      <cfset local.result.subject = duplicate(stripBadChars(arguments.subject))>
      <cfset local.result.suggestion = duplicate(stripBadChars(arguments.suggestion))>
      <cfset local.result.message = ''>
      <cfif len(arguments.suggestion) + len(arguments.subject) EQ 0>
         <cfset local.result.message = 'blank suggestion ignored'>
      <cfelseif containsBannedWord(arguments.suggestion) OR containsBannedWord(arguments.subject)>
         <cfset local.result.message = 'rude! please reword politely'>
      <cfelse>
 	      <cfmail to='#application.emailtouse#' from='#application.emailtouse#' subject="#local.result.subject#" type="html">
	         #local.result.suggestion#
	      </cfmail>
      </cfif>

      <cfreturn local.result>

   </cffunction>

   <cffunction name="containsBannedWord" returntype="boolean" hint="I check a list of banned words and return true if any found">
      <cfargument name="phrase" type="string">

      <cfloop list="#application.rudewords#" index="local.i">
         <cfif REFind('\b#local.i#\b',arguments.phrase)>
            <cfreturn true>
         </cfif>

      </cfloop>
      <cfreturn false>

   </cffunction>
   <cffunction name="stripBadChars" returntype="string" hint="I strip out any possibly hackorific chars">
      <cfargument name="instring" type="string">

      <cfset local.outstring = rereplace(arguments.instring,'[;<>&$%]','','ALL')>
      <cfreturn local.outstring>

   </cffunction>

</cfcomponent>
