<cfoutput>
   <cfparam name="rc.subject" default="">
   <cfparam name="rc.suggestion" default="">
<div class="suggestOuter">
<!--- not edited rest yet --->

   <cfif structkeyexists(rc,"message") and len(rc.message)><span id="errormessage" >#rc.message#</span><br /></cfif>

   <p>Please leave your feedback in the box below. Every suggestion we receive will be read.</p>
   <p>This is 100% anonymous. If you  would like a response from us please let us know who you are.</p>
   <form id="suggestForm" autocomplete="false" method="post" action="?#framework.action#=suggest.sendSuggest"  >



      <label for="Subject">Subject</label>
      <input type="text" id="subject" name="subject" value="#rc.subject#" autocomplete="false"><br />
      <label for="Suggestion">Your anonymous suggestion</label>
      <textarea id="Suggestion" name="Suggestion">#rc.suggestion#</textarea><br />

      <input type="submit" id="submit" name="submit" value="Send Suggestion">
      <input type="reset" id="cancel" name="cancel" value="Cancel">

   </form>
   <!--
   <a href="?#framework.action#=search.search"><img src="#application.imageURL#icons/211014-back-icon.png" alt="back to directory" title="back to directory"></a><br />
   -->

</div>
</cfoutput>