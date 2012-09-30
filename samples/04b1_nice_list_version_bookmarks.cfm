<h2>Prepping for Bookmarks</h2>
<cfinclude template = "../queries/04b_query.cfm" />

<cfinclude template="_qryInfo.cfm" >

<cfoutput query="qryTask" group="leader" >
	<h3>Lead #qryTask.leader#</h3>
	<cfoutput group = "ticketNumber">
	<h4>Task## #qryTask.ticketNumber#</h4>
		<h5>Staff</h5>
		<ul>
			<cfoutput >
				<li>#qryTask.person# -- #qryTask.email#</li>
			</cfoutput>	
		</ul>
	</cfoutput>
</cfoutput>
