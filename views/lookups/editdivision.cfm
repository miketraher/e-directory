<cfoutput>
<h1>Division Edit page</h1>
<a href="?#framework.action#=lookups.showdivision"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="divisioneditform" autocomplete="false" method="post" action="?#framework.action#=lookups.savedivision"  >
      <input type="hidden" name="division_id" value="#rc.data.division_id#">

      <input type="hidden" name="entry_check" value="#hash(rc.data.division_id & month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="edit">

      <label for="division_id">division:</label>
      <input type="text" id="division_id" name="division_id" value="#rc.data.division_id#" disabled><br />

      <label for="division_name">Division Name:</label>
      <input type="text" id="division_name" name="division_name" value="#rc.data.division_name#" autocomplete="false"><br />
      <label for="order_to_show">Order to Show in Lookups:</label>
      <input type="text" id="order_to_show" name="order_to_show" value="#rc.data.order_to_show#" autocomplete="false"><br />

      <input type="submit" id="submit" name="submit" value="Save">

   </form>
</div>
</cfoutput>