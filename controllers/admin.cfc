component {
   // this is the edit function that gives accessto admin functions
   public any function init( fw ) {
      variables.fw = fw;
      return this;
   }
   public void function before( rc ) {
      // must be logged in to get here so session.admin_flag should exist
      if ( structkeyexists(session,"admin_flag") AND session.admin_flag ) {
         // user is a logged in admin - continue
      } else {

         variables.fw.redirect('search.search');
      }

   }

   public void function summaryReport( rc ) {

   }


   public void function default( rc ) {

   }

}