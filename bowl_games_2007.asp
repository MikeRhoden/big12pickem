<%@ language=vbscript%>
<!-- #include file="cClasses_bowls2007.asp" --->
<html>
<head>
<!-- #include file="funcs.asp" --->
<%
	Dim u, g, uid, toolate, cnPick,  i, remaining, max_credits, week, y, numGames
	Dim games(), vis(), visitors(), hos(), homes(), favs(), lines(), mins(), maxs(), gameSet, gObj
	Set u = new cUser
	week = 15
	y = 2007
	uid = Request.QueryString("uid")
	u.Initialize uid,week,y
	numGames = u.Game_Count
	max_credits = 700
	If Request.QueryString("toolate") = "yes" Then
		toolate = true
	End If
	Set g = new cGames
	g.Initialize week, y
	CalcRemaining
%>

<%
	Sub CalcRemaining()
		Dim running, i
		running = 0
		Remaining = max_credits - u.GetWageredCredits
	End Sub

%>
<script language="javascript">
	var max_credits = <%=max_credits%>;
	function calcCredits() {
		var wagered = 0;
		for (var i=1;i<=32;i++)
			if ((document.games["game_"+i][0].checked || document.games["game_"+i][1].checked))
				wagered += Number(document.games["val_" + i].value);
		var remaining = max_credits - wagered;
		document.games.credits.value = remaining;
		document.games.credits2.value = remaining;
	}
	function verify(frm) {
		for (var i=1; i<=32; i++)  {
			if (!(frm["game_"+i][0].checked || frm["game_"+i][1].checked) && (frm["val_" + i].value == 0) && (Number(frm["priority_"+i].value) > 1)) {
				alert("Please select a winner for  the " + frm["bowlName_" + i].value + ".");
				return false;
			}
			if ((frm["game_"+i][0].checked || frm["game_"+i][1].checked) && (frm["val_" + i].value == 0)) {
				alert("Please make a wager for the " + frm["bowlName_" + i].value + ".");
				return false;
			}
			
		}
		for (var i=1; i<=32; i++)  {
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
			alert("You still have " + frm.credits.value + " credits remaining.");
			//frm["val_1"].focus();
			//return false;
		}
		return true;
	}
	function clearGame(num) {
		document.games["val_" + num].value = document.games["min_" + num].value;
		document.games["game_" + num][0].checked = false;
		document.games["game_" + num][1].checked = false;
		calcCredits();
	}
