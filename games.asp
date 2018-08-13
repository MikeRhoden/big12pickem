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
<%
	'Response.Write "Contest will start with games on the weekend of Sept. 11<P><a href='home.asp'>HOME</a>"
	'Response.End
%>
<form name="games" method=post action="postgames.asp?uid=<%=uid%>">
<table border=0 width=100%>
	<tr><td width=33% valign=top>
		<b>Welcome, <%=fName%></b><br>
		<a href="entertext.asp?uid=<%=uid%>">Send email message to <i>Pickem</i> group</a><br>
		<a href="index.htm">*<i>Pickem</i> Home*</a>
	</td>
	<td align=center width=33%><b><font size=+1 color=blue>Week 13 Games</font></b></td>
	<td>&nbsp;</td></tr>
</table>
<hr><center><font color=red><b>Once you submit your picks you can come back here<br>
& edit your picks until Friday @ 3PM </b></font>
</center>  
<hr>
	<center>
<% IF toolate Then %>
<b>IT'S TOO LATE TO MAKE PICKS</b>
<% End If %>
</center><hr>
<center><b><u>Tie Breaker</u></b><br>
Total Points of Army vs. Navy 
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
			<input type=radio name="1" value="MIOH"<%If picks(0) = "MIOH" Then%> checked<%End If%>>Miami, OH <font size=-1 color=blue>(-2)</font><br>
			<input type=radio name="1" value="TOL"<%If picks(0) = "TOL" Then%> checked<%End If%>><B>Toledo</B>
		</td>
	</tr>
	<tr>
		<td align=center>2</td>
		<td>
			<input type=radio name="2" value="VATK"<%If picks(1) = "VATK" Then%> checked<%End If%>>Virginia Tech<br>
			<input type=radio name="2" value="MIFL"<%If picks(1) = "MIFL" Then%> checked<%End If%>><b>Miami</b> <font size=-1 color=blue>(-7)</font>
		</td>
	</tr>
	<tr>
		<td align=center>3</td>
		<td>
			<input type=radio name="3" value="ARMY"<%If picks(2) = "ARMY" Then %> checked<%End If%>>Army<br>
			<input type=radio name="3" value="NAVY"<%If picks(2) = "NAVY" Then %> checked<%End If%>><b>Navy</b> <font size=-1 color=blue>(-13)</font>
		</td>
	</tr>
	<tr>
		<td align=center>4</td>
		<td>
			<input type=radio name="4" value="LOU"<% If picks(3) = "LOU" Then %> checked<%End If%>>Louisville <font size=-1 color=blue>(-28)</font><br>
			<input type=radio name="4" value="TUL"<% If picks(3) = "TUL" Then %> checked<%End If%>><b>Tulane</b>
		</td>
	</tr>
	<tr>
		<td align=center>5</td>
		<td>
			<input type=radio name="5" value="USC"<%If picks(4) = "USC" Then%> checked<%End If%>>USC <font size=-1 color=blue>(-22)</font><br>
			<input type=radio name="5" value="UCLA"<%If picks(4) = "UCLA" Then%> checked<%End If%>><b>UCLA</b>
		</td>
	</tr>
	<tr>
		<td align=center>6</td>
		<td>
			<input type=radio name="6" value="PITT"<%If picks(5) = "PITT" Then%> checked<%End If%>>Pitt <font size=-1 color=blue>(-7)</font><br>
			<input type=radio name="6" value="SFLA"<%If picks(5) = "SFLA" Then%> checked<%End If%>><b>S. Florida</b>
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
			<input type=radio name="7" value="TEN"<%If picks(6) = "TEN" Then%> checked<%End If%>>Tennessee<br>
			<input type=radio name="7" value="AUB"<%If picks(6) = "AUB" Then%> checked<%End If%>><b>Auburn</b> <font size=-1 color=blue>(-12.5)</font>
		</td>
	</tr>
	<tr>
		<td align=center>8</td>
		<td>
			<input type=radio name="8" value="CAL"<%If picks(7) = "CAL" Then%> checked<%End If%>>California <font size=-1 color=blue>(-22.5)</font><br>
			<input type=radio name="8" value="USM"<%If picks(7) = "USM" Then%> checked<%End If%>><b>S. Mississippi</b>
		</td>
	</tr>
	<tr>
		<td align=center>9</td>
		<td>
			<input type=radio name="9" value="CU"<%If picks(8) = "CU" Then%> checked<%End If%>>Colorado<br>
			<input type=radio name="9" value="OU"<%If picks(8) = "OU" Then%> checked<%End If%>><b>Oklahoma</b> <font size=-1 color=blue>(-21.5)</font>
		</td>
	</tr>
	<tr>
		<td align=center>10</td>
		<td>
			<input type=radio name="10" value="MSU"<%If picks(9) = "MSU" Then%> checked<%End If%>>Michigan St. <font size=-1 color=blue>(-6.5)</font><br>
			<input type=radio name="10" value="HAW"<%If picks(9) = "HAW" Then%> checked<%End If%>><b>Hawaii</b>
		</td>
	</tr>
	<tr>
		<td align=center>11</td>
		<td>
			<input type=radio name="11" value="NE"<%If picks(10) = "NE" Then%> checked<%End If%>>Patriots <font size=-1 color=blue>(-7.5)</font><br>
			<input type=radio name="11" value="CLE"<%If picks(10) = "CLE" Then%> checked<%End If%>><b>Browns</b>
		</td>
	</tr>
	<tr>
		<td align=center>12</td>
		<td>
			<input type=radio name="12" value="PIT"<%If picks(11) = "PIT" Then%> checked<%End If%>>Steelers <font size=-1 color=blue>(-3)</font><br>
			<input type=radio name="12" value="JAX"<%If picks(11) = "JAX" Then%> checked<%End If%>><b>Jaguars</b>
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

	<br>
	<a href="http://www.usatoday.com/sports/gaming/odds/index.htm">Current Lines</a>
	
		</td>
	</tr>
</table>
</form>
<table align="center" border="0" cellpadding="3" cellspacing="0">
	<tr><td colspan="2" align="center">
		<font color=red><b>Payments should be made on a weekly basis and received in my paypal account before the games begin on Saturday or your games won't count.</b></font><br>
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
