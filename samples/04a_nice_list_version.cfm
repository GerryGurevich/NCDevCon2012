<h2>Nice List Version</h2>
<cfinclude template = "../queries/04a_query.cfm" />

<cfinclude template="_qryInfo.cfm" >


<cfoutput query="qryTask" group="ticketNumber" >
	<h3>
				Task## #qryTask.ticketNumber# -- Lead #qryTask.leader#
	</h3>
		<h4>Staff</h4>
		<ul>
			<cfoutput >
				<li>#qryTask.person# -- #qryTask.email#</li>
			</cfoutput>	
		</ul>
</cfoutput>
