<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Test</title>
</head>
<body>


<h1>Affinity Test</h1>

<!---
<cfinvoke component="cfc.services.affinity.service"  method="GetFacesheetAccount" returnvariable="rv"
	ParmAccount="3000408850,3000416382,3500083609,3500083633">
--->

<cfinvoke component="cfc.services.affinity.service"  method="GetFacesheetAccount" returnvariable="rv"
	ParmAccount="4130617758">

<CFDUMP VAR="#RV#">

<cfoutput query="rv">

<H2>NOK</H2>
<cfinvoke component="cfc.services.affinity.service"  method="GetFacesheetNOKInfo" returnvariable="rv1"
	ParmPatientID="#rv.PATIENT_id#" ParmSysteM="#RV.SYSTEM#">
<CFDUMP VAR="#RV1#">
<H2>INSURANCE</H2>
<cfinvoke component="cfc.services.affinity.service"  method="GetFacesheetInsuranceInfo" returnvariable="rv2"
	ParmVisitID="#rv.VISIT_id#" ParmSysteM="#RV.SYSTEM#">

<cfdump var="#rv2#">


</cfoutput>
</body>
</html>
