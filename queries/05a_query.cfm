<cfquery name= "qryTask" result="qry" datasource="#application.dsn#" >
	select 
		lead.name as leader
		,count(*) as tickets
	from 
		(tbl_task t
		left join tbl_person lead on lead.person_id = t.lead_id)
	group by 
		lead.name
	order by 
		lead.name

</cfquery>
