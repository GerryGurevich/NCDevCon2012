<cfquery name= "qryTask" result="qry" datasource="#application.dsn#" >
	select 
		t.task_id as ticketNumber
		,t.name  as task
		,p.name as person
		,l.name as location
		,lead.name as leader
		,lead_loc.name as leader_location
		,p.*
		,(select count(*) from tbl_task) as total_tasks
	from 
		((((tbl_task t
		left join tbl_person_task pt on t.task_id=pt.task_id)
		left join tbl_person p on p.person_id=pt.person_id)
		left join tbl_location l on l.location_id=p.location_id)
		left join tbl_person lead on lead.person_id = t.lead_id)
		left join tbl_location lead_loc on lead_loc.location_id=lead.location_id
	order by 
		lead.name
		,t.task_id
		,p.name
		
</cfquery>

<cfset arrRownum=[] /> 
<cfset i = 0 />
<cfoutput query="qryTask" group="ticketNumber" >
	<cfset i=i+1 />
	<cfoutput>
		<cfset arrRownum[qrytask.currentrow]=i />
	</cfoutput>
</cfoutput>
<cfset QueryAddColumn(qryTask, "rownum" ,arrRownum) />
