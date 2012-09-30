<h1>Better Nested Loops</h1>
<h2>Put more in the query</h2>
<cfinclude template = "../queries/03b_query.cfm" />
<cfinclude template="_qryInfo.cfm" >

<cfoutput query="qryLocation" group="location" >
	<h3>#qryLocation.location#</h3>
		<cfoutput>
	<ul>
			<li>#qryLocation.person#</li>
	</ul>
		</cfoutput>
		
</cfoutput>