</script>
<title>Pick Games</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
	.bowl {font-size:10px; font-weight:bold; font-family:Verdana, Arial, Helvetica, sans-serif; white-space:nowrap;}
	.date {color:#cc0000; white-space:nowrap;}
	.priority {font-family:Verdana, Arial, Helvetica, sans-serif; font-size:14px; font-weight:bold; color:#FF6666; white-space:nowrap; text-align:center}
	.manopt1 {background-color:#ffffff; color:#0099CC; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:16px; font-weight:bold;  white-space:nowrap}
	.sec {border:3px solid #cc0000; background-color:#CCCCCC}
</style>
<body bgcolor="#FFFFFF">
<%
	'Response.Write "Contest will start with games on the weekend of Sept. 11<P><a href='home.asp'>HOME</a>"
	'Response.End
%>

<form name="games" method=post action="postbowlgames_2007.asp?uid=<%=uid%>" onSubmit="return verify(this)">
<input type="hidden" name="week" value="<%=week%>">
<table border=0 width=100%>
	<tr><td width=33% valign=top>
		<b>Welcome, <%=u.First_Name%></b><br>
		<a href="entertext.asp?uid=<%=uid%>">Send email message to <i>Pickem</i> group</a><br>
		<a href="index.htm">*<i>Pickem</i> Home*</a>
	</td>
	<td align=center width=33% class="week">2007 Bowl Games </td>
	<td align="left"><span class="warning">Once you submit your picks you can come back here & edit your picks until DEC 20 @ 8PM CST </span></td>
	</tr>
</table>
	

<table border=0 cellpadding=3 cellspacing=0 align=center style="border:5px solid #CC0000">
<% IF toolate Then %>
	<tr>
		<td>
			<span class="warning"><hr noshade><center>IT'S TOO LATE TO MAKE PICKS</center></span>
		</td>
	</tr>
<% End If %>
	<tr><td align="center" valign="top">
		<table border="0" cellpadding="0" cellspacing="3">
			<tr>
				<td align="center" valign="top" class="sec">
					<table border=1 cellpadding=3 cellspacing=0 align=center bgcolor="#FFFFFF">
						<tr><td colspan="2" class="priority">BCS Bowls</td></tr>
						<tr>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (30-50)</th>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<%
								gameSet = g.qryGamesByPriority(4,uid)
								For i = 0 to ubound(gameSet) - 1
									set gObj = gameSet(i)
									g.WriteGame gObj
								Next
								%>
							</td>
						</tr>
					</table>
				</td><td ><img src="http://gtmsportswear.com/gtm/images/transparent.gif" width="16" height="1"></td>
				<td align=center valign=top class="sec">
					<table border=1 cellpadding=3 cellspacing=0 align=center bgcolor="#FFFFFF">
						<tr><td colspan="2" class="priority">Championship</td></tr>
						<tr>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (40-60)</th>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<%
								gameSet = g.qryGamesByPriority(5,uid)
								For i = 0 to ubound(gameSet) - 1
									set gObj = gameSet(i)
									g.WriteGame gObj
								Next
								%>
							</td>
						</tr>
					</table><br><br>
					<table border="0" cellpadding="3" cellspacing="0" align="center" class="manopt" bgcolor="#FFFFFF">
						<tr><td align="center" class="home">You have <%=max_credits%> credits to wager.</td></tr>
						<tr>
							<td align="center">Credits Remaining:<input type="text" size="4" readonly="true" value=<%=remaining%> name="credits2">
							</td></tr>
						
					</table>
<%
	If Not toolate Then
%>
								Click Button to <input type=submit value="Make Picks"  <% if not checktime() then %>disabled="disabled" <% end if%>>
<%
	Else
%>
								<span class="warning">Sorry<br>It is too late to make picks.</span>
<%
	End If
%>

				</td><td ><img src="http://gtmsportswear.com/gtm/images/transparent.gif" width="16" height="1"></td>
				<td align="center" valign="top" class="sec">
					<table border=1 cellpadding=3 cellspacing=0 align=center bgcolor="#FFFFFF">
						<tr><td colspan="2" class="priority">New Year's Day Bowls</td></tr>
						<tr>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (20-40)</th>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<%
								gameSet = g.qryGamesByPriority(3,uid)
								For i = 0 to ubound(gameSet) - 1
									set gObj = gameSet(i)
									g.WriteGame gObj
								Next
								%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</td></tr>
	<tr><td align="center" valign="top">
		<table border="0" cellpadding="0" cellspacing="3">
			<tr>
				<td align="center" valign="top" class="sec">
					<table border=1 cellpadding=3 cellspacing=0 align=center bgcolor="#FFFFFF">
						<tr><td colspan="4" class="priority">Decent Bowls</td></tr>
						<tr>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (10-30)</th>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (10-30)</th>
						</tr>
						<tr>
							<td colspan="2" align="center" valign="top">
								<%
								gameSet = g.qryGamesByPriority(2,uid)
								For i = 0 to 6
									set gObj = gameSet(i)
									g.WriteGame gObj
								Next
								%>
							</td>
							<td colspan="2" align="center" valign="top">
								<%
								gameSet = g.qryGamesByPriority(2,uid)
								For i = 7 to 13
									set gObj = gameSet(i)
									g.WriteGame gObj
								Next
								%>
							</td>
						</tr>
					</table>
				</td>
				<td ><img src="http://gtmsportswear.com/gtm/images/transparent.gif" width="16" height="1"></td>
				<td align="center" valign="top" class="sec">
					<table border=1 cellpadding=3 cellspacing=0 align=center bgcolor="#FFFFFF">
						<tr><td colspan="4" class="priority">Dog Bowls (Optional)</td></tr>
						<tr>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (0-20)</th>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (0-20)</th>
						</tr>
						<tr>
							<td colspan="2" align="center" valign="top">
								<%
								gameSet = g.qryGamesByPriority(1,uid)
								For i = 0 to 4
									set gObj = gameSet(i)
									g.WriteGame gObj
								Next
								%>
							</td>
							<td colspan="2" align="center" valign="top">
								<%
								gameSet = g.qryGamesByPriority(1,uid)
								For i = 5 to 8
									set gObj = gameSet(i)
									g.WriteGame gObj
								Next
								%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</td></tr>
	<tr>
		<td align="center">
			<span class="home">You have <%=max_credits%> credits to wager.  </span><br>
			<table border="0" cellpadding="3" cellspacing="0" align="center" class="manopt">
				<tr>
					<td align="center">Credits Remaining:<input type="text" size="4" readonly="true" value=<%=remaining%> name="credits"></td></tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align=center><hr noshade>
<%
	If Not toolate Then
%>
			Click Button to <input type=submit value="Make Picks"  <% if not checktime() then %>disabled="disabled" <% end if%>>
<%
	Else
%>
	<span class="warning">Sorry<br>It is too late to make picks.</span>
<%
	End If
%>
	<br>
	<span class="home">* Home team in bold.</span>
	<hr noshade>
	
		</td>
	</tr>
</table>
</form>
<table align="center" border="0" cellpadding="3" cellspacing="0">
	<tr>
	  <td colspan="2" align="center">
		<span class="warning">Please make your payments before the games begin.</span><br>
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
<%=u.GetWageredCredits%>
</body>
</html>
<%
	Set u = Nothing
%>