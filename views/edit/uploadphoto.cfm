<cfset request.layout = false>
<cfparam name="rc.data.newImageExt" default="jpg">
<cfparam name="rc.data.newImage" default="dummy">
<cfparam name="rc.emp_id" default="0">



<cfoutput>
<form id="uploadForm" method="post" enctype="multipart/form-data" action="#buildUrl(action='edit.processphoto')#">
   <input type="hidden" name="emp_id" value="#rc.emp_id#">
   <input type="hidden" name="startletter" value="#rc.startletter#">
   <input name="fileField" id="filedata" type="file">
   <input  type="submit" id="photoUpload" name="uploadPhoto" value="upload photo">
</form>
</cfoutput>