<!---

ServiceDesk SERVICE

Methods within this service provide read-only ServiceDesk database. 

The following methods are implemented:

	- GetSDGroups
	-
	-

This ColdFusion cfc implements the TissueBank web service. it provides a safe, single location
for accessing this web service. by utilizing this cfc, ColdFusion programmers need not access the 
web service directly, and do not need to maintain the service location. web service address is 
stored in the weburl variable below.

These methods will refresh the wsdl as needed within ColdFusion.
--->


<cfcomponent>

<cfset WEBURL = "http://svmmatrixdev02/ServiceDesk/ServiceDeskService.svc?wsdl"> 
	
	
<cffunction name="GetSDGroups" access="public" returnvariable="rv" hint="Test Connection to ServiceDesk">
<!---	<cfargument name="AppUser_ID" type="string" required="No">--->
		
<cftry>
	<cfinvoke webservice="#WEBURL#" method="GetSDGroups" returnvariable="wsreturndata"  refreshwsdl="no">

	</cfinvoke>		
  <cfcatch>
		<cfinvoke webservice="#WEBURL#" method="GetSDGroups" returnvariable="wsreturndata"  refreshwsdl="yes">

		</cfinvoke>	
  </cfcatch>
</cftry>
		
<cfreturn wsreturndata>
</cffunction>
	
</cfcomponent>