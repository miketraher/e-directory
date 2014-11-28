<cfoutput>
<cfparam name="rc.data.ctry_id" default="">
<h1>Country Insert page</h1>
<a href="?#framework.action#=lookups.showctry"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="ctryinsertform" autocomplete="false" method="post" action="?#framework.action#=lookups.savectry"  >

      <input type="hidden" name="entry_check" value="#hash(month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="insert">
<!---      <label for="ctry_id">Ctry_id:</label>
      <input type="text" id="ctry_id" name="ctry_id" value="#rc.data.ctry_id#"><br /> 
--->
      <label for="ctry_name_ins">Country Name:</label>
      <input type="text" id="ctry_name_is" name="ctry_name" value="" autocomplete="false"><br />
      <label for="ctry_dialing_code">Country Dialing Code:</label>
      <input type="text" id="ctry_dialing_code" name="ctry_dialing_code" value="" autocomplete="false" maxlength="4"><br />

      <input type="submit" id="submit" name="submit" value="Create New Country">

   </form>
</div>
</cfoutput>