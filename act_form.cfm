<!--- Param the form values. --->
<cfparam name="form.name" type="string" default="">
<cfparam name="form.email" type="string" default="">
<cfparam name="form.birthday" type="string" default="">
<cfparam name="form.optionsRadios" type="string" default="">

<!--- Create a collection of form validation errors. --->
<cfset errors = [] />

<!--- Validate the name. --->
<cfif !len( form.name )>
	<cfset arrayAppend( errors, "Please enter your name." )>
</cfif>
 
<!--- Validate the email. --->
<cfif !isValid( "email", form.email )>
	<cfset arrayAppend( errors, "Please enter a valid email." )>
</cfif>
 
<!--- Validate the birthday. --->
<cfif !isNumericDate( form.birthday )>
	<cfset arrayAppend( errors, "Please enter a valid birthday." )>
</cfif> 

<!--- Validate a radio option. --->
<cfif !len( form.optionsRadios )>
	<cfset arrayAppend(errors, "Please select an option.")>
</cfif>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Results</title>
	<link href="css/bootstrap.css" rel="stylesheet" media="screen">
</head>
<body>
<!---
	Check to see if any errors were found during form
	validation - if so, we'll have to pass them back to
	the user.
--->
<cfif !arrayLen( errors )>
	<!--- Form data is valid, continue to process the request. --->
	<cfdump var="#form#">
	<p>Post and redirect</p>
<cfelse> 
<!---
	If we made it this far, re-render the input form and display
	the errors for the user.
--->
	<cfoutput>
	<section class="container">
	<h1>Form Again Please</h1>
	<form action="act_form.cfm" method="post" class="form-horizontal well" id="contact-form">
	<fieldset>
		<legend>A Form</legend>
		<div class="control-group">
		<label for="name" class="control-label">Name:</label>
		<div class="controls"><input type="text" name="name" id="name" class="required" minlength="2" value="#trim(form.name)#" /><span class="help-inline"></span></div>
		</div>

		<div class="control-group">
		<label for="email" class="control-label">Email:</label>
		<div class="controls"><input type="text" name="email" id="email" class="required email" minlength="2" value="#trim(form.email)#" /><span class="help-inline"></span></div>
		</div>

		<div class="control-group">
		<label for="birthday" class="control-label">Birthday:</label>
		<div class="controls"><input type="text" name="birthday" id="birthday" class="required date" value="#trim(form.birthday)#" /><span class="help-inline"></span></div>
		</div>

		<div class="control-group">
		<div class="controls">
		<label class="radio">
		  <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" class="required" <cfif form.optionsRadios EQ "option1">checked</cfif>>
		  Option one is this and that-be sure to include why it's great
		</label>
		<label class="radio">
		  <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2" <cfif form.optionsRadios EQ "option2">checked</cfif>>
		  Option two can be something else and selecting it will deselect option one
		</label>
		</div>
		</div>

		<div class="form-actions">
		<ul id="errors">
			<cfloop array="#errors#" index="er">
			<li>#er#</li>
			</cfloop>
		</ul>
		<input type="submit" value="Submit" class="submit btn btn-primary" />
		</div>
	</fieldset>
	</form>
 	</section>
	</cfoutput>
</cfif>
</body>
</html>