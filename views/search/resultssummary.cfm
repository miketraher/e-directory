
<cfoutput>
<cfset variables.info_icon = 'information.gif'>
<cfif session.isLoggedIn>
   <cfset variables.info_icon = 'pencil_edit.gif'>
</cfif>

<cfset request.layout = false>
<cfif structKeyExists(rc,"data")>
   <!--- show results from data structure --->
   <div >
      <table id="tblresults" class="tablesorter nowrap">
         <thead>
            <tr>
               <th>Actions</th>
               <th>Last Name</th>
               <th>First Name</th>
               <th>Site</th>
               <th>Extension</th>
               <th>Direct Dial</th>
               <th>Mobile/Cell</th>
               <th>Skype</th>
               <th>Email</th>
            </tr>
         </thead>
         <tbody>
            <cfloop query="rc.data">
            <tr class="bodyrow">
               <td>
                  <img data="#rc.data.emp_id#" class="photoIcon mini" src="#application.rooturl#services/search.cfc?method=getPhoto&emp_id=#rc.data.emp_id#"  >
                  <cfif session.isLoggedIn>
                     <a href="?action=edit.edit&emp_id=#rc.data.emp_id#"><img class="editIcon" src="#application.imageURL#icons/211014-edit-icon.png" title="Full details" data="#rc.data.emp_id#"></a>
                  <cfelse>
                     <img class="info" src="#application.imageURL#icons/information.gif" title="Full details" data="#rc.data.emp_id#">
                  </cfif>

               </td>
               <td>#rc.data.last_name#</td>
               <td>#rc.data.first_name#</td>
               <td>#rc.data.site_name#</td>
               <td class="ext"><a class="phonelink" href="callto:#rereplace(rc.data.extension_number,'[^\+[:digit:]]','','ALL')#">#rc.data.extension_number#</a><span class="nophonelink">#rc.data.extension_number#</span></td>
               <td><a class="phonelink" href="callto:#application.utils.formatPhoneNumber(rc.data.phone_number)#">#rc.data.phone_number#</a><span class="nophonelink">#rc.data.phone_number#</span></td>
               <td><a class="phonelink" href="callto:#rereplace(rc.data.mobile_number,'[^\+[:digit:]]','','ALL')#">#rc.data.mobile_number#</a><span class="nophonelink">#rc.data.mobile_number#</span></td>
               <td><a href="skype:#trim(rc.data.skype_id)#?chat">#rc.data.skype_id#</a></td>
               <td><a href="mailto:#trim(rc.data.email_address)#">#rc.data.email_address#</a></td>

            </tr>
           </cfloop>

        </tbody>

     </table>
   </div>
   <div id="detailDialog" style="display:none;"></div>
</cfif>
</cfoutput>