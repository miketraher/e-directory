component extends="org.corfield.framework" {

	this.sessionManagement = true;
   this.datasource = "dir_sqlserver";

	variables.framework = {
		defaultSection = 'search',
         defaultItem = 'search',
      suppressImplicitService= false,
      reloadApplicationOnEveryRequest = true
      };
	/*
		This is provided for illustration only - you should not use this in
		a real program! Only override the defaults you need to change!
	variables.framework = {
		// the name of the URL variable:
		action = 'action',
		// whether or not to use subsystems:
		usingSubsystems = false,
		// default subsystem name (if usingSubsystems == true):
		defaultSubsystem = 'home',
		// default section name:
		defaultSection = 'search',
		// default item name:

		// if using subsystems, the delimiter between the subsystem and the action:
		subsystemDelimiter = ':',
		// if using subsystems, the name of the subsystem containing the global layouts:
		siteWideLayoutSubsystem = 'common',
		// the default when no action is specified:
		home = defaultSubsystem & ':' & defaultSection & '.' & defaultItem,
		-- or --
		home = defaultSection & '.' & defaultItem,
		// the default error action when an exception is thrown:
		error = defaultSubsystem & ':' & defaultSection & '.error',
		-- or --
		error = defaultSection & '.error',
		// the URL variable to reload the controller/service cache:
		reload = 'reload',
		// the value of the reload variable that authorizes the reload:
		password = 'true',
		// debugging flag to force reload of cache on each request:
		reloadApplicationOnEveryRequest = false,
		// whether to force generation of SES URLs:
		generateSES = false,
		// whether to omit /index.cfm in SES URLs:
		SESOmitIndex = false,
		// location used to find layouts / views:
		base = getDirectoryFromPath( CGI.SCRIPT_NAME ),
		// either CGI.SCRIPT_NAME or a specified base URL path:
		baseURL = 'useCgiScriptName',
		// location used to find controllers / services:
		// cfcbase = essentially base with / replaced by .
		// whether FW/1 implicit service call should be suppressed:
		suppressImplicitService = true,
		// list of file extension_numbers that FW/1 should not handle:
		unhandledextension_numbers = 'cfc',
		// list of (partial) paths that FW/1 should not handle:
		unhandledPaths = '/flex2gateway',
		// flash scope magic key and how many concurrent requests are supported:
		preserveKeyURLKey = 'fw1pk',
		maxNumContextsPreserved = 10,
		// set this to true to cache the results of fileExists for performance:
		cacheFileExists = false,
		// change this if you need multiple FW/1 applications in a single CFML application:
		applicationKey = 'org.corfield.framework'
	};
	*/
   function setupApplication() {
      // use setupApplication to do initialization per application
      param name="session.isLoggedIn" type="boolean" default="false";
      debug_service = createobject("java","coldfusion.server.ServiceFactory").getDebuggingService();
      debug_service.setEnabled(false);
      application.imageURL = "#framework.base#/assets/images/";

      if (ucase(cgi.https) EQ 'OFF') {
         application.protocol = 'http://';
      }
      else {
         application.protocol = 'https://';
      }
      if (listFirst(server.coldfusion.productversion) EQ '10') {
	  	application.scriptname = listlast(cgi.script_name,'/');
    	application.rootPath = left(cgi.script_name,len(cgi.script_name) - len(application.scriptname));
      }
      else {
        application.scriptname = listlast(cgi.path_info,'/');
        application.rootPath = left(cgi.path_info,len(cgi.path_info) - len(application.scriptname));
      }
      application.rootUrl = application.protocol & cgi.server_name & application.rootPath;
      application.imageURL = application.rootURL & 'assets/images/';

      application.imagePath = "#expandPath(application.rootPath)#assets\images\";
      application.dataPath = "#expandPath(application.rootPath)#assets\data\";
      application.qctry = createObject("component","services.lookups").showCtry();
      application.utils = createObject("component","services.utils");
      try {
         application.rudewords = fileRead("#application.dataPath#swearWords.csv");
      }
      catch(any e) {return;};
      if (cgi.server_name EQ 'localhost') {
         application.emailtouse = 'michael.traher@gmail.com';
      } else {
         application.emailtouse = 'suggestions@thecollinsongroup.com';
      }
   }

	function setupSession() {
		// use setupSession to do initialization per session
		param name="session.isLoggedIn" type="boolean" default="false";

	}

   function setupRequest() {
      // use setupRequest to do initialization per request
      if (structKeyExists(url,"appreload") and url.appreload) {
         setupApplication();
      }
      request.imagePath = application.imagePath;
      request.context.startTime = getTickCount();
      param name="session.isLoggedIn" type="boolean" default="false";
      if (rc.action NEQ 'auth') {
         controller('auth.checkLoggedIn');
      };
      debug_service = createobject("java","coldfusion.server.ServiceFactory").getDebuggingService();
      debug_service.setEnabled(true);
   }

}