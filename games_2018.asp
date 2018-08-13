<%@ language=vbscript%>
<!-- #include file="cClasses.asp" -->
<html>
<head>
<!-- #include file="funcs.asp" -->
<%
Dim u, g, uid, toolate, cnPick,  i, remaining, max_credits, week, yr
Dim games(20), vis(20), visitors(20), hos(20), homes(20), favs(20), lines(20), mins(20), maxs(20)

Sub CalcRemaining()
	Dim running, i
	running = 0
	For i = 0 to 19
		running = running + CInt(u.GetValue(i))
	Next
	Remaining = max_credits - running
End Sub

Function WriteGame(no, vis, visitor, ho, home, fav, line, min, max, note, deadline)
	dim rv,passed,disabled,readonly,isDefaultDeadline,rowspan,deadLineText
	isDefaultDeadline=(deadline>=g.defaultDeadline)
	if isDefaultDeadline then
		rowspan=1
		deadLineText=""
	else
		rowspan=2
		deadLineText="pick by: "& DateAdd("h", 2, deadline)
	end if
	passed=now()>deadline
	disabled=""
	readonly=""
	if passed then
		disabled="disabled"
		readonly="readonly"
	end if
	rv="<tr>"
	rv = rv &"<td align='center' valign='middle' class='game_no' rowspan='"&rowspan&"'>" & no & "</td>" & chr(13) & _
			"<td align='left' valign='top'><input "&disabled&" "&readonly&" type='radio' name='game_" & no & "' value='" & vis & "'"
	If (u.GetPick(no-1) <> ho and no<=10) or u.GetPick(no-1) = vis Then
		rv = rv & " checked>"
	Else
		rv = rv & ">"
	End If
	rv = rv & "<span class='visitor'>" & visitor & "</span>"
	If fav = 0 Then
		if line=0 then
			rv = rv & " <span class='line'>(pickem)</span>"
		else
			rv = rv & " <span class='line'>(-" & line & ")</span>"
		end if
	End If
	rv = rv & "<BR><input "&disabled&" "&readonly&" type='radio' name='game_" & no & "' value='" & ho & "'"
	If u.GetPick(no-1) = ho Then
		rv = rv & " checked>"
	Else
		rv = rv & ">"
	End If
	rv = rv & "<span class='home'>" & home & "</span>"
	If fav = 1 Then
		If line = 0 then
			rv = rv & " <span class='line'>(pickem)</span>"
		Else
			rv = rv & " <span class='line'>(-" & line & ")</span>"
		End If
	End If
	'If note <> null then
		rv = rv & "<br><font size=-2 color=red>" & note & "</font>"
	'End If
	'If no = 2 then
	'	rv = rv & "&nbsp;<font size=-2 color=red>(in DAL)</font>"
	'End If
	
	rv = rv & "</td>" & chr(13) & "<td align='center' valign='middle'>" & WriteValue(no,min,max,disabled,readonly) & _
		"<br><img src='http://www.clker.com/cliparts/7/f/4/5/1368296348666168335american-football-ball-icon-hi.png' width='1' height='3'><br><a href='javascript:clearGame(" & no & ");' class='clear'>clear</a></td></tr>" & chr(13)
	rv = rv&"</tr>"
	if not isDefaultDeadline then
		rv=rv&"<tr><td colspan='2' class='visitor' style='background-color:#cccccc; font-weight:bold'"
		if passed then rv=rv&" style='color:red;'&"
		rv = rv&">"&deadLineText&"</td></tr>" '<input type='hidden' name='dl_"&no&"' value='"&deadline&"'>
	end if
	WriteGame = rv
End Function

Function WriteValue(no,min,max,disabled,readonly)
	Dim rv, i
	rv = "<select "&disabled&" "&readonly&" name='val_" & no & "' onChange='calcCredits()'>" & chr(13)
	For i = min to max
		rv = rv & "<option value=" & i
		If CInt(u.GetValue(no-1)) = i Then
			rv = rv & " selected>"
		Else
			rv = rv & ">"
		End If
		rv = rv & i & "</option>"
	Next
	rv = rv & "</select>"
	WriteValue = rv
End Function

connect
Set u = new cUser
yr = 2018
week = qryMaxWeek(yr)
if week=0 then
	%>error ... week 0<%response.End()
end if
u.Initialize Request.QueryString("uid"),week, yr
max_credits = 200
uid = Request.QueryString("uid")
If Request.QueryString("toolate") = "yes" Then
	toolate = true
