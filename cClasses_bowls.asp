<%
Class cUser
	
	Private cn, rs, cd
	Private uid, f_name, l_name, email, picks(25), values(25)
		
	Private Sub Class_Initialize()
		Dim CS
		CS = "Provider=SQLOleDB.1; Data Source=gtm-sql1;Initial Catalog=gtmspocom_db;User ID=mrhoden;Password=firehitsites"
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

	Public Sub Initialize(id, wk)
		uid = id
		GetUserData
		GetPickData wk
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
		'response.write ubound(picks)
		GetPick = Picks(ind)
	End Function
	
	Public Function GetValue(ind)
		GetValue = Values(ind)
	End Function

	Private Sub GetUserData()
		Dim SQL
		SQL = "Select * From pkmUsers Where UID = '" & uid & "'"
		rs.Open SQL
'	Private uid, f_name, l_name, email, picks(20), values(20)
		f_name = rs.fields(1).value
		l_name = rs.fields(2).value
		email = rs.fields(3).value
		rs.Close		
	End Sub
	Private Sub GetPickData(week)
		Dim SQL, rsGames, Games(25), i
		SQL = "Select Game, Pick, Value From pkmPicks Where UID = '" & uid & "' AND Week = '" & week & "' Order By Game"
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
		For i = 1 to 24
			picks(i) = ""
		Next
	End Sub
	Private Sub SetDefaultValues()
		Dim i
		For i = 0 to 24
			values(i) = 0
		Next
	End Sub

End Class 'User
%>
<%
Class cGames
	Private cn, rs, cd
	Private games(25), vis(25), visitors(25), hos(25), homes(25), favs(25), lines(25), mins(25), maxs(25), winners(25), bowls(25), dates(25)
	Private Sub Class_Initialize()
		Dim CS
		CS = "Provider=SQLOleDB.1; Data Source=gtm-sql1;Initial Catalog=gtmspocom_db;User ID=mrhoden;Password=firehitsites"
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

	Public Sub Initialize(wk)
		Dim i, SQL
		SQL = "Select * From pkmGames Where Week = '" & wk & "'"
		rs.Open SQL
		For i = 0 to rs.recordcount - 1
			games(i) = i + 1
			vis(i) = rs.fields(2).value
			visitors(i) = rs.fields(3).value
			hos(i) = rs.fields(4).value
			homes(i) = rs.fields(5).value
			favs(i) = CInt(rs.fields(6).value)
			lines(i) = CDbl(rs.fields(7).value)
			winners(i) = CStr(rs.fields(8).value)
			maxs(i) = 20
			bowls(i) = CStr(rs.fields(9).value)
			dates(i) = CStr(rs.fields(10).value)
			rs.movenext
		Next
		For i = 0 to 24
			mins(i) = 0
		Next
		rs.close
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
	Public Function GetWinner(ind)
		GetWinner = winners(ind)
	End Function
	Public Function GetBowl(ind)
		GetBowl = bowls(ind)
	End Function
	Public Function GetDate(ind)
		GetDate = CStr(dates(ind))
	End Function
End Class 'Games
%>	