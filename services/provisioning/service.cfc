<!---

PHYSICIAN PROVISIONING SERVICE

METHODS WITHIN THIS SERVICE PROVIDE READ-ONLY ACCESS TO PHYSICIAN INFORMATION STORED IN THE ECHO DATABASE.

THE FOLLOWING METHODS ARE IMPLEMENTED:

	TestDatabaseConnection
	PhysicianList
	PhysicianGroupList
	PhysicianDemographics
	GetPhysicianDetail

THIS COLDFUSION CFC IMPLEMENTS THE ECHO PROVISIONING WEB SERVICE. IT PROVIDES A SAFE, SINGLE LOCATION
FOR ACCESSING THIS WEB SERVICE. BY UTILIZING THIS CFC, COLDFUSION PROGRAMMERS NEED NOT ACCESS THE 
WEB SERVICE DIRECTLY, AND DO NOT NEED TO MAINTAIN THE SERVICE LOCATION. WEB SERVICE ADDRESS IS 
STORED IN THE WEBURL VARIABLE BELOW.

THESE METHODS WILL REFRESH THE WSDL AS NEEDED WITHIN COLDFUSION.

THE EXAMPLES PROVIDED WITH EACH METHOD WILL INDICATE THEIR USE. THE PHYSICIANECHO CLASS IS DESCRIBED BELOW:


	Definition of the PhysicianEcho class

    Private dictationID As String
    Private fullname As String
    Private firstname As String
    Private lastname As String
    Private title As String
    Private middlename As String
    Private echoDRID As String
    Private email As String
    Private homeaddress1 As String
    Private homecity As String
    Private homestate As String
    Private homezip As String
    Private workaddress1 As String
    Private workcity As String
    Private workstate As String
    Private workzip As String
    Private phonehome As String
    Private phonework As String
    Private phonecell As String
    Private phoneIVR As String
    Private phoneother As String
    Private groupname As String
    Private taxid As String
    Private status As String
    Private DetailRetrieved As Boolean
    Private PhotoPath As String
    Private specialty As String
    Private department As String
    Private DEA As String
    Private NPI As String
--->


<cfcomponent>

<cfset WEBURL = "http://matrixprod/services/echo/PhysicianInfo.asmx?wsdl">

<!---- 
IMPLEMENTATION OF: TestDatabaseConnection - RETURNS AN STATUS OF THE PROVISIONING DATABASE

USAGE:
  
<cfinvoke component="cfc.services.provisioning.service"  method="TestDatabaseConnection" returnvariable="rv">

---->
	<cffunction name="TestDatabaseConnection" access="public" returntype="boolean" hint="Test Connection to the underlying data source">
		
		<Cftry>
			<cfinvoke webservice="#WEBURL#"
					  method="TestDatabaseConnection"
					  returnvariable="wsreturndata"  refreshwsdl="no">
			</cfinvoke>		
		<cfcatch>
			<cftry>
			<cfinvoke webservice="#WEBURL#"
					  method="TestDatabaseConnection"
					  returnvariable="wsreturndata"  refreshwsdl="yes">
			</cfinvoke>	
			<cfcatch>
				<cfset wsreturndata = "No">
			</cfcatch>
			</cftry>	
					
		</cfcatch>
		</cftry>
		
		<Cfreturn wsreturndata>
	</cffunction>


<!---- 
IMPLEMENTATION OF: PhysicianList - RETURNS AN ARRAY OF PROVISIONED PHYSICIANS OF THE PhysicianECHO class


<ArrayOfPhysicianECHO xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://OrlandoHealth.com/">
- <PhysicianECHO>
  <DictationID xsi:type="xsd:string">667</DictationID> 
  <FullName xsi:type="xsd:string">Abbott, Lionel C.</FullName> 
  <FirstName xsi:type="xsd:string">Lionel</FirstName> 
  <LastName xsi:type="xsd:string">Abbott</LastName> 
  <MiddleName xsi:type="xsd:string">C.</MiddleName> 
  <EchoDRID xsi:type="xsd:string">00667</EchoDRID> 
  <Email xsi:type="xsd:string">lionelabbott@gmail.com</Email> 
  <Status xsi:type="xsd:string">ORHS</Status> 
  <DetailRetrivied xsi:type="xsd:boolean">false</DetailRetrivied> 
  <PhoneCell xsi:type="xsd:string" /> 
  <GroupName xsi:type="xsd:string">Nephrology Associates of Central Florida</GroupName> 
  <PhotoPath xsi:type="xsd:string" /> 
  <Title xsi:type="xsd:string">MD</Title> 
  </PhysicianECHO>
  

