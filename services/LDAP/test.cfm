<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Test</title>
</head>
<body>
<h1>LDAP</h1>
<h2>GetGroupMemberList</h2>
<cfoutput>

        <cfinvoke 	component="cfc.services.ldap.service"
                    method="GetGroupMemberList"
                    returnvariable="session.qTeamMembers"
                    groupName="IS Skills Inventory;Change Control NonIS">



	<cfif IsDefined("SESSION.qTeamMembers")>
		<p>SESSION.qTeamMembers is defined. setting qTeamMembers</p>
		
    
    <CFELSE>
   		<p>SESSION.qTeamMembers is <strong>NOT</strong> defined. Running the service then setting qTeamMembers</p>

        <cfinvoke 	component="cfc.services.ldap.service"
                    method="GetGroupMemberList"
                    returnvariable="session.qTeamMembers"
                    groupName="IS Skills Inventory;Change Control NonIS">
    </CFIF>

<cfset qEditAlerts = session.qTeamMembers>



 <cfinvoke 	component="cfc.services.ldap.service"
                    method="GetGroupMemberList"
                    returnvariable="session.qMgrList"
                    groupName="PG-IS Managers|Change Control Committee" delimiters="|"></cfinvoke>
                    
	<cfif IsDefined("SESSION.qMgrList")>
		<p>SESSION.qMgrList is defined. setting qTeamMembers</p>
    
    <CFELSE>
    
   		<p>SESSION.CachedGroupMemberList is <strong>NOT</strong> defined. Running the service then setting qTeamMembers</p>
        <cfinvoke 	component="cfc.services.ldap.service"
                    method="GetGroupMemberList"
                    returnvariable="session.qMgrList"
                    groupName="PG-IS Managers|Change Control Committee" delimiters="|"></cfinvoke>
    
        
    
    </CFIF>

<cfset qEditAlerts = session.qTeamMembers>
<cfset qMgrList = session.qMgrList>


<cfdump var="#session.qTeamMembers#" expand="no">
<cfdump var="#session.qMgrList#" expand="no">

<!---<cfdump var="#AlertMgrs#" expand="no">--->


<cfquery name="qAlrts" dbtype="query" >
    Select * from qEditAlerts, qMgrList WHERE qEditAlerts.username = qMgrList.username        
</cfquery>
<cfdump var="#qAlrts#" expand="no">



<cfabort>






<cfinvoke component="cfc.services.ldap.service"  method="GetGroupMemberList" returnvariable="rv" groupName="PG-IS Department|Change Control NonIS" delimiters="|">

<select>
<cfloop query="rv">
<option value="#UserName#">#DisplayName#</option>
</cfloop>
</select>
<p>

<cfloop query="rv">
<CFIF EMAILADDRESS GT "">
#DisplayName#,#EMAILADDRESS#<BR>
</CFIF>
</cfloop>


</cfoutput>
<HR>
<H2>GetTeamMemberInformationOnlyByLan</H2>


<cfinvoke component="cfc.services.ldap.service"  method="GetTeamMemberInformationOnlyByLan" returnvariable="rv" LAN="eileenm">

<cfdump var="#rv#">

<HR>
<H2>GetTeamMemberInfoLanSearch</H2>


<cfinvoke component="cfc.services.ldap.service"  method="GetTeamMemberInfoLanSearch" returnvariable="rv" LAN="r316811r">

<cfoutput>
Company: <cfif structKeyExists(rv, "AD_COMPANY")>#rv.AD_COMPANY#</cfif><br>
Department: <cfif structKeyExists(rv, "AD_DEPARTMENT")>#rv.AD_DEPARTMENT#</cfif><br>
Dept Name	: <cfif structKeyExists(rv, "AD_DESCRIPTION")>#rv.AD_DESCRIPTION#</cfif><br>
Display Name: <cfif structKeyExists(rv, "AD_DISPLAYNAME")>#rv.AD_DISPLAYNAME#</cfif><br>
Employee ##: <cfif structKeyExists(rv, "AD_EMPLOYEEID")>#rv.AD_EMPLOYEEID#</cfif><br>
Given Name: <cfif structKeyExists(rv, "AD_GIVENNAME")>#rv.AD_GIVENNAME#</cfif><br>
Has Direct Reports: <cfif structKeyExists(rv, "AD_HASDIRECTREPORTS")>#rv.AD_HASDIRECTREPORTS#</cfif><br>
Last Logon: <cfif structKeyExists(rv, "AD_LastLogonTimestamp")>#rv.AD_LastLogonTimestamp#</cfif><br>
Email: <cfif structKeyExists(rv, "AD_MAIL")>#rv.AD_MAIL#</cfif><br>
Manager SAM: <cfif structKeyExists(rv, "AD_MANAGER_SAMACCOUNTNAME")>#rv.AD_MANAGER_SAMACCOUNTNAME#</cfif><br>
Physical Location: <cfif structKeyExists(rv, "AD_PHYSICALDELIVERYOFFICENAME")>#rv.AD_PHYSICALDELIVERYOFFICENAME#</cfif><br>
User ID / SAM / LAN: <cfif structKeyExists(rv, "AD_SAMACCOUNTNAME")>#rv.AD_SAMACCOUNTNAME#</cfif><br>
Surname: <cfif structKeyExists(rv, "AD_SURNAME")>#rv.AD_SURNAME#</cfif><br>
Telephone: <cfif structKeyExists(rv, "AD_TELEPHONE")>#rv.AD_TELEPHONE#</cfif><br>
Title: <cfif structKeyExists(rv, "AD_TITLE")>#rv.AD_TITLE#</cfif><br>
</cfoutput>
</body>
</html>
