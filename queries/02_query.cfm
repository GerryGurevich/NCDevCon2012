<cfquery name= "qryPerson" result="qry" datasource="#application.dsn#" >
	select 
		person_id
		,name 
	from 
		tbl_person 
	order by 
		name
</cfquery>

<!---<cfdump var="#qryperson#" label="qryperson" />--->