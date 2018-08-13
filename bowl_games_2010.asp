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
	week = 14
	y = 2010
	uid = Request.QueryString("uid")
	u.Initialize uid,week,y
	numGames = u.Game_Count
	max_credits = 600
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
		for (var i=1;i<=30;i++)
			if ((document.games["game_"+i][0].checked || document.games["game_"+i][1].checked))
				wagered += Number(document.games["val_" + i].value);
		var remaining = max_credits - wagered;
		document.games.credits.value = remaining;
		//document.games.credits2.value = remaining;
	}
	function verify(frm) {
		for (var i=1; i<=30; i++)  {
			if (!(frm["game_"+i][0].checked || frm["game_"+i][1].checked) && (frm["val_" + i].value == 0) && (Number(frm["priority_"+i].value) > 1)) {
				alert("Please select a winner for  the " + frm["bowlName_" + i].value + ".");
				return false;
			}
			if ((frm["game_"+i][0].checked || frm["game_"+i][1].checked) && (frm["val_" + i].value == 0)) {
				alert("Please make a wager for the " + frm["bowlName_" + i].value + ".");
				return false;
			}
			
		}
		for (var i=1; i<=30; i++)  {
			if (!(frm["game_"+i][0].checked || frm["game_"+i][1].checked) && (frm["val_" + i].value != 0)) {
				alert("Please make a selection for the " + frm["bowlName_" + i].value + ".");
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

<form name="games" method=post action="postbowlgames_2010.asp?uid=<%=uid%>" onSubmit="return verify(this)">
<input type="hidden" name="week" value="<%=week%>">
<table border=0 width=100%>
	<tr><td width=33% valign=top>
		<b>Welcome, <%=u.First_Name%></b><br>
		<a href="index.htm">*<i>Pickem</i> Home*</a>
	</td>
	<td align=center width=33% class="week"><%=y%> Bowl Games </td>
	<td align="left"><span class="warning">Once you submit your picks you can come back here & edit your picks until DEC 22 @ 12PM (NOON) CST </span></td>
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
					<table><tr><td>
					<table border=1 cellpadding=3 cellspacing=0 align=center bgcolor="#FFFFFF">
						<tr><td colspan="2" class="priority">Championship</td></tr>
						<tr>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (50-70)</th>
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
						<tr><td colspan="2" class="priority">BCS Bowls</td></tr>
						<tr>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (30-50)</th>
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
				<td ><img src="http://gtmsportswear.com/gtm/images/transparent.gif" width="16" height="1"></td>
				<td align="center" valign="top" class="sec">
					<table border=1 cellpadding=3 cellspacing=0 align=center bgcolor="#FFFFFF">
						<tr>
							<td colspan="4" class="priority">Required Bowls</td>
						</tr>
						<tr>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (10-30)</th>
							<th align="center">Matchup&nbsp;&nbsp;</th>
							<th align=center>Wager (10-30)</th>
						</tr>
						<%gameSet = g.qryGamesByPriority(2,uid)%>
						<tr>
							<td colspan="2" align="center">
								<%
								For i = 0 to 4
									set gObj = gameSet(i)
									g.WriteGame gObj
								Next
								%>
							</td>
							<td colspan="2" align="center">
								<%
								For i = 5 to 9
									set gObj = gameSet(i)
									g.WriteGame gObj
								Next
								%>
							</td>
						</tr>
					</table>
				</td><td ><img src="http://gtmsportswear.com/gtm/images/transparent.gif" width="16" height="1"></td>
				<td align="center" valign="top">
					<table border="0" cellpadding="0" cellspacing="3">
						<tr>
							<td align="center" valign="top" class="sec">
								<table border=1 cellpadding=3 cellspacing=0 align=center bgcolor="#FFFFFF">
									<tr>
										<td colspan="4" class="priority">Optional Bowls</td>
									</tr>
									<tr>
										<th align="center">Matchup&nbsp;&nbsp;</th>
										<th align=center>Wager (0-30)</th>
										<th align="center">Matchup&nbsp;&nbsp;</th>
										<th align=center>Wager (0-30)</th>
									</tr>
									<%gameSet = g.qryGamesByPriority(1,uid)%>
									<tr>
										<td colspan="2" align="center" valign="top">
											<%
											For i = 0 to 6
												g.WriteGame gameSet(i)
											Next
											%>
										</td>
										<td colspan="2" align="center" valign="top">
											<%
											For i = 7 to 14
												g.WriteGame gameSet(i)
											Next
											%>
										</td>
									</tr>
								</table>
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
</body>
</html>
<%
	Set u = Nothing
%>