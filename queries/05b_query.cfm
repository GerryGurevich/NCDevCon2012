<cfquery name= "qryTask" result="qry" datasource="#application.dsn#" >
	select 
		task.task_id as tasknumber
		,task.name as task_name
		,lead.name as leader
		,ag.*
	from
		(tbl_task task
		inner join tbl_person lead on task.lead_id=lead.person_id) 
	 	left join ( 
				select 
					t.task_id 
					,p.name as worker
					,count(1)	as logItems
					,min(date) as first_entry
					,max(date) as last_entry
					
				from
					((tbl_task t
					left join tbl_log log on t.task_id=log.task_id)
					left join tbl_person p on p.person_id=log.person_id)	
				group by 
					t.task_id
					,p.name
		) ag on task.task_id = ag.task_id
	where 
		task.task_id <10
	order by 
		task.task_id
		,ag.worker
</cfquery>
