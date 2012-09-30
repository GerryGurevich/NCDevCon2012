<cfcomponent>
		<cffunction name = "getPeople" output="no" returntype="array">    
    		<cfargument name="task_id" type="numeric" required="yes"  />
			<cfquery name="local.qryName" datasource="#application.dsn#" >
				select 
					p.name 
				from
					tbl_person p
					inner join tbl_person_task pt on p.person_id=pt.person_id
				where pt.task_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.task_id#" />				
			</cfquery>
			<cfset local.retValue= arraynew(1) />
			<cfset local.i=0 />  <!--- Don't worry...we are going to refactor this part --->
			<cfloop query="local.qryName" >
				<cfset local.i ++ />
				<cfset local.retvalue[local.i] = local.qryName.name />			
			</cfloop>
    		<cfreturn local.retvalue>    
    	</cffunction>

</cfcomponent>