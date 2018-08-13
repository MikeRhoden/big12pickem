<%@ language=vbscript%>
<!-- #include file="funcs.asp" --->
<%
	Dim uid, picks, toolate, cnPick, fName
	uid = Request.QueryString("uid")
	If Request.QueryString("toolate") = "yes" Then
		toolate = true
	End If
	Connect
	picks = GetGames(uid)
	fName = GetFirstName(uid)
	Disconnect
%>
<html>
<head>
<title>Pick Games</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">
<form name="games" method=post action="postgames.asp?uid=<%=uid%>">
<table border=0 width=100%>
	<tr><td width=33% valign=top>
		<b>Welcome, <%=fName%></b><br>
		<a href="entertext.asp?uid=<%=uid%>">Send email message to <i>Pickem</i> group</a><br>
		<a href="index.htm">*<i>Pickem</i> Home*</a>
	</td>
	<td align=center width=33%><b><font size=+1 color=blue>Week 2 Games</font></b></td>
	<td>&nbsp;</td></tr>
</table>
<hr><center><font color=red><b>Once you submit your picks you can come back here<br>
& edit your picks until Friday @ NOON</b></font></center>  
<hr>
<%
	If picks(0) <> "0" Then
%>
	<center>
<%		If toolate then %>
IT'S TOO LATE TO MAKE PICKS
<%		ELSE %>
<b>YOUR PICKS HAVE BEEN SUBMITTED</b> 
<%		End If %>
</center><hr>
<%
	End If
