<!--- I will show the main default search form --->
<cfparam name="rc.startletter" default="">
<cfparam name="url.site_id" default="0">
<cfparam name="url.dept_id" default="0">
<cfparam name="url.company_id" default="0">
<cfparam name="url.ctry_id" default="0">

<cfif structkeyExists(url,"showdetailbyid") and isnumeric(url.showdetailbyid)>
<div id="detailDialog"></div>

<script language="javascript">
      $("#detailDialog").dialog({ 'autoOpen': false, 'modal': false, 'position': [300,200], 'draggable': true,
         'resizable': true , 'width':628, 'title': 'Employee Profile'});


      function LoadDetail( empID ) {
         $("#detailDialog").load('?action=search.showDetail&emp_id='+empID,function() {
            $("#detailDialog").dialog('open');

            $("#gotoEdit").click(function() {
               var empID = $(this).attr('data');
               document.location = '?action=edit.edit&emp_id='+empID;
            });
         });
      }
      LoadDetail( <cfoutput>#url.showdetailbyid#</cfoutput> );
</script>


</cfif>
<cfif structkeyExists(url,"joiners")>
	<script language="javascript">
      $(document).ready(function() {
         $("#ctry_id_search2").attr("data",<cfoutput>#url.ctry_id#</cfoutput>);
         $("#srchAdvanced3").click();
      })
	</script>

</cfif>
<cfif structkeyExists(url,"showgroup")
	AND (structkeyExists(url,"site_id") AND isnumeric(url.site_id))
	AND (structkeyExists(url,"dept_id") AND isnumeric(url.dept_id))
	AND (structkeyExists(url,"company_id") AND isnumeric(url.company_id))
   AND (structkeyExists(url,"ctry_id") AND isnumeric(url.ctry_id))>



   <script language="javascript">
      $(document).ready(function() {
         $("#site_name_search2").attr("data",<cfoutput>#url.site_id#</cfoutput>);
         $("#dept_name_search").attr("data",<cfoutput>#url.dept_id#</cfoutput>);
         $("#company_name_search").attr("data",<cfoutput>#url.company_id#</cfoutput>);
         $("#ctry_id_search2").attr("data",<cfoutput>#url.ctry_id#</cfoutput>);
         $("#srchAdvanced2").click();
      })
   </script>

</cfif>


<cfoutput>
<div>
   <img id="clearSrch1" src="#application.imageURL#icons/clear.png" alt="clear search" style="position:absolute; top:0; left:0; display:none;" data="" targetvar="">
   <img id="clearSrch2" src="#application.imageURL#icons/clear.png" alt="clear search" style="position:absolute; top:0; left:0; display:none;" data="" targetvar="">
   <img id="clearSrch3" src="#application.imageURL#icons/clear.png" alt="clear search" style="position:absolute; top:0; left:0; display:none;" data="" targetvar="">
   <div class="searchTypeDiv">
      <div id="searchType" >
         <div id="srchName" class="searchIcon">
            <img src="#application.imageURL#icons/250914-name-icon.png" alt="Name">
            Name
         </div>
         <div id="srchAdvanced3" class="searchIcon">
            <img src="#application.imageURL#icons/250914-new-starters-icon.png" alt="Recent Additions">
            New Starters
         </div>
         <div id="srchAdvanced1" class="searchIcon">
            <img src="#application.imageURL#icons/250914-office-icon.png" alt="Site">
            Office
         </div>
         <div id="srchAdvanced2" class="searchIcon">
            <img src="#application.imageURL#icons/250914-company-icon.png" alt="Company">
            Company
         </div>
         <div id="favsearch" class="searchIcon">
            <img src="#application.imageURL#icons/250914-my-favs-icon.png" alt="Favorites">
            My Favourites
         </div>

         <!-- <div style="float:left; padding-left: 10px;"> -->
         <cfif session.isLoggedIn>
         <div class="searchIcon">
         <img id="insertNew" src="#application.imageURL#icons/250914-insert-icon.png" title="Insert a new Entry">
         Insert
         </div>
         <div class="searchIcon">
         <a href="?#framework.action#=auth.logout"><img src="#application.imageURL#icons/250914-logout-icon.png" alt="logout" title="logout">Logout</a>
         </div>
         <cfelse>
         <div class="searchIcon">
         <a href="?action=auth.login"><img src="#application.imageURL#icons/250914-login-icon.png" alt="login to edit records" title="login to edit records">Login</a>
         </div>
         </cfif>

	      <cfif session.isLoggedIn AND (structkeyexists(session,"admin_flag") AND session.admin_flag)>
	      <div class="searchIcon" style="float:left; border-left: solid ##8e8e8e 2px; padding-left: 10px; margin-left: 10px;">
	         <img id="adminFunctions" src="#application.imageURL#icons/250914-admin-icon.png" title="admin functions">
	         Admin
	      </div>
	      </cfif>
      </div>

   </div>
<br class="clear"/>
<br />
	   <div class="searchParams">
	      <div id="srchByName">
            <div id="srchStartletter">
		         <label for="startletter">Name</label>
	            <input type="text" name="startletter" id="startletter" value="#rc.startletter#" size="40" maxlength="40">
               <br />
            </div>
            <div id="srchDefaultCtry">
	            <label for="default_ctry_name">Default Country</label>
	            <!-- <input type="text" id="default_ctry_name" name="default_ctry_name" value="" size="40" maxlength="40" data="0"> -->
               <select id="default_ctry_name" name="default_ctry_name">
                  <option>Show all Countries</option>
                  <cfloop query="application.qctry">
                  <option value="#application.qctry.ctry_id#">#application.qctry.ctry_name#</option>
                  </cfloop>
               </select>
	            <br />
            </div>
	      </div>
	      <div id="srchByAdvanced1" style="display:none;">
	         <div id="SAsite1">
	            <label for="site_name_search">Site</label>
	            <input type="text" id="site_name_search" name="site_name" value="" size="40" maxlength="40" data="0">
	            <br />
	         </div>
	         <div id="SAdesk_location1">
	            <label for="desk_location_name_search">Floor level</label>
	            <input type="text" id="desk_location_name_search" name="desk_location_name" value="" size="40" maxlength="40" data="0">
	            <br />
	         </div>
	      </div>
	      <div id="srchByAdvanced2" style="display:none;">
            <div id="SAsite2">
               <label for="site_name_search2">Site</label>
               <input type="text" id="site_name_search2" name="site_name2" value="" size="40" maxlength="40" data="0">
               <br />
            </div>
            <div id="SAdepartment2">
               <label for="dept_name_search">Function</label>
               <input type="text" id="dept_name_search" name="dept_name" value="" size="40" maxlength="40" data="0">
               <br />
            </div>
            <div id="SAcompany2">
               <label for="company_name_search">Company</label>
               <input type="text" id="company_name_search" name="company_name" value="" size="40" maxlength="40" data="0">
               <!--- the ctry_id_search field below is only used when this function is accessed directly by a url including url.ctry_id   --->
               <input type="hidden" id="ctry_id_search2" name="ctry_id_search2" value="" data="0">
               <br />
  	         </div>

	      </div>
	   </div>
<!---       <div id="displayType" >
         <span>Display As</span>
         <img id="dspTable" src="#application.imageURL#icons/table.png" title="table of results">
         <img id="dspGallery" src="#application.imageURL#icons/gallery.png" title="photo gallery">
         <img id="dspPhoneLinks" src="#application.imageURL#icons/telephone.png" title="toggle phone links">
      </div> --->




      <br class="clear" />
   </div>


<!---       <cfif session.isLoggedIn>
         <a href="?#framework.action#=auth.logout"><img src="#application.imageURL#icons/logout-icon.png" alt="logout" title="logout"></a><br />
      <cfelse>
         <a href="?action=auth.login"><img src="#application.imageURL#icons/key_login.gif" alt="login to edit records" title="login to edit records"></a>
      </cfif> --->
</div>
<br class="clear"/>

<div id="results"></div>
<div id="details"></div>

<div id="photoDialog" class="alert" style="display:none;"></div>

</cfoutput>