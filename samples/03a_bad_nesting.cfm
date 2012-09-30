<h1>Bad Nesting</h1>
<h2>cfquery within query loop</h2>
<cfinclude template = "../queries/03a_query.cfm" />
<cfinclude template="_qryInfo.cfm" >

<cfloop query="qryLocation" >
	<cfquery name="qryPerson" datasource="#application.dsn#" >
		select * from tbl_person where location_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qryLocation.location_id#" /> 
	</cfquery>
	<cfoutput><h3>#qryLocation.name#</h3></cfoutput>
		<ul>
			<cfoutput query="qryPerson" >
				<li>#qryPerson.name#</li>
			</cfoutput>
		</ul>	
</cfloop>