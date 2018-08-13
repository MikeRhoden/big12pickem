<%@ language=vbscript%>
<!-- #include file="cClasses.asp" --->
<html>
<head>
<!-- #include file="funcs.asp" --->
<%
	Dim u, g, uid, toolate, cnPick,  i, remaining, max_credits, week, yr
	Dim games(20), vis(20), visitors(20), hos(20), homes(20), favs(20), lines(20), mins(20), maxs(20)
	Set u = new cUser
	week = 13
	yr = 2006
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

<%
	Sub CalcRemaining()
		Dim running, i
		running = 0
		For i = 0 to 19
			running = running + CInt(u.GetValue(i))
		Next
		Remaining = max_credits - running
	End Sub
'	Dim picks, values, games(20), vis(20), visitors(20), hos(20), homes(20), favs(20), lines(20), mins(20), maxs(20)
	
	Function WriteGame(no, vis, visitor, ho, home, fav, line, min, max)
		dim rv
		rv = "<td align='center' valign='middle' class='game_no'>" & no & "</td>" & chr(13) & _
				"<td align='left' valign='top'><input type='radio' name='game_" & no & "' value='" & vis & "'"
		If u.GetPick(no-1) = vis Then
			rv = rv & " checked>"
		Else
			rv = rv & ">"
		End If
		rv = rv & "<span class='visitor'>" & visitor & "</span>"
		If fav = 0 Then
			rv = rv & " <span class='line'>(-" & line & ")</span>"
		End If
		rv = rv & "<BR><input type='radio' name='game_" & no & "' value='" & ho & "'"
		If u.GetPick(no-1) = ho Then
			rv = rv & " checked>"
		Else
			rv = rv & ">"
		End If
		If no = 1 or no = 2 or no = 6 or no=7 or no=9 then
			rv = rv & "<span class='visitor'>" & home & "</span>"
		else
			rv = rv & "<span class='home'>" & home & "</span>"
		end if
		If fav = 1 Then
			If line = 0 then
				rv = rv & " <span class='line'><font color='red'>(No Line Yet)</font></span>"
			Else
				rv = rv & " <span class='line'>(-" & line & ")</span>"
			End If
		End If
		If no = 1 then
			rv = rv & "<br><font size=-2 color=red>(Big 12 in KC)</font>"
		ElseIf no = 2 then
			rv = rv & "<br><font size=-2 color=red>(SEC in ATL)</font>"
		ElseIf no = 6 then
			rv = rv & "<br><font size=-2 color=red>(in Philly)</font>"
		ElseIf no= 7 then
			rv = rv & "<br><font size=-2 color=red>(ACC in Jacksonville)</font>"
		ElseIf no = 9 then
			rv = rv & "<br><font size=-2 color=red>(Conf USA in Houston)</font>"
		End If
		
		rv = rv & "</td>" & chr(13) & "<td align='center' valign='middle'>" & WriteValue(no,min,max) & _
			"<br><img src='../gtm/images/spacer.gif' width='1' height='3'><br><a href='javascript:clearGame(" & no & ");' class='clear'>clear</a></td></tr>" & chr(13)
		WriteGame = rv		
	End Function
	Function WriteValue(no,min,max)
		Dim rv, i
		rv = "<select name='val_" & no & "' onChange='calcCredits()'>" & chr(13)
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
	</td>
	<td align=center width=33% class="week">Week <%=week%> Games</td>
	<td align="left"><span class="warning">Once you submit your picks you can come back here & edit your picks until Friday @ 6PM </span></td>
	</tr>
</table>
	

<table border=0 cellpadding=3 cellspacing=0 align=center width=480>
<% IF toolate Then %>
<tr><td colspan="7"><span class="warning"><hr noshade><center>IT'S TOO LATE TO MAKE PICKS</center></span></td></tr>
<% End If %>
<tr><td colspan="7" class="warning"><hr noshade>SCROLL RIGHT &gt;&gt;</td></tr>
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
		<%= WriteGame(g.GetGame(i), g.GetVis(i), g.GetVisitor(i), g.GetHo(i), g.GetHome(i), g.GetFav(i), g.GetLine(i), g.GetMin(i), g.GetMax(i)) %>
