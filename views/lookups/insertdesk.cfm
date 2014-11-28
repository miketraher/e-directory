<cfoutput>
<h1>Desk Insert page</h1>
<a href="?#framework.action#=lookups.showdesk"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="deskinsertform" autocomplete="false" method="post" action="?#framework.action#=lookups.savedesk"  >

      <input type="hidden" name="entry_check" value="#hash(month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="insert">
      <input type="hidden" name="desk_location_id" value="-1">

      <label for="desk_location_name_ins">Floor level Name:</label>
      <input type="text" id="desk_location_name_ins" name="desk_location_name" value="" autocomplete="false"><br />

      <label for="site_id_ins">Site:</label>
      <select id="site_id_ins" name="site_id">
         <cfloop query="rc.qsite">
            <option value="#rc.qsite.site_id#">#rc.qsite.site_name#</option>
         </cfloop>
      </select><br />
      <input type="submit" id="submit" name="submit" value="Create New Floor level">

   </form>
</div>
</cfoutput>