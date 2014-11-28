<h1>Manage Floor levels for each site</h1>
<cfoutput>
   <a href="?#framework.action#=lookups.menu"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
   <a href="?#framework.action#=lookups.insertdesk">Add A New Floor level</a>
<div>
   <table class="tablesorter">
      <thead>
         <th>&nbsp;</th>
         <th>Floor level Id</th>
         <th>Site Name</th>
         <th>Floor level Name</th>
      </thead>
   <cfloop query="rc.data">
      <tr>
         <td>
            <a href="?action=lookups.editdesk&desk_location_id=#rc.data.desk_location_id#"><img class="editIcon" src="#application.imageURL#icons/211014-edit-icon.png" title="Edit this floor level" data="#rc.data.desk_location_id#"></a>
            <img class="deskDelete deleteIcon" src="#application.imageURL#icons/211014-delete-icon.png" title="Delete this floor level" data="#rc.data.desk_location_id#" style="cursor:pointer;">
         </td>
         <td>#rc.data.desk_location_id#</td>
         <td>#rc.data.site_name#</td>
         <td>#rc.data.desk_location_name#</td>
      </tr>

   </cfloop>
   </table>
</div>
</cfoutput>
