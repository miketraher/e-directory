<cfset request.layout = false>
<cfoutput>
   <cfset variables.link = application.rooturl & '?showdetailbyid=' & rc.data.emp_id>
   <cfset variables.boss_link = application.rooturl & '?showdetailbyid=' & rc.data.report_to_emp_id>
      <cfset variables.noplus_dialing_code = REReplace(rc.data.ctry_dialing_code, "^\++", "", "ALL")>
   <cfset variables.trimmed_phone_number = REReplace(rc.data.phone_number, "^#trim(variables.noplus_dialing_code)#+", "", "ALL")>
   <cfset variables.trimmed_phone_number = REReplace(trim(variables.trimmed_phone_number), "^0+", "", "ALL")>
   <cfset variables.trimmed_mobile_number = REReplace(rc.data.mobile_number, "^#trim(variables.noplus_dialing_code)#+", "", "ALL")>
   <cfset variables.trimmed_mobile_number = REReplace(trim(variables.trimmed_mobile_number), "^0+", "", "ALL")>
   <cfset variables.favclass = "emptyfav">
   <cfif rc.data.fav>
      <cfset variables.favclass = "fav">
   </cfif>

<div id="showDetail">
   <dl>
      <dt>First Name</dt>
      <dd>#rc.data.first_name#</dd><br />
      <dt>Last Name</dt>
      <dd>#rc.data.last_name#</dd><br />
      <dt>Photo</dt>
      <dd style="border: none; background:none; height: auto;">
         <img src="services/search.cfc?method=getPhoto&emp_id=#rc.data.emp_id#" alt="photo of #rc.data.first_name# #rc.data.last_name# click to change" style="float:left;">
         <div id="thisfav" class="#variables.favclass#"></div>
         <div id="thisfavmessage"></div>
      </dd><br />
      <dt>Link to this entry</dt>
      <dd id="detail_link" style="font-size:10pt; text-decoration:underline; color: grey;">#variables.link#</dd>
      <dt>Capability</dt>
      <dd>#rc.data.division_name#</dd><br />
      <dt>Company</dt>
      <dd>
      <ul id="companies_viewonly">
         <cfloop list="#rc.data.companiesList#" index="company">
            <cfif len(trim(company))>
               <cfset variables.company_name = listGetAt(company, 1, ":")> 
               <cfset variables.company_id = listGetAt(company, 2, ":")>
               <li name="company" data="#variables.company_id#">#variables.company_name#</li>            
            </cfif>
         </cfloop>
      </ul>
      </dd><br />
      <dt>Function</dt>
      <dd>#rc.data.dept_name#</dd><br />
      <dt>Job Title</dt>
      <dd>#rc.data.job_title#</dd><br />
      <dt>Report To</dt>
      <dd><a href="#variables.boss_link#" style="font-size:10pt; text-decoration:underline; color: blue;">#rc.data.report_to#</a></dd><br />
      <dt>Job Role</dt>
      <dd>#rc.data.job_role#</dd><br />
      <dt>Expertise</dt>
      <dd>#rc.data.Expertise#</dd><br />
    </dl>
    <dl>
      <dt>Email</dt>
      <dd><a href="mailto:#trim(rc.data.email_address)#" style="color:blue;">#rc.data.email_address#</a></dd><br />
      <dt>#rc.data.site_name# Extn No.</dt>
      <dd><a class="phonelink" href="callto:#rereplace(rc.data.extension_number,'[^\+[:digit:]]','','ALL')#">#rc.data.extension_number#</a><span class="nophonelink">#rc.data.extension_number#</span></dd><br />
      <dt>Phone Number</dt>
      <dd><a class="phonelink" href="callto:#rereplace(rc.data.phone_number,'[^\+[:digit:]]','','ALL')#">#rc.data.phone_number#</a><span class="nophonelink">#rc.data.phone_number#</span>&nbsp;(#rc.data.ctry_dialing_code# #variables.trimmed_phone_number#)</dd><br />
      <dt>Mobile/Cell Number</dt>
      <dd><a class="phonelink" href="callto:#rereplace(rc.data.mobile_number,'[^\+[:digit:]]','','ALL')#">#rc.data.mobile_number#</a><span class="nophonelink">#rc.data.mobile_number#</span>&nbsp;(#rc.data.ctry_dialing_code# #variables.trimmed_mobile_number#)</dd><br />
      <dt>Skype Id</dt>
      <dd><a href="skype:#trim(rc.data.skype_id)#?chat" style="color:blue;">#rc.data.skype_id#</a></dd><br />
      <dt>Country</dt>
      <dd>#rc.data.ctry_name#</dd><br />
      <dt>Site</dt>
      <dd>#rc.data.site_name#</dd><br />
      <dt>Floor Level</dt>
      <dd>#rc.data.desk_location_name#</dd><br />
  
   </dl>

   <br class="clear">    
   <img src="#application.imageURL#icons/211014-edit-icon.png" style="float:right;" id="gotoEdit" data="#rc.data.emp_id#">
   <cfif rc.data.status NEQ 'Y'>
         <span style="font-size: larger; color: red; float: right; margin: 10px 10px 1px;">* Profile not up to date *</span>   
   </cfif>



</div>
</cfoutput>