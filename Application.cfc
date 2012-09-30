<cfcomponent hint="Hero Application Framework" output="false">
<cfscript>
		this.name = "ncdevcon";

		/* OnApplicationStart() */
	public function onApplicationStart(){
		application.dsn= "looping";
		application.filepath=GetDirectoryFromPath(GetCurrentTemplatePath());
		application.samplefilepath=application.filepath & "samples";
		application.collectionPath=application.filepath & "collection";
		application.rowsperpage = 50;
		application.objUtilities = createObject("component","looping.components.utilities");
		structdelete(application,"filelist",false);
		application.applicationResetTime			= dateformat(now()) & " -- " & timeformat(now())		;
		trace(text:"Application #this.name# started successfully (#application.applicationResetTime#).");
	}
	
		//onRequestStart()
	public function onRequestStart(String requestedPage){
		include "layout/header.cfm";
		if (structkeyexists(url,"reset")){
			onApplicationStart();
		}
	}
	public void function onRequestEnd(){
		include "layout/footer.cfm";
	}
	

		//onSessionStart()
	public boolean function onSessionStart(){
		trace(text:"Session initialized... #dateformat(now())#  --  #timeformat(now())#");
		return true;
	}
	
		//onSessionEnd
	public void function onSessionEnd(){
	}
	
		/*@output true*/
	public void function onError(any exception,String eventName){
			throw(object:arguments.exception);		
	}


</cfscript>
</cfcomponent>