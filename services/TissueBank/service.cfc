<!---

TissueBank SERVICE

Methods within this service provide read-only TissueBank database. DEV for testing only.

The following methods are implemented:

	- applicationusersgetlistall
	-
	-

This ColdFusion cfc implements the TissueBank web service. it provides a safe, single location
for accessing this web service. by utilizing this cfc, ColdFusion programmers need not access the 
web service directly, and do not need to maintain the service location. web service address is 
stored in the weburl variable below.

These methods will refresh the wsdl as needed within ColdFusion.
--->


<cfcomponent>

<cfset WEBURL = "http://svmmatrixdev02/TissueBank/TissueBankService.svc?wsdl"> 
	
	
<cffunction name="ApplicationUsersGetListAll" access="public" returnvariable="rv" hint="Test Connection to TissueBank">
<!---	<cfargument name="AppUser_ID" type="string" required="No">--->
		
<cftry>
	<cfinvoke webservice="#WEBURL#" method="ApplicationUsersGetListAll" returnvariable="wsreturndata"  refreshwsdl="no">

	</cfinvoke>		
  <cfcatch>
		<cfinvoke webservice="#WEBURL#" method="ApplicationUsersGetListAll" returnvariable="wsreturndata"  refreshwsdl="yes">

		</cfinvoke>	
  </cfcatch>
</cftry>
		
<cfreturn wsreturndata>
</cffunction>
	
</cfcomponent>