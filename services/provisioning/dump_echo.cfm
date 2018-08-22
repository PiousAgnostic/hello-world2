	<cfinvoke component="cfc.services.provisioning.service"  method="PhysicianList" returnvariable="rv">
	<cfoutput>
		dictationID|fullname|firstname|lastname|title|middlename|email|workaddress1|workcity|workstate|workzip|phonework|groupname|status|DetailRetrivied|specialty<br>


	<cfloop index="i" from="1" to="#ArrayLen(rv.PhysicianEcho)#">
	<cfif rv.PhysicianEcho[i].Status EQ "ORHS">
		<cfinvoke component="cfc.services.provisioning.service"  method="PhysicianDemographics" returnvariable="docrv" ParmDictationID="#rv.PhysicianEcho[i].DictationID#">
		<cfinvoke component="cfc.services.provisioning.service"  method="GetPhysicianDetail" returnvariable="docrv" inDoc="#docrv#">


		<cfif structKeyExists(docrv, "dictationID")>#RIGHT("000000" & docrv.dictationID, 6)#</cfif>|
		<cfif structKeyExists(docrv, "fullname")>#docrv.fullname#</cfif>|
		<cfif structKeyExists(docrv, "firstname")>#docrv.firstname#</cfif>|
		<cfif structKeyExists(docrv, "lastname")>#docrv.lastname#</cfif>|
		<cfif structKeyExists(docrv, "title")>#docrv.title#</cfif>|
		<cfif structKeyExists(docrv, "middlename")>#docrv.middlename#</cfif>|
		<cfif structKeyExists(docrv, "email")>#docrv.email#</cfif>|
		<cfif structKeyExists(docrv, "workaddress1")>#docrv.workaddress1#</cfif>|
		<cfif structKeyExists(docrv, "workcity")>#docrv.workcity#</cfif>|
		<cfif structKeyExists(docrv, "workstate")>#docrv.workstate#</cfif>|
		<cfif structKeyExists(docrv, "workzip")>#docrv.workzip#</cfif>|
		<cfif structKeyExists(docrv, "phonework")>#docrv.phonework#</cfif>|
		<cfif structKeyExists(docrv, "groupname")>#docrv.groupname#</cfif>|
		<cfif structKeyExists(docrv, "status")>#docrv.status#</cfif>|
		<cfif structKeyExists(docrv, "DetailRetrivied")>#docrv.DetailRetrivied#</cfif>|
		<cfif structKeyExists(docrv, "specialty")>#docrv.specialty#</cfif><br>


	</CFIF>
	</cfloop>
	</cfoutput>