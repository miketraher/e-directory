<cfoutput>
<h1>Site Insert page</h1>
<a href="?#framework.action#=lookups.showsite"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="ctryinsertform" autocomplete="false" method="post" action="?#framework.action#=lookups.savesite"  >

      <input type="hidden" name="entry_check" value="#hash(month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="insert">
      <input type="hidden" name="site_id" value="-1">

      <label for="site_name_ins">Site Name:</label>
      <input type="text" id="site_name_ins" name="site_name" value="" autocomplete="false"><br />

      <label for="ctry_id_ins">Country:</label>
      <select id="ctry_id_ins" name="ctry_id">
         <cfloop query="rc.qctry">
            <option value="#rc.qctry.ctry_id#">#rc.qctry.ctry_name#</option>
         </cfloop>
      </select><br />
      <input type="submit" id="submit" name="submit" value="Create New Site">

   </form>
</div>
</cfoutput>