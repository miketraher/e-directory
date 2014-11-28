component {
	// this is the edit function that allows logged in users to amend entries
	public any function init( fw ) {
		variables.fw = fw;

		return this;
	}

	public void function default( rc ) {

	}

	public void function checkLoggedIn( rc ) {
		// I run before each request called from application.cfc setupRequest to check for auth

      if ( needsLogin(rc.action) ) {
         rc.nextaction = rc.action;
         if (rc.action NEQ 'auth.login') {
	     		if (not session.isLoggedIn) {
               rc.message ="you must be logged in to carry out this action";
			   	variables.fw.redirect('auth.login','nextaction,emp_id,message');
			   }
		   }
      }
	}

   public void function login( rc ) {
      // check that username and password are passed in and are valid
      local.isValidLogin = false;
      if (structKeyExists(rc,'submit')) {

         // redirects to empty controller and service method
         variables.fw.redirect('auth.testlogin','user_id,password,nextaction,emp_id,message');

      } else {

         // drop through to form
      }

   }
   public void function endtestlogin( rc ) {
      // testlogin service will have checked user in DB
      if (structKeyExists(rc.data,'validLogin') AND rc.data.validLogin) {

         session.isLoggedIn = true;
         session.user_id = rc.data.user_id;
         session.admin_flag = rc.data.admin_flag;
         variables.fw.redirect(rc.nextaction,'emp_id');


      } else {

         rc.message ="invalid login details";
         variables.fw.redirect('auth.login','nextaction,emp_id,message');
      }

   }





   private boolean function needsLogin( action ) {
      // this function should check the
      local.needAuthActionList = 'edit.insert,edit.processPhoto,edit.cropPhoto,edit.savePhoto,users.showusers,users.edit,users.insert,admin.menu,lookups.menu,lookups.editctry,lookups.insertctry,lookups.showctry';
      if ( listFindNoCase(local.needAuthActionList,arguments.action) ) {

         return true;
      }
      return false;
   }


   public void function logout() {
      session.isLoggedIn = false;
      session.admin_flag = false;
      variables.fw.redirect('search.search');
   }

   public void function forgottenPassword( rc ) {
      // construct and store a one-time and time limited string
      // send this to email address for the current user

   }
   public void function passwordReset( rc ) {
      // process reset form - if new password OK store and show login screen
      // else show form



   }

}