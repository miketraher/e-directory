<h1>Manage Functions</h1>
<cfoutput>
   <a href="?#framework.action#=lookups.menu"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
   <a href="?#framework.action#=lookups.insertdept">Add new Function</a>
<div>
   <table class="tablesorter">
      <thead>
         <th>&nbsp;</th>
         <th>Function Id</th>
         <th>Function Name</th>
      </thead>
   <cfloop query="rc.data">
      <tr>
         <td>
            <a href="?action=lookups.editdept&dept_id=#rc.data.dept_id#"><img class="editIcon" src="#application.imageURL#icons/211014-edit-icon.png" title="Edit this dept" data="#rc.data.dept_id#"></a>
            <img class="deptDelete deleteIcon" src="#application.imageURL#icons/211014-delete-icon.png" title="Delete this Function" data="#rc.data.dept_id#" style="cursor:pointer;">
         </td>
         <td>#rc.data.dept_id#</td>
         <td>#rc.data.dept_name#</td>
      </tr>

   </cfloop>
   </table>
</div>
</cfoutput>