USAGE:
  
<cfinvoke component="cfc.services.provisioning.service"  method="PhysicianList" returnvariable="rv" ParmLastName="Smith">
<cfoutput>
<select>
<cfloop index="i" from="1" to="#ArrayLen(rv.PhysicianEcho)#">
<option value="#rv.PhysicianEcho[i].Email#">#rv.PhysicianEcho[i].FullName#</option>
</cfloop>
</select>
</cfoutput>

NOTE: Status will contain ORHS or SOLK depending upon whether or not the physician record originates on the ORHS or SOLK 
Echo systems

--->

	<cffunction name="PhysicianList" access="public" hint="Return a list of provisioned physicians">
		<cfargument name="ParmDictationID" type="string" required="No" default="">
        <cfargument name="ParmLastName" type="string" required="No"  default="">
        <cfargument name="ParmGroupName" type="string" required="no" default="">	
	
			<cftry>
				<cfinvoke webservice="#WEBURL#"
						  method="PhysicianList"
						  returnvariable="wsreturndata"  refreshwsdl="no">
					<cfinvokeargument name="ParmDictationID" value="#ParmDictationID#">
					<cfinvokeargument name="ParmLastName" value="#ParmLastName#">
					<cfinvokeargument name="ParmGroupName" value="#ParmGroupName#">
				</cfinvoke>
			<cfcatch>
				<cfinvoke webservice="#WEBURL#"
						  method="PhysicianList"
						  returnvariable="wsreturndata"  refreshwsdl="yes">
					<cfinvokeargument name="ParmDictationID" value="#ParmDictationID#">
					<cfinvokeargument name="ParmLastName" value="#ParmLastName#">
					<cfinvokeargument name="ParmGroupName" value="#ParmGroupName#">
				</cfinvoke>

			</cfcatch>
			</cftry>		
			
			<cfreturn wsreturndata>
	
	</cffunction>

<!---
IMPLEMENTATION OF: PhysicianGroupList - RETURNS AN ARRAY OF PRACTICE GROUPS LISTED FOR PROVISIONED PHYSICIANS OF THE PhysicianGroup class



<ArrayOfPhysicianGroup xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://OrlandoHealth.com/">
- <PhysicianGroup>
  <TaxID xsi:type="xsd:string"></TaxID> 
  <TaxIDGroupName xsi:type="xsd:string"></TaxIDGroupName> 
  <PrimaryAddressGroupName xsi:type="xsd:string"></PrimaryAddressGroupName> 
  <Source xsi:type="xsd:string"></Source> 
  </PhysicianGroup>
  
USAGE:

<cfinvoke component="cfc.services.provisioning.service"  method="PhysicianGroupList" returnvariable="rv" ParmSource="ORHS">
<cfoutput>
<cfloop index="i" from="1" to="#ArrayLen(rv.PhysicianGroup)#">

#rv.PhysicianGroup[i].TaxID# - #rv.PhysicianGroup[i].PrimaryAddressGroupName #<br>

</cfloop>
</cfoutput>  
  
--->
	<cffunction name="PhysicianGroupList" access="public" hint="Return a list of practice groups listed for provisioned physicians">
		<cfargument name="ParmDictationID" type="string" required="No" default="">
        <cfargument name="ParmSource" type="string" required="No"  default="all"> <!---ORHS, SOLK or ALL--->
	
			<cftry>
				<cfinvoke webservice="#WEBURL#"
						  method="PhysicianGroupList"
						  returnvariable="wsreturndata"  refreshwsdl="no">
					<cfinvokeargument name="ParmDictationID" value="#ParmDictationID#">
					<cfinvokeargument name="ParmSource" value="#ParmSource#">

				</cfinvoke>
			<cfcatch>
				<cfinvoke webservice="#WEBURL#"
						  method="PhysicianGroupList"
						  returnvariable="wsreturndata"  refreshwsdl="yes">
					<cfinvokeargument name="ParmDictationID" value="#ParmDictationID#">
					<cfinvokeargument name="ParmSource" value="#ParmSource#">
				</cfinvoke>
			</cfcatch>
			</cftry>		
			
			<cfreturn wsreturndata>
	
	</cffunction>
	
