<cfquery name= "qryTask" result="qry" datasource="#application.dsn#" >
	select 
		t.task_id as ticketNumber
		,t.name  as task
		,pt.person_id
	from 
		tbl_task t
		inner join tbl_person_task pt on t.task_id = pt.task_id
	order by 
		t.task_id
</cfquery>
