<h1>Manage Companies</h1>
<cfoutput>
   <a href="?#framework.action#=lookups.menu"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
   <a href="?#framework.action#=lookups.insertcompany">Add new company</a>
<div>
   <table class="tablesorter">
      <thead>
         <th>&nbsp;</th>
         <th>Company Id</th>
         <th>Company Name</th>
      </thead>
   <cfloop query="rc.data">
      <tr>
         <td>
            <a href="?action=lookups.editcompany&company_id=#rc.data.company_id#"><img class="editIcon" src="#application.imageURL#icons/211014-edit-icon.png" title="Edit this company" data="#rc.data.company_id#"></a>
            <img class="companyDelete deleteIcon" src="#application.imageURL#icons/211014-delete-icon.png" title="Delete this company" data="#rc.data.company_id#" style="cursor:pointer;">
         </td>
         <td>#rc.data.company_id#</td>
         <td>#rc.data.company_name#</td>
      </tr>

   </cfloop>
   </table>
</div>
</cfoutput>
