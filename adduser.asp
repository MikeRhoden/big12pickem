<%@ language=vbscript %>
<!-- #include file="funcs.asp" --->
<%
	Dim cnPick, rsEmail, email, first_name, last_name, password, uid
	email = Request.Form("Email_Address")
	Connect
	Set rsEmail = Server.CreateObject("ADODB.RecordSet")
	rsEmail.ActiveConnection = cnPick
	rsEmail.CursorType = 0
	rsEmail.CursorLocation = 3
	rsEmail.LockType = 1
	rsEmail.Open "Select Email_Address From dbo.pkmUsers Where Email_Address = '" & email & "'"
	If rsEmail.RecordCount > 0 Then
		Response.Redirect("Register.asp?emailexists=yes&email=" & email)
	Else
		First_Name = Request.Form("First_Name")
		Last_Name = Request.Form("Last_Name")
		password = Request.Form("password")
		uid=InsertUser(password, First_Name, Last_Name, email)
		Response.Redirect("games_2017.asp?uid=" & uid)'bowl_games_2010
	End If
	Disconnect
%>
