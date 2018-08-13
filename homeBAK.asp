<%@ language=vbscript%>
<!-- displayresults.asp --->
<!-- #include file="funcs.asp" --->
<%
	Dim uid, results, cnPick, i
	uid = Request.QueryString("uid")
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
			  <table align="center" border=0 cellspacing=1 cellpadding=6 style="border: 1px solid blue">
				<tr><td align=center><table align=center>
			<form action="checklogin.asp" method=post name=login onSubmit="return validate()">
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
				</tr>
			</form>
				<tr>
					<td colspan="2" align="center">
<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
	    <p>
	      <input type="hidden" name="cmd" value="_s-xclick">
  <input type="image" src="https://www.paypal.com/en_US/i/btn/x-click-butcc-donate.gif" border="0" name="submit" alt="Make payments with PayPal - it's fast, free and secure!">
  <input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----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-----END PKCS7-----
">
  <br>
  <strong><u>CREDIT/DEBIT CARD PAYMENT
  ($5.50)</u></strong><br>
</p>
          </form>					</td>
				</tr>
				
				
				</table></td></tr>
				
			</table>
		</td>
	</tr>
	<tr><td colspan="2"><font size="+1"><b>2007 Results</b></font></td></tr>
	<tr><td colspan="2"><table width="100%"><tr>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr>
					<td valign="top">1</td>
					<td valign="top">1. Berard<br>2. Hisey</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_1.asp">Results</a></td>
				</tr>
				<tr>
					<td valign="top">2</td>
					<td valign="top">1. Brockhoff<br>2. Berard</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_2.asp">Results</a></td>
				</tr>
				<tr>
					<td valign="top">3</td>
					<td valign="top">1. Lovette<br>
					  2. Berard </td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_3.asp">Results</a></td>
				</tr>
				<tr>
					<td valign="top">4</td>
					<td valign="top">1. Sims<br>
					  2. Blachly </td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_4.asp">Results</a></td>
				</tr>
				<tr>
					<td valign="top">5</td>
					<td valign="top">1. Strawn Jr<br>2. Strawn Sr</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_5.asp">Results</a></td>
				</tr>
				<tr>
					<td valign="top">6</td>
					<td valign="top">1. Mallot<br>2. Strawn Jr</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_6.asp">Results</a></td>
				</tr>
				<tr>
					<td valign="top">7</td>
					<td valign="top">1. Strawn Jr<br>2. Blachly</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_7.asp">Results</a></td>
				</tr>
				<tr>
					<td valign="top">8</td>
					<td valign="top">1. Darling<br>2. Mallot</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_8.asp">Results</a></td>
				</tr>
			</table>
		</td>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr>
					<td valign="top">9</td>
					<td valign="top">1. Lovette<br>2. Mallot</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_9.asp">Results</a></td>
				</tr>
				<tr>
					<td valign="top">10</td>
					<td valign="top">1. Blachly<br>2. Strawn Sr</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_10.asp">Results</a></td>
				</tr>
				<tr>
					<td valign="top">11</td>
					<td valign="top">1. Brockhoff<br>2. Papa Rhoden</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_11.asp">Results</a></td>
				</tr>
				<tr>
					<td valign="top">12</td>
					<td valign="top">1. Tierney<br>2. Strawn Sr</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_12.asp">Results</a></td>
				</tr>
				<tr>
					<td valign="top">13</td>
					<td valign="top">1. Barnett<br>2. Papa Rhoden</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_13.asp">Results</a></td>
				</tr>
				<tr>
					<td valign="top">14</td>
					<td valign="top">1. Strawn Sr<br>
					  2. Davidson </td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_14.asp">Results</a></td>
				</tr>
<%if not checktime() then %>
				<tr>
					<td valign="top">BOWL</td>
					<td valign="top">&nbsp;</td>
			  	 	<td align="center" valign="top"><a href="rg07.asp">Grid</a></td>
				</tr>
