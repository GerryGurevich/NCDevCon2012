<h2>Collection and Search</h2>

<cfif structkeyexists(form,"term") and form.term neq "" >
	<cfset variables.term = form.term>
	<cfsearch collection="looping" name="qryLog" criteria="#form.term#"  >
	<cfdump var="#qryLog#">
<cfelse>
	<cfset variables.term = "" />		
</cfif>
<cfoutput>
	<form action="06b_search_dump.cfm" method="post">
		<input name="term" type="text" value="#variables.term#"> <br />
		<input type="submit" value="submit" /><br />
		Suggested Search Terms:  bookmarks, assigned, simple
	</form>	
</cfoutput>