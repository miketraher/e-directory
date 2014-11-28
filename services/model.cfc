component {

	public string function longdate( any when ) {
		return dateFormat( when, 'long' );
	}

   remote boolean function isLoggedin () {
      if structKeyExists(session,"loggedin") and session.loggedin {
         return true;
      }
      return false;
   }

}