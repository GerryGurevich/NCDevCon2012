<cfcomponent>
		<cffunction name = "getName" output="no" returntype="string">    
    		<cfargument name="person_id" type="numeric" required="yes" hint="I am the person_id that you wish to retrieve" />
			<cfquery name="local.qryName" datasource="#application.dsn#" >
				select name from tbl_person where person_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.person_id#" />				
			</cfquery>
    		<cfreturn local.qryName.name>    
    	</cffunction>

</cfcomponent>