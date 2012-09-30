
<cfset application.objUtilities = createObject("component","looping.components.utilities") />	


<h2>Nice List Version</h2>
<cfinclude template = "../queries/04c_query.cfm" />

<cfinclude template="_qryInfo.cfm" >

<cfparam name="url.startrow" default="1">
<cfquery name="qryTasklet" dbtype="query" >
	select 
		* 
	from 
		qryTask 
	where 
		rownum >= <cfqueryparam cfsqltype="cf_sql_integer" value="#url.startrow#" />
		and rownum < <cfqueryparam cfsqltype="cf_sql_integer" value="#url.startrow + application.rowsperpage#" />
</cfquery>
<!---
<cfdump var="#qryTask#" label="qryTask" />
<cfdump var="#qryTasklet#" label="qryTasklet" /><cfabort>
--->
<cfset args = {
	totalItems = qryTasklet.total_tasks,
	currentRow = url.startRow,
	rowsperpage=application.rowsperpage,
	itemlabel = "Open Tickets",
	targetLink="04c_nice_list_version_pagination.cfm",
	targetParam="startrow"
}
/>

<cfset pagination = application.objUtilities.paginate(argumentcollection = args) />


<cfoutput>
	<cfloop array="#pagination#" index="item" >
		#item# :: 
	</cfloop>
</cfoutput>
<cfoutput query="qryTasklet" group="ticketNumber" >
	<h3>
		Row #qryTasklet.rownum# -- Task## #qryTasklet.ticketNumber# -- Lead #qryTasklet.leader#
	</h3>
		<h4>Staff</h4>
		<ul>
			<cfoutput >
				<li>#qryTasklet.person# -- #qryTasklet.email#</li>
			</cfoutput>	
		</ul>
</cfoutput>
