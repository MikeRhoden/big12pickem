// JavaScript Document


 function numbersonly(e){
	var unicode=e.charCode? e.charCode : e.keyCode
		if (unicode!=8 && unicode!=9 && unicode!=13 && unicode!=46 && unicode!=37 && unicode!=39){ //if the key isn't the backspace key or tab or delete or left or right(which we should allow)
			if (unicode<48||unicode>57) //if not a number
				return false //disable key press
	}
}

function checkEmail (strng) {
	var emailFilter=/^.+@.+\..{2,3}$/;
	if (!(emailFilter.test(strng)))
		return false;
	else { //test email for illegal characters
		var illegalChars= /[\(\)\<\>\,\;\:\\\"\[\]]/
		if (strng.match(illegalChars))
			return false;
	}
	return true;    
}

function verifyCAlookup1(frm) {
	if (!checkEmail(frm.txtEmail.value)) {
		alert("Please enter a valid email address.");
		frm.txtEmail.focus();
		return false;
	} else if (frm.txtName.value == "") {
		alert("Please enter a design name.");
		frm.txtName.focus();
		return false;
	}
	return true;
}

function verifyCAlookup2(frm) {
	if (frm.txtID.value == "") {
		alert("Please enter an ID for the art you are looking for.");
		frm.txtID.focus();
		return false;
	}
	return true;
}

function artSearch1() {
	var frm = document.calookup;
	if (verifyCAlookup1(frm))
		frm.submit();
}
function artSearch2() {
	var frm = document.calookup;
	if (!checkEmail(frm.txtEmail.value)) {
		alert("Please enter a valid email address.");
		frm.txtEmail.focus();
	} else
		frm.submit();	
}