	<cfinvoke component="cfc.services.provisioning.service"  method="PhysicianList" returnvariable="rv">
	<cfoutput>
	<cfloop index="i" from="1" to="#ArrayLen(rv.PhysicianEcho)#">
	<cfif rv.PhysicianEcho[i].Status EQ "ORHS">
	#rv.PhysicianEcho[i].DictationID#|#rv.PhysicianEcho[i].FullName#|#rv.PhysicianEcho[i].groupname##chr(10)##chr(13)#
	</CFIF>
	</cfloop>
	</cfoutput>