End If
Set g = new cGames
g.Initialize week, yr
CalcRemaining
%>
<script language="javascript">
	var max_credits = 200;
	function calcCredits() {
		var wagered = 0;
		for (var i=1;i<=20;i++)
			wagered += Number(document.games["val_" + i].value);
		var remaining = max_credits - wagered;
		document.games.credits.value = remaining;
	}
	function verify(frm) {
		for (var i=1; i<=10; i++)  {
			if (!(frm["game_"+i][0].checked || frm["game_"+i][1].checked)) {
				alert("Please make a selection for game " + i + ".");
				return false;
			}
		}
		for (var i=11; i<=20; i++)  {
			if ((frm["game_"+i][0].checked || frm["game_"+i][1].checked) && (frm["val_" + i].value == 0)) {
				alert("Please make a wager for game " + i + ".");
				return false;
			}
		}
		for (var i=11; i<=20; i++)  {
			if (!(frm["game_"+i][0].checked || frm["game_"+i][1].checked) && (frm["val_" + i].value != 0)) {
				alert("Please make a selection for game " + i + ".");
				return false;
			}
		}
		if (Number(frm.credits.value < 0)) {
			alert("You have wagered more than " + max_credits + ".  Adjust your wagers");
			frm["val_1"].focus();
			return false;
		} else if (Number(frm.credits.value > 0)) {
			alert("You still have " + frm.credits.value + " credits remaining.  Your picks will still be saved.");
			//frm["val_1"].focus();
			//return false;
		} else if (Number(frm.credits.value > 0)) 
		
		return true;
	}
	function clearGame(num) {
		if (num > 10)
			document.games["val_" + num].value = 0;
		else
			document.games["val_" + num].value = 10;
		document.games["game_" + num][0].checked = false;
		document.games["game_" + num][1].checked = false;
		calcCredits();
	}
</script>
<title>Pick Games</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF">
<%
	'Response.Write "Contest will start with games on the weekend of Sept. 11<P><a href='home.asp'>HOME</a>"
	'Response.End
%>
<form name="games" method=post action="postgames_2005.asp?uid=<%=uid%>" onSubmit="return verify(this)">
<input type="hidden" name="week" value="<%=week%>">
<table border=0 width=100%>
	<tr><td width=33% valign=top>
		<b>Welcome, <%=u.First_Name%></b><br>
		<a href="entertext.asp?uid=<%=uid%>">Send email message to <i>Pickem</i> group</a><br>
		<a href="index.htm">*<i>Pickem</i> Home*</a>
		<%if uid="00027" or uid="00060" or uid="00077" then%><br>
		<a href="updategames.asp?w=<%=week%>&uid=<%=uid%>">UPDATE GAMES</a><br>
		ENTER GAMES FOR WEEK: <%for i=1 to week+1%><a href="entergames.asp?w=<%=i%>&uid=<%=uid%>"><%=i%></a>&nbsp;<%next%>
		<%end if%>
	</td>
	<td align=center width=33% class="week">Week <%=week%> Games</td>
	<td align="left"></td>
	</tr>
</table>
	

<table border=0 cellpadding=3 cellspacing=0 align=center width=480>
<% IF toolate Then %>
<tr><td colspan="7"><span class="warning"><hr noshade><center>IT'S TOO LATE TO MAKE PICKS</center></span></td></tr>
<% End If %>
<tr><td colspan="7" class="warning" align="center"><hr noshade>The deadline to get your picks in is <%=DateAdd("h", 2, g.defaultDeadline)%>.&nbsp;&nbsp;&nbsp;Individual games may have earlier deadlines.</td></tr>
	<tr><td colspan="3" align="center" class="manopt">Mandatory Games</td>
	<td bgcolor="#ffffff">&nbsp;</td><td colspan="3" align="center" class="manopt">Optional Games</td>
	</tr>
  <tr><td align=right valign=top><table border=1 cellpadding=3 cellspacing=0 align=right>
	<tr>
		<th align=center>&nbsp;</th>
		<th>Matchup & Spread&nbsp;&nbsp;</th>
		<th align=center>Wager</th>
	</tr>
