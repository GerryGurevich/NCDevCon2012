<cfquery name= "qryTask" result="qry" datasource="#application.dsn#" >
	select 
		t.task_id as ticketNumber
		,t.name  as task
		,p.name as person
		,l.name as location
		,lead.name as leader
		,lead_loc.name as leader_location
		,p.*
	from 
		((((tbl_task t
		inner join tbl_person_task pt on t.task_id=pt.task_id)
		inner join tbl_person p on p.person_id=pt.person_id)
		inner join tbl_location l on l.location_id=p.location_id)
		inner join tbl_person lead on lead.person_id = t.lead_id)
		inner join tbl_location lead_loc on lead_loc.location_id=lead.location_id
	order by 
		t.task_id
		,lead.name
		,p.name
		
</cfquery>

