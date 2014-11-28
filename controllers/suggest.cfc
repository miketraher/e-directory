component {
   // this is the edit function that gives accessto admin functions
   public any function init( fw ) {
      variables.fw = fw;
      return this;
   }

   public void function endSendSuggest ( rc ) {

      if (len(rc.data.message) ) {
         rc.message = rc.data.message;
         rc.subject = rc.data.subject;
         rc.suggestion = rc.data.suggestion;
         variables.fw.redirect('suggest.showForm','message,subject,suggestion');
      } else {
         variables.fw.redirect('suggest.ThankYou');
      }
   }

}