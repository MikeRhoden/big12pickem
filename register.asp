<%@ language=vbscript %>
<!-- #include file="funcs.asp" --->
<%
	Dim emailexists, email
	If Request.QueryString("emailexists") = "yes" Then
		emailexists = True
		email = Request.QueryString("email")
	End If
%>
<html>
<head>
<title>Register</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language=javascript>
	function validate()
	{
		if (document.register.First_Name.value == "")
		{
			alert("Please enter your first name.");
			document.register.First_Name.focus();
			return false;
		}
		else if (document.register.Last_Name.value == "")
		{
			alert("Please enter your last name.");
			document.register.Last_Name.focus();
			return false;
		}
		else if (document.register.Email_Address.value == "")
		{
			alert("Please enter your email address.");
			document.register.Email_Address.focus();
			return false;
		}
		else if (document.register.password.value == "")
		{
			alert("Please enter your password.");
			document.register.password.focus();
			return false;
		}
		else if (document.register.repassword.value == "")
		{
			alert("Please re-enter your password.");
			document.register.repassword.focus();
			return false;
		}
		else if (document.register.password.value != document.register.repassword.value)
		{
			alert("Make sure you retype your password exactly as you typed it.");
			document.register.password.focus();
			return false;
		}
		return true;
	}
</script>
</head>

<body bgcolor="#FFFFFF">
<h1 align=center>Register for pickem</h1>
<%
	If emailexists Then
%>
		<center><font size=+1 color=red><b>The email address, <%= email %>, already exists in the database.<br>
		If you need your password or want it changed email me at <a href="mailto:mrhoden@igtm.com">mrhoden@igtm.com</a>
		<br>if you want to resolve the problem.  Otherwise use a different email address.</b></font></center><br>
<%
	End If
%>
<center>Remember your password and email that you enter.<br>It's what you will use to login and make your picks.</center><br><br>
<form action="adduser.asp" method=post name="register" onSubmit="return validate()">
	<table border=1 cellspacing=0 cellpadding=2 align=center>
		<tr>
			<td align=right valign=bottom>
				First Name:&nbsp;
			</td>
			<td valign=bottom>
				<input type=text name="First_Name">
			</td>
		</tr>
		<tr>
			<td align=right valign=bottom>
				Last Name:&nbsp;
			</td>
			<td valign=bottom>
				<input type=text name="Last_Name">
			</td>
		</tr>
		<tr>
			<td align=right valign=bottom>
				Email Address:&nbsp;
			</td>
			<td valign=bottom>
				<input type=text name="Email_Address">
			</td>
		</tr>
		<tr>
			<td align=right valign=bottom>
				Password:&nbsp;
			</td>
			<td valign=bottom>
				<input type=password name="password">
			</td>
		</tr>
		<tr>
			<td align=right valign=bottom>
				Retype Password:&nbsp;
			</td>
			<td valign=bottom>
				<input type=password name="repassword">
			</td>
		</tr>
		<tr>
			<td align=center colspan=2>
				<input type=submit value="Register">&nbsp;&nbsp;
				<input type=reset value="Reset"><br>
			</td>
		</tr>
	</table>
</form>
</body>
</html>
