<h1>Nested Components in a Loop</h1>
<h2>Breaking some rules for ease of programming</h2>
<cfinclude template = "../queries/03c_query.cfm" />

<cfinclude template="_qryInfo.cfm" >

<cfset objTask = createObject("component","looping.components.task") />
<cfoutput query="qryTask" group="ticketNumber" >
	<cfset people=objTask.getPeople(qryTask.person_id)>
	<h3>Task## #qryTask.ticketNumber#</h3>
	<h4>Staff</h4>
	<ul>
		<cfloop array="#people#" index="name" >
			<li>#name#</li>
		</cfloop>	
	</ul>
</cfoutput>