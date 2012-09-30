<cfprocessingdirective pageencoding="utf-8">
<cftry>
<cfif IsDebugMode()>
<cfsilent>
<cfset startTime = getTickCount()>
<cfscript>
	formEncoding = getEncoding("FORM");
	urlEncoding = getEncoding("URL");

	setEncoding("FORM", formEncoding);
	setEncoding("URL", urlEncoding);
</cfscript>
<!--- Localized strings --->
<cfset undefined = "">
	<!--- Use the debugging service to check options --->
	<cftry>
		<cfobject action="CREATE" type="JAVA" class="coldfusion.server.ServiceFactory" name="factory">
		<cfset cfdebugger = factory.getDebuggingService()>
		<cfcatch type="Any"></cfcatch>
	</cftry>

	<!--- Load the debugging service's event table --->
	<cfset qEvents = cfdebugger.getDebugger().getData()>

	<!--- Produce the filtered event queries --->
	<!--- EVENT: Templates --->
	<cftry>
		<cfquery dbType="query" name="cfdebug_templates" debug="false">
			SELECT template, parent, Sum(endTime - StartTime) AS et
			FROM qEvents
			WHERE type = 'Template'
			GROUP BY template, parent
			ORDER BY et DESC
		</cfquery>
		<cfscript>
			if( cfdebug_templates.recordCount eq 1 and len(trim(cfdebug_templates.et)) )
			{
				querySetCell(cfdebug_templates, "et", "0", 1);
			}
		</cfscript>
		<cfcatch type="Any">
			<cfscript>
				cfdebug_templates = queryNew('template, parent, et');
			</cfscript>
		</cfcatch>
	</cftry>


	<!--- EVENT: SQL Queries --->
	<cftry>
		<cfquery dbType="query" name="cfdebug_queries" debug="false">
			SELECT *, (endTime - startTime) AS executionTime
			FROM qEvents
			WHERE type = 'SqlQuery'
		</cfquery>
		<cfscript>
			if( cfdebug_queries.recordCount eq 1 and len(trim(cfdebug_queries.executionTime)) )
			{
				querySetCell(cfdebug_queries, "executionTime", "0", 1);
			}
		</cfscript>
		<cfcatch type="Any">
			<cfscript>
				cfdebug_queries = queryNew('ATTRIBUTES, BODY, CACHEDQUERY, CATEGORY, DATASOURCE, ENDTIME, EXECUTIONTIME, LINE, MESSAGE, NAME, PARENT, PRIORITY, RESULT, ROWCOUNT, STACKTRACE, STARTTIME, TEMPLATE, TIMESTAMP, TYPE, URL, et');
			</cfscript>
		</cfcatch>
	</cftry>


	<!--- EVENT: Object Queries --->
	<cftry>
		<cfquery dbType="query" name="cfdebug_cfoql" debug="false">
			SELECT *, (endTime - startTime) AS executionTime
			FROM qEvents
			WHERE type = 'ObjectQuery'
		</cfquery>
		<cfscript>
			if( cfdebug_cfoql.recordCount eq 1 and len(trim(cfdebug_cfoql.executionTime)) )
			{
				querySetCell(cfdebug_cfoql, "executionTime", "0", 1);
			}
		</cfscript>
		<cfcatch type="Any">
			<cfscript>
				cfdebug_cfoql = queryNew('ATTRIBUTES, BODY, CACHEDQUERY, CATEGORY, DATASOURCE, ENDTIME, EXECUTIONTIME, LINE, MESSAGE, NAME, PARENT, PRIORITY, RESULT, ROWCOUNT, STACKTRACE, STARTTIME, TEMPLATE, TIMESTAMP, TYPE, URL');
			</cfscript>
		</cfcatch>
	</cftry>

	<!--- EVENT: Environment Config--->
	<cftry>
		<cfquery dbType="query" name="cfdebug_cfoql" debug="false">
			SELECT *, (endTime - startTime) AS executionTime
			FROM qEvents
			WHERE type = 'ObjectQuery'
		</cfquery>
		<cfscript>
			if( cfdebug_cfoql.recordCount eq 1 and len(trim(cfdebug_cfoql.executionTime)) )
			{
				querySetCell(cfdebug_cfoql, "executionTime", "0", 1);
			}
		</cfscript>
		<cfcatch type="Any">
			<cfscript>
				cfdebug_cfoql = queryNew('ATTRIBUTES, BODY, CACHEDQUERY, CATEGORY, DATASOURCE, ENDTIME, EXECUTIONTIME, LINE, MESSAGE, NAME, PARENT, PRIORITY, RESULT, ROWCOUNT, STACKTRACE, STARTTIME, TEMPLATE, TIMESTAMP, TYPE, URL');
			</cfscript>
		</cfcatch>
	</cftry>

	<!--- EVENT: Stored Procedures --->
	<cftry>
		<cfquery dbType="query" name="cfdebug_storedproc" debug="false">
			SELECT *, (endTime - startTime) AS executionTime
			FROM qEvents
			WHERE type = 'StoredProcedure'
		</cfquery>
		<cfscript>
			if( cfdebug_storedproc.recordCount eq 1 and len(trim(cfdebug_storedproc.executionTime)) )
			{
				querySetCell(cfdebug_storedproc, "executionTime", "0", 1);
			}
		</cfscript>
		<cfcatch type="Any">
			<cfscript>
				cfdebug_storedproc = queryNew('ATTRIBUTES, BODY, CACHEDQUERY, CATEGORY, DATASOURCE, ENDTIME, EXECUTIONTIME, LINE, MESSAGE, NAME, PARENT, PRIORITY, RESULT, ROWCOUNT, STACKTRACE, STARTTIME, TEMPLATE, TIMESTAMP, TYPE, URL');
			</cfscript>
		</cfcatch>
	</cftry>

	<!--- EVENT: Trace Points --->
	<cftry>
		<cfquery dbType="query" name="cfdebug_trace" debug="false">
			SELECT *
			FROM qEvents
			WHERE type = 'Trace'
		</cfquery>
		<cfcatch type="Any">
			<cfscript>
				cfdebug_trace = queryNew('ATTRIBUTES, BODY, CACHEDQUERY, CATEGORY, DATASOURCE, ENDTIME, EXECUTIONTIME, LINE, MESSAGE, NAME, PARENT, PRIORITY, RESULT, ROWCOUNT, STACKTRACE, STARTTIME, TEMPLATE, TIMESTAMP, TYPE, URL');
			</cfscript>
		</cfcatch>
	</cftry>

	<!--- EVENT: CFTimer Points --->
	<cftry>
		<cfquery dbType="query" name="cfdebug_timer" debug="false">
			SELECT *
			FROM qEvents
			WHERE type = 'CFTimer'
		</cfquery>
		<cfcatch type="Any">
			<cfscript>
				cfdebug_timer = queryNew('ATTRIBUTES, BODY, CACHEDQUERY, CATEGORY, DATASOURCE, ENDTIME, EXECUTIONTIME, LINE, MESSAGE, NAME, PARENT, PRIORITY, RESULT, ROWCOUNT, STACKTRACE, STARTTIME, TEMPLATE, TIMESTAMP, TYPE, URL');
			</cfscript>
		</cfcatch>
	</cftry>

	<!--- EVENT: Locking Warning Points --->
	<cftry>
		<cfquery dbType="query" name="cfdebug_lock" debug="false">
			SELECT *
			FROM qEvents
			WHERE type = 'LockWarning'
		</cfquery>
		<cfcatch type="Any">
			<cfscript>
				cfdebug_lock = queryNew('ATTRIBUTES, BODY, CACHEDQUERY, CATEGORY, DATASOURCE, ENDTIME, EXECUTIONTIME, LINE, MESSAGE, NAME, PARENT, PRIORITY, RESULT, ROWCOUNT, STACKTRACE, STARTTIME, TEMPLATE, TIMESTAMP, TYPE, URL');
			</cfscript>
		</cfcatch>
	</cftry>

	<!--- EVENT: Exceptions --->
	<cftry>
		<cfquery dbType="query" name="cfdebug_ex" debug="false">
			SELECT *
			FROM qEvents
			WHERE type = 'Exception'
		</cfquery>
		<cfcatch type="Any">
			<cfscript>
				cfdebug_ex = queryNew('ATTRIBUTES, BODY, CACHEDQUERY, CATEGORY, DATASOURCE, ENDTIME, EXECUTIONTIME, LINE, MESSAGE, NAME, PARENT, PRIORITY, RESULT, ROWCOUNT, STACKTRACE, STARTTIME, TEMPLATE, TIMESTAMP, TYPE, URL');
			</cfscript>
		</cfcatch>
	</cftry>


	<!--- Establish Section Display Flags --->
	<cfparam name="displayDebug" default="false" type="boolean"><!--- ::	display the debug time 	:: --->
	<cfparam name="bGeneral" default="false" type="boolean">
	<cfparam name="bFoundExecution" default="false" type="boolean">
	<cfparam name="bFoundTemplates" default="false" type="boolean">
	<cfparam name="bFoundExceptions" default="false" type="boolean">
	<cfparam name="bFoundSQLQueries" default="false" type="boolean">
	<cfparam name="bFoundObjectQueries" default="false" type="boolean">
	<cfparam name="bFoundStoredProc" default="false" type="boolean">
	<cfparam name="bFoundTrace" default="false" type="boolean">
	<cfparam name="bFoundTimer" default="false" type="boolean">
	<cfparam name="bFoundLocking" default="false" type="boolean">
	<cfparam name="bFoundScopeVars" default="false" type="boolean">

	<cftry>
		<cfscript>
	        // no longer doing template query at the top since we have tree and summary mode
			bFoundTemplates = cfdebugger.check("Template");

			if( bFoundTemplates )
			{ displayDebug=true; }

			if ( isDefined("cfdebugger.settings.general") and cfdebugger.settings.general )
			{ bGeneral = true; displayDebug=true; }

			if (IsDefined("cfdebug_ex") AND cfdebug_ex.recordCount GT 0) { bFoundExceptions = true; displayDebug=true; }
			else { bFoundExceptions = false; }

			if (IsDefined("cfdebug_queries") AND cfdebug_queries.RecordCount GT 0) { bFoundSQLQueries = true; displayDebug=true; }
			else { bFoundSQLQueries = false; }

			if (IsDefined("cfdebug_cfoql") AND cfdebug_cfoql.RecordCount GT 0) { bFoundObjectQueries = true; displayDebug=true; }
			else { bFoundObjectQueries = false; }

			if (IsDefined("cfdebug_storedproc") AND cfdebug_storedproc.RecordCount GT 0) { bFoundStoredProc = true; displayDebug=true; }
			else { bFoundStoredProc = false; }

			if (IsDefined("cfdebug_trace") AND cfdebug_trace.recordCount GT 0) { bFoundTrace = true; displayDebug=true; }
			else { bFoundTrace = false; }

			if (IsDefined("cfdebug_timer") AND cfdebug_timer.recordCount GT 0) { bFoundTimer = true; displayDebug=true; }
			else { bFoundTimer = false; }

			if (IsDefined("cfdebug_lock") AND cfdebug_lock.recordCount GT 0) { bFoundLocking = true; displayDebug=true; }
			else { bFoundLocking = false; }

			if (IsDefined("cfdebugger") AND cfdebugger.check("Variables")) { bFoundScopeVars = true; displayDebug=true; }
			else { bFoundScopeVars = false; }
		</cfscript>
		<cfcatch type="Any"></cfcatch>
	</cftry>
