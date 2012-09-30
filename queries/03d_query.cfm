<cfquery name= "qryTask" result="qry" datasource="#application.dsn#" >
	select 
		t.task_id as ticketNumber
		,t.name  as task
		,p.name as person
	from 
		(tbl_task t
		inner join tbl_person_task pt on t.task_id=pt.task_id)
		inner join tbl_person p on p.person_id=pt.person_id
	order by 
		t.task_id
		,p.name
</cfquery>

