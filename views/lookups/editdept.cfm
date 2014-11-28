<cfoutput>
<h1>Function Edit page</h1>
<a href="?#framework.action#=lookups.showdept"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="depteditform" autocomplete="false" method="post" action="?#framework.action#=lookups.savedept"  >
      <input type="hidden" name="dept_id" value="#rc.data.dept_id#">

      <input type="hidden" name="entry_check" value="#hash(rc.data.dept_id & month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="edit">

      <label for="dept_id">Function:</label>
      <input type="text" id="dept_id" name="dept_id" value="#rc.data.dept_id#" disabled><br />

      <label for="dept_name">Function Name:</label>
      <input type="text" id="dept_name" name="dept_name" value="#rc.data.dept_name#" autocomplete="false"><br />

      <input type="submit" id="submit" name="submit" value="Save">

   </form>
</div>
</cfoutput>