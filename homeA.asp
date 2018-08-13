<%@ language=vbscript%>
<!-- displayresults.asp --->
<!-- #include file="funcs.asp" --->
<%
	Dim uid, results, cnPick, i
	uid = Request.QueryString("uid")
	Connect
	'results = StandingsForWeek(13)
%>
<html>
<head>
<script language=javascript>
	function validate()
	{
		if (document.login.email.value == "")
		{
			alert("Please enter your email address");
			document.login.email.focus();
			return false;
		}
		else if (document.login.pass.value== "")
		{
			alert("Please enter your password");
			document.login.pass.focus();
			return false;
		}
		return true;
	}
</script>
<title>Pick 'Em</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF">

<table border=0 align=center cellpadding=2 cellspacing=1>
	<tr><td colspan="2" align="center"><font size=+2>Welcome to the penultimate pickem challenge!</font></td></tr>
	<tr>
		<td align=center colspan="2" valign=top>
			<form action="checklogin.asp" method=post name=login onSubmit="return validate()">
			  <table align="center" border=0 cellspacing=1 cellpadding=6 style="border: 1px solid blue">
				<tr><td align=center><table align=center>
				<tr>
					<td colspan=2 align=center>
						Login to make your pics or <a href="register.asp">Register</a>
					</td>
				</tr>
				<tr>
					<td align=right>Email:&nbsp;</td>
					<td align=left><input type=text name=email></td>
				</tr>
				<tr>
					<td align=right>Password:&nbsp;</td>
					<td align=left><input type=password name=pass></td>
				</tr>
				<tr>
					<td colspan=2 align=center>
						<input type=submit value="Make your picks.">
					</td>
				</tr></table></td></tr>
			</table>
			</form>
		</td>
	</tr>
	<tr>
	  <td width="50%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr><td valign="top">1</td><td valign="top">T1. Colston<br>T1. Younger</td><td valign="top"><a href="results_grid.asp">Results</a></td></tr>
				<tr><td valign="top">2</td><td valign="top">1. T-Bone<br>2. Strawn Jr.</td><td valign="top"><a href="results_grid_2.asp">Results</a></td></tr>
				<tr><td valign="top">3</td><td valign="top">T1. T-Bone<br>T1. Rob</td><td valign="top"><a href="results_grid_3.asp">Results</a></td></tr>
				<tr>
				  <td valign="top">4</td>
				  <td valign="top"><p>1. Strawn Sr.<br>2. Lane</p></td>
				  <td valign="top"><a href="results_grid_4.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">5</td>
				  <td valign="top">1. Hisey<br>2. Brockhoff </td>
				  <td valign="top"><a href="results_grid_5.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">6</td>
				  <td valign="top">1. Lane<br>2. Tierney</td>
				  <td valign="top"><a href="results_grid_6.asp">Results</a></td>
			  </tr>
<tr>
				  <td valign="top">7</td>
				  <td valign="top">1. Strawn Sr.<br>2. Blach</td>
				  <td valign="top"><a href="results_grid_7.asp">Results</a></td>
			  </tr>		</table>		</td>
	  <td width="50%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				
				<tr>
				  <td valign="top">8</td>
				  <td valign="top">1. Strawn Sr.<br>2. Rhodini</td>
				  <td valign="top"><a href="results_grid_8.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">9</td>
				  <td valign="top">1. Hisey<br>2. Maltbie</td>
				  <td valign="top"><a href="results_grid_9.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">10</td>
				  <td valign="top">1. Strawn Sr.<br>2. T-Bone</td>
				  <td valign="top"><a href="results_grid_10.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">11</td>
				  <td valign="top">1. Berard<br>2. Rhodini</td>
				  <td valign="top"><a href="results_grid_11.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">12</td>
				  <td valign="top">1. Younger<br>2. Blach</td>
				  <td valign="top"><a href="results_grid_12.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">13</td>
				  <td valign="top">1. Rhoden<br>2. Strawn Jr.</td>
				  <td valign="top"><a href="results_grid_13.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">BOWL</td>
				  <td valign="top">&nbsp;</td>
				  <td valign="top">&nbsp;</td>
			  </tr>
		</table>		</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<br><hr>
			Picks must be made by Thursday at 6PM (CST).<br>
			<hr>
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<br>
			<table  align="center" border=0 cellspacing=1 cellpadding=6 width=75% style="border: 1px solid blue">
				<tr><td align=center><table align=center>
				<tr>
					<td align="left">
					<u><b><font size=+1 color="#0033CC">$$$Prize Info$$$</font></b></u><br
					>
					<b>Weekly Entry Fee:</b>&nbsp;&nbsp;$5.50<br>
					<b>Weekly Prize:</b>&nbsp;&nbsp;1st-80%, 2nd-20% <br>
					<b>Tiebreaker:</b>&nbsp;&nbsp;(Starting in Week 4)
					<ol>
					<li>Most picks correct of all games in the week.</li>
					<li>Most picks correct in the mandatory games.</li>
					<li>Most picks correct of the big 12 games.</li>
					<li>Most points accumulated in previous weeks.</li>
					</ol>
					<b>Season Long Prize:</b><br>
					No season prize. <br>
					<br><br>
					</td>
				</tr></table></td></tr>
			</table><br><br>
			Questions?  Email me at <a href="mailto:mrhoden@igtm.com">mrhoden@igtm.com</a><hr>
		</td>
	</tr>
</table>
</body>
</html>
