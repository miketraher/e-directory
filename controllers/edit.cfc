component {
	// this is the edit function that allows logged in users to amend entries
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}

   public void function edit( rc ) {
      // this is edit

   }
   public void function processPhoto( rc ) {
      // this is edit
      if ( NOT len(rc.FileField)  ) {
         // no file submitted
         variables.fw.redirect('edit.edit','emp_id');
      }
   }

   public void function endProcessPhoto( rc ) {
      // this action
      rc.detailOn = false;
      rc.photoCrop = true;
      rc.newimage = rc.data.newimage;
      rc.newimageext = rc.data.newimageext;
      rc.action = 'edit.edit';
      if (rc.emp_id EQ 0) {
         rc.action = 'edit.insert';
      }

      variables.fw.redirect( rc.action ,'emp_id,detailOn,photoCrop,newimage,newimageext');
   }

   public void function endDelete( rc ) {
      // this action
      rc.detailOn = false;
      rc.photoCrop = false;

      variables.fw.redirect('search.search','emp_id,detailOn,photoCrop');
   }

   public void function endSavePhoto( rc ) {
      // this action
      rc.detailOn = false;
      rc.photoCrop = false;

      variables.fw.redirect('search.search','emp_id,startletter,detailOn,photoCrop,data');
   }

   public void function endSave( rc ) {
      // this action
      rc.detailOn = false;
      rc.photoCrop = false;
      local.mode = rc.data.mode;
      if (structkeyexists(rc.data,"success") and rc.data.success) {
         if (local.mode == 'insert') {
            // successful insert - move to edit to do photo
		      if (structkeyexists(rc.data,"new_emp_id")) {
		         rc.emp_id = rc.data.new_emp_id;
		         variables.fw.redirect('edit.edit','emp_id');
		      }
         }
         // else success but from edit - return to search
         variables.fw.redirect('search.search','emp_id,startletter,detailOn,photoCrop,data');
      } else {
         // failure of edit or insert - return to save action
         rc.olddata = rc.data.olddata;
         rc.error = rc.data.error;
         rc.errormessage = rc.data.errormessage;
         variables.fw.redirect('edit.#trim(local.mode)#','emp_id,olddata,error,errormessage');
      }

   }
}