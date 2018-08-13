<%@  language="VBSCRIPT" codepage="1252" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	dim cn, ps
	sub init
		connect
		insertUser
	end sub
	
	sub connect
		dim CS
		CS = "Driver={SQL Server};Server=P3NWPLSK12SQL23;Database=spocom;Uid=strawnj5;Pwd=pick3MMM5;"
		Set cn = Server.CreateObject("ADODB.Connection")
		cn.ConnectionString = CS
		cn.Open()
		
		 Set ps=Server.CreateObject("ADODB.Command")
		 ps.ActiveConnection=cn
		 ps.CommandType=1
		 ps.CommandTimeout=30
		 ps.Prepared=True
	 end sub
	 
	 sub insertUser
		dim sql, params(5)
		sql = "INSERT INTO [dbo].[pkmUsers]([Password],[First_Name],[Last_Name],[Email_Address],[UID]) Values(?, ?, ?, ?, ?)"
		params(0) = "password"
		params(1) = "tfn"
		params(2) = "tln"
		params(3) = "tea123"
		params(4) = "00237"
		set temp = execPreparedStatement (sql, params)
	 end sub
	 
	function execPreparedStatement(sql,params)
		dim i
		ps.CommandText=sql
		ps.parameters.refresh
		for i=0 to ubound(params)-1
			ps.parameters(i).value=params(i)
		next
		set execPreparedStatement = ps.execute
	end function
%> 
<html>
<head>
	<title>Migrate Test</title>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
<% init %>
</body>
</html>
