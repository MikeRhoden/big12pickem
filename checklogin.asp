<%@ language=vbscript%>
<%
	Dim email, password, uid
	Dim cnPick
%>
<!-- #include file="funcs.asp" --->
<%
	email = Request.Form("email")
	password = Request.Form("pass")
	Connect
	uid = CheckLogin(email,password)
	Disconnect
%>
<html>
<head>
<title>Check Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">
<center>
<%
	If uid = "99999" Then
%>
	Your email address was not found.<br>
	<a href="index.htm">Try again.</a><br>
	<a href="register.asp">Register</a>
<%
	ElseIf uid = "00000" Then
%>
	Your password did not match your email address.<br>
	Email me at <a href="mrhoden@igtm.com">mrhoden@igtm.com</a> to get your password or<br>
	<a href="index.htm">Try again.</a>
<%
	Else
		Response.Redirect("games_2018.asp?uid=" & uid)
	End If
%>
</center>
</body>
</html>
