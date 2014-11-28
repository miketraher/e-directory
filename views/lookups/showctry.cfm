<h1>Manage Countries</h1>
<cfoutput>
   <a href="?#framework.action#=lookups.menu"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
   <a href="?#framework.action#=lookups.insertctry">Add new country</a>
<div>
   <table class="tablesorter">
      <thead>
         <th>&nbsp;</th>
         <th>Ctry Id</th>
         <th>Ctry Name</th>
         <th>Ctry Dialing Code</th>
      </thead>
   <cfloop query="rc.data">
      <tr>
         <td>
            <a href="?action=lookups.editctry&ctry_id=#rc.data.ctry_id#"><img class="editIcon" src="#application.imageURL#icons/211014-edit-icon.png" title="Edit this ctry" data="#rc.data.ctry_id#"></a>
            <img class="ctryDelete deleteIcon" src="#application.imageURL#icons/211014-delete-icon.png" title="Delete this ctry" data="#rc.data.ctry_id#" style="cursor:pointer;">
         </td>
         <td>#rc.data.ctry_id#</td>
         <td>#rc.data.ctry_name#</td>
         <td>#rc.data.ctry_dialing_code#</td>
      </tr>

   </cfloop>
   </table>
</div>
</cfoutput>
