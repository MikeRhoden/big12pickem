<!-- #include file="cDeadline.asp" -->
<%
Class cUser
	
	Private cn, rs, cd
	Private uid, f_name, l_name, email, picks(20), values(20)
		
	Private Sub Class_Initialize()
		Dim CS
		'CS = "Driver={SQL Native Client}; Data Source=sldb.igtm.com;Initial Catalog=spocom;Uid=m.rhoden;Pwd=firehitsites"
		CS = "Driver={SQL Server};Server=P3NWPLSK12SQL23;Database=spocom;Uid=strawnj5;Pwd=pick3MMM5;"
		Set cn = Server.CreateObject("ADODB.Connection")
		cn.Open CS
		
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.LockType = 1
		rs.CursorType = 0
		rs.CursorLocation = 3
		rs.ActiveConnection = cn
		
		Set cd = Server.CreateObject("ADODB.Command")
		cd.ActiveConnection = cn
		cd.Commandtype = 1
	End Sub
	
	Private Sub Class_Terminate()
		Set rs.ActiveConnection = Nothing
		Set rs = Nothing
		Set cd.ActiveConnection = Nothing
		Set cd = Nothing
		cn.Close
		Set cn = Nothing
	End Sub
	
	Public Sub Initialize(id, wk, y)
		uid = id
		GetUserData
		GetPickData wk, y
	End Sub
	
	Public Property Get User_ID
		User_ID = uid
	End Property
	
	Public Property Get First_Name
		First_Name = f_name
	End Property
	
	Public Property Get Last_Name
		Last_Name = l_name
	End Property
	
	Public Function GetAllPicks()
		GetAllPicks = Picks
	End Function
	
	Public Function GetAllValues()
		GetAllValues = Values
	End Function
	
	Public Function GetPick(ind)
		GetPick = Picks(ind)
	End Function
	
	Public Function GetValue(ind)
		GetValue = Values(ind)
	End Function

	Private Sub GetUserData()
		Dim SQL
		SQL = "Select * From pkmUsers Where UID = '" & uid & "'"
		rs.Open SQL
		f_name = rs.fields(1).value
		l_name = rs.fields(2).value
		email = rs.fields(3).value
		rs.Close		
	End Sub
	Private Sub GetPickData(week,yr)
		Dim SQL, rsGames, Games(20), i
		SQL = "Select Game, Pick, Value From pkmPicks Where UID = '" & uid & "' AND Week = '" & week & "' AND Year = '" & yr & "' Order By Game"
		rs.Open SQL
		If rs.RecordCount > 0 Then
			rs.MoveFirst
			For i = 0 to rs.RecordCount - 1
				picks(i) = rs.Fields("Pick").value
				values(i) = rs.Fields("Value").value
				rs.MoveNext
			Next
		Else
			SetDefaultValues
			SetDefaultPicks
		End If
			
		rs.Close

	End Sub

	Private	Sub SetDefaultPicks()
		Dim i
		picks(0) = "0"
		For i = 1 to 19
			picks(i) = ""
		Next
	End Sub
	Private Sub SetDefaultValues()
		Dim i
		For i = 0 to 9
			values(i) = 10
		Next
		For i = 10 to 19
			values(i) = 0
		Next
	End Sub

End Class 'User
%>
<%
Class cGames
	Private cn, rs, cd
	Private games(20), vis(20), visitors(20), hos(20), homes(20), favs(20), lines(20), mins(20), maxs(20), winners(20), notes(20), yr, deadlines(20)
	Public defaultDeadline
	
	Private Sub Class_Initialize()
	
		Dim CS
		'CS = "Driver={SQL Native Client}; Data Source=sldb.igtm.com;Initial Catalog=spocom;Uid=m.rhoden;Pwd=firehitsites"
		CS = "Driver={SQL Server};Server=P3NWPLSK12SQL23;Database=spocom;Uid=strawnj5;Pwd=pick3MMM5;"
		Set cn = Server.CreateObject("ADODB.Connection")
		cn.Open CS
		
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.LockType = 1
		rs.CursorType = 0
		rs.CursorLocation = 3
		rs.ActiveConnection = cn
		
		Set cd = Server.CreateObject("ADODB.Command")
		cd.ActiveConnection = cn
		cd.Commandtype = 1
	End Sub
	
	Private Sub Class_Terminate()
		Set rs.ActiveConnection = Nothing
		Set rs = Nothing
		Set cd.ActiveConnection = Nothing
		Set cd = Nothing
		cn.Close
		Set cn = Nothing
	End Sub
	
	Public Property Get Game_Count
		Game_Count = ubound(games)
	End Property

	Public Sub Initialize(wk,y)
		Dim i, SQL
		yr = y
		SQL = "Select * From pkmGames Where Week = '" & wk & "' AND Year = '" & yr & "'"
		rs.Open SQL
		if rs.recordcount > 0 then
			rs.MoveFirst
			For i = 0 to 19
				games(i) = i + 1
				vis(i) = rs.fields(2).value
				visitors(i) = rs.fields(3).value
				hos(i) = rs.fields(4).value
				homes(i) = rs.fields(5).value
				favs(i) = CInt(rs.fields(6).value)
				lines(i) = CDbl(rs.fields(7).value)
				winners(i) = CStr(rs.fields(8).value)
				maxs(i) = 30
				notes(i) = rs("Note").value
				deadlines(i)=nz(rs("dtiKickoff").value,"")
				rs.movenext
			Next
		end if
		rs.close
		'sql="select min(dtiKickOff) def from pkmGames where Week = '" & wk & "' AND Year = '" & yr & "'"
		'rs.open sql
		'if rs.recordcount > 0 then
		defaultDeadline=(new cDeadline).GetDeadlineForWeek2017(wk)
		'else
		''	defaultDeadline = ""
		'end if
		'rs.close
		For i = 0 to 9
			mins(i) = 10
		Next
		For i = 10 to 19
			mins(i) = 0
		Next
	End Sub

'	Private games(20), vis(20), visitors(20), hos(20), homes(20), favs(20), lines(20), mins(20), maxs(20)
	Public Function GetGame(ind)
		GetGame = games(ind)
	End Function
	Public Function GetVis(ind)
		GetVis = vis(ind)
	End Function
	Public Function GetVisitor(ind)
		GetVisitor = visitors(ind)
	End Function
	Public Function GetHo(ind)
		GetHo = hos(ind)
	End Function
	Public Function GetHome(ind)
		GetHome = homes(ind)
	End Function
	Public Function GetFav(ind)
		GetFav = favs(ind)
	End Function
	Public Function GetLine(ind)
		GetLine = lines(ind)
	End Function
	Public Function GetMin(ind)
		GetMin = mins(ind)
	End Function
	Public Function GetMax(ind)
		GetMax = maxs(ind)
	End Function
	Public Function GetNote(ind)
		GetNote = notes(ind)
	End Function
	Public Function GetDeadline(ind)
		GetDeadline = deadlines(ind)
	End Function
	Public Function GetWinner(ind)
		GetWinner = winners(ind)
	End Function
End Class 'Games
%>	