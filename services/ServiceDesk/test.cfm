<cfoutput>


<h1>ServiceDesk Web Service Test</h1>


<H2>Test of the Database</H2>

<cfinvoke component="cfc.services.ServiceDesk.service"  method="GetSDGroups" returnvariable="rv" >

<!---
<cfdump var="#rv#">
	<cfabort>
--->
	
<table>
	<th>Group Name</th>
	<cfloop index="i" from="1" to="#ArrayLen(rv.Groups)#">
	<tr>
		<td>#rv.Groups[i].GroupName#</td>
	</tr>
	</cfloop>
</table>
	
	
</cfoutput>
