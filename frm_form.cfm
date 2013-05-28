<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Client-Side Validation</title>
	<link href="css/bootstrap.css" rel="stylesheet" media="screen">
</head>

<body>
	<section class="container">
	<h1>Hello Form</h1>
	<form action="act_form.cfm" method="post" class="form-horizontal well" id="contact-form">
	<fieldset>
		<legend>A Form</legend>
		<div class="control-group">
		<label for="name" class="control-label">Name:</label>
		<div class="controls"><input type="text" name="name" id="name" class="required" minlength="2" /><span class="help-inline"></span></div>
		</div>
		
		<div class="control-group">
		<label for="email" class="control-label">Email:</label>
		<div class="controls"><input type="text" name="email" id="email" class="required email" minlength="2" /><span class="help-inline"></span></div>
		</div>
		
		<div class="control-group">
		<label for="birthday" class="control-label">Birthday:</label>
		<div class="controls"><input type="text" name="birthday" id="birthday" class="required date" /><span class="help-inline"></span></div>
		</div>
		
		<div class="control-group">
		<div class="controls">
		<label class="radio">
		  <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" class="required" messages="Please select one.">
		  Option one is this and that-be sure to include why it's great
		</label>
		<label class="radio">
		  <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
		  Option two can be something else and selecting it will deselect option one
		</label>
		</div>
		</div>
		
		<div class="form-actions">
		<p id="errors">
			<!-- Errors go here. --->
		</p>
		<input type="submit" value="Submit" class="submit btn btn-primary" />
		</div>
	</fieldset>
	</form>
 	</section>

	<script src="/_includes/jquery/jquery-1.8.2.min.js"></script>
	<script src="js/jquery.validate.js"></script>
	<!--<script src="js/bootstrap.js"></script>-->
	<script type="text/javascript">
	$(document).ready(function(){
		$("#contact-form").validate({
			messages: {
				optionsRadios: "Please select one of the options."
			},
			errorPlacement: function(error, element) {
				var isInputAppend = ($(element).parent('div.input-append').length > 0);
				var isRadio = ($(element).attr('type') == 'radio');
				if(isRadio){
					afterElement = $(element).closest('div.controls').children("label").filter(":last");
					error.insertAfter(afterElement);
				}else if (isInputAppend) {
					appendElement = $(element).next('span.add-on');
					error.insertAfter(appendElement);
				}else {
					error.insertAfter(element);
				}
			},
			showErrors: function(errorMap, errorList) {
				$("#errors").html("Your form contains " + this.numberOfInvalids() + " errors, see details above.");
				this.defaultShowErrors();
			},
			highlight: function(label) {
				$(label).closest('.control-group').addClass('error');
			},
			success: function(label) {
				label
				.html(' <i class="icon-ok"></i>').addClass('valid')
				.closest('.control-group').addClass('success');
			},
			errorElement: 'span'
		});
	}); // end document.ready


	/* Long and messy
	$('#contact-form').validate(
		{ rules: {
			name: {
			minlength: 2,
			required: true
				},
			email: {
			required: true,
			email: true
				},
			birthday: {
			date: true,
			required: true
				}
		},
		highlight: function(label) {
			$(label).closest('.control-group').addClass('error');
		},
		success: function(label) {
			label
			.text('OK!').addClass('valid')
			.closest('.control-group').addClass('success');
		}
	}); */	
 	/* Old School Validation
		// Bind to the form submission.
		$( "form" ).submit(
			function( event ){

				// Get the form being submitted.
				var form = $( this );
 
				// Get the errors collection.
				var errorsList = $( "#errors" )
					.empty()
				;
 
				// Validate the name.
				if (isEmpty( form, "name" )){
					errorsList.append(
						"<li>Please enter your name.</li>"
					);
				}
 
				// Validate the email.
				if (isEmpty( form, "email" )){
					errorsList.append(
						"<li>Please enter a valid email.</li>"
					);
				}
 
				// Validate the birthday.
				if (isEmpty( form, "birthday" )){
					errorsList.append(
						"<li>Please enter a valid birthday.</li>"
					);
				}
 
				// Check to see if we have any errors.
				if (errorsList.children().length){
 
					// Show the errors.
					errorsList.show();
 
					// Cancel the form submission.
					event.preventDefault();
				}
			}
		);

		// I check to see if the given field is empty.
		function isEmpty( form, fieldName ){
			// Return true if the field is empty.
			return( form.find( "input[ name = '" + fieldName + "' ]" ).val() === "" );
		}
		*/

	</script>
</body>
</html>
