<cfquery name= "qryLocation" result="qry" datasource="#application.dsn#" >
	select 
		location_id
		,name 
	from 
		tbl_location 
	order by 
		name
</cfquery>

<cfdump var="#qrylocation#" label="qrylocation" />