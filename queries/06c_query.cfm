<cfquery name= "qryTask" result="qry" datasource="#application.dsn#" >
	select 
		t.LEAD_ID
		,t.NAME
		,CStr(t.TASK_ID) as task_id 
		,p.name as staff
		,l.log
		,l.date as log_date
	from
		(tbl_task t
		inner join tbl_log l on t.task_id=l.task_id)
		inner join tbl_person p on p.person_id = l.person_id
</cfquery>

