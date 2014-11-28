<cfoutput>
<h1>Company Edit page</h1>
<a href="?#framework.action#=lookups.showcompany"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="companyeditform" autocomplete="false" method="post" action="?#framework.action#=lookups.savecompany"  >
      <input type="hidden" name="company_id" value="#rc.data.company_id#">

      <input type="hidden" name="entry_check" value="#hash(rc.data.company_id & month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="edit">

      <label for="company_id">company:</label>
      <input type="text" id="company_id" name="company_id" value="#rc.data.company_id#" disabled><br />

      <label for="company_name">company Name:</label>
      <input type="text" id="company_name" name="company_name" value="#rc.data.company_name#" autocomplete="false"><br />

      <input type="submit" id="submit" name="submit" value="Save">

   </form>
</div>
</cfoutput>