<%dim cn,ps%>
<style type=text/css>
a {color:#0099CC;font-size:12px;font-weight:bold}
a:hover {color:#FF6666}
select {background-color:#0099CC; color:#ffffff; font-size:9px; font-family:Verdana, Arial, Helvetica, sans-serif}
option {background-color:#ffffff; color:#0099CC; font-size:9px; font-family:Verdana, Arial, Helvetica, sans-serif}
.game_no {font-family:Verdana, Arial, Helvetica, sans-serif;font-weight:bold; font-size:14px}
.visitor {font-family:Verdana, Arial, Helvetica, sans-serif; font-size:9px; white-space:nowrap;}
.home {font-family:Verdana, Arial, Helvetica, sans-serif; font-size:9px; font-weight:bold; white-space:nowrap;}
.line {font-family:Verdana, Arial, Helvetica, sans-serif; font-size:9px; color:#0099CC}
.manopt {background-color:#ffffff; color:#0099CC; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px; font-weight:bold; border: 1px solid #000000; white-space:nowrap}
th {font-family:Verdana, Arial, Helvetica, sans-serif; font-size:13px; font-weight:bold; white-space:nowrap}
body {font-family:Verdana, Arial, Helvetica, sans-serif}
.week {font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px; font-weight:bold}
.warning {font-family:Verdana, Arial, Helvetica, sans-serif; font-size:14px; font-weight:bold; color:#FF6666}
.remaining {font-family:Verdana, Arial, Helvetica, sans-serif; font-size:14px; font-weight:bold; color:#0099CC}
a.clear {font-size:8px}
.value_vis {border: 1px solid #666666; background-color:#0099CC; color:#ffffff; font-size:9px; font-weight:bold}
.value_ho {border: 1px solid #666666; background-color:#FF6666; color:#ffffff; font-size:9px; font-weight:bold}
.value_no {border: 1px solid #666666; background-color:#000000; color:#ffffff; font-size:9px; font-weight:bold}
.vis_grid {font-family:Verdana, Arial, Helvetica, sans-serif; font-size:9px; color:#0099CC; font-weight:bold; text-decoration:none}
.vis_grid {font-family:Verdana, Arial, Helvetica, sans-serif; font-size:9px; color:#0099CC; font-weight:bold; text-decoration:none}
.ho_grid {font-family:Verdana, Arial, Helvetica, sans-serif; font-size:9px; color:#FF6666; font-weight:bold; text-decoration:none}
.no_grid {font-family:Verdana, Arial, Helvetica, sans-serif; font-size:9px; color:#000000; font-weight:bold; text-decoration:none}
a.vis_grid:hover {text-decoration:underline; color:#0099CC}
a.ho_grid:hover {text-decoration:underline; color:#FF6666}
.name_grid {font-family:Verdana, Arial, Helvetica, sans-serif; font-size:9px; font-weight:bold; white-space:nowrap}
.results {font-size:10px}
.value_total_pos {border: 1px solid #666666; background-color:#00CC66; color:#000000; font-size:9px; font-weight:bold}
.value_total_neg {border: 1px solid #666666; background-color:#FFFF99; color:#000000; font-size:9px; font-weight:bold}
.value_total_evn {border: 1px solid #666666; background-color:#ffffff; color:#000000; font-size:9px; font-weight:bold}
.correct {text-decoration:underline}
.incorrect {text-decoration:line-through}
</style>
<%
sub connect


	'CS = "Driver={SQL Native Client}; Data Source=sldb.igtm.com;Initial Catalog=spocom;Uid=m.rhoden;Pwd=firehitsites"
	CS = "Driver={SQL Server};Server=P3NWPLSK12SQL23;Database=spocom;Uid=strawnj5;Pwd=pick3MMM5;"
	Set cnPick = Server.CreateObject("ADODB.Connection")
	cnPick.ConnectionString = CS
	cnPick.Open

	'CS=application("gtmspocom_dbCS")
	Set cn=Server.CreateObject("ADODB.Connection")
	cn.ConnectionString=CS
	cn.cursorlocation=3
	cn.Open

	 Set ps=Server.CreateObject("ADODB.Command")
	 ps.ActiveConnection=cn
	 ps.CommandType=1
	 ps.CommandTimeout=30
	 ps.Prepared=True
end sub

function NZ(x, y)
	if isnull(x) or isempty(x) or x="" then
		NZ=y
	else
		NZ=x
	end if
end function

function ZN(x)
	if isnull(x) or isempty(x) or x="" then
		ZN=NULL
	else
		ZN=x
	end if
end function

function execPreparedStatement(sql,params)

	dim i
	ps.CommandText=sql
	ps.parameters.refresh
	for i=0 to ubound(params)-1

	ps.parameters(i).value=params(i)
	next

	set execPreparedStatement=ps.execute
end function
Function GetGameIDFromURL()
	dim r,s,t, rv(2)
	r = split(request.ServerVariables("PATH_INFO"),"/")
	s = left(r(ubound(r)),len(r(ubound(r))) - 4)
	t = split(s,"_")
	rv(0) = t(2)
	rv(1) = t(3)
	GetGameIDFromURL = rv
End Function

Function ReturnEmailsCSV()
	Dim SQL, rs, i, t
	Connect
	SQL = "Select Email_Address From pkmUsers"
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.ActiveConnection = cnPick
	rs.LockType = 1
	rs.CursorLocation = 3
	rs.CursorType = 0
	rs.Open SQL
	t = ""
	For i = 1 to rs.RecordCount
		If rs.Fields(0).Value <> "favorite" AND rs.Fields(0).Value <> "underdog" AND rs.Fields(0).Value <> "mrhoden@igtm.com" AND rs.Fields(0).Value <> "tes" AND rs.Fields(0).Value <> "test"  AND rs.Fields(0).Value <> "abc"   Then
			t = t & rs.Fields(0).Value
			t = t & ";<br />"
		End If
		rs.MoveNext
	Next
	t = t & "<P>" & rs.RecordCount & "</P>"
	rs.Close
	Set rs.ActiveConnection = Nothing
	set rs = nothing
	Disconnect
	ReturnEmailsCSV = t
End Function
%>
<%
Function ReturnEmailsCSVForWeek(wk,yr)
	Dim SQL, rs, i, t
	Connect
	SQL = "Select Distinct Email_Address From pkmUsers, pkmPicks Where Week = " & wk & " and Year = '" & yr & "' AND pkmUsers.UID = pkmPicks.UID"
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.ActiveConnection = cnPick
	rs.LockType = 1
	rs.CursorLocation = 3
	rs.CursorType = 0
	rs.Open SQL
	t = ""
	For i = 1 to rs.RecordCount
		If rs.Fields(0).Value <> "favorite" AND rs.Fields(0).Value <> "underdog" AND rs.Fields(0).Value <> "mrhoden@igtm.com" AND rs.Fields(0).Value <> "tes" AND rs.Fields(0).Value <> "test"  AND rs.Fields(0).Value <> "abc"   Then
			t = t & rs.Fields(0).Value
			t = t & ";<br />"
		End If
		rs.MoveNext
	Next
	t = t & "<P>" & rs.RecordCount & "</P>"
	rs.Close
	Set rs.ActiveConnection = Nothing
	set rs = nothing
	Disconnect
	ReturnEmailsCSVForWeek = t
End Function
%>
<%

Private Sub Disconnect()
	cnPick.Close
	Set cnPick = Nothing
End Sub

Private Function GetFirstName(uid)
	Dim rsName, SQL
	Set rsName = Server.CreateObject("ADODB.Recordset")
	rsName.ActiveConnection = cnPick
	rsName.LockType = 1
	rsName.CursorLocation = 3
	rsName.CursorType = 0
	SQL = "Select First_Name From pkmUsers Where UID = '" & uid & "'"
	rsName.Open SQL
	
	GetFirstName = rsName.Fields(0).Value
	rsName.Close
	Set rsName.ActiveConnection = Nothing
	Set rsName = Nothing
End Function

Private Function CheckLogin(email,password)
	Dim rsLogin, SQL
	SQL = "Select Password, UID From pkmUsers Where Email_Address = '" & email & "'"
	Set rsLogin = Server.CreateObject("ADODB.Recordset")
	rsLogin.ActiveConnection = cnPick
	rsLogin.LockType = 1
	rsLogin.CursorLocation = 3
	rsLogin.CursorType = 0
	rsLogin.Open SQL
	If rsLogin.RecordCount > 0 Then
		If rsLogin.Fields("Password") = password Then
			CheckLogin = rsLogin.Fields("UID")
		Else
			CheckLogin = "00000"
		End If
	Else
		CheckLogin = "99999"
	End If
	rsLogin.Close
	Set rsLogin.ActiveConnection = Nothing
	Set rsLogin = Nothing
End Function
%>
<%
Function CreateUserID()
	Dim objMemberInfo, objFile, tempID, tempNum, IDLength, Zeros, newID

	Set objMemberInfo = CreateObject("Scripting.FileSystemObject")
	Set objFile = objMemberInfo.OpenTextFile("f:\inetpub\gtmsportswear.com\pickem\userid.txt",1)

	tempID = objFile.Readline
	objFile.close
	tempNum = CLng(tempID)
	tempNum = tempNum + 1
	IDLength = len(tempNum)
	Zeros = String(5 - IDLength,"0")
	newID = Zeros & tempNum
	CreateUserID = newID
	
	Set objFile = Nothing
	Set objFile = objMemberInfo.OpenTextFile("f:\inetpub\gtmsportswear.com\pickem\userid.txt",2)
	objFile.Writeline(tempNum)
	objFile.Close
	Set objFile = Nothing
	Set objMemberInfo = Nothing	
End Function
%>
<%
function createuid()
	dim rs,sql,temp
	sql="select max(cast(uid as int))+1 as cuid  from [dbo].[pkmUsers]"
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.ActiveConnection = cnPick
	rs.LockType = 1
	rs.CursorLocation = 3
	rs.CursorType = 0
	rs.Open SQL
	temp=rs("cuid").value
	if temp<1000 then
		createuid="00"&cstr(temp)
	elseif temp<10000 then
		createuid="0"&cstr(temp)
	else
		createuid=cstr(temp)
	end if
end function
%>
<%
Private Function InsertUser(password, First_Name, Last_Name, email)
	Dim cdUser, SQL,uid
	uid=createuid
	Set cdUser = Server.CreateObject("ADODB.Command")
	cdUser.ActiveConnection = cnPick
	cdUser.CommandType = 1
	cdUser.CommandText = "INSERT INTO [dbo].[pkmUsers]([Password],[First_Name],[Last_Name],[Email_Address],[UID]) Values('" & password & "','" & First_Name & "','" & Last_Name & "','" & _
						email & "','" & uid & "')"
	response.write cduser.commandtext
	cdUser.Execute
	Set cdUser.ActiveConnection = Nothing
	Set cdUser = Nothing
	InsertUser=uid
End Function
%>
<%
Private Function GetGames(uid)
	Dim rsGames, SQL, Games(20), i

	SQL = "Select Game, Pick From pkmPicks Where UID = '" & uid & "' Order By Game"
	Set rsGames = Server.CreateObject("ADODB.Recordset")
	rsGames.ActiveConnection = cnPick
	rsGames.LockType = 1
	rsGames.CursorLocation = 3
	rsGames.CursorType = 0
	rsGames.Open SQL
	If rsGames.RecordCount > 0 Then
		rsGames.MoveFirst
		For i = 0 to rsGames.RecordCount - 1
			Games(i) = rsGames.Fields("Pick").value
			rsGames.MoveNext
		Next
	Else
		Games(0) = "0"
	End If
	rsGames.Close
	Set rsGames.ActiveConnection = Nothing
	Set rsGames = Nothing

	GetGames = Games

End Function
%>
<%
Private Function GetWeights(uid)
	Dim rsGames, SQL, Games(26), i

	SQL = "Select Game, Weight From pkmPicks Where UID = '" & uid & "' Order By Game"
	Set rsGames = Server.CreateObject("ADODB.Recordset")
	rsGames.ActiveConnection = cnPick
	rsGames.LockType = 1
	rsGames.CursorLocation = 3
	rsGames.CursorType = 0
	rsGames.Open SQL
	If rsGames.RecordCount > 0 Then
		rsGames.MoveFirst
		For i = 0 to rsGames.RecordCount - 1
			Games(i) = Cint(rsGames.Fields(1).value)
			rsGames.MoveNext
		Next
	Else
		Games(0) = 0
	End If
	rsGames.Close
	Set rsGames.ActiveConnection = Nothing
	Set rsGames = Nothing

	GetWeights = Games

End Function
function qryMaxWeek(yr)
	dim rs,sql,params(1)
	params(0)=yr
	sql="select max(week) as wk from [dbo].[pkmGames] where year=?"
	set rs=execPreparedStatement(sql,params)
	if not rs.eof then
		qryMaxWeek=rs("wk").value
	else
		qryMaxWeek=0
	end if
end function
Function getEndTime()
	dim maxWeek,yr
	yr="2018"
	maxWeek=qryMaxWeek(yr)
	dim rs,sql,params(2)
	params(0)=yr
	params(1)=maxWeek
	sql="select max(dtiKickOff) as ko from [dbo].[pkmGames] where year=? and week=?"
	set rs=execPreparedStatement(sql,params)
	getEndTime=rs("ko").value
End Function
Private Function CheckTime()
	StartTime = Now
	EndTime = getEndTime
	if starttime < cdate(endtime) then
	    checktime = true
	else
	    checktime = false
	end if    
End Function
%>
<%
Private Function CallTimeSeconds(StartTime,EndTime)


	StartHour = Hour(StartTime)
	StartMin =  Minute(StartTime)
	StartSec = Second(StartTime)
	EndHour = Hour(EndTime)
	EndMin = Minute(EndTime)
	EndSec = Second(EndTime)
	StartingSeconds = (StartSec + (StartMin * 60) + ((StartHour * 60)*60))
	EndingSeconds = (EndSec + (EndMin * 60) + ((EndHour * 60)*60))
	CallTimeSeconds = EndingSeconds - StartingSeconds
End Function
%>
<%
Private Sub DeletePicks(uid,wk,yr)
	Dim cdDel
	Set cdDel = Server.CreateObject("ADODB.Command")
	cdDel.ActiveConnection = cnPick
	cdDel.CommandType = 1
	cdDel.CommandText = "Delete From pkmPicks Where UID = '" & uid & "' AND Week = '" & wk & "' AND Year = '" & yr & "'"
	cdDel.Execute
	Set cdDel.ActiveConnection = Nothing
	Set cdDel = Nothing
End Sub

Private Sub InsertPicks(uid,Picks,Values, week,yr,deadlines)
	Dim cdDel, i,sql,rs
	Set cdDel = Server.CreateObject("ADODB.Command")
	cdDel.ActiveConnection = cnPick
	cdDel.CommandType = 1
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.ActiveConnection = cnPick
	rs.LockType = 1
	rs.CursorLocation = 3
	rs.CursorType = 0

	For i = 0 to (UBound(Picks) - 1)
		if now()<deadlines(i) then
			cdDel.CommandText = "DELETE FROM [dbo].[pkmPicks] WHERE [UID]='"&uid&"' AND [Week]="&week&" AND [Game]="&(i+1)&" AND [Year]='"&yr&"'"
			Response.Write cdDel.CommandText & "<BR>"
			cdDel.Execute
			cdDel.CommandText = "Insert into pkmPicks Values('" & uid & "','" & week & "','" & (i+1) & "','" & Picks(i) & "','" & Values(i) & "','" & yr & "')"
			Response.Write cdDel.CommandText & "<BR>"
			cdDel.Execute
		else
			sql="select * from dbo.pkmPicks where [UID]='"&uid&"' AND [Week]="&week&" AND [Game]="&(i+1)&" AND [Year]='"&yr&"'"
			rs.Open SQL
			if rs.recordcount=0 then
				cdDel.CommandText = "Insert into pkmPicks Values('" & uid & "','" & week & "','" & (i+1) & "','','" & 0 & "','" & yr & "')"
				Response.Write cdDel.CommandText & "*********<BR>"
				cdDel.Execute
			end if
			rs.close
		end if
	Next
	if cint(yr)>=2012 then
	    rs.open "select * from dbo.pkmScores where UID='" & uid & "' AND Year = '" & yr & "' AND Week = " & week
	    if rs.recordcount=0 then
			cdDel.CommandText = "Insert into dbo.pkmScores Values('" & uid & "','" & yr & "','" & week & "',0,0,0)"
			Response.Write cdDel.CommandText & "*********<BR>"
			cdDel.Execute
	    end if
	    rs.close
	end if
	Set cdDel.ActiveConnection = Nothing
	Set cdDel = Nothing
End Sub
Private Sub InsertPicksBowls(uid,Picks,Values, week,yr,deadlines)
	Dim cdDel, i,sql,rs
	Set cdDel = Server.CreateObject("ADODB.Command")
	cdDel.ActiveConnection = cnPick
	cdDel.CommandType = 1
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.ActiveConnection = cnPick
	rs.LockType = 1
	rs.CursorLocation = 3
	rs.CursorType = 0

	For i = 0 to (UBound(Picks) - 1)
	    %><!-- %><p><%=now%> : <%=deadlines(i)%></p>--><%
	    if now()<deadlines(i) then
		    cdDel.CommandText = "DELETE FROM [dbo].[pkmPicks] WHERE [UID]='"&uid&"' AND [Week]="&week&" AND [Game]="&(i+1)&" AND [Year]='"&yr&"'"
		    Response.Write cdDel.CommandText & "<BR>"
		    cdDel.Execute
		    cdDel.CommandText = "Insert into pkmPicks Values('" & uid & "','" & week & "','" & (i+1) & "','" & Picks(i) & "','" & Values(i) & "','" & yr & "')"
		    Response.Write cdDel.CommandText & "<BR>"
		    cdDel.Execute
		end if
	Next
	if cint(yr)>=2012 then
	    rs.open "select * from dbo.pkmScores where UID='" & uid & "' AND Year = '" & yr & "' AND Week = " & week
	    if rs.recordcount=0 then
			cdDel.CommandText = "Insert into dbo.pkmScores Values('" & uid & "','" & yr & "','" & week & "',0,0,0)"
			Response.Write cdDel.CommandText & "*********<BR>"
			cdDel.Execute
	    end if
	    rs.close
	end if

	Set cdDel.ActiveConnection = Nothing
	Set cdDel = Nothing
End Sub

Private Sub WritePicks()
	Dim objMemberInfo, objFile, tempLine
	Dim rsPicks, SQL, Users, i, Picks(), Weights(), TempPicks(26), TempWeights(26)

	Users = GetAllUsers()
	Redim Picks(UBound(Users))
	'Redim Weights(UBound(Users))
	Set rsPicks = Server.CreateObject("ADODB.Recordset")
	rsPicks.ActiveConnection = cnPick
	rsPicks.LockType = 1
	rsPicks.CursorType = 0
	rsPicks.CursorLocation = 3

	Set objMemberInfo = CreateObject("Scripting.FileSystemObject")
	Set objFile = objMemberInfo.OpenTextFile("f:\hshome\itsgree0\gtmsportswear.com\pickem\picks13.txt",2)

	For i = 0 to UBound(Users) - 1
		TempPicks(0) = GetUserFNameLName(Users(i))
		SQL = "Select Pick From pkmPicks Where UID = '" & Users(i) & "' Order By Game"
		rsPicks.Open SQL
		j = 1
		If rsPicks.RecordCount > 0 Then
			Do While Not rsPicks.EOF
				TempPicks(j) = rsPicks.Fields(0).Value
				'TempWeights(j) = CInt(rsPicks.Fields(1).Value)
				rsPicks.MoveNext
				j = j + 1
			Loop
		Else
			For j = 1 to 13
				TempPicks(j) = "NONE"
				'TempWeights(j) = 0
			Next
		End If
		rsPicks.Close
		Picks(i) = TempPicks
		'Weights(i) = TempWeights
	Next

	For j = 0 to 13
		tempLine = ""
		For i = 0 to UBound(Picks) - 1
			If j = 0 then
				tempLine = tempLine & Picks(i)(j)
			else
				tempLine = tempLine & Picks(i)(j)
			end if
			If i <> UBound(Picks) - 1 Then
				tempLine = tempLine & ";"
			End If
		Next
		objFile.Writeline(tempLine)
	Next

	objFile.Close
	Set objFile = Nothing
	Set objMemberInfo = Nothing

	Set rsPicks.ActiveConnection = Nothing
	Set rsPicks = Nothing
End Sub
%>
<%
Private Function GetAllUsers()
	Dim rsUsers, SQL, i, Users()

	Set rsUsers = Server.CreateObject("ADODB.Recordset")
	rsUsers.ActiveConnection = cnPick
	rsUsers.LockType = 1
	rsUsers.CursorType = 0
	rsUsers.CursorLocation = 3

	SQL = "Select UID, Last_Name From pkmUsers Order By Last_Name"

	rsUsers.Open SQL
	Redim Users(rsUsers.RecordCount)

	rsUsers.MoveFirst
	i=0
	Do While Not rsUsers.EOF
		Users(i) = rsUsers.Fields(0).Value		
		rsUsers.MoveNext
		i = i + 1
	Loop
	rsUsers.Close
	Set rsUsers.ActiveConnection = Nothing
	Set rsUsers = Nothing
	GetAllUsers = Users
	
End Function
%>
<%
Private Function GetUserFNameLName(uid)
	Dim rsUsers, SQL, i, Users()

	Set rsUsers = Server.CreateObject("ADODB.Recordset")
	rsUsers.ActiveConnection = cnPick
	rsUsers.LockType = 1
	rsUsers.CursorType = 0
	rsUsers.CursorLocation = 3

	SQL = "Select Last_Name, First_Name From pkmUsers Where UID = '" & uid & "'"
	rsUsers.Open SQL
	GetUserFNameLName = rsUsers.Fields(0).Value & ", " & rsUsers.Fields(1).Value
	rsUsers.Close
	Set rsUsers.ActiveConnection = Nothing
	Set rsUsers = Nothing

End Function
%>
<%
Private Function GetAllEmails()
	Dim rsEmails, SQL, i, Emails()

	Set rsEmails = Server.CreateObject("ADODB.Recordset")
	rsEmails.ActiveConnection = cnPick
	rsEmails.LockType = 1
	rsEmails.CursorType = 0
	rsEmails.CursorLocation = 3

	SQL = "Select Email_Address From pkmUsers Where UID <> ''"
	rsEmails.Open SQL
	rsEmails.MoveFirst
	Redim Emails(rsEmails.RecordCount)
	For i = 0 to UBound(Emails) - 1
		Emails(i) = rsEmails.Fields(0).Value
		rsEmails.MoveNext
	Next
	rsEmails.Close
	Set rsEmails.ActiveConnection = Nothing
	Set rsEmails = Nothing
	GetAllEmails = Emails
End Function
%>
<%
Private Function GetUserEmail(uid)
	Dim rsEmail, SQL, Email

	Set rsEmail = Server.CreateObject("ADODB.Recordset")
	rsEmail.ActiveConnection = cnPick
	rsEmail.LockType = 1
	rsEmail.CursorType = 0
	rsEmail.CursorLocation = 3

	SQL = "Select Email_Address From pkmUsers Where UID = '" & uid & "'"
	rsEmail.Open SQL
	Email = rsEmail.Fields(0).Value
	rsEmail.Close
	Set rsEmail.ActiveConnection = Nothing
	Set rsEmail = Nothing
	GetUserEmail = Email
End Function
%>
<%
Private Function SendEmail(sender_email,recipients,subject,body)
	Dim objMail, i, Success
	Success = True
	Err.Clear
		Set objMail = Server.CreateObject("JMail.SMTPMail")
		If Err.Number <> 0 Then
		Success = False
	Else
			objMail.ServerAddress = "mail.gtmsportswear.com"
		Response.Write "Email sent to:<br>"
		For i = 0 to UBound(recipients) - 1
			objMail.AddRecipient recipients(i)
			Response.Write (i+1) & ": " & recipients(i) & "<br>"
		Next
		objMail.Sender = sender_email
		objMail.Subject = "" & subject
		objMail.Body = "" & body
		objMail.Execute
	End If
	Set objMail = Nothing
	SendEmail = Success
End Function 
%>
<%
Private Function StandingsForWeek(Week,yr)
	Dim rsResults, SQL, FI(), Last_Name(), Wins(), Results(3), Numgames, i
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	rsResults.ActiveConnection = cnPick
	rsResults.LockType = 1
	rsResults.CursorType = 0
	rsResults.CursorLocation = 3
	SQL = "Select First_Name, Last_Name, Wins From pkmUsers, pkmResults Where Week = '" & Week & _
		"' And pkmUsers.UID = pkmResults.UID AND Year = '" & yr & "' Order By Wins Desc"
	rsResults.Open SQL
	Numgames = rsResults.RecordCount
	If Numgames > 0 Then
		i = 0
		rsResults.MoveFirst
		Redim FI(Numgames)
		Redim Last_Name(Numgames)
		Redim Wins(Numgames)
		Do While Not rsResults.EOF
			FI(i) = Left(rsResults.fields(0).Value, 1)
			Last_Name(i) = rsResults.Fields(1).Value
			Wins(i) = rsResults.Fields(2).Value
			rsResults.MoveNext
			i = i + 1
		Loop
	Else
		Redim FI(1)
		FI(0) = "0"			
	End If
	Results(0) = FI
	Results(1) = Last_Name
	Results(2) = Wins
	StandingsForWeek = Results
	rsResults.Close
End Function
%>
<%
Private Function GetTotalStandings()
	Dim rsResults, SQL, FI(), Last_Name(), Wins(), Results(4), TotalGames(), Numgames, i, WP
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	rsResults.ActiveConnection = cnPick
	rsResults.LockType = 1
	rsResults.CursorType = 0
	rsResults.CursorLocation = 3
	SQL = "Select First_Name, Last_Name, Sum(Wins) as Total, pkmUsers.UID From pkmUsers, pkmResults Where pkmUsers.UID = pkmResults.UID Group By pkmResults.UID Order By Total Desc"
	rsResults.Open SQL
	Numgames = rsResults.RecordCount
	If Numgames > 0 Then
		i = 0
		rsResults.MoveFirst
		Redim FI(Numgames)
		Redim Last_Name(Numgames)
		Redim Wins(Numgames)
		Redim TotalGames(Numgames)
		Do While Not rsResults.EOF
			FI(i) = Left(rsResults.fields(0).Value, 1)
			Last_Name(i) = rsResults.Fields(1).Value
			Wins(i) = rsResults.Fields(2).Value
			WP = Mid(CStr(Wins(i)/GetTotalGames(rsResults.Fields(3).Value)),2,4)
			If Len(WP) = 2 Then
				WP = WP & "00"
			ElseIf Len(WP) = 3 Then
				WP = WP & "0"
			End If
			TotalGames(i) = WP
			rsResults.MoveNext
			i = i + 1
		Loop
	Else
		Redim FI(1)
		FI(0) = "0"			
	End If
	Results(0) = FI
	Results(1) = Last_Name
	Results(2) = Wins
	Results(3) = TotalGames
	GetTotalStandings = Results
	rsResults.Close
End Function
%>
<%
Private Function GetTotalGames(uid)
	Dim rs, total
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.ActiveConnection = cnPick
	rs.LockType = 1
	rs.CursorType = 0
	rs.CursorLocation = 3
	SQL = "Select * From pkmResults Where UID = '" & uid & "'"
	rs.Open SQL
	total = rs.RecordCount * 12
	rs.Close
	set rs.activeconnection = nothing
	GetTotalGames = total
End Function
%>
<%
Private Function GetTotalStandingsForWeeks(StartWeek,EndWeek,YR)
	Dim rsResults, SQL, FI(), Last_Name(), Wins(), Results(3), Numgames, i
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	rsResults.ActiveConnection = cnPick
	rsResults.LockType = 1
	rsResults.CursorType = 0
	rsResults.CursorLocation = 3
	SQL = "Select First_Name, Last_Name, Sum(Wins) as Total From pkmUsers, pkmResults " & _
		"Where pkmUsers.UID = pkmResults.UID AND Week >= " & StartWeek & " AND Week <= " & EndWeek & _
		" AND Year = '" & yr & "' Group By pkmResults.UID Order By Total Desc"
	rsResults.Open SQL
	Numgames = rsResults.RecordCount
	If Numgames > 0 Then
		i = 0
		rsResults.MoveFirst
		Redim FI(Numgames)
		Redim Last_Name(Numgames)
		Redim Wins(Numgames)
		Do While Not rsResults.EOF
			FI(i) = Left(rsResults.fields(0).Value, 1)
			Last_Name(i) = rsResults.Fields(1).Value
			Wins(i) = rsResults.Fields(2).Value
			rsResults.MoveNext
			i = i + 1
		Loop
	Else
		Redim FI(1)
		FI(0) = "0"			
	End If
	Results(0) = FI
	Results(1) = Last_Name
	Results(2) = Wins
	GetTotalStandingsForWeeks = Results
	rsResults.Close
End Function
%>
<%
Private Function GetData(uid,data,week, yr)
	Dim rsGames, SQL, Games(26), i
	SQL = "Select Game, " & data & " From pkmPicks Where UID = '" & uid & "' AND Week = '" & week & "' AND Year = '" & yr & "' Order By Game"
	Set rsGames = Server.CreateObject("ADODB.Recordset")
	rsGames.ActiveConnection = cnPick
	rsGames.LockType = 1
	rsGames.CursorLocation = 3
	rsGames.CursorType = 0
	rsGames.Open SQL
	If rsGames.RecordCount > 0 Then
		rsGames.MoveFirst
		For i = 0 to rsGames.RecordCount - 1
			Games(i) = rsGames.Fields(data).value
			rsGames.MoveNext
		Next
	Else
		Games(0) = "0"
	End If
	rsGames.Close
	Set rsGames.ActiveConnection = Nothing
	Set rsGames = Nothing

	GetData = Games

End Function
%>
<%
function qryTotals(y)
	dim rs,cd,rv(),cnt, mkt, rvObj
	
	Connect
	set cd = server.CreateObject("ADODB.Command")
	cd.activeConnection = cnPick
	cd.commandType = 4
	cd.commandText = "WEB_qry" & y & "pickemTotals_MCR"
	cd.commandTimeout = 30
	cd.parameters.refresh
	
	set rs = cd.execute
	
	if not rs.eof then
		cnt = 0
		do until rs.eof
			cnt = cnt + 1
			redim preserve rv(cnt)
			set rvObj = server.createobject("scripting.dictionary")
			rvObj.add "lname", rs("Last_Name").value
			rvObj.add "fname", rs("First_Name").value
			rvObj.add "total", rs("total").value
			rvObj.add "weeksPlayed", rs("weeksPlayed").value
			rvObj.add "average", rs("total").value/rs("weeksPlayed").value
			if y="2010" or y="2011" or y="2012"  or y="2014" then rvObj.add "mandatoryCorrect", rs("mandatoryCorrect").value
			set rv(cnt-1) = rvObj
			rs.movenext
		loop
	else
		redim rv(0)
	end if
	qryTotals = rv
end function
function qryTotalsV2(y)
	Dim rsResults, SQL, rvObj, rv(), queryWeek
	Set rsResults = Server.CreateObject("ADODB.Recordset")

	rsResults.ActiveConnection = cnPick
	rsResults.LockType = 1
	rsResults.CursorType = 0
	rsResults.CursorLocation = 3
  	'resposne.write y
  	'response.end()
	queryWeek = ""
	if y = 2017 then queryWeek = " AND s.week > 1 "
	SQL = "SELECT " & _ 
      "u.Last_Name, u.First_Name, SUM([Mandatory_Correct]) as mandatoryCorrect, AVG(Score) as average, Count(week) weeksPlayed, Max(week) lastWeekPlayed " & _
	"FROM [dbo].[pkmScores] as s " & _
		"inner join [dbo].[pkmUsers] u on s.uid=u.uid " & _
	"WHERE s.year=" + y + " " & queryWeek & _
	"GROUP BY u.Last_Name, u.First_Name " & _
	"ORDER BY mandatoryCorrect desc "
	'resposne.write sql
	'response.end()
	rsResults.Open SQL
	if not rsResults.eof then
		cnt = 0
		do until rsResults.eof
			cnt = cnt + 1
			redim preserve rv(cnt)
			set rvObj = server.createobject("scripting.dictionary")
			rvObj.add "lname", rsResults("Last_Name").value
			rvObj.add "fname", rsResults("First_Name").value
			rvObj.add "weeksPlayed", rsResults("weeksPlayed").value
			rvObj.add "average", rsResults("average").value
			rvObj.add "mandatoryCorrect", rsResults("mandatoryCorrect").value
			rvObj.add "lastWeekPlayed", rsResults("lastWeekPlayed").value
			set rv(cnt-1) = rvObj
			rsResults.movenext
		loop
	else
		redim rv(0)
	end if
	qryTotalsV2 = rv
	rsResults.Close
end function
%>
<%
sub getUID(email)
	dim rs,sql
	sql="select uid from pkmUsers where Email_Address='"&email&"'"
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.ActiveConnection = cnPick
	rs.LockType = 1
	rs.CursorLocation = 3
	rs.CursorType = 0
	rs.Open SQL
	if not rs.eof then
		getUID=rs("uid").value
	else
		getUID=""
	end if
end sub
%>