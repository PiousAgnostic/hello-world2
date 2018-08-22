<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Test</title>
</head>
<body>
<cfoutput>


<h1>Physician Provisioning (Echo)</h1>


<H2>Test of the Database</H2>

<cfinvoke component="cfc.services.provisioning.service"  method="TestDatabaseConnection" returnvariable="rv">

Database Available: #rv# 
<hr>
<cfif rv>

	<h2>Test of Physician List</h2>
	
	<cfinvoke component="cfc.services.provisioning.service"  method="PhysicianList" returnvariable="rv" ParmLastName="Smith">
	
	<select>
	<cfloop index="i" from="1" to="#ArrayLen(rv.PhysicianEcho)#">
	<option value="#rv.PhysicianEcho[i].DictationID#">#rv.PhysicianEcho[i].FullName#</option>
	</cfloop>
	</select>
	
	<hr>
	<h2>Test of Physician Group List</h2>
	<cfinvoke component="cfc.services.provisioning.service"  method="PhysicianGroupList" returnvariable="rv" ParmSource="ORHS">
	
	<select>
	<cfloop index="i" from="1" to="#ArrayLen(rv.PhysicianGroup)#">
	<option value="#rv.PhysicianGroup[i].TaxID#">#rv.PhysicianGroup[i].PrimaryAddressGroupName #</option>
	</cfloop>
	</select>
	
	<hr>
	<h2>Test of PhysicianDemographics</h2>
	<cfinvoke component="cfc.services.provisioning.service"  method="PhysicianDemographics" returnvariable="rv" ParmDictationID="1150">
	
	
		DicationID: <cfif structKeyExists(rv, "dictationID")>#rv.dictationID#</cfif><br>
	    Full Name: <cfif structKeyExists(rv, "fullname")>#rv.fullname#</cfif><br>
	    First Name: <cfif structKeyExists(rv, "firstname")>#rv.firstname#</cfif><br>
	    Last Name: <cfif structKeyExists(rv, "lastname")>#rv.lastname#</cfif><br>
	    Title: <cfif structKeyExists(rv, "title")>#rv.title#</cfif><br>
	    Middle Name: <cfif structKeyExists(rv, "middlename")>#rv.middlename#</cfif><br>
	    EchoDRID: <cfif structKeyExists(rv, "echoDRID")>#rv.echoDRID#</cfif><br>
	    EMail: <cfif structKeyExists(rv, "email")>#rv.email#</cfif> <br>
	    Home Address: <cfif structKeyExists(rv, "homeaddress1")>#rv.homeaddress1#</cfif><br>
	    Home City: <cfif structKeyExists(rv, "homecity")>#rv.homecity#</cfif><br>
	    Home State: <cfif structKeyExists(rv, "homestate")>#rv.homestate#</cfif><br>
	    Home Zip: <cfif structKeyExists(rv, "homezip")>#rv.homezip#</cfif><br>
	    Work Address: <cfif structKeyExists(rv, "workaddress1")>#rv.workaddress1#</cfif><br>
	    Work City: <cfif structKeyExists(rv, "workcity")>#rv.workcity#</cfif><br>
	    Work State: <cfif structKeyExists(rv, "workstate")>#rv.workstate#</cfif><br>
	    Work Zip: <cfif structKeyExists(rv, "workzip")>#rv.workzip#</cfif><br>
	    Phone - Home: <cfif structKeyExists(rv, "phonehome")>#rv.phonehome#</cfif><br>
	    Phone - Work: <cfif structKeyExists(rv, "phonework")>#rv.phonework#</cfif><br>
	    Phone - Cell: <cfif structKeyExists(rv, "phonecell")>#rv.phonecell#</cfif><br>
	    Phone - IVR: <cfif structKeyExists(rv, "phoneIVR")>#rv.phoneIVR#</cfif> <br>
	    Phone - Other: <cfif structKeyExists(rv, "phoneother")>#rv.phoneother#</cfif><br>
	    Group Name: <cfif structKeyExists(rv, "groupname")>#rv.groupname#</cfif><br>
	    TaxID: <cfif structKeyExists(rv, "taxid")>#rv.taxid#</cfif><br>
	    Status: <cfif structKeyExists(rv, "status")>#rv.status#</cfif><br>
	    Detail Retrieved: <cfif structKeyExists(rv, "DetailRetrivied")>#rv.DetailRetrivied#</cfif><br>
	    PhotoPath: <cfif structKeyExists(rv, "PhotoPath")>#rv.PhotoPath#</cfif><br>
	    Specialty: <cfif structKeyExists(rv, "specialty")>#rv.specialty#</cfif><br>
	    Department: <cfif structKeyExists(rv, "department")>#rv.department#</cfif><br>
	    DEA: <cfif structKeyExists(rv, "DEA")>#rv.DEA#</cfif><br>
	    NPI: <cfif structKeyExists(rv, "NPI")>#rv.NPI#</cfif> <br>
	
	
	
	<hr>
	<h2>Test of GetPhysicianDetail</h2>
	<cfinvoke component="cfc.services.provisioning.service"  method="PhysicianDemographics" returnvariable="rv" ParmDictationID="1150">
	<cfinvoke component="cfc.services.provisioning.service"  method="GetPhysicianDetail" returnvariable="rv" inDoc="#rv#">
	
	
		DicationID: <cfif structKeyExists(rv, "dictationID")>#rv.dictationID#</cfif><br>
	    Full Name: <cfif structKeyExists(rv, "fullname")>#rv.fullname#</cfif><br>
	    First Name: <cfif structKeyExists(rv, "firstname")>#rv.firstname#</cfif><br>
	    Last Name: <cfif structKeyExists(rv, "lastname")>#rv.lastname#</cfif><br>
	    Title: <cfif structKeyExists(rv, "title")>#rv.title#</cfif><br>
	    Middle Name: <cfif structKeyExists(rv, "middlename")>#rv.middlename#</cfif><br>
	    EchoDRID: <cfif structKeyExists(rv, "echoDRID")>#rv.echoDRID#</cfif><br>
	    EMail: <cfif structKeyExists(rv, "email")>#rv.email#</cfif> <br>
	    Home Address: <cfif structKeyExists(rv, "homeaddress1")>#rv.homeaddress1#</cfif><br>
	    Home City: <cfif structKeyExists(rv, "homecity")>#rv.homecity#</cfif><br>
	    Home State: <cfif structKeyExists(rv, "homestate")>#rv.homestate#</cfif><br>
	    Home Zip: <cfif structKeyExists(rv, "homezip")>#rv.homezip#</cfif><br>
	    Work Address: <cfif structKeyExists(rv, "workaddress1")>#rv.workaddress1#</cfif><br>
	    Work City: <cfif structKeyExists(rv, "workcity")>#rv.workcity#</cfif><br>
	    Work State: <cfif structKeyExists(rv, "workstate")>#rv.workstate#</cfif><br>
	    Work Zip: <cfif structKeyExists(rv, "workzip")>#rv.workzip#</cfif><br>
	    Phone - Home: <cfif structKeyExists(rv, "phonehome")>#rv.phonehome#</cfif><br>
	    Phone - Work: <cfif structKeyExists(rv, "phonework")>#rv.phonework#</cfif><br>
	    Phone - Cell: <cfif structKeyExists(rv, "phonecell")>#rv.phonecell#</cfif><br>
	    Phone - IVR: <cfif structKeyExists(rv, "phoneIVR")>#rv.phoneIVR#</cfif> <br>
	    Phone - Other: <cfif structKeyExists(rv, "phoneother")>#rv.phoneother#</cfif><br>
        Fax: <!---<cfif structKeyExists(rv, "phoneother")>#rv.phoneother#</cfif><br>--->
	    Group Name: <cfif structKeyExists(rv, "groupname")>#rv.groupname#</cfif><br>
	    TaxID: <cfif structKeyExists(rv, "taxid")>#rv.taxid#</cfif><br>
	    Status: <cfif structKeyExists(rv, "status")>#rv.status#</cfif><br>
	    Detail Retrieved: <cfif structKeyExists(rv, "DetailRetrivied")>#rv.DetailRetrivied#</cfif><br>
	    PhotoPath: <cfif structKeyExists(rv, "PhotoPath")>#rv.PhotoPath#</cfif><br>
	    Specialty: <cfif structKeyExists(rv, "specialty")>#rv.specialty#</cfif><br>
	    Department: <cfif structKeyExists(rv, "department")>#rv.department#</cfif><br>
	    DEA: <cfif structKeyExists(rv, "DEA")>#rv.DEA#</cfif><br>
	    NPI: <cfif structKeyExists(rv, "NPI")>#rv.NPI#</cfif> <br>
        Privilege Expiration: <!---<cfif structKeyExists(rv, "phoneother")>#rv.phoneother#</cfif><br>--->

</cfif>

</cfoutput>
</body>
</html>
