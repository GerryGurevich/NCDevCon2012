<cffunction name="querySim" returntype="query" >
		<cfargument name="queryData" required="true" type="string" />
<!---
This library is part of the Common Function Library Project. An open source
	collection of UDF libraries designed for ColdFusion 5.0 and higher. For more information,
	please see the web site at:

		http://www.cflib.org

	Warning:
	You may not need all the functions in this library. If speed
	is _extremely_ important, you may want to consider deleting
	functions you do not plan on using. Normally you should not
	have to worry about the size of the library.

	License:
	This code may be used freely.
	You may modify this code as you see fit, however, this header, and the header
	for the functions must remain intact.

	This code is provided as is.  We make no warranty or guarantee.  Use of this code is at your own risk.
--->

<cfscript>
/**
 * Accepts a specifically formatted chunk of text, and returns it as a query object.
 * v2 rewrite by Jamie Jackson
 * 
 * @param queryData 	 Specifically format chunk of text to convert to a query. (Required)
 * @return Returns a query object. 
 * @author Bert Dawson (bert@redbanner.com) 
 * @version 2, December 18, 2007 
 */
	var fieldsDelimiter="|";
	var colnamesDelimiter=",";
	var listOfColumns="";
	var tmpQuery="";
	var numLines="";
	var cellValue="";
	var cellValues="";
	var colName="";
	var lineDelimiter=chr(10) & chr(13);
	var lineNum=0;
	var colPosition=0;

	// the first line is the column list, eg "column1,column2,column3"
	listOfColumns = Trim(ListGetAt(queryData, 1, lineDelimiter));
	
	// create a temporary Query
	tmpQuery = QueryNew(listOfColumns);

	// the number of lines in the queryData
	numLines = ListLen(queryData, lineDelimiter);
	
	// loop though the queryData starting at the second line
	for(lineNum=2;  lineNum LTE numLines;  lineNum = lineNum + 1) {
	    cellValues = ListGetAt(queryData, lineNum, lineDelimiter);

		if (ListLen(cellValues, fieldsDelimiter) IS ListLen(listOfColumns,",")) {
			QueryAddRow(tmpQuery);
			for (colPosition=1; colPosition LTE ListLen(listOfColumns); colPosition = colPosition + 1){
				cellValue = Trim(ListGetAt(cellValues, colPosition, fieldsDelimiter));
				colName   = Trim(ListGetAt(listOfColumns,colPosition));
				QuerySetCell(tmpQuery, colName, cellValue);
			}
		} 
	}
</cfscript>



		<cfreturn tmpQuery>

	</cffunction>

<cfsavecontent variable="queryData" >
	a,b,c
	1|2|3
	4|5|6
</cfsavecontent> 	
<cfset qry=querysim(querydata)>
<cfdump var="#qry#" label="qry" /><cfabort>