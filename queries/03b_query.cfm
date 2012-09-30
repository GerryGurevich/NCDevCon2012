﻿<cfquery name= "qryLocation" result="qry" datasource="#application.dsn#" >
	select 
		l.location_id
		,l.name  as location
		,p.name as person
	from 
		tbl_location l
		inner join tbl_person p on p.location_id=l.location_id
	order by 
		l.name
		,p.name
</cfquery>

<cfdump var="#qrylocation#" label="qrylocation" />