<%
Class cUser
	
	Private cn, rs, cd
	Private uid, f_name, l_name, email, picks(), values(), numGames, uWeek, uYear
		
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

	Public Sub Initialize(id, wk, yr)
		uid = id
		GetUserData
		uWeek = wk
		uYear = yr
		'GetPickData wk, yr
	End Sub
	
	Public Property Get Game_Count
		Game_Count = numGames
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
		'response.write ubound(picks)
		GetPick = Picks(ind)
	End Function
	
	Public Function GetValue(ind)
		GetValue = Values(ind)
	End Function

	Public Function GetWageredCredits()
		rs.Open "Select Sum(Value) as totalWagered From dbo.pkmPicks Where UID = '" & uid & "' AND Week = " & uWeek & " AND Year = '" & uYear & "'"
		if rs.recordcount > 0 then
			GetWageredCredits = NZ(rs("totalWagered").value,0)
		else
			GetWageredCredits = 0
		end if
		rs.close
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
	Private Sub GetPickData(week,y)
		Dim SQL, rsGames, Games(), i
		Redim Games(numGames)
		SQL = "Select Game, Pick, Value From pkmPicks Where UID = '" & uid & "' AND Week = '" & week & "' AND Year = '" & y & "' Order By Game"
		rs.Open SQL
		If rs.RecordCount > 0 Then
			numGames = rs.recordcount
			redim picks(numGames)
			redim values(numGames)
			rs.MoveFirst
			For i = 0 to rs.RecordCount - 1
				picks(i) = rs.Fields("Pick").value
				values(i) = rs.Fields("Value").value
				rs.MoveNext
			Next
		Else
			rs.close
			SQL = "Select * From pkmGames WHERE Week = '" & week & "' AND Year = '" & y & "'"
			rs.open sql
			numGames = rs.recordcount
			redim picks(numGames)
			redim values(numGames)
			SetDefaultValues
			SetDefaultPicks
		End If
			
		rs.Close

	End Sub

	Private	Sub SetDefaultPicks()
		Dim i
		picks(0) = "0"
		For i = 1 to numGames-1
			picks(i) = ""
		Next
	End Sub
	Private Sub SetDefaultValues()
		Dim i
		For i = 0 to numGames-1
			values(i) = 5
		Next
	End Sub
	Private Function NZ(x, y)
		if isnull(x) or isempty(x) or x = "" then
			NZ = y
		else
			NZ = x
		end if
	End Function


End Class 'User
%>
<%
Class cGames
	Private cn, rs, cd, sp
	Private games(), vis(), visitors(), hos(), homes(), favs(), lines(), mins(), maxs(), winners(), bowls(), dates(), numGames, pWeek, pYear
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

		Set sp = Server.CreateObject("ADODB.Command")
		sp.ActiveConnection = cn
		sp.CommandType = 4
		sp.CommandTimeout = 30
	End Sub
	
	Private Sub Class_Terminate()
		Set rs.ActiveConnection = Nothing
		Set rs = Nothing
		Set cd.ActiveConnection = Nothing
		Set cd = Nothing
		Set sp.ActiveConnection = Nothin
		Set sp = Nothing
		cn.Close
		Set cn = Nothing
	End Sub
	
	Public Property Get Game_Count
		Game_Count = ubound(games)
	End Property

	Public Sub Initialize(wk,yr)
		pWeek = wk
		pYear = yr
	End Sub
	
	Public Sub redimArrays(u)
		redim games(u)
		redim vis(u)
		redim visitors(u)
		redim hos(u)
		redim homes(u)
		redim favs(u)
		redim lines(u)
		redim winners(u)
		redim maxs(u)
		redim mins(u)
		redim bowls(u)
		redim dates(u)
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
	
	Public Function qryGamesByPriority(p,uid)
		dim puid, rv(), rvObj, c, rs
			
		sp.CommandText = "PKM_qryGamesByPriority_MCR"
		sp.Parameters.Refresh
		sp.Parameters("@priority") = p
		sp.Parameters("@week") = pWeek
		sp.Parameters("@year") = pYear
		sp.Parameters("@uid") = uid
		set rs = sp.execute
		c=0
		redim rv(0)
		do while not rs.eof
			set rvObj = server.CreateObject("Scripting.Dictionary")
			rvObj.add "gNumber", NZ(rs("gNumber").value,0)
			rvObj.add "vis", NZ(rs("vis").value,"")
			rvObj.add "visitor", NZ(rs("visitor").value,"")
			rvObj.add "ho", NZ(rs("ho").value,"")
			rvObj.add "home", NZ(rs("home").value,"")
			rvObj.add "bowl", NZ(rs("bowl").value,"")
			rvObj.add "gameDate", NZ(rs("gameDate").value,"")
			rvObj.add "location", NZ(rs("location").value,"")
			rvObj.add "minBet", NZ(rs("minBet").value,0)
			rvObj.add "maxBet", NZ(rs("maxBet").value,0)
			rvObj.add "pick", NZ(rs("pick").value,"")
			rvObj.add "value", NZ(rs("value").value,0)
			rvObj.add "priority", p
			redim preserve rv(c+1)
			set rv(c) = rvObj
			c=c+1
			rs.movenext
		loop
		
		qryGamesByPriority = rv
	End Function
	
	Private Function NZ(x, y)
		if isnull(x) or isempty(x) or x = "" then
			NZ = y
		else
			NZ = x
		end if
	End Function
	
	Public Sub writeGame(gObj)
		dim bLoop
	%>
		<table border="0" cellpadding="3" cellspacing="0" width="100%" style="border:1px solid #000000">
			<tr>
				<td colspan='2' align='left'><span class="bowl"><%=gObj("bowl")%> Bowl, <%=gObj("location")%> <span class='date'>(<%=gObj("gameDate")%>)</span></span>
				</td>
			</tr>
			<tr>
				<td align='left' valign='top'>
					<input type="hidden" name="priority_<%=gObj("gNumber")%>" value="<%=gObj("priority")%>"  />
					<input type="hidden" name="bowlName_<%=gObj("gNumber")%>" value="<%=gObj("bowl")%> Bowl"  />
					<input type="hidden" name="min_<%=gObj("gNumber")%>" value="<%=gObj("minBet")%>"  />
					<input type='radio' name='game_<%=gObj("gNumber")%>' value='<%=gObj("vis")%>'<%If gObj("pick") = gObj("vis") Then%> checked<%End If%> onchange="calcCredits()" /><span class='visitor'><%=gObj("visitor")%></span>
					<BR><input type='radio' name='game_<%=gObj("gNumber")%>' value='<%=gObj("ho")%>' <%If gObj("pick") = gObj("ho") Then%> checked<%End If%> onchange="calcCredits()"/><span class='visitor'><%=gObj("home")%></span>
				</td>
				<td align='right' valign='middle'>
					<select name='val_<%=gObj("gNumber")%>' onChange='calcCredits()'>
					<%
					For bLoop = gObj("minBet") to gObj("maxBet")
					%>
						<option value="<%=bLoop%>" <%if gObj("value") = bLoop then%> selected="selected"<%end if%> ><%=bLoop%></option>
					<%
					Next
					%>
					</select><br />
					<a href='javascript:clearGame("<%=gObj("gNumber")%>");' class='clear'>clear</a>
				</td>
			</tr>
		</table>
	<%
	End Sub

End Class 'Games
%>	