</cfsilent>
<cfsetting enablecfoutputonly="Yes">
<cfif displayDebug>

<cfoutput>
<style type="text/css">
/* DEBUG PANEL MAIN */
.fw_debugPanel{
    font-family: Arial,Helvetica,sans-serif;
    font-size: 11px;
    font-weight: normal;
    color: black;
	background-color:##eee;
    text-align: left;
}
.fw_titles{
    font-size: 13px;
    font-weight:bold;
    color: white;
    background-color: ##134A7A;
    padding:5px 5px 5px 5px;
    cursor: pointer;
	border:1px outset ##eee;
}
.fw_titles:hover{
   background: ##B9D3FB;
   color: black;
   cursor: pointer;
}
.fw_tracerMessage{
    padding:5px 5px 5px 5px;
    border:1px solid ##3366CC;
    background-color: ##fff;
    color: black;
}
.fw_debugContent{
    display:none;
}
.fw_debugContentView{
    padding: 5px 5px 5px 5px;
    display:block;
    margin:auto;
}
.fw_debugTitleCell{
    font-weight:bold;
    float:left;
    width: 130px;
    clear:left;
    height:  20px;
}
.fw_debugContentCell{
    clear:right;
    height: 20px;
}
.fw_renderTime{
	margin-top: 20px;
	margin-bottom: 20px;
	font-weight: bold;
	font-style: italic;	
}
/* END OF DEBUG PANEL MAIN */

/* Types of Text To Render in Spans */
.fw_redText{
	font-weight:bold;
	color:##CC0000;
}
.fw_greenText{
	color: ##336600;
	font-weight:bold;
}
.fw_blueText{
	font-weight:bold;
	color: ##0022AA;
}
.fw_blackText{
	font-weight:bold;
	color: ##000000;
}
.fw_purpleText{
	font-weight:bold;
	color: ##67306A;
}
.fw_errorText{
	font-size: 12px;
	color: ##666666;
	font-weight:bold;
}
/* END OF COLORS */