<% For i = 0 to 4
''	Dim picks, values, games(20), vis(20), visitors(20), hos(20), homes(20), favs(20), lines(20), mins(20), maxs(20)
 %>
		<%'= WriteGame(games(i), vis(i), visitors(i), hos(i), homes(i), favs(i), lines(i), mins(i), maxs(i)) %>
		<%= WriteGame(g.GetGame(i), g.GetVis(i), g.GetVisitor(i), g.GetHo(i), g.GetHome(i), g.GetFav(i), g.GetLine(i), g.GetMin(i), g.GetMax(i), g.GetNote(i), g.getDeadline(i)) %>
<% Next %>
	</table></td>
	<td bgcolor="#ffffff"><img src="http://www.clker.com/cliparts/7/f/4/5/1368296348666168335american-football-ball-icon-hi.png" width="20"></td>
	<td align=left valign=top><table border=1 cellpadding=3 cellspacing=0>
	<tr>
		<th align=center>&nbsp;</th>
		<th>Matchup & Spread&nbsp;&nbsp;</th>
		<th align=center>Wager</th>
	</tr>
<% For i = 5 to 9
''	Dim picks, values, games(20), vis(20), visitors(20), hos(20), homes(20), favs(20), lines(20), mins(20), maxs(20)
 %>
		<%= WriteGame(g.GetGame(i), g.GetVis(i), g.GetVisitor(i), g.GetHo(i), g.GetHome(i), g.GetFav(i), g.GetLine(i), g.GetMin(i), g.GetMax(i), g.GetNote(i), g.getDeadline(i)) %>
<% Next %>
	</table></td>
	<td bgcolor="#ffffff"><img src="http://www.clker.com/cliparts/7/f/4/5/1368296348666168335american-football-ball-icon-hi.png" width="20"></td>
	<td align=right valign=top><table border=1 cellpadding=3 cellspacing=0 align=right>
	<tr>
		<th align=center>&nbsp;</th>
		<th>Matchup & Spread&nbsp;&nbsp;</th>
		<th align=center>Wager</th>
	</tr>
<% For i = 10 to 14
''	Dim picks, values, games(20), vis(20), visitors(20), hos(20), homes(20), favs(20), lines(20), mins(20), maxs(20)
 %>
		<%= WriteGame(g.GetGame(i), g.GetVis(i), g.GetVisitor(i), g.GetHo(i), g.GetHome(i), g.GetFav(i), g.GetLine(i), g.GetMin(i), g.GetMax(i), g.GetNote(i), g.getDeadline(i)) %>
<% Next %>
	</table></td>
	<td bgcolor="#ffffff"><img src="http://www.clker.com/cliparts/7/f/4/5/1368296348666168335american-football-ball-icon-hi.png" width="20"></td>
	<td align=left valign=top><table border=1 cellpadding=3 cellspacing=0>
	<tr>
		<th align=center>&nbsp;</th>
		<th>Matchup & Spread&nbsp;&nbsp;</th>
		<th align=center>Wager</th>
	</tr>
<% For i = 15 to 19
''	Dim picks, values, games(20), vis(20), visitors(20), hos(20), homes(20), favs(20), lines(20), mins(20), maxs(20)
 %>
		<%= WriteGame(g.GetGame(i), g.GetVis(i), g.GetVisitor(i), g.GetHo(i), g.GetHome(i), g.GetFav(i), g.GetLine(i), g.GetMin(i), g.GetMax(i), g.GetNote(i), g.getDeadline(i)) %>
<% Next %>
	</table><br><br></td>
	</tr>
	<tr><td colspan="8" align="center">
		<span class="home">You have 200 credits to wager.  At least 10 credits must be wagered on each of the first 10 games.<br>
		Allocate the remaining 100 credits however you wish.  Finish with the most credits to win.</span><br><br>
		<table border="0" cellpadding="3" cellspacing="0" align="center" class="manopt">
		<tr><td align="center">Credits Remaining:<input type="text" size="4" readonly="true" value=<%=remaining%> name="credits"></td></tr>
	  </table>
		</td></tr>
	<tr>
	  <td colspan=7 align=center><hr noshade>
<%
	If Not toolate Then
%>
			Click Button to <input type=submit value="<%If u.GetPick(0)="0" Then%>Make<%Else%>Change<%End If%> Picks">
<%
	Else
%>
	<span class="warning">Sorry<br>It is too late to make picks.</span>
<%
	End If
%>
	<br>
	<span class="home">* Home team in bold.</span>
	<!--<a href="http://www.usatoday.com/sports/gaming/odds/index.htm">Current Lines</a>-->
	<hr noshade>
	
		</td>
	</tr>
</table>
</form>
</body>
</html>
<%
	Set u = Nothing
%>