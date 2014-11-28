<!--- I allow display photos to be cropped --->
<cfset request.layout= false>

<cfoutput>

<div id="photoEditArea" data="#rc.emp_id#">
   <div id="originalArea">
   		<!--- TODO:  this hardcoding is bad! but relates to remote calls getting temp image directory from expand path and application paths building them properly 
		net result is that /testdir2 site under live site writes temp images to the live temp image folder
   		 --->
      <img id="tempImage" src="https://e-directory.tcgnws.com/assets/images/temp/#rc.newimage#">
   </div>
   <div id="controlsArea">
      <button id="savePreview">Save This Version</button>
   </div>
   <div id="previewArea" style="display:none;">
      <img id="preview" src="" style="display:none;">
   </div>
</div>
</cfoutput>