<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Test</title>
</head>
<body>


<h3>Now Example</h3> 
<p>Now returns the current date and time as a valid date/time object. 
 
<p>The current date/time value is <cfoutput>#Now()#</cfoutput> 
<p>You can also represent this as <cfoutput>#DateFormat(Now())#,#TimeFormat(Now())#</cfoutput>
<p>Next Date <cfoutput>#DateAdd("yyyy", 1,Now())#</cfoutput>
    
    
<cfoutput>
<!---<cfinvoke component="cfc.services.AppsInventory.service"  method="GetApplicationList" returnvariable="rv">

COUNT from CFC: #rv.recordcount#<br>

<cfinvoke webservice="http://orlandohealthsoa.orhs.org/applicationinventory/applicationinventoryservice.svc?wsdl"
		  method="ApplicationsSearchList"
		  returnvariable="wsreturndata"  refreshwsdl="yes">
COUNT directly from WS: #ArrayLen(wsreturndata.Application)#<br>--->


<h3>TST Records</h3>



<!---<cfdump var="#wsreturndata#">
--->



			<Cfset EmployeeHealthRecord = QueryNew("ACTION_DT,COMMENTS,EMPLID,KEYER_ID,NEXT_DUE_DATE,PPD,PPD_DATE1,PPD_FIT_MASK_SIZE,PPD_FIT_MASK_SIZE2,PPD_TREATMENT,TEST_ID,ZZ_INCOMPL_REAS")>

			    <cfset temp = QueryAddRow(EmployeeHealthRecord)> 
			    <cfset Temp = QuerySetCell(EmployeeHealthRecord, "ACTION_DT", Trim(wsreturndata.ACTION_DT))> 
			    <cfset Temp = QuerySetCell(EmployeeHealthRecord, "COMMENTS", Trim(wsreturndata.COMMENTS))> 
			    <cfset Temp = QuerySetCell(EmployeeHealthRecord, "EMPLID", Trim(wsreturndata.EMPLID))> 
			    <cfset Temp = QuerySetCell(EmployeeHealthRecord, "KEYER_ID", Trim(wsreturndata.KEYER_ID))> 
			    <cfset Temp = QuerySetCell(EmployeeHealthRecord, "NEXT_DUE_DATE", Trim(wsreturndata.NEXT_DUE_DATE))> 
			    <cfset Temp = QuerySetCell(EmployeeHealthRecord, "PPD", Trim(wsreturndata.PPD))> 
			    <cfset Temp = QuerySetCell(EmployeeHealthRecord, "PPD_DATE1", Trim(wsreturndata.PPD_DATE1))> 
			    <cfset Temp = QuerySetCell(EmployeeHealthRecord, "PPD_FIT_MASK_SIZE", Trim(wsreturndata.PPD_FIT_MASK_SIZE))> 
			    <cfset Temp = QuerySetCell(EmployeeHealthRecord, "PPD_FIT_MASK_SIZE2", Trim(wsreturndata.PPD_FIT_MASK_SIZE2))> 
			    <cfset Temp = QuerySetCell(EmployeeHealthRecord, "PPD_TREATMENT", Trim(wsreturndata.PPD_TREATMENT))> 
			    <cfset Temp = QuerySetCell(EmployeeHealthRecord, "TEST_ID", Trim(wsreturndata.TEST_ID))> 
			    <cfset Temp = QuerySetCell(EmployeeHealthRecord, "ZZ_INCOMPL_REAS", Trim(wsreturndata.ZZ_INCOMPL_REAS))> 
			     
				

    


<cfinvoke webservice="http://svmmatrixdev02.orhs.org/OrganizationService/OrganizationService.svc?wsdl"
		  method="GetEmployeeHealthRecordCurrent"
		  returnvariable="wsreturndata"  refreshwsdl="yes"
          employeeId="175824">    
            
<cfscript>
     root = structnew();
     root.ACTION_DT = #Now()#;
     root.COMMENTS = "AutoUpdate";
     root.EMPLID = #Trim(wsreturndata.EMPLID)#;
     root.KEYER_ID = "INTRANET";
     root.NEXT_DUE_DATE = #DateAdd("yyyy", 1,wsreturndata.NEXT_DUE_DATE)#;
     root.PPD = "TQ";
     root.PPD_DATE1 = #Now()#;
     root.PPD_FIT_MASK_SIZE = " ";
     root.PPD_FIT_MASK_SIZE2 = " ";
     root.PPD_TREATMENT = " ";
     root.TEST_ID = " ";
     root.ZZ_INCOMPL_REAS = " ";
</cfscript>
            
<cfinvoke webservice="http://svmmatrixdev02.orhs.org/OrganizationService/OrganizationService.svc?wsdl"
		  method="EmployeeHealthInsertUpdate"
		  returnvariable="retcode"  refreshwsdl="yes">
        <cfinvokeargument name="value" value="#root#">
</cfinvoke>            
            
            
            
            
<cfdump var="#EmployeeHealthRecord#">            
<cfdump var="#root#">


<!---
<cfset Temp = QuerySetCell(EmployeeHealthRecord, "ACTION_DT", Trim(wsreturndata.ACTION_DT))>
<cfset Temp = QuerySetCell(EmployeeHealthRecord, "NEXT_DUE_DATE", Trim(wsreturndata.NEXT_DUE_DATE))> 
<cfset Temp = QuerySetCell(EmployeeHealthRecord, "PPD_DATE1", Trim(wsreturndata.PPD_DATE1))>

<cfdump var="#EmployeeHealthRecord#">



          
--->
</cfoutput>



</body>
</html>
