<cfoutput>


<h1>TissueBank Web Service Test</h1>


<H2>Test of the Database</H2>

<cfinvoke component="cfc.services.TissueBank.service"  method="ApplicationUsersGetListAll" returnvariable="rv" >

<!---<cfdump var="#rv#">--->
	
<table>
	<th>User ID</th>
	<th>Employee ID</th>
	<th>User Name</th>
	<th>Active?</th>
	<th>Admin?</th>
	<cfloop index="i" from="1" to="#ArrayLen(rv.tbl_ApplicationUsers)#">
	<tr>
		<td>#rv.tbl_ApplicationUsers[i].AppUser_ID#</td>
		<td>#rv.tbl_ApplicationUsers[i].Employee_ID#</td>
		<td>#rv.tbl_ApplicationUsers[i].UserName#</td>
		<td>#rv.tbl_ApplicationUsers[i].ynActive#</td>
		<td>#rv.tbl_ApplicationUsers[i].ynAdmin#</td>
	</tr>
	</cfloop>
</table>
	
	
</cfoutput>
