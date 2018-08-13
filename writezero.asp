<%@language=vbscript%>
<%
	Dim cnPick, Users, rsUsers, i
%>
<!-- #include file="funcs.asp" --->
<%
	Connect
	Set rsUsers = Server.CreateObject("ADODB.Recordset")
	rsUsers.ActiveConnection = cnPick
	rsUsers.LockType = 1
	rsUsers.CursorLocation = 3
	rsUsers.CursorType = 0
	SQL = "Select UID From Users"
	rsUsers.Open SQL
	redim users(rsusers.recordcount)

	Set cd = Server.CreateObject("ADODB.Command")
	cd.ActiveConnection = cnPick
	cd.CommandType = 1

	for i = 0 to ubound(users) - 1
		users(i) = rsusers.fields(0).value
		cd.CommandText = "Insert into pkmPicks Values('" & users(i) & "',13,'0')"
		cd.Execute
		rsusers.movenext
	next
	rsusers.close
	set rsusers = nothing

	Set cd.ActiveConnection = Nothing
	Set cd = Nothing
	Disconnect
%>

	