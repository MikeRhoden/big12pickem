<%@ language=vbscript%>
<!-- entertext.asp --->
<!-- #include file="funcs.asp" --->
<%
	Dim uid, senderemail, cnPick
	uid = Request.QueryString("uid")
	Connect
	senderemail = GetUserEmail(uid)
	Disconnect
%>
<html>
<head>
<title>Send Group Email</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">
<form name="emailtext" method=post action="sendemail.asp?uid=<%=uid%>">
	<table border=1 cellpadding=2 cellspacing=1 align=center>
		<tr>
			<td align=center>
				<div align=left><b>Once you hit "Send Email" an email will be sent to all members of this group<br> with
				your registered email address <font color=red>(<%= senderemail %>)</font> as the reply address.</b></div><hr>
				<b>Subject:&nbsp;</b><input type=text name="subject" value="Place subject here." size=40><br>
				<textarea name="content" rows=15 cols=40>Enter content here.</textarea>
				<br><input type="submit" value="Send Email">&nbsp;&nbsp;<input type=reset value="Clear"><hr>
				<a href="games.asp?uid=<%=uid%>">Back to Games of the Week</a>
			</td>
		</tr>
	</table>	
</form>
</body>
</html>
