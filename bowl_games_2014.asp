<%@ language=vbscript%>
<!-- #include file="cClasses_bowls2009.asp" --->
<html>
<head>
<!-- #include file="funcs.asp" --->
<%
	Dim u, g, uid, toolate, cnPick,  i, remaining, max_credits, week, y, numGames
	Dim games(), vis(), visitors(), hos(), homes(), favs(), lines(), mins(), maxs(), gameSet, gObj
	connect
	Set u = new cUser
	week = 15
	y = 2014
	uid = Request.QueryString("uid")
	u.Initialize uid,week,y
	numGames = u.Game_Count
	max_credits = 1100
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
		for (var i=1;i<=27;i++)
			if ((document.games["game_"+i][0].checked || document.games["game_"+i][1].checked))
				wagered += Number(document.games["val_" + i].value);
		var remaining = max_credits - wagered;
		console.log(remaining);
		document.games.credits.value = remaining;
	}
	
	function verify(frm) {
		for (var i=1; i<=27; i++)
			if (!(frm["game_"+i][0].checked || frm["game_"+i][1].checked) && (frm["val_" + i].value == 0)) {
				alert("Please select a winner for " + frm["bowlName_" + i].value + ".");
				return false;
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
	.sec {border:3px solid #0099CC; background-color:#CCCCCC}
</style>

<body bgcolor="#FFFFFF">
<form name="games" method=post action="postbowlgames_2014.asp?uid=<%=uid%>" >
<input type="hidden" name="week" value="<%=week%>">
<table border=0 width=100%>
	<tr><td width=33% valign=top>
		<b>Welcome, <%=u.First_Name%></b><br>
		<a href="index.htm">*<i>Pickem</i> Home*</a>
		<%if uid="00027" or uid="00060" or uid="00077" then%><br>
		<a href="updategames.asp?w=15&uid=<%=uid%>">UPDATE GAMES</a><br>
		<a href="entergames.asp?w=15&uid=<%=uid%>">ENTER GAMES</a>
		<%end if%>	</td>
	<td align=center width=33% class="week"><%=y%> Bowl Games </td>
	<td align="left"><span class="warning">Once you submit your picks you can come back here & edit your picks until JAN 1 @ 10:30 AM </span></td>
	</tr>
</table>
	

<table border=0 cellpadding=3 cellspacing=0 align=center style="border:5px solid #0099CC">
<% IF toolate Then %>
	<tr>
		<td>
			<span class="warning"><hr noshade><center>IT'S TOO LATE TO MAKE PICKS</center></span>
		</td>
	</tr>
<% End If %>
	<tr><td align="center" valign="top" colspan="5" >
		<table border="0" cellpadding="0" cellspacing="3">
			<tr>
				<td align="center" class="sec" style="padding:3px;">
					<br>
					<table border="1" cellpadding="3" cellspacing="0" align="center" bgcolor="#FFFFFF">
						<tbody>
							<tr>
								<td colspan="2" class="priority">Championship</td>
							</tr>
							<tr>
								<th align="center">Matchup&nbsp;&nbsp;</th>
								<th align="center">Wager (100....)</th>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<table border=1 cellpadding=3 cellspacing=0 align=center bgcolor="#FFFFFF">
										<tbody>
											<tr>
												<td align="left"><span class="bowl">College Football Playoff<BR>National Championship, Arlington</span></td>
											</tr>
											<tr>
<%
								gameSet = g.qryGamesByPriority(5,uid)
								For i = 0 to ubound(gameSet) - 1
									set gObj = gameSet(i)
									g.WriteGame gObj
								Next
								%>
											</tr>

										</tbody>
									</table>	
								</td>
							</tr>
	<tr>
		<td align=center><hr noshade>
<%
	If Not toolate Then
%>
			Click Button to <input type=submit value="Make Picks"<% if now()>cdate("1/12/2015  07:29:59 PM") then %>disabled="disabled" <% end if%> />
			<%
	Else
%>
	<span class="warning">Sorry<br>It is too late to make picks.</span>
<%
	End If
%>
		</td>
	</tr>						</tbody>
					</table>
					<br><span class="home">You have minimum 100 credits to wager on the championship game.</span><br>
					<span class="home">After all the other games have been completed you can select the</span><br>
					<span class="home">winner and amount you want to place on the championship game.</span><br><br>
					<span class="home">If you are under 1000 at that time you will only be able to bet 100.</span><br>
					<span class="home">If you are over 1000 at that time you bet 100+ the amount you are over 1000.</span><br><br>
					<span class="home">Use your 1000 on the games below.</span>
					<br><br>
				</td>
			</tr>
			<tr>
				<td align="center" valign="top" class="sec">
					<table><tr><td valign="top">
					<table border=1 cellpadding=3 cellspacing=0 align=center bgcolor="#FFFFFF">
						<tr><td colspan="2" class="priority">Semi Finals</td></tr>
						<tr>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (70-90)</th>
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
					</table></td></tr>
					<tr><td>&nbsp;</td></tr>
					<tr><td>	
					<table border=1 cellpadding=3 cellspacing=0 align=center bgcolor="#FFFFFF">
						<tr><td colspan="2" class="priority">Tier 1 Bowls</td></tr>
						<tr>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (50-70)</th>
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
					</table></td></tr>
				</table></td>
				<td ><img src="../gtm/images/spacer.gif" width="16" height="1"></td>
				<td align="center" valign="top" class="sec">
					<table border=1 cellpadding=3 cellspacing=0 align=center bgcolor="#FFFFFF">
						<tr><td colspan="2" class="priority">Tier 2 Bowls</td></tr>
						<tr>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (30-50)</th>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<%
								gameSet = g.qryGamesByPriority(2,uid)
								For i = 0 to ubound(gameSet) - 1
									set gObj = gameSet(i)
									g.WriteGame gObj
								Next
								%>
							</td>
						</tr>
					</table>
				</td>
				<td ><img src="../gtm/images/spacer.gif" width="16" height="1"></td>
				<td align="center" valign="top" class="sec">
					<table border=1 cellpadding=3 cellspacing=0 align=center bgcolor="#FFFFFF">
						<tr><td colspan="2" class="priority">Tier 3 Bowls</td></tr>
						<tr>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (10-30)</th>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<%
								gameSet = g.qryGamesByPriority(1,uid)
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
	<tr>
		<td align="center" colspan="">
			<span class="home">You have <%=max_credits%> credits to wager.  </span><br>
			<table border="0" cellpadding="3" cellspacing="0" align="center" class="manopt">
				<tr>
					<td align="center">Credits Remaining:<input type="text" size="4" readonly="true" value=<%=remaining%> name="credits"></td></tr>
			</table>
		</td>
	</tr>

</table>
</form>
</body>
</html>
<%
	Set u = Nothing
%>