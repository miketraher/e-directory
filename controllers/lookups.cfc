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
   public void function endSaveCtry ( rc ) {
      local.returnto = 'lookups.' & rc.data.mode &'ctry';

      if (len(rc.data.message) ) {
         rc.message = rc.data.message;
         variables.fw.redirect(local.returnto,'ctry_id,message');
      } else {
         variables.fw.redirect('lookups.showctry');
      }
   }
   public void function endDeleteCtry ( rc ) {

         variables.fw.redirect('lookups.showctry');
   }
   public void function EditSite ( rc ) {

      // queue up a service to get countries
         variables.fw.service( 'lookups.showctry', 'qctry' );
   }
   public void function InsertSite ( rc ) {

      // queue up a service to get countries
         variables.fw.service( 'lookups.showctry', 'qctry' );
   }

   public void function endSaveSite ( rc ) {
      local.returnto = 'lookups.' & rc.data.mode &'site';

      if (len(rc.data.message) ) {
         rc.message = rc.data.message;
         variables.fw.redirect(local.returnto,'site_id,message');
      } else {
         variables.fw.redirect('lookups.showsite');
      }
   }
   public void function endDeleteSite ( rc ) {

         variables.fw.redirect('lookups.showsite');
   }
//  floor level lookup maintenance
   public void function EditDesk ( rc ) {

      // queue up a service to get sites
         variables.fw.service( 'lookups.showsite', 'qsite' );
   }
   public void function InsertDesk ( rc ) {

      // queue up a service to get sites
         variables.fw.service( 'lookups.showsite', 'qsite' );
   }

   public void function endSaveDesk ( rc ) {
      local.returnto = 'lookups.' & rc.data.mode &'desk';

      if (len(rc.data.message) ) {
         rc.message = rc.data.message;
         variables.fw.redirect(local.returnto,'desk_location_id,message');
      } else {
         variables.fw.redirect('lookups.showdesk');
      }
   }
   public void function endDeleteDesk ( rc ) {

         variables.fw.redirect('lookups.showdesk');
   }
//  division lookup maintenance

   public void function endSavedivision ( rc ) {
      local.returnto = 'lookups.' & rc.data.mode &'division';

      if (len(rc.data.message) ) {
         rc.message = rc.data.message;
         variables.fw.redirect(local.returnto,'division_id,message');
      } else {
         variables.fw.redirect('lookups.showdivision');
      }
   }
   public void function endDeletedivision ( rc ) {

         variables.fw.redirect('lookups.showdivision');
   }
//  company lookup maintenance

   public void function endSaveCompany ( rc ) {
      local.returnto = 'lookups.' & rc.data.mode &'company';

      if (len(rc.data.message) ) {
         rc.message = rc.data.message;
         variables.fw.redirect(local.returnto,'company_id,message');
      } else {
         variables.fw.redirect('lookups.showCompany');
      }
   }
   public void function endDeleteCompany ( rc ) {

         variables.fw.redirect('lookups.showCompany');
   }
//  dept lookup maintenance

   public void function endSavedept ( rc ) {
      local.returnto = 'lookups.' & rc.data.mode &'dept';

      if (len(rc.data.message) ) {
         rc.message = rc.data.message;
         variables.fw.redirect(local.returnto,'dept_id,message');
      } else {
         variables.fw.redirect('lookups.showdept');
      }
   }
   public void function endDeletedept ( rc ) {

         variables.fw.redirect('lookups.showdept');
   }

}