/* Debugging Tables */
.fw_debugTables{
	font-size: 11px;
	border:1px outset ##93C2FF;
	background: ##eeeeee;
	width: 99%;
}
.fw_debugTables th{
	font-size: 11px;
	background: ##CFE9FF;
	font-weight:bold;
	padding: 5px 5px 5px 5px;
	text-align:center;
}
.fw_debugTables tr{
	background-color: white;
}
.fw_debugTables tr:hover{
	background-color: ##FEFFAF;
}
.fw_debugTables tr:nth-child(even){
	background-color: ##EFF6FF;
}
.fw_debugTables tr:nth-child(odd):hover{
	background-color: ##FEFFAF;
}
.fw_debugTables td{
	padding: 5px 5px 5px 5px;
	font-size: 11px;
}
.fw_debugTables tr.showRC{
	display: table-row;
}
.fw_debugTables tr.hideRC{
	display: none;
}
.fw_cachetable{
	overflow: auto;
	height: 375px;
	border: 2px inset ##cccccc;
	background: white;
}
/* END OF Debugging Tables */

.fw_errorTables{
	font-size: 12px;
	font-family: verdana;
	border:1px outset ##000000;
	background: ##fff;
	width: 99%;
}
.fw_errorTables th{
	background: ##969491;
	color:##000000;
	font-weight: bold;
	padding:5px 5px 5px 5px;
}
.fw_errorTables td{
	font-size: 10px;
	background-color: ##ffffff;
	border: 1px dotted ##cccccc;
	padding: 5px 5px 5px 5px;
}
.fw_errorTables td.fw_errorTablesTitles{
	font-size: 10px;
	font-weight: bold;
	background-color: ##EDEDEA;
	padding: 5px 5px 5px 5px;
}
.fw_overflowScroll{
	width: 600px;
	overflow:scroll;
	height: 300px;
}
pre.cfdebugquery {
	margin:20px;
	}
span.cfqueryparam,
span.cfdebugcachedquery {
	color: blue;
	}
h4.cfdebugvariable {
	font-size:1.1em;
	font-weight:bold;
	margin-top:10px;
	}

h4.cfdebugqueryparam {
	font-weight:bold;
	padding-left:20px;
	}
ul.cfdebugqueryparams {
	margin:0;
	padding:0;
	padding-left:35px;
	}

ul.cfdebugqueryparams li {
	list-style:none;
	padding:2px 0;
	}

ul.cfdebugqueryparams li span {
	color: blue;
	}
.cfdebug code, .cfdebug pre, td.cfdebug, table.cfdebug, pre.cfdebugquery, ##fw_scope pre  {
	font-family: Arial, sans-serif;
	line-height: 1.5em;
	}
.fw_debugToolbar{
padding: .5em; margin: 0; width:50%;
}
.fw_debugButton{
   outline: 0; 
   margin:0 4px 0 0; 
   padding: .4em 1em; 
   text-decoration:none !important; 
   cursor:pointer; 
   position: relative; 
   text-align: center; 
   zoom: 1; 
}
</style>
<script type="text/javascript">
function fw_toggle(divid){
	if ( document.getElementById(divid).className == "fw_debugContent ui-widget-content"){
		document.getElementById(divid).className = "fw_debugContentView ui-widget-content";
		setCookie(divid,1);
	}
	else{
		document.getElementById(divid).className = "fw_debugContent ui-widget-content";
		setCookie(divid,0);
	}
}
function setCookie(c_name,value){
	var expiredays = 40;
	var exdate=new Date();
	exdate.setDate(exdate.getDate()+expiredays);
	document.cookie=c_name+ "=" +escape(value)+
	((expiredays==null) ? "" : ";expires="+exdate.toGMTString());
}
</script>
<div style="margin-top:40px"></div>
<div class="fw_debugPanel ui-widget">
</cfoutput>
</cfif>

<cfif bGeneral>
<cfoutput>
	<cftry>
	<div class="ui-widget">
		<div class="fw_titles ui-widget-header" onclick="fw_toggle('fw_info')" >&gt; Debugging Information</div>
		<div class="fw_debugToolbar ui-widget-content">
			<cfset currentaddress = "#cgi.script_name#?#cgi.query_string#" />
			
			<!--- if the current address doesn't already include 'flush', append it --->
			<cfif not StructKeyExists(url,"reset")>
				<cfset currentaddress = currentaddress & "&reset" />
			</cfif>
			<a href="#currentaddress#" class="fw_debugButton ui-state-default ui-corner-all" title="Reinitialize">Reinitialize</a>
		  <br>
		</div>
		<div class="fw_debugContent<cfif structkeyexists(cookie,"fw_info") and cookie.fw_info>View</cfif> ui-widget-content" id="fw_info">
			<div class="fw_debugTitleCell">#server.coldfusion.productname#</div>
			<div class="fw_debugContentCell">#server.coldfusion.productversion#</div>
			<div class="fw_debugTitleCell"> Template </div>
			<div class="fw_debugContentCell">#xmlFormat(CGI.Script_Name)#</div>
			<div class="fw_debugTitleCell"> Time Stamp </div>
			<div class="fw_debugContentCell">#DateFormat(Now())# #TimeFormat(Now())#</div>
			<div class="fw_debugTitleCell"> Locale </div>
			<div class="fw_debugContentCell">#GetLocale()#</div>
			<div class="fw_debugTitleCell"> User Agent </div>
			<div class="fw_debugContentCell">#CGI.HTTP_USER_AGENT#</div>
			<div class="fw_debugTitleCell"> Remote IP </div>
			<div class="fw_debugContentCell">#CGI.REMOTE_ADDR#</div>
			<div class="fw_debugTitleCell"> Host Name </div>
			<div class="fw_debugContentCell">#CGI.REMOTE_HOST#</div>
		</div>
	</div>
		<cfcatch type="Any"></cfcatch>
	</cftry>
</cfoutput>
</cfif>


