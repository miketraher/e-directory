<cfoutput>
<cfset variables.info_icon = 'information.gif'>
<cfif session.isLoggedIn>
   <cfset variables.info_icon = 'pencil_edit.gif'>
</cfif>
<cfset request.layout = false>
<cfset variables.galleryClass = "gallery">
<cfif rc.joiners>
   <cfset variables.galleryClass = "galleryJoiners">
</cfif>
<cfif structKeyExists(rc,"data")>
   <div class="#variables.galleryClass#" >
            <cfset variables.inARow = 0>
            <cfloop query="rc.data">

               <cfif rc.joiners AND rc.data.currentrow EQ 1>
                  <cfset variables.currentsite = rc.data.site_name>
                  <p class="joiners">New Additions for #variables.currentsite#</p>
               </cfif>
               <!--- for joiners we sort and separate different sites --->
               <cfif rc.joiners AND variables.currentsite NEQ rc.data.site_name>
                  <cfset variables.currentsite = rc.data.site_name>
                  <cfset variables.inARow = 0>
                  <br class="clear" />
                  <hr class="joiners">
                  <p class="joiners">New Additions for #variables.currentsite#</p>
               </cfif>
               <cfsavecontent variable="variables.siteext">
                  #rc.data.site_name#<br />(#rc.data.ctry_dialing_code#)<br />
                  <cfif len(rc.data.extension_number)>&nbsp</cfif>
                  <a class="phonelink" style="font-size:10px;" href="callto:#rereplace(rc.data.extension_number,'[^\+[:digit:]]','','ALL')#">#rc.data.extension_number#</a><span class="nophonelink" style="font-size:10px;">#rc.data.extension_number#</span>
                  <br />
                  <a class="phonelink" style="font-size:10px;" href="callto:#application.utils.formatPhoneNumber(rc.data.phone_number,rc.data.ctry_id)#">#rc.data.phone_number#</a><span class="nophonelink" style="font-size:10px;">#rc.data.phone_number#</span>
                  <br />
                  <a class="phonelink" style="font-size:10px;" href="callto:#application.utils.formatPhoneNumber(rc.data.mobile_number,rc.data.ctry_id)#">#rc.data.mobile_number#</a><span class="nophonelink" style="font-size:10px;">#rc.data.mobile_number#</span>

               </cfsavecontent>

               <div class="galleryPicDiv">
                  <img data="#rc.data.emp_id#" class="galleryPic" src="#application.rooturl#services/search.cfc?method=getPhoto&emp_id=#rc.data.emp_id#" />
                  <span class="galleryName">#rc.data.name#</span><br />
                  <span class="galleryName">#rc.data.job_title#</span><br />
                  <span class="gallerySite">#iif(len(variables.siteext) GT 3,de("#variables.siteext#"),de("&nbsp;"))#</span>
               </div>
               <!--- getting 5 on a row needs to be done differently for joiners --->
               <cfset variables.inARow = variables.inARow +1>
               <cfif variables.inARow EQ 5>
                  <br class="clear" /><br />
                  <cfset variables.inARow = 0>
               </cfif>

           </cfloop>

   </div>
   <br class="clear" />
   <div id="adminStats">
      <p>count of selected records&nbsp;#rc.data.recordcount#</p>
   </div>
   <div id="detailDialog" style="display:none;"></div>
</cfif>
</cfoutput>