<%@  language="VBSCRIPT" codepage="1252" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    dim test
    test = 0

    private sub init
        test = CInt(Request.QueryString("test"))
    end sub

    private sub HelloWorld
        Response.Write("Hello World")    
    end sub

    private sub connect
        dim CS
        CS = ""
        if request.querystring("c") = "1" then
           CS = "Data Source=184.168.194.77;Integrated Security=False;User ID=strawnj5;Connect Timeout=15;Encrypt=False;Packet Size=4096"
        elseif request.querystring("c") = "2" then
           CS = "Driver={SQL Native Client}; Data Source=184.168.194.77;Initial Catalog=spocom;Uid=strawnj5;Pwd=pick3MMM5"
        end if
	    Set cnPick = Server.CreateObject("ADODB.Connection")
	    cnPick.ConnectionString = CS
	    cnPick.Open
        Response.Write("Connection Successful")
    end sub

    init
%>
<html>
<head>
    <title>Migrate Test</title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>

<body>
    <%
    if test > 0 then HelloWorld
    %>
    <br />
    <%
    if test > 1 then connect
    %>
</body>
</html>
