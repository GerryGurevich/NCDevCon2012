<a name="top"></a>
<h2>With Bookmarks</h2>
<cfinclude template = "../queries/04b_query.cfm" />

<cfinclude template="_qryInfo.cfm" >

<cfset bookmarks = "" />

<cfsavecontent variable="table" >
	<cfoutput query="qryTask" group="leader" >
		<cfsavecontent variable="temp" >
			<li><a href="###lcase(qryTask.leader)#">#qryTask.leader#</a></li>
		</cfsavecontent>
		<cfset bookmarks = bookmarks & temp />
		<a name="#lcase(qryTask.leader)#"></a><h3>Lead #qryTask.leader#</h3>
		<cfoutput group = "ticketNumber">
			<h4>Task## #qryTask.ticketNumber#<h4>
			<h5>Staff</h5>
			<ul>
				<cfoutput >
					<li>#qryTask.person# -- #qryTask.email#</li>
				</cfoutput>	
			</ul>
		</cfoutput> <!--- group = "ticketNumber" --->
		<a href="##top">top</a>	
	</cfoutput> <!--- group="leader" --->
</cfsavecontent>
<cfoutput>
	<ul>
		#bookmarks#
	</ul>
	#table#
</cfoutput>