<!--- Template Stack and Executions Times --->
<cfif bFoundTemplates>

	<cfquery dbType="query" name="templates_in_order" debug="false">
		SELECT template, parent, endTime - StartTime AS et
		FROM qEvents
		WHERE type = 'Template'
		ORDER BY starttime asc, parent
	</cfquery>


  	<!--- Total Execution Time of all top level pages --->
  	<cfquery dbType="query" name="cfdebug_execution" debug="false">
      	SELECT (endTime - startTime) AS executionTime
      	FROM qEvents
      	WHERE type = 'ExecutionTime'
  	</cfquery>
	<!--- ::
		in the case that no execution time is recorded.
		we will add a value of -1 so we know that a problem exists but the template continues to run properly.
		:: --->
	<cfif not cfdebug_execution.recordCount>
		<cfscript>
			queryAddRow(cfdebug_execution);
			querySetCell(cfdebug_execution, "executionTime", "-1");
		</cfscript>
	</cfif>

  	<cfquery dbType="query" name="cfdebug_top_level_execution_sum" debug="false">
  		SELECT sum(endTime - startTime) AS executionTime
	  	FROM qEvents
  		WHERE type = 'Template' AND parent = ''
  	</cfquery>

    <!--- File not found will not produce any records when looking for top level pages --->
    <cfif cfdebug_top_level_execution_sum.recordCount and len(trim(cfdebug_top_level_execution_sum.executionTime[1])) gt 0>
        <cfset time_other = Max(cfdebug_execution.executionTime - val(cfdebug_top_level_execution_sum.executionTime), 0)>
        <cfoutput>
			<div class="ui-widget">
       		<div class="fw_titles ui-widget-header" onclick="fw_toggle('fw_execution')" >&gt; Execution Time</div>
			<div class="fw_debugContent<cfif structkeyexists(cookie,"fw_execution") and cookie.fw_execution>View</cfif> ui-widget-content" id="fw_execution">
        </cfoutput>
		
        <cfif cfdebugger.settings.template_mode EQ "tree">
            <cfset a = arrayNew(1)>
            <cfloop query="qEvents">
               <cfscript>
                    // only want templates, IMQ of SELECT * ...where type = 'template' will result
                    // in cannot convert the value "" to a boolean for cachedquery column
                    // SELECT stacktrace will result in Query Of Queries runtime error.
                    // Failed to get meta_data for columnqEvents.stacktrace .
                    // Was told I need to define meta data for debugging event table similar to <cfldap>
                    if( qEvents.type eq "template" ) {
                        st = structNew();
                        st.StackTrace = qEvents.stackTrace;
                        st.template = qEvents.template;
                        st.startTime = qEvents.starttime;
                        st.endTime = qEvents.endtime;
                        st.parent =  qEvents.parent;
                        st.line =  qEvents.line;

                        arrayAppend(a, st);
                    }
               </cfscript>
            </cfloop>
            <cfset qTree = queryNew("template,templateId,parentId,duration,line")>
            <cfloop index="i" from="1" to="#arrayLen(a)#">
                <cfset childidList = "">
                <cfset parentidList = "">
                <cfloop index="x" from="#arrayLen(a[i].stacktrace.tagcontext)#" to="1" step="-1">
                    <cfscript>
                        if( a[i].stacktrace.tagcontext[x].id NEQ "CF_INDEX" ) {
                            // keep appending the line number from the template stack to form a unique id
                            childIdList = listAppend(childIdList, a[i].stacktrace.tagcontext[x].line);
                            if( x eq 1 ) {
                                parentIdList = listAppend(parentIdList, a[i].stacktrace.tagcontext[x].template);
                            } else {
                                parentIdList = listAppend(parentIdList, a[i].stacktrace.tagcontext[x].line);
                            }
                        }
                    </cfscript>
                </cfloop>

                <cfscript>
                    // template is the last part of the unique id...12,5,17,c:\wwwroot\foo.cfm
                    // if we don't remove the "CFC[" prefix, then the parentId and childId relationship
                    // will be all wrong
                    startToken = "CFC[ ";
                    endToken = " | ";
                    thisTemplate = a[i].template;
                    startTokenIndex = FindNoCase(startToken, thisTemplate, 1);
                    if( startTokenIndex NEQ 0 ) {
                        endTokenIndex = FindNoCase(endToken, thisTemplate, startTokenIndex);
                        thisTemplate = Trim(Mid(thisTemplate,Len(startToken),endTokenIndex-Len(startToken)));
                    }
                    childIdList = listAppend(childIdList, thisTemplate);

                    queryAddRow(qTree);
                    querySetCell(qTree, "template", a[i].template);
                    querySetCell(qTree, "templateId", childIdList);
                    querySetCell(qTree, "parentId", parentIdList);
                    querySetCell(qTree, "duration", a[i].endtime - a[i].starttime);
                    querySetCell(qTree, "line", a[i].line);
                </cfscript>
            </cfloop>

            <cfset stTree = structNew()>
            <cfloop query="qTree">
                <cfscript>
                // empty parent assumed to be top level with the exception of application.cfm
                if( len(trim(parentId)) eq 0 ){
                    parentId = 0;
                }
                    stTree[parentId] = structNew();
                    stTree[parentId].templateId = qTree.templateId;
                    stTree[parentId].template = qTree.template;
                    stTree[parentId].duration = qTree.duration;
                    stTree[parentId].line = qTree.line;
                    stTree[parentId].children = arrayNew(1);
                </cfscript>
            </cfloop>
            <cfloop query="qTree">
                <cfscript>
                    stTree[templateId] = structNew();
                    stTree[templateId].templateId = qTree.templateId;
                    stTree[templateId].template = qTree.template;
                    stTree[templateId].duration = qTree.duration;
                    stTree[templateId].line = qTree.line;
                    stTree[templateId].children = arrayNew(1);
                </cfscript>
            </cfloop>
            <cfloop query="qTree">
                <cfscript>
                    arrayAppend(stTree[parentId].children, stTree[templateId]);
                </cfscript>
            </cfloop>

            <cfquery dbType="query" name="topNodes" debug="false">
                SELECT parentId, templateid
                FROM qTree
                WHERE parentId = ''
            </cfquery>


            <cfoutput query="topNodes">
                #drawTree(stTree,-1,topNodes.templateid,cfdebugger.settings.template_highlight_minimum)#
            </cfoutput>
            <cfoutput><p class="template">
                (#time_other# ms) STARTUP, PARSING, COMPILING, LOADING, &amp; SHUTDOWN<br />
                (#cfdebug_execution.executionTime# ms) TOTAL EXECUTION TIME<br />
                <font color="red"><span class="template_overage">red = over #cfdebugger.settings.template_highlight_minimum# ms execution time</span></font>
                </p></cfoutput>
        <cfelse>
        	<cftry>
                <cfquery dbType="query" name="cfdebug_templates_summary" debug="false">
	                SELECT  template, Sum(endTime - startTime) AS totalExecutionTime, count(template) AS instances
	                FROM qEvents
	                WHERE type = 'Template'
	                group by template
	                order by totalExecutionTime DESC
                </cfquery>
                <cfoutput>
                <table border="0" align="center" cellpadding="0" cellspacing="1" class="fw_debugTables">
				  <tr>
					<th width="13%">Total Time</th>
					<th>Avg Time</td>
					<th>Count</th>
					<th>Template</th>
				</tr>
                </cfoutput>

                <cftry>
                    <cfoutput query="cfdebug_templates_summary">
                        <cfset templateOutput = template>
                        <cfset templateAverageTime = Round(totalExecutionTime / instances)>

                        <cfif template EQ ExpandPath(cgi.script_name)>
                            <cfset templateOutput = "<img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/topdoc.gif' alt='top level' border='0'> " &
                                "<strong>" & template & "</strong>">
							 <cfif templateAverageTime GT cfdebugger.settings.template_highlight_minimum>
                                <cfset templateOutput = "<font color='red'><span class='template_overage'>" & template & "</span></font>">
                                <cfset templateAverageTime = "<font color='red'><span class='template_overage'>" & templateAverageTime & "</span></font>">
								<cfset totalTime = "<font color='red'><span class='template_overage'>" & totalExecutionTime & "</span></font>">
                            </cfif>
                        <cfelse>
                            <cfif templateAverageTime GT cfdebugger.settings.template_highlight_minimum>
                                <cfset templateOutput = "<font color='red'><span class='template_overage'>" & template & "</span></font>">
                                <cfset templateAverageTime = "<font color='red'><span class='template_overage'>" & templateAverageTime & "</span></font>">
								<cfset totalTime = "<font color='red'><span class='template_overage'>" & totalExecutionTime & "</span></font>">
                            </cfif>
                        </cfif>

                        <tr>
							<cfif isDefined("totalTime") and len(trim(totalTime))>
								<td align="right" class="cfdebug" >#totalTime# ms</td>
								<cfset totalTime = "">
							<cfelse>
    	                        <td align="right" class="cfdebug" >#totalExecutionTime# ms</td>
							</cfif>
                            <td align="right" class="cfdebug" >#templateAverageTime# ms</td>
                            <td align="center" class="cfdebug" >#instances#</td>
                            <td align="left" class="cfdebug" >#templateOutput#</td>
                        </tr>
                        </cfoutput>
                	<cfcatch type="Any"></cfcatch>
                </cftry>
                <cfoutput>
                <tr>
					<td align="right" class="cfdebug" ><em>#time_other# ms</em></td><td colspan=2>&nbsp;</td>
                    <td align="left" class="cfdebug"><em>STARTUP, PARSING, COMPILING, LOADING, &amp; SHUTDOWN</em></td>
				</tr>
                <tr>
					<td align="right" class="cfdebug" ><em>#cfdebug_execution.executionTime# ms</em></td><td colspan=2>&nbsp;</td>
                    <td align="left" class="cfdebug"><em>TOTAL EXECUTION TIME</em></td>
				</tr>
                <!--- <font color="red"><span class="template_overage">red = over #cfdebugger.settings.template_highlight_minimum# ms average execution time</span></font> --->
            	</table>
				</div>
			</div>
				</cfoutput>
        	<cfcatch type="Any"></cfcatch>
        	</cftry>
        </cfif> <!--- template_mode = summary--->
    <cfelse>
	<div class="ui-widget">
        <div class="fw_titles ui-widget-header" onclick="fw_toggle('fw_execution')" >&gt; Execution Time</div>
        <div class="ui-widget-content">No top level page was found.</div>
	</div>
    </cfif> <!--- if top level templates are available --->
</cfif>

<!--- CFCS --->
<cfquery dbType="query" name="cfcs" debug="false">
select template, (endTime - startTime) as et, [timestamp]
from qEvents
where type = 'Template'
and template like 'CFC[[ %'
escape '['
group by template, [timestamp], startTime, endTime
</cfquery>
<cfset cfcData = structNew()>
<cfloop query="cfcs">
	<cfset tString = replaceNoCase(template, "CFC[ ", "")>
	<cfset tString = reReplace(tString, "] from .*", "")>
	<cfset theCFC = trim(listFirst(tString, "|"))>
	<cfset theMethod = trim(listLast(tString, "|"))>
	<!--- remove args --->
	<cfset theMethod = trim(reReplaceNoCase(theMethod, "\(.*?\).*", "()"))>
	<cfif not structKeyExists(cfcData, theCFC)>
		<cfset cfcData[theCFC] = structNew()>
	</cfif>
	<cfif not structKeyExists(cfcData[theCFC], theMethod)>
		<cfset cfcData[theCFC][theMethod] = structNew()>
		<cfset cfcData[theCFC][theMethod].count = 0>
		<cfset cfcData[theCFC][theMethod].total = 0>
	</cfif>
	<cfset cfcData[theCFC][theMethod].count = cfcData[theCFC][theMethod].count + 1>
	<cfset cfcData[theCFC][theMethod].total = cfcData[theCFC][theMethod].total + et>
</cfloop>

<!--- make averages --->
<cfloop item="cfc" collection="#cfcData#">
	<cfloop item="method" collection="#cfcdata[cfc]#">
		<cfset cfcdata[cfc][method].average = cfcdata[cfc][method].total / cfcdata[cfc][method].count>
	</cfloop>
</cfloop>




<cfif cfcs.recordcount>
<cfoutput>
<div class="ui-widget">
	<div class="fw_titles ui-widget-header" onclick="fw_toggle('fw_cfc')">&gt; CFC Data</div>
	<div class="fw_debugContent<cfif structkeyexists(cookie,"fw_cfc") and cookie.fw_cfc>View</cfif> ui-widget-content" id="fw_cfc">
		<table border="0" align="center" cellpadding="0" cellspacing="1" class="fw_debugTables">
		<thead>
			<tr>
				<th>Total Time</th>
				<th>Avg Time</th>
				<th>Count</th>
				<th>CFC</th>
				<th>Method</th>
			</tr>
		</thead>
		<tbody>
		<cfloop item="cfc" collection="#cfcData#">
			<cfloop item="method" collection="#cfcdata[cfc]#">
				<tr>
					<td>#cfcdata[cfc][method].total# ms</td>
					<td>#numberFormat(cfcdata[cfc][method].average,"00.00")# ms</td>
					<td>#cfcdata[cfc][method].count#</td>
					<td>#cfc#</td>
					<td>#method#</td>
				</tr>
			</cfloop>
		</cfloop>
		</tbody>
		</table>
	</div>
</div>
</cfoutput>
</cfif>
<!---	<cftry>
		<div class="ui-widget">
			<div class="fw_titles ui-widget-header" onclick="fw_toggle('fw_ordered_exec')" >&gt; Execution Time (Ordered)</div>
			<div class="fw_debugContent<cfif structkeyexists(cookie,"fw_ordered_exec") and cookie.fw_execution>View</cfif> ui-widget-content" id="fw_ordered_exec">
				<cfoutput>
					<table border="1" cellpadding="2" cellspacing="0" class="cfdebug">
					<tr>
					<td class="cfdebug"><b>Template</b></td>
					<td class="cfdebug" align="center"><b>Execution Time</b></td>
					<td class="cfdebug" align="left"><b>Called By</b></td>
					</tr>
				</cfoutput>
				<cfoutput query="templates_in_order">
					<tr>
						<td align="left" class="cfdebug" nowrap>#template#</td>
						<td align="right" class="cfdebug" nowrap>#et# ms</td>
						<td align="left" class="cfdebug" nowrap>#parent#&nbsp;</td>
					</tr>
				</cfoutput>
				<cfoutput>
					</table>
				</cfoutput>
			</div>
		</div>
		<cfcatch type="Any"></cfcatch>
	</cftry>

--->

<!--- Exceptions --->
<cfif bFoundExceptions>
<cftry>
<cfoutput>
<div class="ui-widget">
	<div class="fw_titles ui-widget-header" onclick="fw_toggle('fw_exceptions')">&gt; Exceptions</div>
	<div class="fw_debugContent<cfif structkeyexists(cookie,"fw_exceptions") and cookie.fw_cfc>fw_exceptions</cfif>" id="fw_exceptions">
	<cfloop query="cfdebug_ex">
	    <div class="cfdebug">#TimeFormat(cfdebug_ex.timestamp, "HH:mm:ss.SSS")# - #cfdebug_ex.name# <cfif FindNoCase("Exception", cfdebug_ex.name) EQ 0>Exception</cfif> - in #cfdebug_ex.template# : line #cfdebug_ex.line#</div>
	    <cfif IsDefined("cfdebug_ex.message") AND Len(Trim(cfdebug_ex.message)) GT 0>
	    <pre>
	    #cfdebug_ex.message#
	    </pre>
	    </cfif>
	</cfloop>
	</div>
</div>
</cfoutput>
	<cfcatch type="Any">
		<!--- Error reporting an exception event entry. --->
	</cfcatch>
</cftry>
</cfif>
	
<!--- SQL Queries --->
<cfoutput>
<cfif bFoundSQLQueries>
	<cftry>
	<div class="ui-widget">
		<div class="fw_titles ui-widget-header" onclick="fw_toggle('fw_sql')" >&gt; SQL Queries</div>
		<div class="fw_debugContent<cfif structkeyexists(cookie,"fw_sql") and cookie.fw_sql>View</cfif> ui-widget-content" id="fw_sql">
		
		<cfloop query="cfdebug_queries">
			
			<strong>#cfdebug_queries.name#</strong> (Datasource=#cfdebug_queries.datasource#, Time=#Max(cfdebug_queries.executionTime, 0)#ms<cfif IsDefined("cfdebug_queries.rowcount") AND IsNumeric(cfdebug_queries.rowcount)>, Records=#Max(cfdebug_queries.rowcount, 0)#<cfelseif IsDefined("cfdebug_queries.result.recordCount")>, Records=#cfdebug_queries.result.recordCount#</cfif><cfif cfdebug_queries.cachedquery>, <span class="cfdebugcachedquery">Cached Query</span></cfif>) in #cfdebug_queries.template# @ #TimeFormat(cfdebug_queries.timestamp, "HH:mm:ss.SSS")#<br />

			<cfset theBody = cfdebug_queries.body>
			<cfif arrayLen(cfdebug_queries.attributes) GT 0>
           		<cfloop from="1" to="#arrayLen(cfdebug_queries.attributes)#" index="i">
           			<cfset stThisParam = cfdebug_queries.attributes[cfdebug_queries.currentRow][i]>
           			<cfswitch expression="#stThisParam.sqlType#">
           				<cfcase value="cf_sql_datetime,cf_sql_date,cf_sql_integer" delimiters=",">
           					<cfset thisParam = stThisParam.value>
           				</cfcase>
           				<cfcase value="cf_sql_bit">
           					<cfif stThisParam.value>
           						<cfset thisParam = "'1'">
           					<cfelse>
           						<cfset thisParam = "'0'">
           					</cfif>
           				</cfcase>
           				<cfdefaultcase>
           					<cfset thisParam = "'#stThisParam.value#'">
           				</cfdefaultcase>
           			</cfswitch>
           			<cfset thisParam = '<span class="cfqueryparam">#thisParam#</span>'>
           			<cfset theBody = replace(theBody, '?', thisParam)>
				</cfloop>
			</cfif>

			<!--- remove empty lines --->
			<cfset newBody = "" />
			<cfloop list="#theBody#" index="i" delimiters="#chr(13)#">
				<cfset newLine = trim(i) />
				<cfif newLine neq "">
					<cfif newBody eq "">
						<cfset newBody = newLine />
					<cfelse>
						<cfset newBody = newBody & chr(13) & newLine />
					</cfif>
				</cfif>
			</cfloop>

			<!--- replace tabs --->
			<cfset newBody = replace(newBody,chr(9),"","all") />

			<pre class="cfdebugquery syntaxhighlighter">#newBody#</pre>

			<cfif arrayLen(cfdebug_queries.attributes) GT 0>
			    <h4 class="cfdebugqueryparam">Query Parameter Value(s)</h4>
			    <ul class="cfdebugqueryparams">
				    <cfloop index="x" from=1 to="#arrayLen(cfdebug_queries.attributes)#">
		        		<cfset thisParam = #cfdebug_queries.attributes[cfdebug_queries.currentRow][x]#>
				        <li>Parameter ###x#<cfif StructKeyExists(thisParam, "sqlType")>(#thisParam.sqlType#)</cfif> = <cfif StructKeyExists(thisParam, "value")><span>#htmleditformat(thisParam.value)#</span></cfif></li>
				    </cfloop>
				   </ul>
			    <br />
			</cfif>
		</cfloop>
		</div>
	</div>
	<cfcatch type="Any">
		<!--- Error reporting query event --->
	</cfcatch>
</cftry>
</cfif>

<!--- Stored Procs --->
<cfif bFoundStoredProc>
<cftry>
<div class="ui-widget">
<div class="fw_titles ui-widget-header" onclick="fw_toggle('fw_procedures')">&gt; Stored Procedures</div>
<div class="fw_debugContent<cfif structkeyexists(cookie,"fw_procedures") and cookie.fw_procedures>View</cfif> ui-widget-content" id="fw_procedures">
<cfloop query="cfdebug_storedproc">
<!--- Output stored procedure details, remember, include result (output params) and attributes (input params) columns --->
<code><strong>#cfdebug_storedproc.name#</strong> (Datasource=#cfdebug_storedproc.datasource#, Time=#Max(cfdebug_storedproc.executionTime, 0)#ms) in #cfdebug_storedproc.template# @ #TimeFormat(cfdebug_storedproc.timestamp, "HH:mm:ss.SSS")#</code><br />
    <table border=0 cellpadding=0 cellspacing=0>
    <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td>
            <table border=1 cellpadding=2 cellspacing=2>
            <tr bgcolor="gray"><td colspan="5" align="center"><font color="white">parameters</font></td></tr>
            <tr><td><code><em>type</em></code></td><td><code><em>CFSQLType</em></code></td><td><code><em>value</em></code></td><td><code><em>variable</em></code></td><td><code><em>dbVarName</em></code></td></tr>

            <cfloop index="x" from=1 to="#arrayLen(cfdebug_storedproc.attributes)#">
            <cfset thisParam = #cfdebug_storedproc.attributes[cfdebug_storedproc.currentRow][x]#>
            <tr>
                <td>&nbsp;<code><cfif StructKeyExists(thisParam, "type")>#thisParam.type#</cfif></code></td>
                <td>&nbsp;<code><cfif StructKeyExists(thisParam, "sqlType")>#thisParam.sqlType#</cfif></code></td>
                <td>&nbsp;<code><cfif StructKeyExists(thisParam, "value")>#htmleditformat(thisParam.value)#</cfif></code></td>
                <td>&nbsp;<code><cfif StructKeyExists(thisParam, "variable")>#thisParam.variable# = #CFDebugSerializable(thisParam.variable)#</cfif></code></td>
                <td>&nbsp;<code><cfif StructKeyExists(thisParam, "dbVarName")>#thisParam.dbVarName#</cfif></code></td>
            </tr>
            </cfloop>
            </table>
        </td>
    </tr>
    <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td>
            <table border=1 cellpadding=2 cellspacing=2>
            <tr bgcolor="gray"><td colspan="5" align="center"><font color="white">resultsets</font></td></tr>
            <tr><td><code><em>name</em></code></td><td><code><em>resultset</em></code></td></tr>

            <cfloop index="x" from=1 to="#arrayLen(cfdebug_storedproc.result)#">
            <cfset thisParam = #cfdebug_storedproc.result[cfdebug_storedproc.currentRow][x]#>
            <tr>
                <td>&nbsp;<code><cfif StructKeyExists(thisParam, "name")>#thisParam.name#</cfif></code></td>
                <td>&nbsp;<code><cfif StructKeyExists(thisParam, "resultSet")>#thisParam.resultSet#</cfif></code></td>
            </tr>
            </cfloop>
            </table>
        </td>
    </tr>
    </table>
</cfloop>
</div>
</div>
	<cfcatch type="Any">
		<!--- Error reporting stored proc event --->
	</cfcatch>
</cftry>
</cfif>

<!--- :: CFTimer :: --->
<cfif bFoundTimer>
<div class="ui-widget">
<div class="fw_titles ui-widget-header" onclick="fw_toggle('fw_timer')">&gt;CFTimer Times</div>
<p class="cfdebug">

<cfloop query="cfdebug_timer">
    <cftry>
    	<img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/#Replace(cfdebug_timer.priority, " ", "%20")#_16x16.gif' alt="#cfdebug_timer.priority# type">
		 [#val(cfdebug_timer.endTime) - val(cfdebug_timer.startTime)#ms] <em>#cfdebug_timer.message#</em><br />
    	<cfcatch type="Any"></cfcatch>
    </cftry>
</cfloop>
</p>
</div>
</cfif>


<!--- Tracing --->
<cfif bFoundTrace>
<div class="ui-widget">
<div class="fw_titles ui-widget-header" onclick="fw_toggle('fw_points')">&gt;Trace Points</div>
<p class="fw_debugContent<cfif structkeyexists(cookie,"fw_points") and cookie.fw_scope>View</cfif> ui-widget-content" id="fw_points">

<cfset firstTrace=true>
<cfset prevDelta=0>
<cfloop query="cfdebug_trace">
    <cfset deltaFromRequest = Val(cfdebug_trace.endTime)>
    <cfset deltaFromLast = Val(deltaFromRequest-prevDelta)>
    <cftry>
    	<img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/#Replace(cfdebug_trace.priority, " ", "%20")#_16x16.gif' alt="#cfdebug_trace.priority# type"> [#TimeFormat(cfdebug_trace.timestamp, "HH:mm:ss.lll")# #cfdebug_trace.template# @ line: #cfdebug_trace.line#] [#deltaFromRequest# ms (<cfif firstTrace>1st trace<cfelse>#deltaFromLast# ms</cfif>)] - <cfif #cfdebug_trace.category# NEQ "">[#cfdebug_trace.category#]</cfif> <cfif #cfdebug_trace.result# NEQ "">[#cfdebug_trace.result#]</cfif> <em>#cfdebug_trace.message#</em><br />
    	<cfcatch type="Any"></cfcatch>
    </cftry>
    <cfset prevDelta = deltaFromRequest>
    <cfset firstTrace=false>
</cfloop>
</p>
</div>
</cfif>


<!--- SCOPE VARIABLES --->
<cfif bFoundScopeVars>
<div class="ui-widget">
<div class="fw_titles ui-widget-header" onclick="fw_toggle('fw_scope')" >&gt; Scope Variables</div>
<div class="fw_debugContent<cfif structkeyexists(cookie,"fw_scope") and cookie.fw_scope>View</cfif> ui-widget-content" id="fw_scope">
<cftry>
<cfif IsDefined("APPLICATION") AND IsStruct(APPLICATION) AND StructCount(APPLICATION) GT 0 AND cfdebugger.check("ApplicationVar")>
<h4 class="cfdebugvariable">Application Variables:</h4>
<pre>#sortedScope(application)#</pre>
</cfif>
<cfcatch type="Any"></cfcatch>
</cftry>

<cftry>
<cfif IsDefined("CGI") AND IsStruct(CGI) AND StructCount(CGI) GT 0 AND cfdebugger.check("CGIVar")>
<h4 class="cfdebugvariable">CGI Variables:</h4>
<pre>#sortedScope(cgi)#</pre>
</cfif>
<cfcatch type="Any"></cfcatch>
</cftry>

<cftry>
<cfif IsDefined("CLIENT") AND IsStruct(CLIENT) AND StructCount(CLIENT) GT 0 AND cfdebugger.check("ClientVar")>
<h4 class="cfdebugvariable">Client Variables:</h4>
<pre>#sortedScope(client)#</pre>
</cfif>
<cfcatch type="Any"></cfcatch>
</cftry>

<cftry>
<cfif IsDefined("COOKIE") AND IsStruct(COOKIE) AND StructCount(COOKIE) GT 0 AND cfdebugger.check("CookieVar")>
<h4 class="cfdebugvariable">Cookie Variables:</h4>
<pre>#sortedScope(cookie)#</pre>
</cfif>
<cfcatch type="Any"></cfcatch>
</cftry>

<cftry>
<cfif IsDefined("FORM") AND IsStruct(FORM) AND StructCount(FORM) GT 0 AND cfdebugger.check("FormVar")>
<h4 class="cfdebugvariable">Form Fields:</h4>
<pre>#sortedScope(form)#</pre>
</cfif>
<cfcatch type="Any"></cfcatch>
</cftry>

<cftry>
<cfif IsDefined("REQUEST") AND IsStruct(REQUEST) AND StructCount(REQUEST) GT 0 AND cfdebugger.check("RequestVar")>
<h4 class="cfdebugvariable">Request Parameters:</h4>
<pre>#sortedScope(request)#</pre>
</cfif>
<cfcatch type="Any"></cfcatch>
</cftry>

<cftry>
<cfif IsDefined("SERVER") AND IsStruct(SERVER) AND StructCount(SERVER) GT 0 AND cfdebugger.check("ServerVar")>
<h4 class="cfdebugvariable">Server Variables:</h4>
<pre>#sortedScope(server)#</pre>
</cfif>
<cfcatch type="Any"></cfcatch>
</cftry>

<cftry>
<cfif IsDefined("SESSION") AND IsStruct(SESSION) AND StructCount(SESSION) GT 0 AND cfdebugger.check("SessionVar")>
<h4 class="cfdebugvariable">Session Variables:</h4>
<pre>#sortedScope(session)#</pre>
</cfif>
<cfcatch type="Any"></cfcatch>
</cftry>

<cftry>
<cfif IsDefined("URL") AND IsStruct(URL) AND StructCount(URL) GT 0 AND cfdebugger.check("URLVar")>
<h4 class="cfdebugvariable">URL Parameters:</h4>
<pre>#sortedScope(url)#</pre>
</cfif>
<cfcatch type="Any"></cfcatch>
</cftry>
</cfif>

<cfset duration = getTickCount() - startTime>
<cfif displayDebug>
<pre class="cfdebug"><em>Debug Rendering Time: #duration# ms</em></pre><br />
</cfif>
</cfoutput>
</div>
<cfsetting enablecfoutputonly="No">
</cfif>
</div>
</div>


<cfscript>
//UDF - Handle output of complex data types.
function CFDebugSerializable(variable)
{
var ret = "";
try
    {
		if(IsSimpleValue(variable))
		{
			ret = xmlFormat(variable);
		}
		else
		{
			if (IsStruct(variable))
			{
				ret = ("Struct (" & StructCount(variable) & ")");
			}
			else if(IsArray(variable))
			{
				ret = ("Array (" & ArrayLen(variable) & ")");
			}
			else if(IsQuery(variable))
			{
				ret = ("Query (" & variable.RecordCount & ")");
			}
			else
			{
				ret = ("Complex type");
			}
		}
}
    catch("any" ex)
    {
        ret = "undefined";
    }
    return ret;
}
// UDF - tree writing
function drawNode(nTree, indent, id, highlightThreshold) {
    var templateOuput = "";
    if( nTree[id].duration GT highlightThreshold ) {
        templateOutput = "<font color='red'><span class='template_overage'>(#nTree[id].duration#ms) " & nTree[id].template & " @ line " & #nTree[id].line# & "</span></font><br>";
    } else {
        templateOutput = "<span class='template'>(#nTree[id].duration#ms) " & nTree[id].template & " @ line " & #nTree[id].line# & "</span><br>";
    }
    writeOutput(repeatString("&nbsp;&nbsp;&middot;", indent + 1) & " <img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/arrow.gif' alt='arrow' border='0'><img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/endDoc.gif' alt='top level' border='0'> " & templateOutput);
    return "";
}

function drawTree(tree, indent, id, highlightThreshold) {
    var alength = 1;
    var i = 1;
    var templateOuput = "";

	if( structKeyExists(tree, id) )
	{
	    // top level nodes (application.cfm,cgi.script_name,etc) have a -1 parent line number
	    if(tree[id].line EQ -1) {
			if( Tree[id].duration GT highlightThreshold )
			{
	        	writeoutput( "<img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/topdoc.gif' alt='top level' border='0'> " & "<font color='red'><span class='template_overage'><strong>(#Tree[id].duration#ms) " & Tree[id].template & "</strong></span></font><br>" );
			}
			else
			{
				writeoutput( "<img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/topdoc.gif' alt='top level' border='0'> " & "<span class='template'><strong>(#Tree[id].duration#ms) " & Tree[id].template & "</strong></span><br>" );
			}
	    } else {
	        if( Tree[id].duration GT highlightThreshold ) {
	            templateOutput = "<font color='red'><span class='template_overage'>(#Tree[id].duration#ms) " & Tree[id].template & " @ line " & #Tree[id].line# & "</span></font><br>";
	        } else {
	            templateOutput = "<span class='template'>(#Tree[id].duration#ms) " & Tree[id].template & " @ line " & #Tree[id].line# & "</span><br>";
	        }
	        writeoutput( repeatString("&nbsp;&nbsp;&middot;", indent + 1) & " <img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/arrow.gif' alt='arrow' border='0'><img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/parentDoc.gif' alt='top level' border='0'> " & templateOutput );
	    }

	    if( isArray( tree[id].children ) and arrayLen( tree[id].children ) ) {
	        alength = arrayLen( tree[id].children );
	        for( i = 1; i lte alength; i = i + 1 ) {
	            if( isArray(tree[id].children[i].children) and arrayLen( tree[id].children[i].children ) gt 0 ) {
	                drawTree(tree, indent + 1, tree[id].children[i].templateid, highlightThreshold);
	            } else {
	                drawNode(tree, indent + 1, tree[id].children[i].templateid, highlightThreshold);
	            }
	        }
	    } else {
	        // single template, no includes?
	        //drawNode(tree, indent + 1, tree[id].template, highlightThreshold);
	    }
	}
    return "";
}
</cfscript>

<cffunction name="sortedScope" output="false">
    <cfargument name="scope">
    <cfset retVal="">
    <cfset keys = structKeyArray(scope)>
    <cfset arraySort(keys,"text")>
    <cfloop index="x" from=1 to="#arrayLen(keys)#">
    	<cfset keyName = keys[x]>
        <cfset retVal = retVal & keyName & "=">
           <cftry>
    		    <cfset keyValue = CFDebugSerializable(scope[keyname])>
    		<cfcatch>
    			<cfset keyValue = "undefined">
           	</cfcatch>
      	    </cftry>
        <cfset retVal = retVal & keyValue & Chr(13) & Chr(10)>
    </cfloop>
    <cfreturn retVal>
</cffunction>
	
	<cfcatch type="Any">
		<cfdump var="#cfcatch#" label="cfcatch" /><cfabort>
	</cfcatch>
</cftry>