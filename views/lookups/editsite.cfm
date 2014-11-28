<cfoutput>
<h1>Site Edit page</h1>
<a href="?#framework.action#=lookups.showsite"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="siteeditform" autocomplete="false" method="post" action="?#framework.action#=lookups.savesite"  >
      <input type="hidden" name="site_id" value="#rc.data.site_id#">

      <input type="hidden" name="entry_check" value="#hash(rc.data.site_id & month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="edit">


      <label for="site_name">Country Name:</label>
      <input type="text" id="site_name" name="site_name" value="#rc.data.site_name#" autocomplete="false"><br />
      <label for="ctry_id">Country:</label>
      <select id="ctry_id" name="ctry_id">
         <cfloop query="rc.qctry">
            <option value="#rc.qctry.ctry_id#" #iif(rc.data.ctry_id EQ rc.qctry.ctry_id,de('selected'),de(''))#>#rc.qctry.ctry_name#</option>
         </cfloop>
      </select><br />

      <input type="submit" id="submit" name="submit" value="Save">

   </form>
</div>
</cfoutput>