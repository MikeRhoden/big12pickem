<%@ language=vbscript %>
<!-- #include file="funcs.asp" --->
<%
	Dim cnPick
	Connect
	WritePicks
	Disconnect
%>
<html>
<head>
<title>Write Picks</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">
Picks Written to picks.txt file
</body>
</html>
