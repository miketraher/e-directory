<h1>Manage Users</h1>
<cfoutput>
   <a href="?#framework.action#=admin.menu"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
   <a href="?#framework.action#=users.insert">Add new user</a>
<div>
   <table class="tablesorter">
      <thead>
         <th>&nbsp;</th>
         <th>User Id</th>
         <th>Last Login</th>
         <th>Failed login attempts</th>
         <th>Admin User</th>
      </thead>
   <cfloop query="rc.data">
      <tr>
         <td>
            <a href="?action=users.edit&user_id=#rc.data.user_id#"><img class="editIcon" src="#application.imageURL#icons/211014-edit-icon.png" title="Edit this user" data="#rc.data.user_id#"></a>
            <img class="userDelete deleteIcon" src="#application.imageURL#icons/211014-delete-icon.png" title="Delete this user" data="#rc.data.user_id#" style="cursor:pointer;">
         </td>
         <td>#rc.data.user_id#</td>
         <td>#dateformat(rc.data.last_login_date,"dd-mmm-yyyy")#</td>
         <td>#rc.data.failed_login_attempts#</td>
         <td><cfif rc.data.admin_flag>Yes</cfif></td>
      </tr>

   </cfloop>
   </table>
</div>
</cfoutput>
