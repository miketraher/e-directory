<cfoutput>
<h1>Ctry Edit page</h1>
<a href="?#framework.action#=lookups.showctry"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="ctryeditform" autocomplete="false" method="post" action="?#framework.action#=lookups.savectry"  >
      <input type="hidden" name="ctry_id" value="#rc.data.ctry_id#">

      <input type="hidden" name="entry_check" value="#hash(rc.data.ctry_id & month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="edit">

      <label for="ctry_id">Ctry:</label>
      <input type="text" id="ctry_id" name="ctry_id" value="#rc.data.ctry_id#" disabled><br />

      <label for="ctry_name">Country Name:</label>
      <input type="text" id="ctry_name" name="ctry_name" value="#rc.data.ctry_name#" autocomplete="false"><br />
      <label for="ctry_dialing_code">Country Dialing Code:</label>
      <input type="text" id="ctry_dialing_code" name="ctry_dialing_code" value="#rc.data.ctry_dialing_code#" autocomplete="false"><br />

      <input type="submit" id="submit" name="submit" value="Save">

   </form>
</div>
</cfoutput>