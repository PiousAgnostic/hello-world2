<!---

AFFINITY SERVICE

METHODS WITHIN THIS SERVICE PROVIDE READ-ONLY ACCESS TO AFFINITY DATABASE.

THE FOLLOWING METHODS ARE IMPLEMENTED:

	GetFacesheetAccount
	GetFacesheetNOKInfo
	GetFacesheetInsuranceInfo

THIS COLDFUSION CFC IMPLEMENTS THE AFFINITY WEB SERVICE. IT PROVIDES A SAFE, SINGLE LOCATION
FOR ACCESSING THIS WEB SERVICE. BY UTILIZING THIS CFC, COLDFUSION PROGRAMMERS NEED NOT ACCESS THE 
WEB SERVICE DIRECTLY, AND DO NOT NEED TO MAINTAIN THE SERVICE LOCATION. WEB SERVICE ADDRESS IS 
STORED IN THE WEBURL VARIABLE BELOW.

THESE METHODS WILL REFRESH THE WSDL AS NEEDED WITHIN COLDFUSION.


--->


<cfcomponent>

<!---<cfset WEBURL = "\\svmsoa01\c$\inetpub\wwwroot\OrlandoHealth\Service\Affinity?wsdl">--->
<!---
<cfset WEBURL = "http://orlandohealthsoa.orhs.org/Affinity/AffinityService.svc?wsdl">
--->

<!---<cfset WEBURL = "http://svmmatrixdev02.orhs.org/Affinity/AffinityService.svc?wsdl">--->

<cfset WEBURL = "http://svmmatrixdev02.orhs.org/Affinity/FaceSheet.svc?wsdl"> 


<cfset CLIENTID = "47318FFC-AD91-0A5A-7FD5-F34B1F7CBBD0" >


<!---
IMPLEMENTATION OF: GetFacesheetAccount - RETURNS ACCOUNT INFORMATION FROM THE VIEW _SYSTEM.YCKN_V_PHYS_FS

RETURNS: ColdFusion Query of all found Account numbers

USAGE:
  
<cfinvoke component="cfc.services.affinity.service"  method="GetFacesheetAccount" returnvariable="rv"
	ParmAccount="3000408850,3000416382,3500083609,3500083633">

<cfdump var="#rv#">

