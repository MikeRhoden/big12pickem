<%
Class cUser
	
	Private cn, rs, cd
	Private uid, f_name, l_name, email, picks(), values(), correct_picks(), weekly_credits, total_games
		
	Private Sub Class_Initialize()
		Dim CS
		CS = "Driver={SQL Native Client}; Data Source=sldb.igtm.com;Initial Catalog=spocom;Uid=m.rhoden;Pwd=firehitsites"
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
		weekly_credits = 1000
		GetUserData
		
		CalcCorrectPicks wk, y
	End Sub
	
	Public Property Get Week_Credits
		Week_Credits = weekly_credits
	End Property

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
	
	Public Function GetCorrectPick(ind)
		GetCorrectPick = correct_picks(ind)
	End Function
	
	Private Sub CalcCorrectPicks(week,y)
		Dim g, i, winner
		Set g = New cGames
		g.Initialize week,y
		total_games = g.Game_Count
		redim picks(total_games)
		redim correct_picks(total_games)
		redim values(total_games)
		GetPickData week, y
		For i = 0 to total_games - 1
			winner = g.GetWinner(i)
			if winner <> "0" then
				if winner = picks(i) then
					weekly_credits = weekly_credits + values(i)
					correct_picks(i) = 1
				else
					weekly_credits = weekly_credits - values(i)
					correct_picks(i) = -1
				end if
			else
				correct_picks(i) = 0
			end if
		Next
		Set g = Nothing
	End Sub

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
	Private Sub GetPickData(week,y)
		Dim SQL, rsGames, i
		SetDefaultValues
		SetDefaultPicks
		for i = 1 to total_games
		SQL = "Select Game, Pick, Value From pkmPicks Where UID = '" & uid & "' AND Week = '" & week & "' AND Year = '" & y & "' AND Game = " & i & " Order By Game"
		rs.Open SQL
		If not rs.eof Then
			picks(i-1) = rs.Fields("Pick").value
			values(i-1) = CInt(rs.Fields("Value").value)
		End If
		rs.Close
		next

	End Sub

	Private	Sub SetDefaultPicks()
		Dim i
		For i = 0 to total_games-1
			picks(i) = ""
		Next
	End Sub
	Private Sub SetDefaultValues()
		Dim i
		For i = 0 to total_games-1
			values(i) = 0
		Next
	End Sub
	Public Sub SetWeekCredits(wk,y)
	    if cint(y)>=2012 then
		    cd.CommandText = "Update dbo.pkmScores Set Score = " & weekly_credits & " Where UID = '" & uid & "' and Year = '" & y & "' AND Week = " & wk
	    else
		    cd.CommandText = "Update pkmUsers Set Week_Score_" & y & "_" & wk & " = " & weekly_credits & " Where UID = '" & uid & "'"
		end if
		cd.Execute
	End Sub
End Class 'User
%>
<%
Class cGames
	Private cn, rs, cd
	Private games, vis, visitors, hos, homes, favs, lines, mins, maxs, winners, week, yr
	public bowls
	Private max_bet, min_mandatory_bet
	Private Sub Class_Initialize()
		Dim CS
		CS = "Driver={SQL Native Client}; Data Source=sldb.igtm.com;Initial Catalog=spocom;Uid=m.rhoden;Pwd=firehitsites"
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
		week = wk
		yr = y
		total_games = GetTotalGames(wk)
		max_bet = 20
		min_mandatory_bet = 0
		Redim games(total_games)		
		Redim vis(total_games)		
		Redim visitors(total_games)		
		Redim hos(total_games)		
		Redim homes(total_games)		
		Redim favs(total_games)		
		Redim lines(total_games)		
		Redim mins(total_games)		
		Redim maxs(total_games)		
		Redim winners(total_games)		
		Redim bowls(total_games)

		Dim i, SQL
		SQL = "Select * From pkmGames Where Week = '" & wk & "' AND Year = '" & yr & "'"
		rs.Open SQL
		rs.MoveFirst
		For i = 0 to total_games - 1
			games(i) = i + 1
			vis(i) = rs.fields(2).value
			visitors(i) = rs.fields(3).value
			hos(i) = rs.fields(4).value
			homes(i) = rs.fields(5).value
			favs(i) = CInt(rs.fields(6).value)
			lines(i) = CDbl(rs.fields(7).value)
			winners(i) = CStr(rs.fields(8).value)
			maxs(i) = max_bet
			bowls(i)=rs("bowl").value
			rs.movenext
		Next
		For i = 0 to total_games-1
			mins(i) = 0
		Next
		rs.close
	End Sub
	
	Public Property Get Games_Count
		Games_Count = total_games
	End Property
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
	Private Function GetTotalGames(wk)
		rs.Open "Select Count(*) From pkmGames Where Week = " & wk & " AND Year = '" & yr & "'"
		if rs.recordcount > 0 Then
			GetTotalGames = CInt(rs.fields(0).value)
		else
			GetTotalGames = 0
		end if
		rs.close
	End Function
	Public Function Get_Pick_Count(tm,gm)
		dim team
		if tm = 0 then
			team = vis(gm-1)
		else
			team = hos(gm-1)
		end if
		rs.open "Select Count(*) From pkmPicks Where Pick = '" & team & "' AND Game = " & gm & " AND Week = " & week & " AND Year = '" & yr & "'"
		if rs.recordcount > 0 then
			Get_Pick_Count = rs.fields(0).value
		else
			Get_Pick_Count = 0
		end if
		rs.close
	End Function
End Class 'Games
%>	