<!---- 

IMPLEMENTATION OF: PhysicianDemographics - RETURNS A SINGLE PROVISIONED PHYSICIANS OF THE PhysicianECHO class
Note: Not all available information is returned by this method; what is provided are those things that are
most likely to be needed.

Required Argument - Dictation ID


<PhysicianECHO xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://OrlandoHealth.com/">
  <DictationID xsi:type="xsd:string">110</DictationID> 
  <FullName xsi:type="xsd:string">Parsons, Robert L.</FullName> 
  <FirstName xsi:type="xsd:string">Robert</FirstName> 
  <LastName xsi:type="xsd:string">Parsons</LastName> 
  <MiddleName xsi:type="xsd:string">L.</MiddleName> 
  <EchoDRID xsi:type="xsd:string">P0267</EchoDRID> 
  <Email xsi:type="xsd:string" /> 
  <Status xsi:type="xsd:string">Initialized</Status> 
  <DetailRetrivied xsi:type="xsd:boolean">false</DetailRetrivied> 
  <PhoneCell xsi:type="xsd:string" /> 
  <PhotoPath xsi:type="xsd:string" /> 
  <Title xsi:type="xsd:string">MD</Title> 
  </PhysicianECHO>	
  
USAGE:
  
<cfinvoke component="cfc.services.provisioning.service"  method="PhysicianDemographics" returnvariable="rv" ParmDictationID="1150">

<cfoutput>
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

</cfoutput>
  
  --->




	<cffunction name="PhysicianDemographics" access="public" hint="Return Physician Demographics information for a specified DictationID ">
		<cfargument name="ParmDictationID" type="string" required="Yes">
	
			<cftry>
				<cfinvoke webservice="#WEBURL#"
						  method="PhysicianDemographics"
						  returnvariable="wsreturndata"  refreshwsdl="no">
					<cfinvokeargument name="ParmDictationID" value="#ParmDictationID#">

				</cfinvoke>
			<cfcatch>
				<cfinvoke webservice="#WEBURL#"
						  method="PhysicianDemographics"
						  returnvariable="wsreturndata"  refreshwsdl="yes">
					<cfinvokeargument name="ParmDictationID" value="#ParmDictationID#">
				</cfinvoke>
			</cfcatch>
			</cftry>		
			
			<cfreturn wsreturndata>
	
	</cffunction>

<!---
IMPLEMENTATION OF: GetPhysicianDetail - RETURNS A SINGLE PROVISIONED PHYSICIANS OF THE PhysicianECHO class
Note: This fills-out the PhysicianEcho class with more detailed information.

Required Argument - inDoc - pass in an object of type PhysicianEcho that has previously been initialized, perhaps
by a call to PhysicianDemographics

USAGE:

<cfinvoke component="cfc.services.provisioning.service"  method="PhysicianDemographics" returnvariable="rv" ParmDictationID="1150">
<cfinvoke component="cfc.services.provisioning.service"  method="GetPhysicianDetail" returnvariable="rv" inDoc="#rv#">

<cfoutput>
<cfoutput>
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

</cfoutput>
</cfoutput>
--->

	<cffunction name="GetPhysicianDetail" access="public" hint="Return Physician Detailed information for a specified Physician">
		<cfargument name="inDoc" required="Yes">
	
			<cftry>
				<cfinvoke webservice="#WEBURL#"
						  method="GetPhysicianDetail"
						  returnvariable="wsreturndata"  refreshwsdl="no">
					<cfinvokeargument name="inDoc" value="#inDoc#">

				</cfinvoke>
			<cfcatch>
				<cfinvoke webservice="#WEBURL#"
						  method="GetPhysicianDetail"
						  returnvariable="wsreturndata"  refreshwsdl="yes">
					<cfinvokeargument name="inDoc" value="#inDoc#">

				</cfinvoke>
			</cfcatch>
			</cftry>		
			
			<cfreturn wsreturndata>
	
	</cffunction>
	
	

	
	
</cfcomponent>