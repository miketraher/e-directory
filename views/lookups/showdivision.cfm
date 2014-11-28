<h1>Manage Divisions</h1>
<cfoutput>
   <a href="?#framework.action#=lookups.menu"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
   <a href="?#framework.action#=lookups.insertdivision">Add new division</a>
<div>
   <table class="tablesorter">
      <thead>
         <th>&nbsp;</th>
         <th>Division Id</th>
         <th>Division Name</th>
      </thead>
   <cfloop query="rc.data">
      <tr>
         <td>
            <a href="?action=lookups.editdivision&division_id=#rc.data.division_id#"><img class="editIcon" src="#application.imageURL#icons/211014-edit-icon.png" title="Edit this division" data="#rc.data.division_id#"></a>
            <img class="divisionDelete deleteIcon" src="#application.imageURL#icons/211014-delete-icon.png" title="Delete this division" data="#rc.data.division_id#" style="cursor:pointer;">
         </td>
         <td>#rc.data.division_id#</td>
         <td>#rc.data.division_name#</td>
      </tr>

   </cfloop>
   </table>
</div>
</cfoutput>
