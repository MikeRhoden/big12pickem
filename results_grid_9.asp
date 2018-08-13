<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- #include file="cClasses2.asp" --->
<html>
<head>
<!-- #include file="funcs.asp" --->
<%
	Dim week, g, u, users, bg, pick_style, val_style, i, j, cnPick, correct, correct_style, total_style
	week = 9 'Request.Form("week")
	users = GetUsers(week)
	For i = 0 to ubound(users) - 1
		Set u = new cUser
		u.initialize users(i), week
		u.SetWeekCredits week
		Set u = nothing
	Next
	users = GetUsers(week)
	Set g = New cGames
	g.Initialize week
%>
<%
	Function GetUsers(wk)
		Dim rs, rv, i
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.LockType = 1
		rs.CursorType = 0
		rs.CursorLocation = 3
		Connect
		rs.ActiveConnection = cnPick
		rs.Open "Select Distinct pkmUsers.UID, Last_Name, First_Name, Week_Score_" & wk & " From pkmUsers, pkmPicks Where pkmUsers.UID = pkmPicks.UID And Week = '" & wk & "' Order By Week_Score_" & wk & " DESC, Last_Name, First_Name ASC"
		redim rv(rs.recordcount)
		for i = 0 to rs.recordcount - 1
			rv(i) = rs.fields(0).value
			rs.movenext
		next
		rs.close
		Disconnect
		GetUsers = rv
	End Function
%>	
	
<title>Grid: Week <%=week%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<table border="1" cellpadding="1" cellspacing="0" align="center">
	<tr>
		<td align="center" valign="middle" class="grid_hdr">Week <%=week%></td>
<%For i = 0 to g.Game_Count	- 1%>
		<td align="left" valign="top">
			<span class="vis_grid"><%=g.GetVis(i)%>[<%=g.Get_Pick_Count(0,(i+1))%>]<br><%If g.GetFav(i) = 0 Then%>(-<%=g.GetLine(i)%>)<%End If%><br></span>
			<span class="ho_grid"><%=g.GetHo(i)%>[<%=g.Get_Pick_Count(1,(i+1))%>]<br><%If g.GetFav(i) = 1 Then%>(-<%=g.GetLine(i)%>)<%End If%></span>
		</td>
<%Next%>
	</tr>
<%For i = 0 to UBound(users) - 1
		Set u = New cUser
		u.Initialize users(i),week
		If i mod 2 = 0 then
			bg = "#cccccc"
		Else
			bg = "#ffffff"
		End If
		If u.Week_Credits > 200 Then
			total_style = "value_total_pos"
		ElseIf u.Week_Credits < 200 Then
			total_style = "value_total_neg"
		Else
			total_style = "value_total_evn"
		End If
		
		%>
	<tr bgcolor="<%=bg%>"><td align="left" class="name_grid"><table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td align="left"><%=u.Last_Name%>, <%=u.First_Name%></td>
		<td align="center" class="<%=total_style%>"><%= u.Week_Credits %></td>
		</tr></table>
		 
	</td>
	<%For j = 0 to g.Game_Count	- 1%>
		<td align="center" valign="middle">
		<%If u.GetPick(j) <> "" Then
				If u.GetPick(j) = g.GetVis(j) Then
					pick_style = "vis_grid"
					val_style = "value_vis"
				ElseIf u.GetPick(j) = g.GetHo(j) Then
					pick_style = "ho_grid"
					val_style = "value_ho"
				End If
				correct = u.GetCorrectPick(j)
				If correct = - 1 Then
					correct_style = "incorrect"
				ElseIf correct = 0 Then
					correct_style = ""
				ElseIf correct = 1 Then
					correct_style = "correct"
				End If
			%>
			<table border="0" cellpadding="1" cellspacing="0" align="center">
				<tr><td class="<%=pick_style%>"><span class="<%=correct_style%>"><%=u.GetPick(j)%></span></td><td class="<%=val_style%>"><%=u.GetValue(j)%></td></tr>
			</table>
		<%Else%>&nbsp;<%End If%>
		</td>
	<%Next%>
	</tr>
<%
	Set u = Nothing
Next%>	
</table>
<%	Set g = Nothing %>
</body>
</html>