<%end if%>				
			</table>
		</td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Total</th><th>Weeks</th><th>Average</th></tr>
<%
	dim totalResults, tLoop, tObj
	totalResults = qryTotals("2007")
	for tLoop = 0 to ubound(totalResults) - 1
		set tObj = totalResults(tLoop)
%>
				<tr><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("total")%></td><td><%=tObj("weeksPlayed")%></td><td><%=round(tObj("average"),2)%></td></tr>
<%
	next
%>
			</table>
		</td>
	</tr></table></td></tr>
	<tr><td colspan="2"><font size="+1"><b>2006 Results</b></font></td></tr>
	<tr><td colspan="2"><table><tr>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr><td valign="top">1</td>
				<td valign="top">1. Maltbie<br>
				   2. Mallot </td>
			   <td align="center" valign="top"><a href="results_grid_2006_1.asp">Results</a></td>
				</tr>
				<tr>
          <td valign="top">2</td>
          <td valign="top">1. Strawn Sr<br>
				   2. Tierney</td>
          <td align="center" valign="top"><a href="results_grid_2006_2.asp">Results</a></td>
        </tr>
				<tr>
          <td valign="top">3</td>
          <td valign="top">1. Alonso<br>
             2. Darling </td>
          <td align="center" valign="top"><a href="results_grid_2006_3.asp">Results</a></td>
        </tr>
<tr>
          <td valign="top">4</td>
          <td valign="top">1. Colston<br>
             2. Maltbie</td>
          <td align="center" valign="top"><a href="results_grid_2006_4.asp">Results</a></td>
        </tr>
        <tr>
          <td valign="top">5</td>
          <td valign="top">1. Tierney<br>
             2. Mallot </td>
          <td align="center" valign="top"><a href="results_grid_2006_5.asp">Results</a></td>
        </tr>
		<tr>
          <td valign="top">6</td>
          <td valign="top">1. Greene<br>
             2. Maltbie </td>
          <td align="center" valign="top"><a href="results_grid_2006_6.asp">Results</a></td>
        </tr>
		<tr>
          <td valign="top">7</td>
          <td valign="top">1. Sims<br>
            2. Blachly </td>
          <td align="center" valign="top"><a href="results_grid_2006_7.asp">Results</a></td>
        </tr>
		</table></td>
		<td width="33%" align=center valign="top"><table border="1" cellpadding="3" cellspacing="0" class="results">
        <tr>
          <th width="40">Week</th>
          <th width="98">Winners</th>
          <th width="44">View</th>
        </tr>
	        
        
		<tr>
          <td valign="top">8</td>
          <td valign="top">1. Alonso<br>
            2. Greene </td>
          <td align="center" valign="top"><a href="results_grid_2006_8.asp">Results</a></td>
        </tr>
		<tr>
          <td valign="top">9</td>
          <td valign="top">1. Maltbie<br>
            2. Blachly </td>
          <td align="center" valign="top"><a href="results_grid_2006_9.asp">Results</a></td>
        </tr>
		<tr>
          <td valign="top">10</td>
          <td valign="top">1. Darling<br>
             2. Alonso </td>
          <td align="center" valign="top"><a href="results_grid_2006_10.asp">Results</a></td>
        </tr>
		<tr>
          <td valign="top">11</td>
          <td valign="top">1. Rhoden<br>
2. Maltbie</td>
          <td align="center" valign="top"><a href="results_grid_2006_11.asp">Results</a></td>
        </tr>
		<tr>
          <td valign="top">12</td>
          <td valign="top">1. Strawn Sr<br>2. Darling</td>
          <td align="center" valign="top"><a href="results_grid_2006_12.asp">Results</a></td>
        </tr>
		<tr>
          <td valign="top">13</td>
          <td valign="top">1. Strawn Sr<br>2. Rhoden</td>
          <td align="center" valign="top"><a href="results_grid_2006_13.asp">Results</a></td>
        </tr>
		<tr>
          <td valign="top">BOWL</td>
          <td valign="top">1. Davidson<br>
             2. Maltbie</td>
          <td align="center" valign="top"><a href="rg06.asp">Results</a></td>
        </tr>
      </table></td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Total</th><th>Weeks</th><th>Average</th></tr>
