component {

   public any function init( fw ) {
      variables.fw = fw;
      return this;
   }
   public any function resultsGallery ( rc ) {

      variables.fw.service( 'search.resultsSummary', 'data');

   }




}