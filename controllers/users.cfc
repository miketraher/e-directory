component {
	// this is the edit function that allows logged in users to amend entries
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}

	public void function default( rc ) {

	}
   public void function before( rc ) {
      // must be logged in to get here so session.admin_flag should exist
      if ( structkeyexists(session,"admin_flag") AND session.admin_flag ) {
         // user is a logged in admin - continue
      } else {

         variables.fw.redirect('search.search');
      }

   }
   public void function endSave ( rc ) {
      local.returnto = 'users.' & rc.data.mode;

      if (len(rc.data.message) ) {
         rc.message = rc.data.message;
         variables.fw.redirect(local.returnto,'user_id,message');
      } else {
         variables.fw.redirect('users.showusers');
      }
   }
   public void function endDelete ( rc ) {

         variables.fw.redirect('users.showusers');
   }
}