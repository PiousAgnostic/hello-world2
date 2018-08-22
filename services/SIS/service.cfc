<cfcomponent>

  <cfset WEBURL = "http://svmmatrixdev02.orhs.org/SIS/SISService.svc?wsdl" />

<!---
IMPLEMENTATION OF: GetLocations - RETURNS A COLDFUSION QUERY CONTIANING A LIST OF Facilities

USAGE:
  
<cfinvoke component="cfc.services.SIS.service"  method="GetLocations" returnvariable="rv">

<select>
<cfloop query="rv">
<option value="#Id#">#Name#</option>
</cfloop>
</select>

NOTE: Return value is a ColdFusion Query sorted by Facility Name, containing the following fields:

Id
Name
--->


  <cffunction name="GetLocations" access="public" hint="Return a list of Facilities" returntype="query" >
		<cftry>
			<cfinvoke webservice="#WEBURL#"
				method="GetLocations"
				returnvariable="wsreturndata" refreshwsdl="no">
			</cfinvoke>
			<cfcatch>
				<cfinvoke webservice="#WEBURL#"
				  method="GetLocations"
				  returnvariable="wsreturndata"  refreshwsdl="YES">
				</cfinvoke>
			</cfcatch>
		</cftry>
	
	<cfset nQuery = QueryNew("Id,Name") />	
		
        <cfif structKeyExists(wsreturndata, "Location")>
          <cfloop index="i" from="1" to="#ArrayLen(wsreturndata.Location)#" >
            <cfset temp = QueryAddRow(nQuery) />
            <cfset temp = QuerySetCell(nQuery, "Id", wsreturndata.Location[i].Id) />
            <cfset temp = QuerySetCell(nQuery, "Name", wsreturndata.Location[i].Name) />
          </cfloop>
        </cfif>
	<Cfreturn nQuery> 
  </cffunction>
  
  
<!---
IMPLEMENTATION OF: GetScheduleByFacilityRange - RETURNS A COLDFUSION QUERY CONTIANING A LIST OF Appointments

USAGE:
  
<cfinvoke component="cfc.services.SIS.service"  method="GetScheduleByFacilityRange" returnvariable="rv">


NOTE: Return value is a ColdFusion Query sorted by StartDate, containing the following fields:

	AnesthesiaType
	CNCType
	CareEventCounter
	CaseConfirmationNumber
	COmments
	DateOfBirth
	DisplayProcedure
	FacilityID
	FirstName
	HospitalPatientID
	LastName
	MedicalRecordNumber
	MiddleName
	ModuleId
	OrderCode
	PatientFullName
	PatientId
	ReportingName
	RoomId
	RoomName
	Sex
	StartDate
	StopDate
	SurgeonText

