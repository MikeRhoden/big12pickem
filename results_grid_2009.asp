<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- #include file="cClasses2.asp" --->
<html>
<head>
<!-- #include file="funcs.asp" --->
<%
	Dim yr, week, g, u, users, bg, pick_style, val_style, i, j, cnPick, correct, correct_style, total_style,tmp,TB
	'tmp = GetGameIDFromURL
	week = request.QueryString("w")
	yr = "2009"
	
	users = GetUsers(week, yr)
	For i = 0 to ubound(users) - 1
		Set u = new cUser
		u.initialize users(i), week, yr
		u.SetWeekCredits week, yr
		Set u = nothing
	Next
	Set g = New cGames
	g.Initialize week, yr
%>
<%
	Function GetUsers(wk, yr)
		Dim rs, rv, i
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.LockType = 1
		rs.CursorType = 0
		rs.CursorLocation = 3
		Connect
		rs.ActiveConnection = cnPick
		rs.Open "Select Distinct pkmUsers.UID, Last_Name, First_Name, Week_Score_" & yr & "_" & wk & " From pkmUsers, pkmPicks Where pkmUsers.UID = pkmPicks.UID And Week = '" & wk & "' AND Year = '" & yr & "' Order By Week_Score_" & yr & "_" & wk & "  DESC, Last_Name, First_Name ASC"
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
	
<title>Grid: Week <%=week%> <%=yr%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript">
	function sg(w,g) {
		document.updategames.winner.value=w
		document.updategames.game.value=g+1
		document.updategames.submit();
	}
</script>
</head>

<body>
<form action="updategames.asp?w=<%=week%>&rg=1" method="post" name="updategames">
	<input type="hidden" name="edit" value="y" /><input type="hidden" name="winner" /><input type="hidden" name="game" />
</form>
<table border="1" cellpadding="1" cellspacing="0" align="center">
	<tr>
		<td align="center" valign="middle" class="grid_hdr">Week <%=week%></td>
<%For i = 0 to g.Game_Count	- 1%>
		<td align="left" valign="top">
			<span class="vis_grid"><%if request.QueryString("u")=1 then%><a href="javascript:sg('<%=g.getVis(i)%>',<%=i%>);" class="vis_grid"><%end if%><%=g.GetVis(i)%><%if request.QueryString("u")=1 then%></a><%end if%><br><%If g.GetFav(i) = 0 Then%>(-<%=g.GetLine(i)%>)<%End If%><br></span>
			<span class="ho_grid"><%if request.QueryString("u")=1 then%><a href="javascript:sg('<%=g.GetHo(i)%>',<%=i%>);" class="ho_grid"><%end if%><%=g.GetHo(i)%><%if request.QueryString("u")=1 then%></a><%end if%> <br><%If g.GetFav(i) = 1 Then%>(-<%=g.GetLine(i)%>)<%End If%> </span>
		</td>
<%Next%>
		<td>&nbsp;</td>
	</tr>
<%For i = 0 to UBound(users) - 1
		Set u = New cUser
		u.Initialize users(i),week,yr
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
	<%TB=0: For j = 0 to g.Game_Count	- 1%>
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
					if j<10 then TB=TB+1
				End If
			%>
			<table border="0" cellpadding="1" cellspacing="0" align="center">
				<tr><td class="<%=pick_style%>"><span class="<%=correct_style%>"><%=u.GetPick(j)%></span></td><td class="<%=val_style%>"><%=u.GetValue(j)%></td></tr>
			</table>
		<%Else%>&nbsp;<%End If%>
		</td>
	<%Next%>
		<td><%=tb%></td>
	</tr>
<%
	Set u = Nothing
Next%>	
</table>
<%	Set g = Nothing %>
</body>
</html>