%>
<center><b><u>Tie Breaker</u></b><br>Total Points of UCLA/CU Game
<input type=text name="13" <%if picks(0) <> "0" then%>value=<%=picks(12)%><%else%>value=0<%end if%> size=5>
<br><font size=-1>(used for weekly results)</font></center>
<table border=0 cellpadding=3 cellspacing=0 align=center width=480>
   <tr><td align=right valign=top><table border=1 cellpadding=3 cellspacing=0 align=right>
	<tr>
		<th align=center>Game</th>
		<th>Matchup & Spread</th>
	</tr>
	<tr>
		<td align=center>1</td>
		<td>
			<input type=radio name="1" value="NCSU"<%If picks(0) = "NCSU" Then%> checked<%End If%>>NC St.  <font size=-1 color=blue>(-7.5)</font><br>
			<input type=radio name="1" value="WAKE"<%If picks(0) = "WAKE" Then%> checked<%End If%>><b>Wake Forest</b>
		</td>
	</tr>
	<tr>
		<td align=center>2</td>
		<td>
			<input type=radio name="2" value="WSU"<%If picks(1) = "WSU" Then%> checked<%End If%>>Washington St.<br>
			<input type=radio name="2" value="UND"<%If picks(1) = "UND" Then%> checked<%End If%>><b>Notre Dame</b> <font size=-1 color=blue>(-6)</font>
		</td>
	</tr>
	<tr>
		<td align=center>3</td>
		<td>
			<input type=radio name="3" value="AUB"<%If picks(2) = "AUB" Then%> checked<%End If%>>Auburn <font size=-1 color=blue>(-8.5)</font><br>
			<input type=radio name="3" value="GATECH"<%If picks(2) = "GATECH" Then%> checked<%End If%>><b>Ga. Tech</b>
		</td>
	</tr>
	<tr>
		<td align=center>4</td>
		<td>
			<input type=radio name="4" value="BYU"<%If picks(3) = "BYU" Then%> checked<%End If%>>BYU<br>
			<input type=radio name="4" value="SOCAL"<%If picks(3) = "SOCAL" Then%> checked<%End If%>><b>Southern Cal</b><font size=-1 color=blue> (-22)</font>
		</td>
	</tr>
	<tr>
		<td align=center>5</td>
		<td>
			<input type=radio name="5" value="MARSH"<%If picks(4) = "MARSH" Then%> checked<%End If%>>Marshall<br>
			<input type=radio name="5" value="TENN"<%If picks(4) = "TENN" Then%> checked<%End If%>><b>Tennessee</b> <font size=-1 color=blue>(-19.5)</font>
		</td>
	</tr>
	<tr>
		<td align=center>6</td>
		<td>
			<input type=radio name="6" value="BC"<%If picks(5) = "BC" Then%> checked<%End If%>>Boston College<br>
			<input type=radio name="6" value="PSU"<%If picks(5) = "PSU" Then%> checked<%End If%>><b>Penn St.</b> <font size=-1 color=blue>(-10)</font>
		</td>
	</tr></table></td>
	<td width=10%>&nbsp;</td>
	<td align=left valign=top><table border=1 cellpadding=3 cellspacing=0>
	<tr>
		<th align=center>Game</th>
		<th>Matchup & Spread</th>
	</tr>
	<tr>
		<td align=center>7</td>
		<td>
			<input type=radio name="7" value="UCLA"<%If picks(6) = "UCLA" Then%> checked<%End If%>>UCLA<br>
			<input type=radio name="7" value="CU"<%If picks(6) = "CU" Then%> checked<%End If%>><b>Colorado</b>  <font size=-1 color=blue>(-2.5)</font>
		</td>
	</tr>
	<tr>
		<td align=center>8</td>
		<td>
			<input type=radio name="8" value="CSU"<%If picks(7) = "CSU" Then%> checked<%End If%>>Colorado St.<br>
			<input type=radio name="8" value="CAL"<%If picks(7) = "CAL" Then%> checked<%End If%>><b>California</b> <font size=-1 color=blue>(-2.5)</font>
		</td>
	</tr>
	<tr>
		<td align=center>9</td>
		<td>
			<input type=radio name="9" value="OU"<%If picks(8) = "OU" Then%> checked<%End If%>>Oklahoma <font size=-1 color=blue>(-7.5)</font><br>
			<input type=radio name="9" value="BAMA"<%If picks(8) = "BAMA" Then%> checked<%End If%>><b>Alabama</b>
		</td>
	</tr>
	<tr>
		<td align=center>10</td>
		<td>
			<input type=radio name="10" value="FLA"<%If picks(9) = "FLA" Then%> checked<%End If%>>Florida<br>
			<input type=radio name="10" value="MIAMI"<%If picks(9) = "MIAMI" Then%> checked<%End If%>><b>Miami</b>  <font size=-1 color=blue>(-14.5)</font>
		</td>
	</tr>
	<tr>
		<td align=center>11</td>
		<td>
			<input type=radio name="11" value="UVA"<%If picks(10) = "UVA" Then%> checked<%End If%>>Virginia <font size=-1 color=blue>(-3)</font><br>
			<input type=radio name="11" value="USC"<%If picks(10) = "USC" Then%> checked<%End If%>><b>South Carolina</b>
		</td>
	</tr>
	<tr>
		<td align=center>12</td>
		<td>
			<input type=radio name="12" value="MIZZOU"<%If picks(11) = "MU" Then%> checked<%End If%>>Missouri<br>
			<input type=radio name="12" value="BSU"<%If picks(11) = "BSU" Then%> checked<%End If%>><b>California</b> <font size=-1 color=blue>(-3.5)</font>
		</td>
	</tr></table></td>
	</tr>
	<tr>
		<td colspan=3 align=center>
<%
	If Not toolate Then
%>
			Click Button to <input type=submit value="<%If Picks(0)="0" Then%>Make<%Else%>Change<%End If%> Picks">
<%
	Else
%>
	<b><font size=+1>Sorry<br>It is too late to make picks.</font></b>
<%
	End If
%>
	<br>
	<font size=-1>* Home team in bold.</font>

	<br>Betting Lines found Monday night at <a href="http://www.linesandodds.com/cfb-lines.php3">Bobby Babowski's Site</a>.<br>
	
		</td>
	</tr>
</table>
</form>
</body>
</html>
