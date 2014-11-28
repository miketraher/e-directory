<script>
   $(document).ready(function() {
      $("#user_id").focus();
   })
</script>
<cfoutput>
<cfparam name="rc.emp_id" default="0">
<cfparam name="rc.nextaction" default="search.search">
<div>
   <a href="?#framework.action#=search.search"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a>
   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage">#rc.message#</span></cfif>
	<form id="loginform" autocomplete="false" method="post" action="?#framework.action#=auth.login"  >
      <input type="hidden" name="nextaction" value="#rc.nextaction#">
      <input type="hidden" name="emp_id" value="#rc.emp_id#">
		<label for="user_id">Username:</label>
		<input type="text" id="user_id" name="user_id" value=""><br />
		<label for="password">Password:</label>
		<input type="password" id="password" name="password" value="" autocomplete="false"><br />

		<input type="submit" id="submit" name="submit" value="Login">

	</form>
</div>
</cfoutput>