NOTE: Status will contain EAGLE or FALCON depending upon where the ACCOUNT record originates
--->

	<cffunction name="GetFacesheetAccount" access="public" >
		<cfargument name="ParmAccount" type="string" required="Yes">

		<cfset nQuery = QueryNew("ACCIDENT_DATE,ACCIDENT_OCCURRED_HOW,ACCIDENT_OCCURRED_WHERE,ACCIDENT_TIME,ACCIDENT_TYPE,ADMIT_DATE,ADMIT_DIAGNOSIS_CODE,ADMIT_DIAGNOSIS_DESCRIPTION,ADMIT_PHYSICIAN_NAME,ADMIT_PHYSICIAN_NUMBER,ADMIT_PHYSICIAN_OFFICE_ID,ADMIT_PHYSICIAN_PHONE,ADMIT_TIME,ADMIT_TYPE,ADM_PHYSICIAN_ID,ADV_DIR_FLAG1,ADV_DIR_FLAG2,ADV_DIR_FLAG3,ADV_DIR_FOLLOW_UP_REQUIRED,ADV_DIR_INFO_GIVEN,ARRIVED_BY,ATTEND_PHYSICIAN_PHONE,ATT_PHYSICIAN_ID,ATT_PHYSICIAN_NAME,ATT_PHYSICIAN_NUMBER,AUTH_TO_RELEASE_INFO,CAMPUS_DESCRIPTION,CFT_DATE,CFT_END_DATE,CFT_STATUS_CODE,CFT_UNABLE_TO_SIGN_DATE,CID_NUMBER,COMMENT,CURRENT_BED,CURRENT_DATETIME,CURRENT_NURSING_UNIT,CURRENT_ROOM,DATE_OF_LMP,DISCHARGE_DATE,DISCHARGE_STATUS,DISCHARGE_TIME,EMPLOYEE_OCCUPATION,EMPLOYER_ADDRESS,EMPLOYER_ADDRESS_2,EMPLOYER_CITY,EMPLOYER_NAME,EMPLOYER_STATE,EMPLOYER_ZIP_CODE,EMPLOYMENT_STATUS,ETHNICITY,FACILITY_DESCRIPTION,GUARANTOR_EMPLOYER_ADDRESS_1,GUARANTOR_EMPLOYER_ADDRESS_2,GUARANTOR_EMPLOYER_CITY,GUARANTOR_EMPLOYER_NAME,GUARANTOR_EMPLOYER_PHONE_NUMBER,GUARANTOR_EMPLOYER_STATE,GUARANTOR_EMPLOYER_ZIP_CODE,GUARANTOR_OCCUPATION,GUAR_ADDRESS_LINE_1,GUAR_ADDRESS_LINE_2,GUAR_CITY,GUAR_DOB,GUAR_EMAIL,GUAR_NAME,GUAR_PHONE,GUAR_RELATIONSHIP_TO_PATIENT,GUAR_SSN,GUAR_STATE,GUAR_ZIP,INTERPRETER_NEEDED,MARITAL_STATUS,MOTHER_SSN,MSP_AGE,MSP_DISABILITY,MSP_ESRD,MSP_QUESTIONNAIRE_COMPLETE,ONSET_OF_SYMPTOMS_ILLNESS,OTHER_EMPLOYER_ADDRESS,OTHER_EMPLOYER_ADDRESS_2,OTHER_EMPLOYER_CITY,OTHER_EMPLOYER_NAME,OTHER_EMPLOYER_STATE,OTHER_EMPLOYER_ZIP_CODE,OTHER_GUARANTOR_EMPLOYER_ADDRESS_1,OTHER_GUARANTOR_EMPLOYER_ADDRESS_2,OTHER_GUARANTOR_EMPLOYER_CITY,OTHER_GUARANTOR_EMPLOYER_NAME,OTHER_GUARANTOR_EMPLOYER_PHONE_NUMBER,OTHER_GUARANTOR_EMPLOYER_STATE,OTHER_GUARANTOR_EMPLOYER_ZIP_CODE,PATIENT_ACCOUNT_NUMBER,PATIENT_ID,PATIENT_LANGUAGE,PATIENT_SERVICE_CODE,PATIENT_TYPE,PC_PHYSICIAN_NAME,PC_PHYSICIAN_NUMBER,PREF_METHOD_OF_CONTACT,PREVIOUS_NURSING_UNIT,PROGRAM_DESCRIPTION,PRS_STATUS,PT_ADDRESS_LINE_1,PT_ADDRESS_LINE_2,PT_AGE,PT_CELL,PT_CITY,PT_COUNTY,PT_DOB,PT_FOREIGN_COUNTRY,PT_HOME_PHONE,PT_MRUN,PT_NAME,PT_SEX,PT_STATE,PT_WORK_PHONE,PT_ZIP,RACE,REASON_MISSING_SSN,RELIGION_CODE,RETURN_MAIL_FLAG,SIS_ID,SSN,VALUABLES_SECURED,VISIT_ID,VISIT_REASON,SYSTEM")>	
	
		<cfloop list="#ParmAccount#" index="PA">
	
		 	<cftry>
				<cfinvoke webservice="#WEBURL#"
						  method="GetFacesheetAccount"
						  returnvariable="wsreturndata"  refreshwsdl="no">
					<cfinvokeargument name="clientid" value="#CLIENTID#">
					<cfinvokeargument name="accountnumber" value="#PA#">
				</cfinvoke>
			<cfcatch>
				<cfinvoke webservice="#WEBURL#"
						  method="GetFacesheetAccount"
						  returnvariable="wsreturndata"  refreshwsdl="no">
					<cfinvokeargument name="clientid" value="#CLIENTID#">
					<cfinvokeargument name="accountnumber" value="#PA#">
				</cfinvoke>
			</cfcatch>
			</cftry>	
			

			<cfif structKeyExists(wsreturndata, "FacesheetAccount")>

				<cfloop FROM="1" TO="#ARRAYLEN(wsreturndata.FacesheetAccount)#" INDEX="f">				

					<CFSET FA = wsreturndata.FacesheetAccount[F]>	
					<cfset temp = QueryAddRow(nQuery)>
					<cfset Temp = QuerySetCell(nQuery, "ACCIDENT_DATE", FA.ACCIDENT_DATE)>
					<cfset Temp = QuerySetCell(nQuery, "ACCIDENT_OCCURRED_HOW", FA.ACCIDENT_OCCURRED_HOW)>
					<cfset Temp = QuerySetCell(nQuery, "ACCIDENT_OCCURRED_WHERE", FA.ACCIDENT_OCCURRED_WHERE)>
					<cfset Temp = QuerySetCell(nQuery, "ACCIDENT_TIME", FA.ACCIDENT_TIME)>
					<cfset Temp = QuerySetCell(nQuery, "ACCIDENT_TYPE", FA.ACCIDENT_TYPE)>
					<cfset Temp = QuerySetCell(nQuery, "ADMIT_DATE", FA.ADMIT_DATE)>
					<cfset Temp = QuerySetCell(nQuery, "ADMIT_DIAGNOSIS_CODE", FA.ADMIT_DIAGNOSIS_CODE)>
					<cfset Temp = QuerySetCell(nQuery, "ADMIT_DIAGNOSIS_DESCRIPTION", FA.ADMIT_DIAGNOSIS_DESCRIPTION)>
					<cfset Temp = QuerySetCell(nQuery, "ADMIT_PHYSICIAN_NAME", FA.ADMIT_PHYSICIAN_NAME)>
					<cfset Temp = QuerySetCell(nQuery, "ADMIT_PHYSICIAN_NUMBER", FA.ADMIT_PHYSICIAN_NUMBER)>
					<cfset Temp = QuerySetCell(nQuery, "ADMIT_PHYSICIAN_OFFICE_ID", FA.ADMIT_PHYSICIAN_OFFICE_ID)>
					<cfset Temp = QuerySetCell(nQuery, "ADMIT_PHYSICIAN_PHONE", FA.ADMIT_PHYSICIAN_PHONE)>
					<cfset Temp = QuerySetCell(nQuery, "ADMIT_TIME", FA.ADMIT_TIME)>
					<cfset Temp = QuerySetCell(nQuery, "ADMIT_TYPE", FA.ADMIT_TYPE)>
					<cfset Temp = QuerySetCell(nQuery, "ADM_PHYSICIAN_ID", FA.ADM_PHYSICIAN_ID)>
					<cfset Temp = QuerySetCell(nQuery, "ADV_DIR_FLAG1", FA.ADV_DIR_FLAG1)>
					<cfset Temp = QuerySetCell(nQuery, "ADV_DIR_FLAG2", FA.ADV_DIR_FLAG2)>
					<cfset Temp = QuerySetCell(nQuery, "ADV_DIR_FLAG3", FA.ADV_DIR_FLAG3)>
					<cfset Temp = QuerySetCell(nQuery, "ADV_DIR_FOLLOW_UP_REQUIRED", FA.ADV_DIR_FOLLOW_UP_REQUIRED)>
					<cfset Temp = QuerySetCell(nQuery, "ADV_DIR_INFO_GIVEN", FA.ADV_DIR_INFO_GIVEN)>
					<cfset Temp = QuerySetCell(nQuery, "ARRIVED_BY", FA.ARRIVED_BY)>
					<cfset Temp = QuerySetCell(nQuery, "ATTEND_PHYSICIAN_PHONE", FA.ATTEND_PHYSICIAN_PHONE)>
					<cfset Temp = QuerySetCell(nQuery, "ATT_PHYSICIAN_ID", FA.ATT_PHYSICIAN_ID)>
					<cfset Temp = QuerySetCell(nQuery, "ATT_PHYSICIAN_NAME", FA.ATT_PHYSICIAN_NAME)>
					<cfset Temp = QuerySetCell(nQuery, "ATT_PHYSICIAN_NUMBER", FA.ATT_PHYSICIAN_NUMBER)>
					<cfset Temp = QuerySetCell(nQuery, "AUTH_TO_RELEASE_INFO", FA.AUTH_TO_RELEASE_INFO)>
					<cfset Temp = QuerySetCell(nQuery, "CAMPUS_DESCRIPTION", FA.CAMPUS_DESCRIPTION)>
					<cfset Temp = QuerySetCell(nQuery, "CFT_DATE", FA.CFT_DATE)>
					<cfset Temp = QuerySetCell(nQuery, "CFT_END_DATE", FA.CFT_END_DATE)>
					<cfset Temp = QuerySetCell(nQuery, "CFT_STATUS_CODE", FA.CFT_STATUS_CODE)>
					<cfset Temp = QuerySetCell(nQuery, "CFT_UNABLE_TO_SIGN_DATE", FA.CFT_UNABLE_TO_SIGN_DATE)>
					<cfset Temp = QuerySetCell(nQuery, "CID_NUMBER", FA.CID_NUMBER)>
					<cfset Temp = QuerySetCell(nQuery, "COMMENT", FA.COMMENT)>
					<cfset Temp = QuerySetCell(nQuery, "CURRENT_BED", FA.CURRENT_BED)>
					<cfset Temp = QuerySetCell(nQuery, "CURRENT_DATETIME", FA.CURRENT_DATETIME)>
					<cfset Temp = QuerySetCell(nQuery, "CURRENT_NURSING_UNIT", FA.CURRENT_NURSING_UNIT)>
					<cfset Temp = QuerySetCell(nQuery, "CURRENT_ROOM", FA.CURRENT_ROOM)>
					<cfset Temp = QuerySetCell(nQuery, "DATE_OF_LMP", FA.DATE_OF_LMP)>
					<cfset Temp = QuerySetCell(nQuery, "DISCHARGE_DATE", FA.DISCHARGE_DATE)>
					<cfset Temp = QuerySetCell(nQuery, "DISCHARGE_STATUS", FA.DISCHARGE_STATUS)>
					<cfset Temp = QuerySetCell(nQuery, "DISCHARGE_TIME", FA.DISCHARGE_TIME)>
					<cfset Temp = QuerySetCell(nQuery, "EMPLOYEE_OCCUPATION", FA.EMPLOYEE_OCCUPATION)>
					<cfset Temp = QuerySetCell(nQuery, "EMPLOYER_ADDRESS", FA.EMPLOYER_ADDRESS)>
					<cfset Temp = QuerySetCell(nQuery, "EMPLOYER_ADDRESS_2", FA.EMPLOYER_ADDRESS_2)>
					<cfset Temp = QuerySetCell(nQuery, "EMPLOYER_CITY", FA.EMPLOYER_CITY)>
					<cfset Temp = QuerySetCell(nQuery, "EMPLOYER_NAME", FA.EMPLOYER_NAME)>
					<cfset Temp = QuerySetCell(nQuery, "EMPLOYER_STATE", FA.EMPLOYER_STATE)>
					<cfset Temp = QuerySetCell(nQuery, "EMPLOYER_ZIP_CODE", FA.EMPLOYER_ZIP_CODE)>
					<cfset Temp = QuerySetCell(nQuery, "EMPLOYMENT_STATUS", FA.EMPLOYMENT_STATUS)>
					<cfset Temp = QuerySetCell(nQuery, "ETHNICITY", FA.ETHNICITY)>
					<cfset Temp = QuerySetCell(nQuery, "FACILITY_DESCRIPTION", FA.FACILITY_DESCRIPTION)>
					<cfset Temp = QuerySetCell(nQuery, "GUARANTOR_EMPLOYER_ADDRESS_1", FA.GUARANTOR_EMPLOYER_ADDRESS_1)>
					<cfset Temp = QuerySetCell(nQuery, "GUARANTOR_EMPLOYER_ADDRESS_2", FA.GUARANTOR_EMPLOYER_ADDRESS_2)>
					<cfset Temp = QuerySetCell(nQuery, "GUARANTOR_EMPLOYER_CITY", FA.GUARANTOR_EMPLOYER_CITY)>
					<cfset Temp = QuerySetCell(nQuery, "GUARANTOR_EMPLOYER_NAME", FA.GUARANTOR_EMPLOYER_NAME)>
					<cfset Temp = QuerySetCell(nQuery, "GUARANTOR_EMPLOYER_PHONE_NUMBER", FA.GUARANTOR_EMPLOYER_PHONE_NUMBER)>
					<cfset Temp = QuerySetCell(nQuery, "GUARANTOR_EMPLOYER_STATE", FA.GUARANTOR_EMPLOYER_STATE)>
					<cfset Temp = QuerySetCell(nQuery, "GUARANTOR_EMPLOYER_ZIP_CODE", FA.GUARANTOR_EMPLOYER_ZIP_CODE)>
					<cfset Temp = QuerySetCell(nQuery, "GUARANTOR_OCCUPATION", FA.GUARANTOR_OCCUPATION)>
					<cfset Temp = QuerySetCell(nQuery, "GUAR_ADDRESS_LINE_1", FA.GUAR_ADDRESS_LINE_1)>
					<cfset Temp = QuerySetCell(nQuery, "GUAR_ADDRESS_LINE_2", FA.GUAR_ADDRESS_LINE_2)>
					<cfset Temp = QuerySetCell(nQuery, "GUAR_CITY", FA.GUAR_CITY)>
					<cfset Temp = QuerySetCell(nQuery, "GUAR_DOB", FA.GUAR_DOB)>
					<cfset Temp = QuerySetCell(nQuery, "GUAR_EMAIL", FA.GUAR_EMAIL)>
					<cfset Temp = QuerySetCell(nQuery, "GUAR_NAME", FA.GUAR_NAME)>
					<cfset Temp = QuerySetCell(nQuery, "GUAR_PHONE", FA.GUAR_PHONE)>
					<cfset Temp = QuerySetCell(nQuery, "GUAR_RELATIONSHIP_TO_PATIENT", FA.GUAR_RELATIONSHIP_TO_PATIENT)>
					<cfset Temp = QuerySetCell(nQuery, "GUAR_SSN", FA.GUAR_SSN)>
					<cfset Temp = QuerySetCell(nQuery, "GUAR_STATE", FA.GUAR_STATE)>
					<cfset Temp = QuerySetCell(nQuery, "GUAR_ZIP", FA.GUAR_ZIP)>
					<cfset Temp = QuerySetCell(nQuery, "INTERPRETER_NEEDED", FA.INTERPRETER_NEEDED)>
					<cfset Temp = QuerySetCell(nQuery, "MARITAL_STATUS", FA.MARITAL_STATUS)>
					<cfset Temp = QuerySetCell(nQuery, "MOTHER_SSN", FA.MOTHER_SSN)>
					<cfset Temp = QuerySetCell(nQuery, "MSP_AGE", FA.MSP_AGE)>
					<cfset Temp = QuerySetCell(nQuery, "MSP_DISABILITY", FA.MSP_DISABILITY)>
					<cfset Temp = QuerySetCell(nQuery, "MSP_ESRD", FA.MSP_ESRD)>
					<cfset Temp = QuerySetCell(nQuery, "MSP_QUESTIONNAIRE_COMPLETE", FA.MSP_QUESTIONNAIRE_COMPLETE)>
					<cfset Temp = QuerySetCell(nQuery, "ONSET_OF_SYMPTOMS_ILLNESS", FA.ONSET_OF_SYMPTOMS_ILLNESS)>
					<cfset Temp = QuerySetCell(nQuery, "OTHER_EMPLOYER_ADDRESS", FA.OTHER_EMPLOYER_ADDRESS)>
					<cfset Temp = QuerySetCell(nQuery, "OTHER_EMPLOYER_ADDRESS_2", FA.OTHER_EMPLOYER_ADDRESS_2)>
					<cfset Temp = QuerySetCell(nQuery, "OTHER_EMPLOYER_CITY", FA.OTHER_EMPLOYER_CITY)>
					<cfset Temp = QuerySetCell(nQuery, "OTHER_EMPLOYER_NAME", FA.OTHER_EMPLOYER_NAME)>
					<cfset Temp = QuerySetCell(nQuery, "OTHER_EMPLOYER_STATE", FA.OTHER_EMPLOYER_STATE)>
					<cfset Temp = QuerySetCell(nQuery, "OTHER_EMPLOYER_ZIP_CODE", FA.OTHER_EMPLOYER_ZIP_CODE)>
					<cfset Temp = QuerySetCell(nQuery, "OTHER_GUARANTOR_EMPLOYER_ADDRESS_1", FA.OTHER_GUARANTOR_EMPLOYER_ADDRESS_1)>
					<cfset Temp = QuerySetCell(nQuery, "OTHER_GUARANTOR_EMPLOYER_ADDRESS_2", FA.OTHER_GUARANTOR_EMPLOYER_ADDRESS_2)>
					<cfset Temp = QuerySetCell(nQuery, "OTHER_GUARANTOR_EMPLOYER_CITY", FA.OTHER_GUARANTOR_EMPLOYER_CITY)>
					<cfset Temp = QuerySetCell(nQuery, "OTHER_GUARANTOR_EMPLOYER_NAME", FA.OTHER_GUARANTOR_EMPLOYER_NAME)>
					<cfset Temp = QuerySetCell(nQuery, "OTHER_GUARANTOR_EMPLOYER_PHONE_NUMBER", FA.OTHER_GUARANTOR_EMPLOYER_PHONE_NUMBER)>
					<cfset Temp = QuerySetCell(nQuery, "OTHER_GUARANTOR_EMPLOYER_STATE", FA.OTHER_GUARANTOR_EMPLOYER_STATE)>
					<cfset Temp = QuerySetCell(nQuery, "OTHER_GUARANTOR_EMPLOYER_ZIP_CODE", FA.OTHER_GUARANTOR_EMPLOYER_ZIP_CODE)>
					<cfset Temp = QuerySetCell(nQuery, "PATIENT_ACCOUNT_NUMBER", FA.PATIENT_ACCOUNT_NUMBER)>
					<cfset Temp = QuerySetCell(nQuery, "PATIENT_ID", FA.PATIENT_ID)>
					<cfset Temp = QuerySetCell(nQuery, "PATIENT_LANGUAGE", FA.PATIENT_LANGUAGE)>
					<cfset Temp = QuerySetCell(nQuery, "PATIENT_SERVICE_CODE", FA.PATIENT_SERVICE_CODE)>
					<cfset Temp = QuerySetCell(nQuery, "PATIENT_TYPE", FA.PATIENT_TYPE)>
					<cfset Temp = QuerySetCell(nQuery, "PC_PHYSICIAN_NAME", FA.PC_PHYSICIAN_NAME)>
					<cfset Temp = QuerySetCell(nQuery, "PC_PHYSICIAN_NUMBER", FA.PC_PHYSICIAN_NUMBER)>
					<cfset Temp = QuerySetCell(nQuery, "PREF_METHOD_OF_CONTACT", FA.PREF_METHOD_OF_CONTACT)>
					<cfset Temp = QuerySetCell(nQuery, "PREVIOUS_NURSING_UNIT", FA.PREVIOUS_NURSING_UNIT)>
					<cfset Temp = QuerySetCell(nQuery, "PROGRAM_DESCRIPTION", FA.PROGRAM_DESCRIPTION)>
					<cfset Temp = QuerySetCell(nQuery, "PRS_STATUS", FA.PRS_STATUS)>
					<cfset Temp = QuerySetCell(nQuery, "PT_ADDRESS_LINE_1", FA.PT_ADDRESS_LINE_1)>
					<cfset Temp = QuerySetCell(nQuery, "PT_ADDRESS_LINE_2", FA.PT_ADDRESS_LINE_2)>
					<cfset Temp = QuerySetCell(nQuery, "PT_AGE", FA.PT_AGE)>
					<cfset Temp = QuerySetCell(nQuery, "PT_CELL", FA.PT_CELL)>
					<cfset Temp = QuerySetCell(nQuery, "PT_CITY", FA.PT_CITY)>
					<cfset Temp = QuerySetCell(nQuery, "PT_COUNTY", FA.PT_COUNTY)>
					<cfset Temp = QuerySetCell(nQuery, "PT_DOB", FA.PT_DOB)>
					<cfset Temp = QuerySetCell(nQuery, "PT_FOREIGN_COUNTRY", FA.PT_FOREIGN_COUNTRY)>
					<cfset Temp = QuerySetCell(nQuery, "PT_HOME_PHONE", FA.PT_HOME_PHONE)>
					<cfset Temp = QuerySetCell(nQuery, "PT_MRUN", FA.PT_MRUN)>
					<cfset Temp = QuerySetCell(nQuery, "PT_NAME", FA.PT_NAME)>
					<cfset Temp = QuerySetCell(nQuery, "PT_SEX", FA.PT_SEX)>
					<cfset Temp = QuerySetCell(nQuery, "PT_STATE", FA.PT_STATE)>
					<cfset Temp = QuerySetCell(nQuery, "PT_WORK_PHONE", FA.PT_WORK_PHONE)>
					<cfset Temp = QuerySetCell(nQuery, "PT_ZIP", FA.PT_ZIP)>
					<cfset Temp = QuerySetCell(nQuery, "RACE", FA.RACE)>
					<cfset Temp = QuerySetCell(nQuery, "REASON_MISSING_SSN", FA.REASON_MISSING_SSN)>
					<cfset Temp = QuerySetCell(nQuery, "RELIGION_CODE", FA.RELIGION_CODE)>
					<cfset Temp = QuerySetCell(nQuery, "RETURN_MAIL_FLAG", FA.RETURN_MAIL_FLAG)>
					<cfset Temp = QuerySetCell(nQuery, "SIS_ID", FA.SIS_ID)>
					<cfset Temp = QuerySetCell(nQuery, "SSN", FA.SSN)>
					<cfset Temp = QuerySetCell(nQuery, "VALUABLES_SECURED", FA.VALUABLES_SECURED)>
					<cfset Temp = QuerySetCell(nQuery, "VISIT_ID", FA.VISIT_ID)>
					<cfset Temp = QuerySetCell(nQuery, "VISIT_REASON", FA.VISIT_REASON)>
					<cfset Temp = QuerySetCell(nQuery, "SYSTEM", FA.SYSTEM)>
					
				</cfLOOP>
			</CFIF>
		</CFLOOP>

		<cfreturn nQuery>
	
	</cffunction>


