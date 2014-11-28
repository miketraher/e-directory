<cfoutput>
<h1>Floor level Edit page</h1>
<a href="?#framework.action#=lookups.showdesk"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="siteeditform" autocomplete="false" method="post" action="?#framework.action#=lookups.savedesk"  >
      <input type="hidden" name="desk_location_id" value="#rc.data.desk_location_id#">

      <input type="hidden" name="entry_check" value="#hash(rc.data.desk_location_id & month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="edit">


      <label for="desk_location_name">Floor level Name:</label>
      <input type="text" id="desk_location_name" name="desk_location_name" value="#rc.data.desk_location_name#" autocomplete="false"><br />
      <label for="site_id">Site:</label>
      <select id="site_id" name="site_id">
         <cfloop query="rc.qsite">
            <option value="#rc.qsite.site_id#" #iif(rc.data.site_id EQ rc.qsite.site_id,de('selected'),de(''))#>#rc.qsite.site_name#</option>
         </cfloop>
      </select><br />

      <input type="submit" id="submit" name="submit" value="Save">

   </form>
</div>
</cfoutput>