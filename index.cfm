<h2>Looping and Grouping Samples</h2>
<cfif structkeyexists(application,"filelist")>
	<cfset qryfilelist = application.filelist>
<cfelse>
	<cfdirectory action="list" directory="#application.samplefilepath#" name="qryfilelist" >
	<cflock scope="Application" timeout="10" throwontimeout="true" >
		<cfset application.filelist=qryfilelist />	
	</cflock> 
</cfif>
<a href="preso/Looping%20And%20Grouping.pptx">Presentation Slides</a>
<ul>
	<cfset last = "">
	<cfoutput query="qryfilelist" >
		<cfset current=left(qryfilelist.name,2) />
		<cfif isnumeric(current) > <!--- ignore any special include files.  All example files start with 2 digits --->
			<cfif qryfilelist.recordcount neq 1>
				
				<cfif last neq current>
					<br />
				</cfif>
				<cfset last=current>
			</cfif>
			<li><a href="samples/#qryfilelist.name#">#qryfilelist.name#</a></li>
		</cfif>
	</cfoutput>
</ul>