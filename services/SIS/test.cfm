<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Test</title>
</head>
<body>

<h1>SIS</h1>
<h2>GetSISLocations</h2>
Start of Test

	<!---## SIS Service ##--->
	<cfinvoke component="cfc.services.sis.service"
    method="GetLocations"
    returnvariable="rv">
	<cfdump var="#rv#">


<cfinvoke component="cfc.services.sis.service"
	method="GetScheduleByFacilityRange"
	facilityId = "3"
	dateStart = "7/1/2017 10:29:00 AM"
	dateEnd = "7/5/2017 10:29:00 AM"
	returnvariable="rv">

	<cfdump var="#rv#">
	<hr />
End of Test

</body>
</html>
