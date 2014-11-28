<br />
<cfoutput>
<a href="?#framework.action#=admin.menu"><img id="adminCancel" src="#application.imageURL#icons/211014-back-icon.png"></a><br />
</cfoutput>



<table style="margin: 20px; " class="summaryReport">
<col width="200">
<col width="250">
<col width="200">
<col width="250">
<col width="100">
<thead>
   <th>Country</th>
   <th>Site</th>
   <th>Floor level</th>
   <th>Company</th>
   <th>Count</th>
</thead>
<tbody>
      <cfset variables.current_ctry_name = "">
      <cfset variables.current_site_name = "">
      <cfset variables.current_desk_location_name = "">
      <cfset variables.current_company_name = "">
      <cfset variables.site_total = 0>
      <cfset variables.grand_total = 0>
<cfoutput query="rc.data">

   <cfif rc.data.site_name NEQ variables.current_site_name AND rc.data.currentRow NEQ 1>
      <tr class="subtotal">
         <td colspan="4">#variables.current_site_name# Site Total</td><td class="number">#variables.site_total#</td>
      </tr>
      <cfset variables.site_total = 0>
   </cfif>
   <cfset variables.site_total = variables.site_total + rc.data.emp_count>
   <cfset variables.grand_total = variables.grand_total + rc.data.emp_count>
	<tr>
	   <td>#iif(rc.data.ctry_name NEQ variables.current_ctry_name,de(rc.data.ctry_name),de('&nbsp;'))#</td>
	   <td>#iif(rc.data.site_name NEQ variables.current_site_name,de(rc.data.site_name),de('&nbsp;'))#</td>
	   <td>#iif((rc.data.desk_location_name NEQ variables.current_desk_location_name) OR (rc.data.site_name NEQ variables.current_site_name) ,de(rc.data.desk_location_name),de('&nbsp;'))#</td>
      <td>#iif(rc.data.company_name NEQ variables.current_company_name,de(rc.data.company_name),de('&nbsp;'))#</td>
	   <td class="number">#rc.data.emp_count#</td>
	</tr>
   <cfif rc.data.currentRow EQ 1>
      <!--- store all the first values --->
      <cfset variables.current_ctry_name = rc.data.ctry_name>
      <cfset variables.current_site_name = rc.data.site_name>
      <cfset variables.current_desk_location_name = rc.data.desk_location_name>
      <cfset variables.current_company_name = rc.data.company_name>
   </cfif>
   <cfif rc.data.ctry_name NEQ variables.current_ctry_name><cfset variables.current_ctry_name = rc.data.ctry_name></cfif>
   <cfif rc.data.site_name NEQ variables.current_site_name>
      <cfset variables.current_site_name = rc.data.site_name>
   </cfif>
   <cfif rc.data.desk_location_name NEQ variables.current_desk_location_name><cfset variables.current_desk_location_name = rc.data.desk_location_name></cfif>
   <cfif rc.data.company_name NEQ variables.current_company_name><cfset variables.current_company_name = rc.data.company_name></cfif>



</cfoutput>
   <!--- print final site total --->
      <tr class="subtotal">
         <td colspan="4"><cfoutput>#variables.current_site_name#</cfoutput>&nbsp;Site Total</td><td class="number"><cfoutput>#variables.site_total#</cfoutput></td>
      </tr>
      <tr class="subtotal">
         <td colspan="4">Grand Total</td><td class="number"><cfoutput>#variables.grand_total#</cfoutput></td>
      </tr>
</tbody>
</table>