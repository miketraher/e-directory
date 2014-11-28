<!DOCTYPE HTML>
<html>
	<head>
		<!-- title set by a view - there is no default -->
		<title>TCG E-Directory (Live)</title>
      <!-- the meta tag below overrides compatibility mode in IE to stop weird stuff happening -->
      <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE" />
      <meta http-equiv="cache-control" content="no-cache">
      <meta http-equiv="Pragma" content="no-cache">
      <meta http-equiv="Expires" content="-1">
      <link rel="stylesheet" type="text/css" href="assets/css/fontface.css?_20141029">
      <link rel="stylesheet" type="text/css" href="assets/css/style.css?_20141029">
      <link rel="stylesheet" type="text/css" href="assets/css/custom-theme/jquery-ui-1.10.4.custom.css?_20141029">
      <link rel="stylesheet" type="text/css" href="assets/css/jquery.Jcrop.css?_20141029">
      <link rel="stylesheet" type="text/css" href="assets/css/token-input.css?_20141029">
      <link rel="stylesheet" type="text/css" href="assets/css/token-input-facebook.css?_20141029">
      <script type="text/javascript" src="assets/js/jquery.min.js?_20141029"></script>
      <script type="text/javascript" src="assets/js/jquery.tablesorter.min.js?_20141029"></script>
      <script type="text/javascript" src="assets/js/jquery-ui-1.10.4.custom.min.js?_20141029"></script>
      <script type="text/javascript" src="assets/js/jquery.Jcrop.min.js?_20141029"></script>
      <script type="text/javascript" src="assets/js/jquery.color.js?_20141029"></script>
      <script type="text/javascript" src="assets/js/jquery.slidingGallery-1.2.min.js?_20141029"></script>
      <script type="text/javascript" src="assets/js/jquery.cookie.js?_20141029"></script>
      <script type="text/javascript" src="assets/js/modernizr.custom.44994.js?_20141029"></script>
      <script type="text/javascript" src="assets/js/jquery.tokeninput.js?_20141029"></script>

      <!-- <script type="text/javascript" src="assets/js/autocomplete.js"></script>
      <script type="text/javascript" src="assets/js/json.js"></script> -->


      <cfparam name="rc.startletter" default="">
      <cfparam name="rc.detailOn" default="false">
      <cfparam name="rc.photocrop" default="false">
      <cfparam name="rc.emp_id" default="0">
      <cfparam name="rc.data.emp_ID" default="#rc.emp_id#">
      <cfparam name="rc.mode" default="view">
      <cfparam name="rc.newImageExt" default="png">
      <cfparam name="rc.newImage" default="default">
      <cfparam name="session.loggedin" default="false">
      <cfparam name="session.header" default="true">
      <cfif structkeyexists(rc,"data") AND structKeyExists(rc.data,"olddata") AND structKeyExists(rc.data.olddata,"last_name")>
         <cfset rc.startletter = rc.data.olddata.last_name>
      </cfif>
      <script type="text/javascript">
         var CFargs = new Object();
         CFargs.x = 103;
         CFargs.y= 34;
         CFargs.width = 148;
         CFargs.height = 192;
         CFargs.imageext = '<cfoutput>#rc.newImageExt#</cfoutput>';
         CFargs.inputImage = '<cfoutput>#rc.newImage#</cfoutput>';

         var startLetter = '<cfoutput>#rc.startletter#</cfoutput>';
         var detailOn = <cfoutput>#rc.detailOn#</cfoutput>;
         var photocrop = <cfoutput>#rc.photocrop#</cfoutput>;
         var empID = <cfoutput>#rc.data.emp_ID#</cfoutput>;
         var formMode = '<cfoutput>#rc.mode#</cfoutput>';
         var loggedin = '<cfoutput>#session.loggedin#</cfoutput>';
         var imageURL = '<cfoutput>#application.imageURL#</cfoutput>';
         var imagePath = "<cfoutput>#replacenocase(application.imagePath,'\','\\','ALL')#</cfoutput>";
         var rootURL = '<cfoutput>#application.rootUrl#</cfoutput>';
      </script>

      <script type="text/javascript" src="assets/js/dir.js?_20141029"></script>
		<script type="text/javascript">

		  var _gaq = _gaq || [];
		  _gaq.push(['_setAccount', 'UA-35207361-2']);
		  _gaq.push(['_trackPageview']);

		  (function() {
		    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		  })();

		</script>
	</head>
	<body>
      <img id="loaderImage" src="assets/images/ajax-loader.gif" style="display: none;">
      <cfsetting showdebugoutput="false" >
      <cfoutput>
      <cfsavecontent variable="variables.heading">
            <div style="padding-top: 10px;">
               <a href="#application.rootUrl#">
                  <img id="tcglogo" src="#application.imageurl#/icons/250914-e-directory.png" style="padding :27px 0 11px 0;" >
               </a>
               <a href="http://www.collinsongroup.com" >
                  <img id="tcglogo" src="#application.imageurl#/icons/101014-collinson-logo.png" style="float:right;">
               </a>
            </div>
      </cfsavecontent>
      <cfif request.section EQ 'suggest'>
         <cfsavecontent variable="variables.heading">
            <div style="color: ##c60c30; font-size: x-large; font-weight:bold; padding-top: 10px;float:left;">
               Collinson Suggestion Box
            </div>
         </cfsavecontent>
      </cfif>

      <cfif structkeyexists(rc,"header")>
			<cfif rc.header>
		         <cfset session.header = true>
			<cfelse>
		         <cfset session.header = false>
			</cfif>
      </cfif>
      <cfif session.header>
         <div style="  width:665px; border-bottom: solid 1px ##c0c0c0; padding-bottom: 10px; margin-bottom:20px; ">
            #variables.heading#
            
         </div>
      </cfif>
		#body#
      </cfoutput>
	</body>
</html>