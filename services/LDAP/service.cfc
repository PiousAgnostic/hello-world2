<cfcomponent>

<CFSET WEBURL = "http://svmmatrixdev02.orhs.org/LDAPService/LDAPService.svc?wsdl">



<!---- 
IMPLEMENTATION OF: GetGroupMemberList - RETURNS AN COLDFUSION QUERY CONTIANING A LIST OF TEAM MEMBERS 
										CONTAINED WITHIN THE PROVIDED AD GROUP NAME

USAGE:
  
<cfinvoke component="cfc.services.ldap.service"  method="GetGroupMemberList" returnvariable="rv" groupName="PG-IS Managers">

<select>
<cfloop query="rv">
<option value="#UserName#">#DisplayName#</option>
</cfloop>
</select>

NOTE: Return value is a ColdFusion Query sorted by DisplayName, containing the following fields:

DisplayName
UserName
EmailAddress
EmployeeID
FirstName
LastName

--->


	<cffunction name="GetGroupMemberList" access="public" hint="Return a list of team members contained in a AD Group" returntype="Query" >
		<cfargument name="groupName" type="string" required="Yes">
		<cfargument name="delimiters" type="string" required="No" default=";">

		<cfset whereclause = "WHERE (1 = 0) ">
		<cfloop list="#groupName#" delimiters="#delimiters#" index="Group">	
			<CFSET whereclause = whereclause & " OR (memberof like '%" & Group & "%') ">
		</cfloop>
		
		<Cfquery name="NameList" DATASOURCE="collective">
		SELECT DISTINCT [DiasplayName] AS DisplayName
		       	,[UserID] as UserName
		      	,[Mail] as EmailAddress
		      	,[employeeid]
			, CASE WHEN CHARINDEX ( ',' , [DiasplayName]) > 1 THEN
					SUBSTRING ( [DiasplayName] ,1 , CHARINDEX ( ',' , [DiasplayName])-1 )  
					ELSE ''
				END AS LastName
			, CASE WHEN CHARINDEX ( ',' , [DiasplayName]) > 1 THEN
				SUBSTRING ( [DiasplayName] ,CHARINDEX ( ',' , [DiasplayName])+1 , len([DiasplayName]) )  	  
				ELSE ''
			END AS FirstName 		      
		  	FROM [tbl_CACHED_LDAP_Information]	
  			#PreserveSingleQuotes(whereclause)#
  			ORDER BY DIASPLAYNAME
  		</cfquery>
  		

		<Cfreturn NameList> 
	</cffunction>


	<cffunction name="GetTeamMemberInfoLanSearch" access="public" hint="Look up provided LAN ID, including Management Tree"  >
		<cfargument name="LAN" type="string" required="Yes" default="">		
		
	
		<CFTRY>
			<cfinvoke   method="GetTeamMemberInfoLanSearch" 
						returnvariable="wsreturndata" 
						webservice="#WEBURL#" 
						refreshwsdl="NO">
			    <cfinvokeargument name="LAN" value="#LAN#">
			</cfinvoke>
		<CFCATCH>
			<cfinvoke   method="GetTeamMemberInfoLanSearch" 
						returnvariable="wsreturndata" 
						webservice="#WEBURL#" 
						refreshwsdl="yes">
			    <cfinvokeargument name="LAN" value="#LAN#">
			</cfinvoke>	
		</CFCATCH>
		</CFTRY>
		<cfif isDefined("wsreturndata")>
			<Cfreturn wsreturndata>
		</cfif> 
	</cffunction>


	<cffunction name="GetTeamMemberInformationOnlyByLan" access="public" hint="Look up provided LAN ID; do not pull direct reports or Management Tree" returntype="Query"    >
		<cfargument name="LAN" type="string" required="Yes" default="">
		
		<cfset nQuery = QueryNew("AD_COMPANY,AD_DEPARTMENT,AD_DESCRIPTION,AD_DISPLAYNAME,AD_EMPLOYEEID,AD_GIVENNAME,AD_MAIL,AD_LastLogonTimestamp,AD_PHYSICALDELIVERYOFFICENAME,AD_SAMACCOUNTNAME,AD_SURNAME,AD_TELEPHONE,AD_TITLE,")>




		<CFTRY>
			<cfinvoke   method="GetTeamMemberInformationOnlyByLan" 
						returnvariable="wsreturndata" 
						webservice="#WEBURL#" 
						refreshwsdl="NO">
			    <cfinvokeargument name="LAN" value="#LAN#">
			</cfinvoke>
		<CFCATCH>
			<cfinvoke   method="GetTeamMemberInformationOnlyByLan" 
						returnvariable="wsreturndata" 
						webservice="#WEBURL#" 
						refreshwsdl="yes">
			    <cfinvokeargument name="LAN" value="#LAN#">
			</cfinvoke>		
		</CFCATCH>
		</CFTRY>
		<cfif isdefined("wsreturndata")>
		<cfif structKeyExists(wsreturndata, "AD_COMPANY")>
					<cfset temp = QueryAddRow(nQuery)>
					<cfset Temp = QuerySetCell(nQuery, "AD_COMPANY", wsreturndata.AD_COMPANY)>
					<cfset Temp = QuerySetCell(nQuery, "AD_DEPARTMENT", wsreturndata.AD_DEPARTMENT)>	
					<cfset Temp = QuerySetCell(nQuery, "AD_DESCRIPTION", wsreturndata.AD_DESCRIPTION)>
					<cfset Temp = QuerySetCell(nQuery, "AD_DISPLAYNAME", wsreturndata.AD_DISPLAYNAME)>	
					<cfset Temp = QuerySetCell(nQuery, "AD_EMPLOYEEID", wsreturndata.AD_EMPLOYEEID)>
					<cfset Temp = QuerySetCell(nQuery, "AD_GIVENNAME", wsreturndata.AD_GIVENNAME)>						
					<cfset Temp = QuerySetCell(nQuery, "AD_MAIL", wsreturndata.AD_MAIL)>
					<cfset Temp = QuerySetCell(nQuery, "AD_LastLogonTimestamp", wsreturndata.AD_LastLogonTimestamp)>	
					<cfset Temp = QuerySetCell(nQuery, "AD_PHYSICALDELIVERYOFFICENAME", wsreturndata.AD_PHYSICALDELIVERYOFFICENAME)>
					<cfset Temp = QuerySetCell(nQuery, "AD_SAMACCOUNTNAME", wsreturndata.AD_SAMACCOUNTNAME)>	
					<cfset Temp = QuerySetCell(nQuery, "AD_SURNAME", wsreturndata.AD_SURNAME)>
					<cfset Temp = QuerySetCell(nQuery, "AD_TELEPHONE", wsreturndata.AD_TELEPHONE)>	
					<cfset Temp = QuerySetCell(nQuery, "AD_TITLE", wsreturndata.AD_TITLE)>
		</cfif>
<!---		<cfelse>
			COULDN'T FIND <cfoutput>#LAN#</cfoutput>--->
		</cfif>
		<Cfreturn nQuery> 
	</cffunction>

</cfcomponent>