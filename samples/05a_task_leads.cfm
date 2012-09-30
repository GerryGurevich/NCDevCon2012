<h2>Nice List Version</h2>
<cfinclude template = "../queries/05a_query.cfm" />

<cfinclude template="_qryInfo.cfm" >


<table>
	<tr>
		<th>Lead</th>
		<th>Tasks</th>
	</tr>
	<cfoutput query="qryTask" >
		<tr>
			<td>#qryTask.leader#</td>
			<td>#qryTask.tickets#</td>
		</tr>
	</cfoutput>
 </table>