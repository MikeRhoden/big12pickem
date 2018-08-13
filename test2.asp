<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<%= request.ServerVariables("PATH_INFO")%><br>
<%
	dim r,s,t
	r = split(request.ServerVariables("PATH_INFO"),"/")
	s = left(r(ubound(r)),len(r(ubound(r))) - 4)
	t = split(s,"_")
%>
<%= left(r(ubound(r)),len(r(ubound(r))) - 4) %>
</body>
</html>
