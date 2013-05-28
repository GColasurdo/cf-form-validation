<!--- Param the form values. --->
<cfparam name="form.name" type="string" default="" />
<cfparam name="form.email" type="string" default="" />
<cfparam name="form.birthday" type="string" default="" />
 
<!--- Create a default API response. --->
<cfset response = {} />
<cfset response[ "success" ] = true />
<cfset response[ "code" ] = "200" />
<cfset response[ "data" ] = "" />
<cfset response[ "error" ] = "" />
 
 
<!--- Try to process the form data. --->
<cftry>
 
	<!--- Validate the name. --->
	<cfif !len( form.name )>
 
		<cfthrow
			type="BadRequest"
			message="Name is required."
			/>
 
	</cfif>
 
	<!--- Validate the email. --->
	<cfif !isValid( "email", form.email )>
 
		<cfthrow
			type="BadRequest"
			message="Email is required (and must be valid)."
			/>
 
	</cfif>
 
	<!--- Validate the birthday. --->
	<cfif !isNumericDate( form.birthday )>
 
		<cfthrow
			type="BadRequest"
			message="Birthday is required (and must be valid)."
			/>
 
	</cfif>
 
 
	<!--- ..... --->
	<!--- Form data is valid - continue to process request. --->
	<!--- ..... --->
 
 
	<!--- Catch bad request exceptions. --->
	<cfcatch type="BadRequest">
 
		<!--- Flag the response as a failure. --->
		<cfset response.success = false />
		<cfset response.code = "400" />
		<cfset response.error = cfcatch.message />
 
	</cfcatch>
 
</cftry>
 
 
<!--- Return the API response back to the client. --->
<cfcontent
	type="text/x-application-json"
	variable="#toBinary( toBase64( serializeJSON( response ) ) )#"
	/>
