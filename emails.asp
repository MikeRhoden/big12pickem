<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- #include file="funcs.asp" --->
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<% Dim cnPick%>
<%= ReturnEmailsCSV() %><br>
<br>
<br>
<%= ReturnEmailsCSVForWeek(2,2006) %>

</body>
</html>
