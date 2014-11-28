<cfparam name="rc.data.emp_id" default="0">
<cfparam name="rc.olddata.report_to_emp_id" default="">
<cfparam name="rc.olddata.ctry_id" default="">
<cfparam name="rc.olddata.site_id" default="">
<cfparam name="rc.olddata.desk_location_id" default="">
<cfparam name="rc.olddata.division_id" default="">
<cfparam name="rc.olddata.company_id" default="">
<cfparam name="rc.olddata.dept_id" default="">
<cfparam name="rc.olddata.first_name" default="">
<cfparam name="rc.olddata.last_name" default="">
<cfparam name="rc.olddata.job_title" default="">
<cfparam name="rc.olddata.job_role" default="">
<cfparam name="rc.olddata.expertise" default="">
<cfparam name="rc.olddata.report_to" default="">
<cfparam name="rc.olddata.email_address" default="">
<cfparam name="rc.olddata.extension_number" default="">
<cfparam name="rc.olddata.phone_number" default="">
<cfparam name="rc.olddata.mobile_number" default="">
<cfparam name="rc.olddata.skype_id" default="">
<cfparam name="rc.olddata.ctry_name" default="">
<cfparam name="rc.olddata.site_name" default="">
<cfparam name="rc.olddata.desk_location_name" default="">
<cfparam name="rc.olddata.division_name" default="">
<cfparam name="rc.olddata.company_name" default="">
<cfparam name="rc.olddata.dept_name" default="">
<cfoutput>
<div id="editform">
   <script type="text/javascript">
      $(document).ready(function() {
         <cfif structKeyExists(rc,"error") AND isArray(rc.error)>
            <!--- putback the original data entered --->
            <cfset rc.data = duplicate(rc.olddata)>
            <cfloop array="#rc.error#" index="variables.idx">
               $("###lcase(variables.idx)#").addClass('errorField');
            </cfloop>
         </cfif>


      })
   </script>
   <form name="entryedit" id="entryedit" method="post" action="?action=edit.save">
      <input type="hidden" name="emp_id" id="emp_id" value="0">
      <!--- TODO: make this has include a session value from logged in memeber --->
      <input type="hidden" name="entry_check" value="#hash(0 & month(now()) & session.cftoken)#">
      <!--- TODO: sort out these values properly! --->
      <input type="hidden" name="updated_by" value="1">
      <input type="hidden" name="report_to_emp_id" id="report_to_emp_id" value="">
      <input type="hidden" name="ctry_id" id="ctry_id" value="">
      <input type="hidden" name="site_id" id="site_id" value="">
      <input type="hidden" name="desk_location_id" id="desk_location_id" value="">
      <input type="hidden" name="division_id" id="division_id" value="">
      <input type="hidden" name="company_id" id="company_id" value="">
      <input type="hidden" name="dept_id" id="dept_id" value="">

      <label for="first_name">First Name</label>
      <input type="text" id="first_name" name="first_name" value="#rc.olddata.first_name#" size="60" maxlength="100"><br />
      <label for="last_name">Last Name</label>
      <input type="text" id="last_name" name="last_name" value="#rc.olddata.last_name#" size="60" maxlength="100"><br />
      <div class="autocomp">
         <!--- wrap autocomplete fields in this class of div to turn on auto open and close --->
      <label for="division_name">Capability</label>
      <input type="text" id="division_name" name="division_name" value="#rc.olddata.division_name#" size="40" maxlength="40">
      <br />
      <label for="company_name">Company</label>
      <input type="text" id="company_name" name="company_name" value="" size="40" maxlength="40">
      <br />
      <ul id="companies" display="none">
      </ul>
      <label for="dept_name">Function</label>
      <input type="text" id="dept_name" name="dept_name" value="#rc.olddata.dept_name#" size="40" maxlength="40">
      <br />
      </div>
      <label for="job_title">Job Title</label>
      <input type="text" id="job_title" name="job_title" value="#rc.olddata.job_title#" size="60" maxlength="40"><br />
      <label for="report_to">Report To</label>
      <input type="text" id="report_to" name="report_to" value="#rc.olddata.report_to#" size="60" maxlength="40"><br />
      <label for="job_role">Job Role</label>
      <textarea id="job_role" name="job_role" rows="3" cols="60" maxlength="1000">#rc.olddata.job_role#</textarea><br />
      <label for="expertise">Expertise</label>
      <textarea id="expertise" name="expertise" rows="3" cols="60" maxlength="1000">#rc.olddata.expertise#</textarea><br />
      <label for="email_address">Email</label>
      <input type="text" id="email_address" name="email_address" value="#rc.olddata.email_address#" size="60" maxlength="150"><br />
      <label for="extension_number">Extension No.</label>
      <input type="text" id="extension_number" name="extension_number" value="#rc.olddata.extension_number#" size="60" maxlength="25"><br />
      <label for="phone_number">Phone Number</label>
      <input type="text" id="phone_number" name="phone_number" value="#rc.olddata.phone_number#" size="60" maxlength="25"><br />
      <label for="mobile_number">Mobile/Cell Number</label>
      <input type="text" id="mobile_number" name="mobile_number" value="#rc.olddata.mobile_number#" size="60" maxlength="25"><br />
      <label for="skype_id">Skype Id</label>
      <input type="text" id="skype_id" name="skype_id" value="#rc.olddata.skype_id#" size="60" maxlength="50"><br /><br />

      <div class="autocomp">
         <!--- wrap autocomplete fields in this class of div to turn on auto open and close --->

      <label for="ctry_name">Country</label>
      <input type="text" id="ctry_name" name="ctry_name" value="#rc.olddata.ctry_name#" size="40" maxlength="40">
      <br />


      <label for="site_name">Site</label>
      <input type="text" id="site_name" name="site_name" value="#rc.olddata.site_name#" size="40" maxlength="40">
      <br />


      <label for="desk_location_name">Floor level</label>
      <input type="text" id="desk_location_name" name="desk_location_name" value="#rc.olddata.desk_location_name#" size="40" maxlength="40">
      <br />
      </div>
      <br />
         <cfif structKeyExists(rc,"error") AND isArray(rc.error)>
            <!--- show error list --->
            <cfloop array="#rc.errorMessage#" index="variables.idx2">
               <p style="color:red;">#variables.idx2#</p>
            </cfloop>
         </cfif>

      <input id="editSave" style="width:auto; float:right; margin-left: 40px;" type="image" src="#application.imageURL#icons/211014-save-icon.png" title="Save Changes">
      <input id="editCancel" style="width:auto; float:right;" type="image" src="#application.imageURL#icons/211014-back-icon.png" title="Cancel and return to search">
   </form>
   <div id="photoUpload" style="display:none;"></div>
   <div id="photoEdit" style="display:none;"></div>
</div>
</cfoutput>