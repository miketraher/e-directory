
<cfoutput>
   <img id="clearLookup1" src="#application.imageURL#icons/clear.png" alt="clear search" style="position:absolute; top:0; left:0; display:none;" data="" targetvar="">
   <img id="clearLookup2" src="#application.imageURL#icons/clear.png" alt="clear search" style="position:absolute; top:0; left:0; display:none;" data="" targetvar="">
   <img id="clearLookup3" src="#application.imageURL#icons/clear.png" alt="clear search" style="position:absolute; top:0; left:0; display:none;" data="" targetvar="">
   <img id="clearLookup4" src="#application.imageURL#icons/clear.png" alt="clear search" style="position:absolute; top:0; left:0; display:none;" data="" targetvar="">
   <img id="clearLookup5" src="#application.imageURL#icons/clear.png" alt="clear search" style="position:absolute; top:0; left:0; display:none;" data="" targetvar="">
   <img id="clearLookup6" src="#application.imageURL#icons/clear.png" alt="clear search" style="position:absolute; top:0; left:0; display:none;" data="" targetvar="">
   <img id="clearLookup7" src="#application.imageURL#icons/clear.png" alt="clear search" style="position:absolute; top:0; left:0; display:none;" data="" targetvar="">

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
      <!-- #month(now())# #session.cftoken# -->
    <form name="entryedit" id="entryedit" method="post" action="?action=edit.save">
      <input type="hidden" name="emp_id" id="emp_id" value="#rc.data.emp_id#">
      <input type="hidden" name="entry_check" value="#hash(rc.data.emp_id &  month(now()) & session.cftoken)#">
      <input type="hidden" name="updated_by" value="1">
      <input type="hidden" name="report_to_emp_id" id="report_to_emp_id" value="#rc.data.report_to_emp_id#">
      <input type="hidden" name="ctry_id" id="ctry_id" value="#rc.data.ctry_id#">
      <input type="hidden" name="site_id" id="site_id" value="#rc.data.site_id#">
      <input type="hidden" name="desk_location_id" id="desk_location_id" value="#rc.data.desk_location_id#">
      <input type="hidden" name="division_id" id="division_id" value="#rc.data.division_id#">
      <input type="hidden" name="company_id" id="company_id" value="#rc.data.company_id#">
      <input type="hidden" name="companieslist" id="companieslist" value="#rc.data.companieslist#">
      <input type="hidden" id="status" name="status" value="#rc.data.status#">
      <input type="hidden" name="dept_id" id="dept_id" value="#rc.data.dept_id#">
      <div>
      <label for="first_name">First Name</label>
      <input type="text" id="first_name" name="first_name" value="#rc.data.first_name#" size="60" maxlength="100"><br />
      <label for="last_name">Last Name</label>
      <input type="text" id="last_name" name="last_name" value="#rc.data.last_name#" size="60" maxlength="100"><br />
      </div>
      <div style="float:left; width: 209px; ">&nbsp;</div>
      <div style="min-height: 183px;" id="<cfif session.isLoggedIn>editphoto<cfelse>editphoto_noclick</cfif>" data="#rc.data.emp_id#" title="photo of #rc.data.first_name# #rc.data.last_name# click to change">
         <img src="services/search.cfc?method=getPhoto&emp_id=#rc.data.emp_id#" alt="photo of #rc.data.first_name# #rc.data.last_name# click to change">
                  <cfif session.isLoggedIn><img id="editphotoIcon" src="#application.imageURL#icons/211014-photo-icon.png"></cfif>
      </div><br class="clear">
      <div class="autocomp" >
         <!--- wrap autocomplete fields in this class of div to turn on auto open and close --->
      <label for="division_name">Capability</label>
      <input type="text" id="division_name" name="division_name" value="#rc.data.division_name#" size="40" maxlength="40">
      <div title="Select the name of the company you work for. You can select multiple companies if you work for or represent more than one">
      <label for="company_name">Company</label>
      <input type="text" id="company_name" name="company_name" value="" size="40" maxlength="40">
      <br style="height: 5px;"/>
      <ul id="companies" display="none">
         <cfloop list="#rc.data.companiesList#" index="company">
            <cfif len(trim(company))>
               <cfset variables.company_name = listGetAt(company, 1, ":")> 
               <cfset variables.company_id = listGetAt(company, 2, ":")>
               <li name="company" data="#variables.company_id#">#variables.company_name#&nbsp;<img src="#application.imageURL#icons/clear.png"></li>            
            </cfif>
         </cfloop>
      </ul>
      </div>
      <div title="Choose the function which best represents your primary role">
      <label for="dept_name">Function</label>
      <input type="text" id="dept_name" name="dept_name" value="#rc.data.dept_name#" size="40" maxlength="40">
      </div>
      <br />
      </div>
      <label for="job_title">Job Title</label>
      <input type="text" id="job_title" name="job_title" value="#rc.data.job_title#" size="60" maxlength="40"><br />
      <label for="report_to">Report To</label>
      <input type="text" id="report_to" name="report_to" value="#rc.data.report_to#" size="60" maxlength="40"><br />
      <div title="Provide a short description which explains what you do">
      <label for="job_role">Job Role</label>
      <textarea id="job_role" name="job_role" rows="3" cols="60" maxlength="1000">#rc.data.job_role#</textarea><br />
      </div>
      <div title="Are you an expert in a certain field or programme? Do you have a strong relationship with a particular client? Please use a comma to separate your expertise">
      <label for="expertise">Expertise</label>
      <textarea id="expertise" name="expertise" rows="3" cols="60" maxlength="1000">#rc.data.expertise#</textarea><br />
      </div>
      <br class="clear" />

      <label for="email_address">Email</label>
      <input type="text" id="email_address" name="email_address" value="#rc.data.email_address#" size="60" maxlength="150"><br />
      <label for="extension_number">#rc.data.site_name# Extn No.</label>
      <input type="text" id="extension_number" name="extension_number" value="#rc.data.extension_number#" size="60" maxlength="25"><br />
      <label for="phone_number">Phone Number</label>
      <input type="text" id="phone_number" name="phone_number" value="#rc.data.phone_number#" size="60" maxlength="25"><br />
      <label for="mobile_number">Mobile/Cell Number</label>
      <input type="text" id="mobile_number" name="mobile_number" value="#rc.data.mobile_number#" size="60" maxlength="25"><br />
      <label for="skype_id">Skype Id</label>
      <input type="text" id="skype_id" name="skype_id" value="#rc.data.skype_id#" size="60" maxlength="50"><br />
      <div class="autocomp">
         <!--- wrap autocomplete fields in this class of div to turn on auto open and close --->
      <label for="ctry_name">Country</label>
      <input type="text" id="ctry_name" name="ctry_name" value="#rc.data.ctry_name#" size="40" maxlength="40">
      <br />
      <label for="site_name">Site</label>
      <input type="text" id="site_name" name="site_name" value="#rc.data.site_name#" size="40" maxlength="40">
      <br />
      <label for="desk_location_name">Floor Level</label>
      <input type="text" id="desk_location_name" name="desk_location_name" value="#rc.data.desk_location_name#" size="40" maxlength="40">
      <br />
      </div>
      <cfif (session.isLoggedIn AND rc.data.status EQ 'Y')
            OR
            rc.data.status NEQ 'Y'>
         <label for="checkstatus">My profile is up to date</label>
         <input type="checkbox" id="checkstatus" name="checkstatus" value="Y" #iif(rc.data.status EQ 'Y',de('checked'),de(''))# style="width:21px; height:21px; margin-left: 1px;">
         <br />
      </cfif>
         <cfif structKeyExists(rc,"error") AND isArray(rc.error)>
            <!--- show error list --->
            <cfloop array="#rc.errorMessage#" index="variables.idx2">
               <p style="color:red;">#variables.idx2#</p>
            </cfloop>
         </cfif>

      <input id="editSave" style="width:auto; float:right; margin-left: 40px;" type="image" src="#application.imageURL#icons/211014-save-icon.png" title="Save Changes">
      <cfif session.isLoggedIn><input id="editDelete" style="width:auto; float:right; margin-left: 40px;" type="image" class="deleteIcon" src="#application.imageURL#icons/211014-delete-icon.png" title="Delete this record"></cfif>
      <input id="editCancel" style="width:auto; float:right;" type="image" src="#application.imageURL#icons/211014-back-icon.png" title="Cancel and return to search">
   </form>
   <div id="photoUpload" style="display:none;"></div>
   <div id="photoEdit" style="display:none;"></div>
</div>
</cfoutput>