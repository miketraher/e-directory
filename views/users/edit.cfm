<cfoutput>
<h1>User Edit page</h1>
<a href="?#framework.action#=users.showusers"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
<div class="lookups">
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
   <form id="usereditform" autocomplete="false" method="post" action="?#framework.action#=users.save"  >
      <input type="hidden" name="user_id" value="#rc.data.user_id#">

      <input type="hidden" name="entry_check" value="#hash(rc.data.user_id & month(now()) & session.cftoken)#">
      <input type="hidden" name="mode" value="edit">

      <label for="user_id">Username:</label>
      <input type="text" id="user_id" name="user_id" value="#rc.data.user_id#" disabled><br />
      <label for="skip_password">Leave Password Unchanged?:</label>
      <input type="checkbox" id="skip_password" name="skip_password" checked value="1"><br />

      <label for="user_password">Password:</label>
      <input type="password" id="user_password" name="user_password" value="#rc.data.user_password#" autocomplete="false"><br />
      <label for="user_password_confirm">Confirm password:</label>
      <input type="password" id="user_password_confirm" name="user_password_confirm" value="#rc.data.user_password#" autocomplete="false"><br />
      <label for="admin_flag">Admin User?:</label>
      <input type="checkbox" id="admin_flag" name="admin_flag" <cfif rc.data.admin_flag>checked</cfif> value="1"><br />

      <input type="submit" id="submit" name="submit" value="Save">

   </form>
</div>
</cfoutput>