<%
	totalResults = qryTotals("2006")
	for tLoop = 0 to ubound(totalResults) - 1
		set tObj = totalResults(tLoop)
%>
				<tr><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("total")%></td><td><%=tObj("weeksPlayed")%></td><td><%=round(tObj("average"),2)%></td></tr>
<%
	next
%>
			</table>
		</td>
	  
	</tr></table></td></tr>
	
	
	<tr><td colspan="2"><font size="+1"><b>2005 Results</b></font></td></tr>
	<tr><td colspan="2"><table><tr>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr><td valign="top">1</td><td valign="top">T1. Colston<br>T1. Younger</td><td valign="top"><a href="results_grid_2005_1.asp">Results</a></td></tr>
				<tr><td valign="top">2</td><td valign="top">1. Tierney<br>2. Strawn Jr</td><td valign="top"><a href="results_grid_2005_2.asp">Results</a></td>
				</tr>
				<tr><td valign="top">3</td><td valign="top">T1. Tierney<br>T1. Berard</td><td valign="top"><a href="results_grid_2005_3.asp">Results</a></td>
				</tr>
				<tr>
				  <td valign="top">4</td>
				  <td valign="top"><p>1. Strawn Sr<br>2. Lane</p></td>
				  <td valign="top"><a href="results_grid_2005_4.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">5</td>
				  <td valign="top">1. Hisey<br>2. Brockhoff </td>
				  <td valign="top"><a href="results_grid_2005_5.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">6</td>
				  <td valign="top">1. Lane<br>2. Tierney</td>
				  <td valign="top"><a href="results_grid_2005_6.asp">Results</a></td>
			  </tr>
<tr>
				  <td valign="top">7</td>
				  <td valign="top">1. Strawn Sr<br>2. Blachly</td>
				  <td valign="top"><a href="results_grid_2005_7.asp">Results</a></td>
			  </tr>		</table>		</td>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				
				<tr>
				  <td valign="top">8</td>
				  <td valign="top">1. Strawn Sr<br>2. Rhoden</td>
				  <td valign="top"><a href="results_grid_2005_8.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">9</td>
				  <td valign="top">1. Hisey<br>2. Maltbie</td>
				  <td valign="top"><a href="results_grid_2005_9.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">10</td>
				  <td valign="top">1. Strawn Sr<br>2. Tierney</td>
				  <td valign="top"><a href="results_grid_2005_10.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">11</td>
				  <td valign="top">1. Berard<br>2. Rhoden</td>
				  <td valign="top"><a href="results_grid_2005_11.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">12</td>
				  <td valign="top">1. Younger<br>2. Blachly</td>
				  <td valign="top"><a href="results_grid_2005_12.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">13</td>
				  <td valign="top">1. Rhoden<br>2. Strawn Jr</td>
				  <td valign="top"><a href="results_grid_2005_13.asp">Results</a></td>
			  </tr>
				<tr>
				  <td valign="top">BOWL</td>
				  <td valign="top">1. Rhoden<br>2. Hisey</td>
				  <td valign="top"><a href="rg.asp">Results</a></td>
			  </tr>
		</table>		</td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Total</th><th>Weeks</th><th>Average</th></tr>
<%
	totalResults = qryTotals("2005")
	for tLoop = 0 to ubound(totalResults) - 1
		set tObj = totalResults(tLoop)
%>
				<tr><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("total")%></td><td><%=tObj("weeksPlayed")%></td><td><%=round(tObj("average"),2)%></td></tr>
<%
	next
%>
			</table>
		</td></tr></table></td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<br><hr>
			Picks must be made by SEPT  8 at 11AM (CST).<br>
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
					<b>Tiebreaker:</b>
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
