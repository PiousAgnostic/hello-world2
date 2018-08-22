<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Test</title>
</head>
<body>



<cfoutput>
<cfinvoke component="cfc.services.AppsInventory.service"  method="GetApplicationListSQL" returnvariable="rv">


<cfquery dbtype="query" name="Test">	
	select * from rv
</cfquery>

	
<!---	
<select>
<cfloop query="Test">
	
<option>#System# --- #ManagerName# --- #FunctionalSupportGroupName#	
</cfloop>	
</select>	

<cfinvoke component="cfc.services.AppsInventory.service"  method="GetApplicationByName" returnvariable="rv" Name="Change Control System">
--->
	

<cfdump var="#rv#">

</cfoutput>

</body>
</html>
