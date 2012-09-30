<cfquery name= "qryPerson" result="qry" datasource="#application.dsn#" >
	select * from tbl_person
</cfquery>

<cfdump var="#qry#" label="qry" />
<cfdump var="#qryperson#" label="qryperson" />