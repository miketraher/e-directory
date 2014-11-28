<cfoutput>
<cfparam name="rc.data.user_id" default="">
<h1>User Insert page</h1>
<a href="?#framework.action#=users.showusers"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="userinsertform" autocomplete="false" method="post" action="?#framework.action#=users.save"  >

      <input type="hidden" name="entry_check" value="#hash(month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="insert">
      <label for="user_id">Username:</label>
      <input type="text" id="user_id" name="user_id" value="#rc.data.user_id#"><br />

      <label for="user_password">Password:</label>
      <input type="password" id="user_password" name="user_password" value="" autocomplete="false"><br />
      <label for="user_password_confirm">Confirm password:</label>
      <input type="password" id="user_password_confirm" name="user_password_confirm" value="" autocomplete="false"><br />
      <label for="admin_flag">Admin User?:</label>
      <input type="checkbox" id="admin_flag" name="admin_flag"><br />

      <input type="submit" id="submit" name="submit" value="Create New User">

   </form>
</div>
</cfoutput>