<!---- 
IMPLEMENTATION OF: GetFacesheetNOKInfo - RETURNS Next-of-Kin INFORMATION FROM THE VIEW _SYSTEM.YCKN_V_PHYS_FS_NOK

RETURNS: ColdFusion Query of all found NOK PatientIDs

USAGE:
  
<cfinvoke component="cfc.services.affinity.service"  method="GetFacesheetAccount" returnvariable="rv"
	ParmAccount="3000408850">

<cfinvoke component="cfc.services.affinity.service"  method="GetFacesheetNOKInfo" returnvariable="rv"
	ParmPatientID="#rv.PATIENT_id#" ParmSysteM="#RV.SYSTEM#">

NOTE: PatientID is an internal ID for Affinity, and there are duplicates in Eagle and Falcon, which
      is why the System needs to be passed.
--->
	
	<cffunction name="GetFacesheetNOKInfo" access="public" >
		<cfargument name="ParmPatientID" type="string" required="Yes">
		<cfargument name="ParmSystem" type="string" required="No" default="eagle">
		
		<cfset nQuery = QueryNew("NOK_ADDRESS,NOK_ADDRESS_2,NOK_CITY,NOK_HOME_PHONE_NUMBER,NOK_NAME,NOK_PATIENT_ID,NOK_RELATIONSHIP_TO_PATIENT,NOK_STATE,NOK_WORK_PHONE_NUMBER,NOK_ZIP_CODE,NOK_CELL_PHONE_NUMBER,system")>
	
		<cfloop list="#ParmPatientID#" index="PA">
	
			<cftry>
				<cfinvoke webservice="#WEBURL#"
						  method="GetFacesheetNOKInfo"
						  returnvariable="wsreturndata"  refreshwsdl="no">
					<cfinvokeargument name="clientid" value="#CLIENTID#">
					<cfinvokeargument name="patientID" value="#PA#">
					<cfinvokeargument name="systemID" value="#ParmSystem#">
				</cfinvoke>
			<cfcatch>
				<cfinvoke webservice="#WEBURL#"
						  method="GetFacesheetNOKInfo"
						  returnvariable="wsreturndata"  refreshwsdl="yes">
					<cfinvokeargument name="clientid" value="#CLIENTID#">
					<cfinvokeargument name="patientid" value="#PA#">
					<cfinvokeargument name="systemID" value="#ParmSystem#">					
				</cfinvoke>

			</cfcatch>
			</cftry>		

			<cfif structKeyExists(wsreturndata, "FacesheetNOKInfo")>


				<cfloop FROM="1" TO="#ARRAYLEN(wsreturndata.FacesheetNOKInfo)#" INDEX="f">				
					<CFSET FA = wsreturndata.FacesheetNOKInfo[F]>
					<cfset temp = QueryAddRow(nQuery)>
					<cfset Temp = QuerySetCell(nQuery, "NOK_ADDRESS", FA.NOK_ADDRESS)>
					<cfset Temp = QuerySetCell(nQuery, "NOK_ADDRESS_2", FA.NOK_ADDRESS_2)>
					<cfset Temp = QuerySetCell(nQuery, "NOK_CITY", FA.NOK_CITY)>
					<cfset Temp = QuerySetCell(nQuery, "NOK_HOME_PHONE_NUMBER", FA.NOK_HOME_PHONE_NUMBER)>
					<cfset Temp = QuerySetCell(nQuery, "NOK_NAME", FA.NOK_NAME)>
					<cfset Temp = QuerySetCell(nQuery, "NOK_PATIENT_ID", FA.NOK_PATIENT_ID)>
					<cfset Temp = QuerySetCell(nQuery, "NOK_RELATIONSHIP_TO_PATIENT", FA.NOK_RELATIONSHIP_TO_PATIENT)>
					<cfset Temp = QuerySetCell(nQuery, "NOK_STATE", FA.NOK_STATE)>
					<cfset Temp = QuerySetCell(nQuery, "NOK_WORK_PHONE_NUMBER", FA.NOK_WORK_PHONE_NUMBER)>
					<cfset Temp = QuerySetCell(nQuery, "NOK_CELL_PHONE_NUMBER", FA.NOK_CELL_PHONE_NUMBER)>
					<cfset Temp = QuerySetCell(nQuery, "NOK_ZIP_CODE", FA.NOK_ZIP_CODE)>
					<cfset Temp = QuerySetCell(nQuery, "SYSTEM", FA.SYSTEM)>
				</cfLOOP>
			</CFIF>
		</CFLOOP>
		<cfreturn nQuery>		
		
	</cffunction>
	
