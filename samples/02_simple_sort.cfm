<h2>Simple Sort</h2>
<cfinclude template = "../queries/02_query.cfm" />

<cfinclude template="_qryInfo.cfm" >

<h3>Looping using cfoutput</h3>
<cfoutput query="qryPerson">
	#qryPerson.person_id# -- #qryPerson.name# <br /> 
</cfoutput>
	
	
<h3>Looping using cfloop</h3>	 
<cfloop query="qryPerson">
	<cfoutput>#qryPerson.person_id# -- #qryPerson.name# <br /></cfoutput> 
</cfloop>
	