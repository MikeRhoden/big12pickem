<%
Class cUser
	
	Private cn, rs, cd
	Private uid, f_name, l_name, email, picks(), values(), numGames, uWeek, uYear
		
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
		rs.Open "Select Sum(Value) as totalWagered From dbo.pkmPicks Where UID = '" & uid & "' AND Week = " & uWeek & " AND Year = '" & uYear & "' AND Pick <> ''"
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
		f_name = rs.fields(1).value
		l_name = rs.fields(2).value
		email = rs.fields(3).value
		response.write("f_name: " & f_name)
		rs.Close		
	End Sub
	
	Private Sub GetPickData(week,y)
		Dim SQL, rsGames, Games(), i
		Redim Games(numGames)
        SetDefaultValues
        SetDefaultPicks
		for i=1 to numGames
		    SQL = "Select Game, Pick, Value From pkmPicks Where UID = '" & uid & "' AND Week = '" & week & "' AND Year = '" & y & "' AND Game = " & i & " Order By Game"
		    rs.Open SQL
		    If not rs.eof Then
			    picks(i-1) = rs.Fields("Pick").value
			    values(i-1) = rs.Fields("Value").value
		    End If
    			
		    rs.Close
		next
	End Sub
	
	Private Sub GetPickDataBackup(week,y)
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
	Public Sub SetWeekCredits(wk,yr)
		cd.CommandText = "Update pkmUsers Set Week_Score_" & yr & "_" & wk & " = " & weekly_credits & " Where UID = '" & uid & "'"
		cd.Execute
	End Sub
End Class 'User
%>
<%
Class cGames
	Private cn, rs, cd, sp
	Private games(), vis(), visitors(), hos(), homes(), favs(), lines(), mins(), maxs(), winners(), bowls(), dates(), numGames, pWeek, pYear
	public defaultDeadline
	
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
	    dim sql
		pWeek = wk
		pYear = yr
		sql="select max(dtiKickOff) def from pkmGames where Week = '" & wk & "' AND Year = '" & yr & "'"
		rs.open sql
		defaultDeadline=rs("def").value
		rs.close
	End Sub
	
	' Public Sub redimArrays(u)
		' redim games(u)
		' redim vis(u)
		' redim visitors(u)
		' redim hos(u)
		' redim homes(u)
		' redim favs(u)
		' redim lines(u)
		' redim winners(u)
		' redim maxs(u)
		' redim mins(u)
		' redim bowls(u)
		' redim dates(u)
	' End Sub
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
			
		sp.CommandText = "PKM_qry2009BowlGamesByPriority_MCR"
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
			rvObj.add "fav", NZ(rs("fav").value,0)
			rvObj.add "line", NZ(rs("line").value,0)
			rvObj.add "ko", NZ(rs("k").value,"")
			redim preserve rv(ubound(rv)+1)
			set rv(ubound(rv)-1) = rvObj
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
	'if gObj("gNumber")<>8 then
		dim bLoop
	    dim rv,passed,disabled,readonly,isDefaultDeadline,deadline,deadlineText
	    deadline = gObj("ko")
	    isDefaultDeadline=(deadline>cdate("1/9/2017 06:30:00 PM"))
	    if isDefaultDeadline then
		    rowspan=1
		    deadlineText=""&deadline
	    else
		    rs=2
		    deadlineText="pick by: "&deadline
	    end if
	    passed=now()>deadline
	    disabled=""
	    readonly=""
	    if passed then
		    disabled=" disabled=disabled "
		    readonly=" readonly=readonly "
	    end if
	%>
		<table border="0" cellpadding="3" cellspacing="0" width="100%" style="border:1px solid #000000">
			<tr>
				<td colspan='2' align='left'><span class="bowl"><%=gObj("location")%></span>
				</td>
			</tr>
			<tr>
				<td align='left' valign='top'>
					<input type="hidden" name="priority_<%=gObj("gNumber")%>" value="<%=gObj("priority")%>"  />
					<input type="hidden" name="bowlName_<%=gObj("gNumber")%>" value="<%=gObj("location")%>"  />
					<input type="hidden" name="min_<%=gObj("gNumber")%>" value="<%=gObj("minBet")%>"  />
					<input <%=disabled%> <%=readonly%> type='radio' name='game_<%=gObj("gNumber")%>' value='<%=gObj("vis")%>'<%If gObj("pick") = gObj("vis") Then%> checked<%End If%> onchange="calcCredits()" /><span class='visitor'><%=gObj("visitor")%></span>
					<%if gObj("fav")=0 then%>&nbsp;<%
						if gObj("line")=0 then%><span class='line'>(pickem)</span><%else%><span class='line'>(-<%=gObj("line")%>)</span><%end if
					end if%>

					<BR><input <%=disabled%> <%=readonly%> type='radio' name='game_<%=gObj("gNumber")%>' value='<%=gObj("ho")%>' <%If gObj("pick") = gObj("ho") Then%> checked<%End If%> onchange="calcCredits()"/><span class='visitor'><%=gObj("home")%></span>
					<%if gObj("fav")=1 then%>&nbsp;<%
						if gObj("line")=0 then%><span class='line'>(pickem)</span><%else%><span class='line'>(-<%=gObj("line")%>)</span><%end if
					end if%>
				</td>
				<td align='right' valign='middle'>
					<select <%=disabled%> <%=readonly%> name='val_<%=gObj("gNumber")%>' onChange='calcCredits()'>
					<%
					For bLoop = gObj("minBet") to gObj("maxBet")
					%>
						<option value="<%=bLoop%>" <%if gObj("value") = bLoop then%> selected="selected"<%end if%> ><%=bLoop%></option>
					<%
					Next
					%>
					</select><br />
					<%if not passed then%><a href='javascript:clearGame("<%=gObj("gNumber")%>");' class='clear'>clear</a><%end if%>
				</td>
			</tr>
        	<%if not isDefaultDeadline then%>
		    <tr><td colspan="2" class="visitor" style="background-color:#cccccc; font-weight:bold; <%if passed then%>color:red;<%end if%>"> <%=deadlineText%></td></tr><input type="hidden" name="dl_<%=gObj("gNumber")%>" value="<%=gObj("ko")%>">
		    <%else%>
			<tr><td colspan="2" class="visitor" style="background-color:#ffffff; font-weight:bold; "> <%=deadlineText%></td></tr><input type="hidden" name="dl_<%=gObj("gNumber")%>" value="<%=gObj("ko")%>">
			<%end if%>
		</table>
	<%
	'end if
	End Sub

End Class 'Games
%>	