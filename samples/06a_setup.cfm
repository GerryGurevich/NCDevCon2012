<h2>Collection and Search</h2>

<cfinclude template = "../queries/06_query.cfm" />

	<cftry>
		<cfcollection 	action="create"
	              		collection="looping"
	              		path="#application.collectionPath#"
				 		engine = "solr"
			  >
		<cfcatch>
			<cfif cfcatch.detail neq "There is already a collection registered with the Solr Search service by that name.">
				Problem creating collection<br />
				<cfdump var="#cfcatch#"><cfabort>
			</cfif>
		</cfcatch>
	</cftry>
	<cfindex action="purge" collection="looping">
	<cfindex action="UPDATE" 
			 collection="looping"
			 query="qryTask"
			 body = "log"
			 key="log_id"
			 custom1="task_id"	 
	>	
<cfoutput>
	<pre>
		#qry.sql#
#qry.ColumnList#		
	</pre>
</cfoutput>
