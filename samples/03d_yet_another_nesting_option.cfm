<h1>An Alternative to Nested Components in a Loop</h1>
<cfinclude template = "../queries/03d_query.cfm" />

<cfinclude template="_qryInfo.cfm" >

<cfoutput query="qryTask" group="ticketNumber" >
	<h3>Task## #qryTask.ticketNumber#</h3>
	<h4>Staff</h4>
	<ul>
		<cfoutput >
			<li>#qryTask.person#</li>
		</cfoutput>	
	</ul>
</cfoutput>