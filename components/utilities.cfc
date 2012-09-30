<cfcomponent>
	<cffunction name = "paginate" output="no" returntype="array">        
		<cfargument name="totalItems" required="yes" type="numeric"  hint="I am the total number of items to paginate" />
		<cfargument name="currentRow" required="no" type="numeric" default="1" hint="I am the first row of this page" />
		<cfargument name="rowsPerPage" required="no" type="numeric" default="100" hint="I am the number of rows per page" />	
		<cfargument name="itemLabel" required="no" type="string" default="Item" hint="I am the label to display in the pagination" />	
		<cfargument name="targetLink" required="yes"  type="string" hint="I will go into the href attribute for creating the link.  I will be the page name" />
		<cfargument name="targetParam" required="no"  type="string" hint="I will go into the href attribute for creating the link.  I will be the url parameter to indicate which row" />
		
		<!---<cfset local.retValue = arrayNew(1) />--->
		<cfset local.retValue = [] />
		<cfset local.pages = ((arguments.totalItems-1) \ arguments.rowsPerPage) + 1 />
		<cfloop from="1" to="#local.pages#" index="local.thisPage" >
			<cfsilent>
				<cfsavecontent variable="local.listItem" >
					<cfset local.firstRow=(local.thisPage -1) * arguments.rowsPerPage +1 />
					<cfset local.lastRow= local.firstRow + arguments.rowsPerPage -1 /> 
					<cfif local.lastRow gt arguments.totalItems>
							<cfset local.lastRow = arguments.totalItems />
					</cfif>
					<cfif arguments.currentRow lte local.lastRow and arguments.currentRow gte local.firstRow >
						<cfoutput>#arguments.itemLabel# (#local.firstrow# - #local.lastRow#)</cfoutput>
					<cfelse>
						<cfoutput><a href = "#arguments.targetLink#?#arguments.targetParam#=#local.firstRow#">#arguments.itemLabel# (#local.firstrow# - #local.lastRow#)</a></cfoutput>
					</cfif>
				</cfsavecontent>
			</cfsilent>
			<cfset local.retValue[local.thisPage] = local.listItem />
		</cfloop>		
		<cfreturn local.retValue>        
	</cffunction>
</cfcomponent>