--->  
  
  <cffunction name="GetScheduleByFacilityRange" access="public" hint="Return a list of Appointments for a Facility and Date Range" returntype="query" >
  	<cfargument name="facilityId" type="string" required="Yes" default="">
        <cfargument name="dateStart" type="string" required="Yes"  default="">
        <cfargument name="dateEnd" type="string" required="Yes" default="">	

	<cftry>
		<cfinvoke webservice="#WEBURL#"
			method="GetScheduleByFacilityRange"
			returnvariable="wsreturndata" refreshwsdl="no">
			<cfinvokeargument name="facilityId" value="#facilityId#">
			<cfinvokeargument name="dateStart" value="#dateStart#">
			<cfinvokeargument name="dateEnd" value="#dateEnd#">			
		</cfinvoke>
		<cfcatch>
			<cfinvoke webservice="#WEBURL#"
			  method="GetScheduleByFacilityRange"
			  returnvariable="wsreturndata"  refreshwsdl="YES">
			<cfinvokeargument name="facilityId" value="#facilityId#">
			<cfinvokeargument name="dateStart" value="#dateStart#">
			<cfinvokeargument name="dateEnd" value="#dateEnd#">			  
			</cfinvoke>
		</cfcatch>
	</cftry>
	
	
	<cfset nQuery = QueryNew("AnesthesiaType,CNCType,CareEventCounter,CaseConfirmationNumber,Comments,DateOfBirth,DisplayProcedure,FacilityID,FirstName,HospitalPatientID,LastName,MedicalRecordNumber,MiddleName,ModuleId,OrderCode,PatientFullName,PatientId,ReportingName,RoomId,RoomName,Sex,StartDate,StopDate,SurgeonText") />	
		
        <cfif structKeyExists(wsreturndata, "Appointment")>
          <cfloop index="i" from="1" to="#ArrayLen(wsreturndata.Appointment)#" >
            	<cfset temp = QueryAddRow(nQuery) />
		<cfset temp = QuerySetCell(nQuery, "AnesthesiaType", wsreturndata.Appointment[i].AnesthesiaType) />
		<cfset temp = QuerySetCell(nQuery, "CNCType", wsreturndata.Appointment[i].CNCType) />
		<cfset temp = QuerySetCell(nQuery, "CareEventCounter", wsreturndata.Appointment[i].CareEventCounter) />
		<cfset temp = QuerySetCell(nQuery, "CaseConfirmationNumber", wsreturndata.Appointment[i].CaseConfirmationNumber) />
		<cfset temp = QuerySetCell(nQuery, "COmments", wsreturndata.Appointment[i].COmments) />
		<cfset temp = QuerySetCell(nQuery, "DateOfBirth", wsreturndata.Appointment[i].DateOfBirth) />
		<cfset temp = QuerySetCell(nQuery, "DisplayProcedure", wsreturndata.Appointment[i].DisplayProcedure) />
		<cfset temp = QuerySetCell(nQuery, "FacilityID", wsreturndata.Appointment[i].FacilityID) />
		<cfset temp = QuerySetCell(nQuery, "FirstName", wsreturndata.Appointment[i].FirstName) />
		<cfset temp = QuerySetCell(nQuery, "HospitalPatientID", wsreturndata.Appointment[i].HospitalPatientID) />
		<cfset temp = QuerySetCell(nQuery, "LastName", wsreturndata.Appointment[i].LastName) />
		<cfset temp = QuerySetCell(nQuery, "MedicalRecordNumber", wsreturndata.Appointment[i].MedicalRecordNumber) />
		<cfset temp = QuerySetCell(nQuery, "MiddleName", wsreturndata.Appointment[i].MiddleName) />
		<cfset temp = QuerySetCell(nQuery, "ModuleId", wsreturndata.Appointment[i].ModuleId) />
		<cfset temp = QuerySetCell(nQuery, "OrderCode", wsreturndata.Appointment[i].OrderCode) />
		<cfset temp = QuerySetCell(nQuery, "PatientFullName", wsreturndata.Appointment[i].PatientFullName) />
		<cfset temp = QuerySetCell(nQuery, "PatientId", wsreturndata.Appointment[i].PatientId) />
		<cfset temp = QuerySetCell(nQuery, "ReportingName", wsreturndata.Appointment[i].ReportingName) />
		<cfset temp = QuerySetCell(nQuery, "RoomId", wsreturndata.Appointment[i].RoomId) />
		<cfset temp = QuerySetCell(nQuery, "RoomName", wsreturndata.Appointment[i].RoomName) />
		<cfset temp = QuerySetCell(nQuery, "Sex", wsreturndata.Appointment[i].Sex) />
		<cfset temp = QuerySetCell(nQuery, "StartDate", wsreturndata.Appointment[i].StartDate) />
		<cfset temp = QuerySetCell(nQuery, "StopDate", wsreturndata.Appointment[i].StopDate) />
		<cfset temp = QuerySetCell(nQuery, "SurgeonText", wsreturndata.Appointment[i].SurgeonText) />
          </cfloop>
        </cfif>
	<Cfreturn nQuery> 
	
  </cffunction>
  
  
</cfcomponent>