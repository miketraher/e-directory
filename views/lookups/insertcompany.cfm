<cfoutput>
<h1>Company Insert page</h1>
<a href="?#framework.action#=lookups.showcompany"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="companyinsertform" autocomplete="false" method="post" action="?#framework.action#=lookups.savecompany"  >

      <input type="hidden" name="entry_check" value="#hash(month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="insert">
      <input type="hidden" id="company_id" name="company_id" value="-1"><br />

      <label for="company_name_ins">Company Name:</label>
      <input type="text" id="company_name_is" name="company_name" value="" autocomplete="false"><br />

      <input type="submit" id="submit" name="submit" value="Create New Company">

   </form>
</div>
</cfoutput>