<% Next %>
	</table></td>
	<td bgcolor="#ffffff"><img src="../gtm/images/spacer.gif" width="20"></td>
	<td align=left valign=top><table border=1 cellpadding=3 cellspacing=0>
	<tr>
		<th align=center>&nbsp;</th>
		<th>Matchup & Spread&nbsp;&nbsp;</th>
		<th align=center>Wager</th>
	</tr>
<% For i = 5 to 9
''	Dim picks, values, games(20), vis(20), visitors(20), hos(20), homes(20), favs(20), lines(20), mins(20), maxs(20)
 %>
		<%= WriteGame(g.GetGame(i), g.GetVis(i), g.GetVisitor(i), g.GetHo(i), g.GetHome(i), g.GetFav(i), g.GetLine(i), g.GetMin(i), g.GetMax(i)) %>
<% Next %>
	</table></td>
	<td bgcolor="#ffffff"><img src="../gtm/images/spacer.gif" width="20"></td>
	<td align=right valign=top><table border=1 cellpadding=3 cellspacing=0 align=right>
	<tr>
		<th align=center>&nbsp;</th>
		<th>Matchup & Spread&nbsp;&nbsp;</th>
		<th align=center>Wager</th>
	</tr>
<% For i = 10 to 14
''	Dim picks, values, games(20), vis(20), visitors(20), hos(20), homes(20), favs(20), lines(20), mins(20), maxs(20)
 %>
		<%= WriteGame(g.GetGame(i), g.GetVis(i), g.GetVisitor(i), g.GetHo(i), g.GetHome(i), g.GetFav(i), g.GetLine(i), g.GetMin(i), g.GetMax(i)) %>
<% Next %>
	</table></td>
	<td bgcolor="#ffffff"><img src="../gtm/images/spacer.gif" width="20"></td>
	<td align=left valign=top><table border=1 cellpadding=3 cellspacing=0>
	<tr>
		<th align=center>&nbsp;</th>
		<th>Matchup & Spread&nbsp;&nbsp;</th>
		<th align=center>Wager</th>
	</tr>
<% For i = 15 to 19
''	Dim picks, values, games(20), vis(20), visitors(20), hos(20), homes(20), favs(20), lines(20), mins(20), maxs(20)
 %>
		<%= WriteGame(g.GetGame(i), g.GetVis(i), g.GetVisitor(i), g.GetHo(i), g.GetHome(i), g.GetFav(i), g.GetLine(i), g.GetMin(i), g.GetMax(i)) %>
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
<table align="center" border="0" cellpadding="3" cellspacing="0">
	<tr>
	  <td colspan="2" align="center">
		<span class="warning">Please make your payments before the games begin on Saturday.</span><br>
		Every transaction contains a .45 fee so I am now just asking for a $5.50 payment from everybody for each week.
	</td></tr>
	<tr>
	  <td align="center" width="50%" valign="middle" colspan="2"><form action="https://www.paypal.com/cgi-bin/webscr" method="post">
	    <p>
	      <input type="hidden" name="cmd" value="_s-xclick">
  <input type="image" src="https://www.paypal.com/en_US/i/btn/x-click-butcc-donate.gif" border="0" name="submit" alt="Make payments with PayPal - it's fast, free and secure!">
  <input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----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-----END PKCS7-----
">
  <br>
  <strong><u>CREDIT CARD PAYMENT
  ($5.50)</u></strong><br>
</p>
          </form>
</td>
<!--<td align="center" width="50%" valign="middle"><form action="https://www.paypal.com/cgi-bin/webscr" method="post">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="image" src="https://www.paypal.com/en_US/i/btn/x-click-but04.gif" border="0" name="submit" alt="Make payments with PayPal - it's fast, free and secure!">
<input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----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-----END PKCS7-----
">
<br>
<strong><u>CASH PAYMENT ($5.00)</u><br>
</strong>Click the image above if you do have a paypal account<br>
and want to transfer $5 out of it.
	  </form>
</td> -->
	</tr>
</table>
</body>
</html>
<%
	Set u = Nothing
%>