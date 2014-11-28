<cfset request.layout=false>
<cfsetting showdebugoutput="false">
<cffile action="read" file="ram:///#url.filename#" variable="variables.mycsv">
<cfheader name="Content-disposition" value="attachment;filename=export.csv" >
<cfcontent type="text/csv" reset="true"><cfoutput>#variables.mycsv#</cfoutput>