<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Test</title>
</head>
<body>

<cfloop index="i" from="1" to="10">

<cfinvoke component="cfc.services.ldap.service"  method="GetTeamMemberInfoLanSearch" returnvariable="rv" LAN="eileenm">
<cfquery name="NewRequest" datasource="AssetManagement" dbtype="ODBC">
INSERT INTO [AssetManagement].[dbo].[tbl_ChangeControlTest]
           ([userID]
           ,[managaerID])
     VALUES
           ('eileenm'
           ,<cfif structKeyExists(rv, "AD_MANAGER_SAMACCOUNTNAME")>'#rv.AD_MANAGER_SAMACCOUNTNAME#'<cfelse>'failed'</cfif>)
</cfquery>
</cfloop>

</body>
</html>
