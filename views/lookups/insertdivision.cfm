<cfoutput>
<cfparam name="rc.data.division_id" default="">
<h1>Division Insert page</h1>
<a href="?#framework.action#=lookups.showdivision"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="divisioninsertform" autocomplete="false" method="post" action="?#framework.action#=lookups.savedivision"  >

      <input type="hidden" name="entry_check" value="#hash(month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="insert">
      <input type="hidden" id="division_id" name="division_id" value="-1"><br />

      <label for="division_name_ins">Division Name:</label>
      <input type="text" id="division_name_is" name="division_name" value="" autocomplete="false"><br />

      <input type="submit" id="submit" name="submit" value="Create New Division">

   </form>
</div>
</cfoutput>