<!---- 
IMPLEMENTATION OF: GetFacesheetInsuranceInfo - RETURNS Insurance INFORMATION FROM THE VIEW _SYSTEM.YCKN_V_PHYS_FS_INS

RETURNS: ColdFusion Query of all found Insurance records associated with VisitIDs

USAGE:
  
<cfinvoke component="cfc.services.affinity.service"  method="GetFacesheetAccount" returnvariable="rv"
	ParmAccount="3000408850">

<cfinvoke component="cfc.services.affinity.service"  method="GetFacesheetInsuranceInfo" returnvariable="rv"
	ParmVisitID="#rv.VISIT_id#" ParmSysteM="#RV.SYSTEM#">


NOTE: VisitID is an internal ID for Affinity, and there are duplicates in Eagle and Falcon, which
      is why the System needs to be passed.
--->

	<cffunction name="GetFacesheetInsuranceInfo" access="public" >
		<cfargument name="ParmVisitID" type="string" required="Yes">
		<cfargument name="ParmSystem" type="string" required="No" default="eagle">
		
		<cfset nQuery = QueryNew("AUTHORIZATION_NBR,BLUE_CROSS_POLICY_NBR,CHAMPUS_GROUP_NBR,GROUP_INSURANCE_POLICY_NUMBER,GROUP_NUMBER,HMO_GROUP_NBR,HMO_POLICY_NBR,INSURANCE_EFFECTIVE_DATE,INSURANCE_FINANCIAL_CLASS_CODE,INSURANCE_SUBSCRIBER_EMPLOYMENT_STATUS,INS_ADDRESS_LINE_1,INS_CITY,INS_CODE,INS_COMPANY_NAME,INS_PHONE,INS_PRIORITY,INS_STATE,INS_TYPE,INS_ZIP,MEDICAID_GROUP_NBR,MEDICARE_EFFECTIVE_DATE,MEDICARE_GROUP_NBR,OTH_INS_ADDRESS_LINE_1,OTH_INS_CITY,OTH_INS_COMPANY_NAME,OTH_INS_PHONE,OTH_INS_STATE,OTH_INS_ZIP,PATIENT_RELATIONSHIP_TO_INSURED,SUBSCRIBER_DOB,SUBSCRIBER_NAME,WORKERS_COMP_GROUP_NBR,System")>
	
		<cfloop list="#ParmVisitID#" index="PA">
	
			<cftry>
				<cfinvoke webservice="#WEBURL#"
						  method="GetFacesheetInsuranceInfo"
						  returnvariable="wsreturndata"  refreshwsdl="no">
					<cfinvokeargument name="clientid" value="#CLIENTID#">
					<cfinvokeargument name="visitID" value="#PA#">
					<cfinvokeargument name="systemID" value="#ParmSystem#">
				</cfinvoke>
			<cfcatch>
				<cfinvoke webservice="#WEBURL#"
						  method="GetFacesheetInsuranceInfo"
						  returnvariable="wsreturndata"  refreshwsdl="yes">
					<cfinvokeargument name="clientid" value="#CLIENTID#">
					<cfinvokeargument name="visitID" value="#PA#">
					<cfinvokeargument name="systemID" value="#ParmSystem#">					
				</cfinvoke>

			</cfcatch>
			</cftry>		

			<cfif structKeyExists(wsreturndata, "FacesheetInsuranceInfo")>

				<cfloop FROM="1" TO="#ARRAYLEN(wsreturndata.FacesheetInsuranceInfo)#" INDEX="f">
					<CFSET FA = wsreturndata.FacesheetInsuranceInfo[F]>	
					<cfset temp = QueryAddRow(nQuery)>
					<cfset Temp = QuerySetCell(nQuery, "AUTHORIZATION_NBR", FA.AUTHORIZATION_NBR)>
					<cfset Temp = QuerySetCell(nQuery, "BLUE_CROSS_POLICY_NBR", FA.BLUE_CROSS_POLICY_NBR)>
					<cfset Temp = QuerySetCell(nQuery, "CHAMPUS_GROUP_NBR", FA.CHAMPUS_GROUP_NBR)>
					<cfset Temp = QuerySetCell(nQuery, "GROUP_INSURANCE_POLICY_NUMBER", FA.GROUP_INSURANCE_POLICY_NUMBER)>
					<cfset Temp = QuerySetCell(nQuery, "GROUP_NUMBER", FA.GROUP_NUMBER)>
					<cfset Temp = QuerySetCell(nQuery, "HMO_GROUP_NBR", FA.HMO_GROUP_NBR)>
					<cfset Temp = QuerySetCell(nQuery, "HMO_POLICY_NBR", FA.HMO_POLICY_NBR)>
					<cfset Temp = QuerySetCell(nQuery, "INSURANCE_EFFECTIVE_DATE", FA.INSURANCE_EFFECTIVE_DATE)>
					<cfset Temp = QuerySetCell(nQuery, "INSURANCE_FINANCIAL_CLASS_CODE", FA.INSURANCE_FINANCIAL_CLASS_CODE)>
					<cfset Temp = QuerySetCell(nQuery, "INSURANCE_SUBSCRIBER_EMPLOYMENT_STATUS", FA.INSURANCE_SUBSCRIBER_EMPLOYMENT_STATUS)>
					<cfset Temp = QuerySetCell(nQuery, "INS_ADDRESS_LINE_1", FA.INS_ADDRESS_LINE_1)>
					<cfset Temp = QuerySetCell(nQuery, "INS_CITY", FA.INS_CITY)>
					<cfset Temp = QuerySetCell(nQuery, "INS_CODE", FA.INS_CODE)>
					<cfset Temp = QuerySetCell(nQuery, "INS_COMPANY_NAME", FA.INS_COMPANY_NAME)>
					<cfset Temp = QuerySetCell(nQuery, "INS_PHONE", FA.INS_PHONE)>
					<cfset Temp = QuerySetCell(nQuery, "INS_PRIORITY", FA.INS_PRIORITY)>
					<cfset Temp = QuerySetCell(nQuery, "INS_STATE", FA.INS_STATE)>
					<cfset Temp = QuerySetCell(nQuery, "INS_TYPE", FA.INS_TYPE)>
					<cfset Temp = QuerySetCell(nQuery, "INS_ZIP", FA.INS_ZIP)>
					<cfset Temp = QuerySetCell(nQuery, "MEDICAID_GROUP_NBR", FA.MEDICAID_GROUP_NBR)>
					<cfset Temp = QuerySetCell(nQuery, "MEDICARE_EFFECTIVE_DATE", FA.MEDICARE_EFFECTIVE_DATE)>
					<cfset Temp = QuerySetCell(nQuery, "MEDICARE_GROUP_NBR", FA.MEDICARE_GROUP_NBR)>
					<cfset Temp = QuerySetCell(nQuery, "OTH_INS_ADDRESS_LINE_1", FA.OTH_INS_ADDRESS_LINE_1)>
					<cfset Temp = QuerySetCell(nQuery, "OTH_INS_CITY", FA.OTH_INS_CITY)>
					<cfset Temp = QuerySetCell(nQuery, "OTH_INS_COMPANY_NAME", FA.OTH_INS_COMPANY_NAME)>
					<cfset Temp = QuerySetCell(nQuery, "OTH_INS_PHONE", FA.OTH_INS_PHONE)>
					<cfset Temp = QuerySetCell(nQuery, "OTH_INS_STATE", FA.OTH_INS_STATE)>
					<cfset Temp = QuerySetCell(nQuery, "OTH_INS_ZIP", FA.OTH_INS_ZIP)>
					<cfset Temp = QuerySetCell(nQuery, "PATIENT_RELATIONSHIP_TO_INSURED", FA.PATIENT_RELATIONSHIP_TO_INSURED)>
					<cfset Temp = QuerySetCell(nQuery, "SUBSCRIBER_DOB", FA.SUBSCRIBER_DOB)>
					<cfset Temp = QuerySetCell(nQuery, "SUBSCRIBER_NAME", FA.SUBSCRIBER_NAME)>
					<cfset Temp = QuerySetCell(nQuery, "WORKERS_COMP_GROUP_NBR", FA.WORKERS_COMP_GROUP_NBR)>
					<cfset Temp = QuerySetCell(nQuery, "SYSTEM", FA.SYSTEM)>
					
				</cfLOOP>
			</CFIF>
		</CFLOOP>

		<cfreturn nQuery>		
		
	</cffunction>	
	
</cfcomponent>