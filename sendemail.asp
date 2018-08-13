<%@ language=vbscript%>
<!-- sendemail.asp --->
<!-- #include file="funcs.asp" --->
<%
	Dim uid, subject, content, recipients, cnPick, x, testrec(3), EmailSent, i
	uid = Request.QueryString("uid")
	Connect
	x = GetUserEmail(uid)
	content = Request.Form("content")
	subject = Request.Form("subject")
	recipients = GetAllEmails()
	testrec(1) = "mcrhoden@yahoo.com"
	testrec(0) = "mblachly@hotmail.com"
	testrec(2) = "gib4ksu@hotmail.com"
	EmailSent = SendEmail(x, recipients, subject, content)
	Disconnect
%>
<html>
<head>
<title>Send Group Email</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">
<br><br>
<table width=200 border=1 cellspacing=0 cellpadding=3 align=center><tr><td align=center>
<% If EmailSent Then %>
	<p align=center>Your email has been sent.
<% End If %>
<p align=center><a href="index.htm">*<i>Pickem</i> Home*</a>
<p align=center><a href="games_2007.asp?uid=<%=uid%>">Back to Games of the Week</a>
</td></tr></table>

</body>
</html>
