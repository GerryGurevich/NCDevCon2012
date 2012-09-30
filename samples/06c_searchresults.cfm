<h2>Collection and Search</h2>
<cfinclude template = "../queries/06c_query.cfm" />

<cfif structkeyexists(form,"term") and form.term neq "" >
	<cfset variables.term = form.term>
	<cfsearch collection="looping" name="qryLog" criteria="#form.term#"  >

	<cfquery name="qryResult" dbtype="query"  >
		select distinct
			qryTask .*
		from 
			qryLog 
			,qryTask 
		where 
			qryLog.custom1= qryTask.task_id
		order by 
			qryTask.task_id
			,qryTask.staff
			,qryTask.log_date desc
	</cfquery>
	<cfoutput query="qryResult" group="task_id">
	<h3>Task:  #qryResult.task_id#</h3>
		<table>
			<tr>
				<th>Staff</th>
				<th>Action</th>
				<th>Date</th>
			</tr>
			<cfoutput >
				<tr>
					<td>#qryResult.staff#</td>
					<td>#qryResult.log#</td>
					<td>
						#dateformat(qryResult.log_date)#<br />
						#timeformat(qryResult.log_date)#
					</td>				
				</tr>
			</cfoutput>
		</table>
	<br />
</cfoutput>

	
<cfelse>
	<cfset variables.term = "" />		
</cfif>




<cfoutput>
	<form action="06c_searchresults.cfm" method="post">
		<input name="term" type="text" value="#variables.term#"> <br />
		<input type="submit" value="submit" /><br />
		Suggested Search Terms:  bookmarks, assigned, simple
	</form>	
</cfoutput>