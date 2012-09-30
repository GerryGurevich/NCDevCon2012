<h2>Using subselects</h2>
<cfinclude template = "../queries/05b_query.cfm" />

<cfinclude template="_qryInfo.cfm" >
<cfoutput query="qryTask" group="tasknumber">
	<h3>Task:  #qryTask.tasknumber#</h3>
	<h4>Leader:  #qryTask.leader#</h4>
		<table>
			<tr>
				<th>Staff</th>
				<th>First Activity</th>
				<th>Last Activity</th>
			</tr>
			<cfoutput>
				<tr>
					<td>#qryTask.worker#</td>
					<td>#dateformat(qryTask.first_entry)#</td>
					<td>#dateformat(qryTask.last_entry)#</td>				
				</tr>
			</cfoutput>
		</table>
	<br />
</cfoutput>
