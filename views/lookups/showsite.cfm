<h1>Manage Sites</h1>
<cfoutput>
   <a href="?#framework.action#=lookups.menu"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
   <a href="?#framework.action#=lookups.insertsite">Add A New Site</a>
<div>
   <table class="tablesorter">
      <thead>
         <th>&nbsp;</th>
         <th>Site Id</th>
         <th>Ctry Name</th>
         <th>Site Name</th>
      </thead>
   <cfloop query="rc.data">
      <tr>
         <td>
            <a href="?action=lookups.editsite&site_id=#rc.data.site_id#"><img class="editIcon" src="#application.imageURL#icons/211014-edit-icon.png" title="Edit this site" data="#rc.data.site_id#"></a>
            <img class="siteDelete deleteIcon" src="#application.imageURL#icons/211014-delete-icon.png" title="Delete this site" data="#rc.data.site_id#" style="cursor:pointer;">
         </td>
         <td>#rc.data.site_id#</td>
         <td>#rc.data.ctry_name#</td>
         <td>#rc.data.site_name#</td>
      </tr>

   </cfloop>
   </table>
</div>
</cfoutput>
