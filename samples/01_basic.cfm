<h2>Basic Elements of CFQUERY</h2>
<cfinclude template = "../queries/01_query.cfm" />

<cfinclude template="_qryInfo.cfm" >

<cfoutput query="qryPerson">
	#qryPerson.person_id# -- #qryPerson.name# <br /> 
</cfoutput>
	
	
	 