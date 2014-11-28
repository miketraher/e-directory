<cfoutput>
<h1>Function Insert page</h1>
<a href="?#framework.action#=lookups.showdept"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="deptinsertform" autocomplete="false" method="post" action="?#framework.action#=lookups.savedept"  >

      <input type="hidden" name="entry_check" value="#hash(month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="insert">
      <input type="hidden" id="dept_id" name="dept_id" value="-1"><br />

      <label for="dept_name_ins">Function Name:</label>
      <input type="text" id="dept_name_is" name="dept_name" value="" autocomplete="false"><br />

      <input type="submit" id="submit" name="submit" value="Create New Function">

   </form>
</div>
</cfoutput>