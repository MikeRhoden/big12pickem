<%@ language=vbscript%>
<!-- #include file="funcs.asp" -->
<!-- #include file="cDeadline.asp" -->
<%
Dim uid, results, cnPick, i
dim totalResults, tLoop, tObj
uid=Request.QueryString("uid")
connect
function pastDeadlineForWeek(week)
	pastDeadlineForWeek = now() > (new cDeadline).GetDeadlineForWeek2018(week)
end function
%>

<html>
<head>
<style type="text/css">
    .show-all{cursor:pointer}
    .show-hide-old-results{background-color:#CCCCCC; float:right}    
    .old-results{ border-top: 3px solid #000000 ;margin-top: 20px;}
</style>
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" charset="utf-8"></script>
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
				</table></td></tr>
			</table>
		</td>
	</tr>

	<tr><td colspan="2"><font size="+3"><b>2018 Results</b></font></td></tr>
	<tr><td colspan="2"><table width="100%"><tr>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
					<td valign="top">1</td>
					<td valign="top"></td>
					   <td align="center" valign="top"><a href="results_grid_2018.asp?w=1&t=1">Results</a></td>
				</tr>		
			</table>
		</td>
		<td width="33%" align=center valign="top">
		</td>
		<td>
		</td>
	</tr></table></td></tr>


	<tr><td colspan="2"><font size="+3"><b>2017 Results</b></font></td></tr>

	<tr><td colspan="2"><table width="100%"><tr>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
                
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
					<td valign="top">1</td>
					<td valign="top">1. Domenico, 2. Eddie</td>
					   <td align="center" valign="top"><a href="results_grid_2017.asp?w=2&t=1">Results</a></td>
				</tr>		
				<tr>
					<td valign="top">2</td>
					<td valign="top">1. Maltibe, 2. Darling</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2017.asp?w=3&t=1">Results</a></td>
				</tr>
				<tr>
					<td valign="top">3</td>
					<td valign="top">1. Leay & Strawny </td>
					   <td align="center" valign="top"><a href="results_grid_2017.asp?w=4">Results</a></td>
				</tr>
				<tr>
					<td valign="top">4</td>
					<td valign="top">1. Lewison & Strawny </td>
			  	 	<td align="center" valign="top"><a href="results_grid_2017.asp?w=5">Results</a></td>
				</tr>
				<tr>
					<td valign="top">5</td>
					<td valign="top">1. Mallot<BR>2. Morgan, Bob</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2017.asp?w=6">Results</a></td>
				</tr>
				<tr>
					<td valign="top">6</td>
					<td valign="top">1. Leay<BR>2. Hurt, Tamamsi</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2017.asp?w=7">Results</a></td>
				</tr>
				<tr>
					<td valign="top">7</td>
					<td valign="top">1. Leay<BR>2. Domenico</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2017.asp?w=8">Results</a></td>
				</tr>
			</table>
		</td>
		<td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr>
					<td valign="top">8</td>
					<td valign="top">1. Strawny<BR>2. Lewison</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2017.asp?w=9">Results</a></td>
				</tr>
				<tr>
					<td valign="top">9</td>
					<td valign="top">1. Leay<BR>2. Domenico</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2017.asp?w=10">Results</a></td>
				</tr>
				<tr>
					<td valign="top">10</td>
					<td valign="top">1. 4 way tie<br>Lewison, May<BR>Mallot, Strawn  </td>
			  	 	<td align="center" valign="top"><a href="results_grid_2017.asp?w=11">Results</a></td>
				</tr>
				<tr>
					<td valign="top">11</td>
					<td valign="top">1. Tamasi<br>2. Maltbie</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2017.asp?w=12">Results</a></td>
				</tr>
				<tr>
					<td valign="top">12</td>
					<td valign="top">1. Maltbie<br>2. Bob, Michelle</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2017.asp?w=13">Results</a></td>
				</tr>
			</table>
		</td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Mandatory<br>Correct</th><th>Average<br>Score</th><th>Weeks<br>Played</th><th>Last Week<br />Played</th</tr>
<%
	
	totalResults=qryTotalsV2("2017")
	for tLoop=0 to ubound(totalResults) - 1
		set tObj=totalResults(tLoop)
%>
				<tr class="total-results"><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("mandatoryCorrect")%></td><td><%=round(round(tObj("average"),2))%></td><td><%=tObj("weeksPlayed")%></td><td><%=tObj("lastWeekPlayed")%></td><!--<td><%=tObj("total")%></td><td><%=round(tObj("average"),2)%></td>--></tr>
<%
	next
%>
                <tr><td colspan="5"><a class="show-all">... show all</a></td></tr>
			</table>
		</td>
	</tr></table></td></tr>
<tr><td colspan="2"><font size="+3"><b>2016 Results</b></font><!--<div style="float:right"><font size="+1"><b><a href="rg13.asp">2012-13 Bowl Results</a></b></font></div>--></td></tr>
	<tr><td colspan="2"><table width="100%"><tr>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
                <%if now()>cdate("9/3/2016 10:59:59 AM") then%>
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
					<td valign="top">1</td>
					<td valign="top">1. Tierney 2. Eddie, Michelle</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=1">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("9/10/2016 10:59:59 AM") then%>
				<tr>
					<td valign="top">2</td>
					<td valign="top">1. Tamasi 2. Maltbie</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=2">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("9/17/2016 10:59:59 AM") then%>
				<tr>
					<td valign="top">3</td>
					<td valign="top">1.Domenico<br>2.&nbsp;Strawny</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=3">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("9/24/2016 10:59:59 AM") then%>
				<tr>
					<td valign="top">4</td>
					<td valign="top">1. Keough<br /> 2. Maltbie</rb></td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=4">Results</a></td>
				</tr>
            <%end if %>
				<%if now()>cdate("10/1/2016 10:59:59 AM") then%>
				<tr>
					<td valign="top">5</td>
					<td valign="top">1. Hisey, Tierney</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=5">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("10/8/2016 10:59:59 AM") then%>
				<tr>
					<td valign="top">6</td>
					<td valign="top">1. Morgan<br /> 2. Hisey</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=6">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("10/15/2016 10:59:59 AM") then%>
				<tr>
					<td valign="top">7</td>
					<td valign="top">1. Hisey<br /> 2. Domenico</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=7">Results</a></td>
				</tr>
				<%end if%>
			</table>
		</td>
		<td width="33%" align=center valign="top">
			<%if now()>cdate("10/22/2016 10:59:59 AM") then%>
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<%if now()>cdate("10/22/2016 10:59:59 AM") then%>
				<tr>
					<td valign="top">8</td>
					<td valign="top">1. Domenico, Tierney</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=8">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("10/29/2016 10:59:59 AM") then%>
				<tr>
					<td valign="top">9</td>
					<td valign="top">1. Hsu<br>2. Tierney</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=9">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("11/5/2016 10:59:59 AM") then%>
				<tr>
					<td valign="top">10</td>
					<td valign="top">1. Blachly<br>2. Maltbie</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=10">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("11/12/2016 10:59:59 AM") then%>
				<tr>
					<td valign="top">11</td>
					<td valign="top">1. Lewison<br>2. Darling, Mallot</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=11">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("11/19/2016 10:59:59 AM") then%>
				<tr>
					<td valign="top">12</td>
					<td valign="top">1. Maltbie<br>2. Bob, Michelle</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=12">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("11/26/2016 10:59:59 AM") then%>
				<tr>
					<td valign="top">13</td>
					<td valign="top">1. Hsu<br>2. Maltbie, Domenico, Mallot</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=13">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("12/3/2016 10:59:59 AM") then%>
				<tr>
					<td valign="top">14</td>
					<td valign="top">1. Hsu<br>2. Hisey</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2016.asp?w=14">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("12/29/2016 02:59:59 AM") then%>
				<tr>
					<td valign="top">Bowl</td>
					<td valign="top"></td>
			  	 	<td align="center" valign="top"><a href="rg16.asp">2016-17 Bowl Results</a></td>
				</tr>
				<%end if%>
			</table>
			<%end if%>
		</td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Mandatory<br>Correct</th><th>Average<br>Score</th><th>Weeks<br>Played</th><th>Last Week<br />Played</th</tr>
<%
	
	totalResults=qryTotalsV2("2016")
	for tLoop=0 to ubound(totalResults) - 1
		set tObj=totalResults(tLoop)
%>
				<tr class="total-results"><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("mandatoryCorrect")%></td><td><%=round(round(tObj("average"),2))%></td><td><%=tObj("weeksPlayed")%></td><td><%=tObj("lastWeekPlayed")%></td><!--<td><%=tObj("total")%></td><td><%=round(tObj("average"),2)%></td>--></tr>
<%
	next
%>
                <tr><td colspan="5"><a class="show-all">... show all</a></td></tr>
			</table>
		</td>
	</tr></table></td></tr>
	
   	<tr><td colspan="2" class="old-results"><font size="+1"><b>2015 Results</b></font></td></tr>
	<tr><td colspan="2"><table width="100%"><tr>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
            <%if now()>cdate("9/5/2015 10:59:59 AM") then%>
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
					<td valign="top">1</td>
					<td valign="top">1.&nbsp;Bob, Rhoden</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=1">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("9/12/2015 10:59:59 AM") then%>
				<tr>
					<td valign="top">2</td>
					<td valign="top">1.&nbsp;Domenico<br>2.&nbsp;Lewison</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=2">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("9/19/2015 10:59:59 AM") then%>
				<tr>
					<td valign="top">3</td>
					<td valign="top">1.&nbsp;Darling<br>2.&nbsp;Lewison<br>&nbsp;Broxty<br>&nbsp;Strawny</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=3">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("9/26/2015 10:59:59 AM") then%>
				<tr>
					<td valign="top">4</td>
					<td valign="top">1.&nbsp;Lewison<br>2.&nbsp;Blachly</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=4">Results</a></td>
				</tr>
            <%end if %>
				<%if now()>cdate("10/3/2015 10:59:59 AM") then%>
				<tr>
					<td valign="top">5</td>
					<td valign="top">1.&nbsp;Newcomb<br>2.&nbsp;Domenico</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=5">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("10/10/2015 10:59:59 AM") then%>
				<tr>
					<td valign="top">6</td>
					<td valign="top">1.&nbsp;Tierney<br>2.&nbsp;Bob</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=6">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("10/17/2015 10:59:59 AM") then%>
				<tr>
					<td valign="top">7</td>
					<td valign="top">1.&nbsp;Becker<br>2.&nbsp;Lewison</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=7">Results</a></td>
				</tr>
				<%end if%>
			</table>
		</td>
		<td width="33%" align=center valign="top">
			<%if now()>cdate("10/24/2015 10:59:59 AM") then%>
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<%if now()>cdate("10/24/2015 10:59:59 AM") then%>
				<tr>
					<td valign="top">8</td>
					<td valign="top">1.&nbsp;Maltbie<br>2.&nbsp;Broxterman</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=8">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("10/31/2015 10:59:59 AM") then%>
				<tr>
					<td valign="top">9</td>
					<td valign="top">1.&nbsp;Morgan<br>2.&nbsp;Lewison</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=9">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("11/7/2015 10:59:59 AM") then%>
				<tr>
					<td valign="top">10</td>
					<td valign="top">1.&nbsp;Blachly<br>2.&nbsp;Martucci</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=10">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("11/14/2015 10:59:59 AM") then%>
				<tr>
					<td valign="top">11</td>
					<td valign="top">1.&nbsp;Maltbie<br>2.&nbsp;Mallot</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=11">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("11/21/2015 10:59:59 AM") then%>
				<tr>
					<td valign="top">12</td>
					<td valign="top">1.&nbsp;Mallot<br>2.&nbsp;Tamasi</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=12">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("11/28/2015 10:59:59 AM") then%>
				<tr>
					<td valign="top">13</td>
					<td valign="top">1.&nbsp;Bob, T-Bone</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=13">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("12/5/2015 10:59:59 AM") then%>
				<tr>
					<td valign="top">14</td>
					<td valign="top">1.&nbsp;Lewison<br>2.&nbsp;Becker, Darling</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2015.asp?w=14">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("12/31/2015 02:59:59 AM") then%>
				<tr>
					<td valign="top">Bowl</td>
					<td valign="top"></td>
			  	 	<td align="center" valign="top"><a href="rg15.asp">2015-16 Bowl Results</a></td>
				</tr>
				<%end if%>
			</table>
			<%end if%>
		</td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Mandatory<br>Correct</th><th>Average<br>Score</th><th>Weeks<br>Played</th><th>Last Week<br />Played</th><!--<th>Total<br>Cleared</th><th>Average<br>Cleared</th>--></tr>
<%
	
	totalResults=qryTotalsV2("2015")
	for tLoop=0 to ubound(totalResults) - 1
		set tObj=totalResults(tLoop)
%>
				<tr class="total-results"><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("mandatoryCorrect")%></td><td><%=round(round(tObj("average"),2))%></td><td><%=tObj("weeksPlayed")%></td><td><%=tObj("lastWeekPlayed")%></td><!--<td><%=tObj("total")%></td><td><%=round(tObj("average"),2)%></td>--></tr>
<%
	next
%>
                <tr><td colspan="5"><a class="show-all">... show all</a></td></tr>
			</table>
		</td>
	</tr></table></td></tr>
	

	<tr><td colspan="2" class="old-results"><font size="+1"><b>2014 Results</b></font><div style="float:right"><font size="+1"><b><a href="rg13.asp">2014-15 Bowl Results</a></b></font></div></td></tr>
	<tr><td colspan="2"><table width="100%"><tr>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
					<td valign="top">1</td>
					<td valign="top">1.&nbsp;Blachly<BR>2.&nbsp;Hisey</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=1">Results</a></td>
				</tr>
				<tr>
					<td valign="top">2</td>
					<td valign="top">1.&nbsp;Strawn,J<BR>2. Clark</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=2">Results</a></td>
				</tr>
				<tr>
					<td valign="top">3</td>
					<td valign="top">1.&nbsp;Strawn,B<BR>2. Hisey; Jonas</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=3">Results</a></td>
				</tr>
				<tr>
					<td valign="top">4</td>
					<td valign="top">1.&nbsp;Hisey,&nbsp;Morgan</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=4">Results</a></td>
				</tr>
				<%if now()>cdate("10/4/2014 10:59:59 AM") then%>
				<tr>
					<td valign="top">5</td>
					<td valign="top">1.&nbsp;Link<BR>2.&nbsp;Lewison; Strawn</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=5">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("10/11/2014 10:59:59 AM") then%>
				<tr>
					<td valign="top">6</td>
					<td valign="top">1.&nbsp;Tierney;&nbsp;Lewison</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=6">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("10/18/2014 10:59:59 AM") then%>
				<tr>
					<td valign="top">7</td>
					<td valign="top">1.&nbsp;Lewison<br>2. Hsu</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=7">Results</a></td>
				</tr>
				<%end if%>
			</table>
		</td>
		<td width="33%" align=center valign="top">
			<%if now()>cdate("10/25/2014 10:59:59 AM") then%>
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<%if now()>cdate("10/25/2014 10:59:59 AM") then%>
				<tr>
					<td valign="top">8</td>
					<td valign="top">1. Strawn<br>2. Tamasi</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=8">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("11/1/2014 10:59:59 AM") then%>
				<tr>
					<td valign="top">9</td>
					<td valign="top">1. Becker; Hisey; Strawn B</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=9">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("11/8/2014 10:59:59 AM") then%>
				<tr>
					<td valign="top">10</td>
					<td valign="top">1. Mallot<BR>2. Becker</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=10">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("11/15/2014 10:59:59 AM") then%>
				<tr>
					<td valign="top">11</td>
					<td valign="top">1. Strawn B<br>2. Tamasi</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=11">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("11/22/2014 10:59:59 AM") then%>
				<tr>
					<td valign="top">12</td>
					<td valign="top">1. Rhoden<br>2. Blachly; Garvert</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=12">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("11/29/2014 10:59:59 AM") then%>
				<tr>
					<td valign="top">13</td>
					<td valign="top">1. Domenico<br>2. Rhoden</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=13">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("12/6/2014 10:59:59 AM") then%>
				<tr>
					<td valign="top">14</td>
					<td valign="top">1. Maltbie<br>2. Hsu; Jonas; Link; Mallot</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2014.asp?w=14">Results</a></td>
				</tr>
				<%end if%>
				<tr>
					<td valign="top">Bowl</td>
					<td valign="top"></td>
			  	 	<td align="center" valign="top"><a href="rg14.asp">Results</a></td>
				</tr>

			</table>
			<%end if%>
		</td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Mandatory<br>Correct</th><th>Average<br>Score</th><th>Weeks<br>Played</th><th>Last Week<br />Played</th><!--<th>Total<br>Cleared</th><th>Average<br>Cleared</th>--></tr>
<%
	
	totalResults=qryTotalsV2("2014")
	for tLoop=0 to ubound(totalResults) - 1
		set tObj=totalResults(tLoop)
%>
				<tr class="total-results"><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("mandatoryCorrect")%></td><td><%=round(round(tObj("average"),2))%></td><td><%=tObj("weeksPlayed")%></td><td><%=tObj("lastWeekPlayed")%></td><!--<td><%=tObj("total")%></td><td><%=round(tObj("average"),2)%></td>--></tr>
<%
	next
%>
                <tr><td colspan="5"><a class="show-all">... show all</a></td></tr>
			</table>
		</td>
	</tr></table></td></tr>
	
	<tr><td colspan="2" class="old-results"><font size="+1"><b>2013 Results</b></font><div style="float:right"><font size="+1"><b><a href="rg13.asp">2013-14 Bowl Results</a></b></font></div></td></tr>
	<tr><td colspan="2"><table width="100%"><tr>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
					<td valign="top">1</td>
					<td valign="top">1.&nbsp;Garvert,&nbsp;Bauer</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=1">Results</a></td>
				</tr>
				<tr>
					<td valign="top">2</td>
					<td valign="top">1.&nbsp;Strawn, J<BR>2. Clark</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=2">Results</a></td>
				</tr>
				<tr>
					<td valign="top">3</td>
					<td valign="top">1.&nbsp;Strawn, J<BR>2. Crowe, Hardesty, Hisey</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=3">Results</a></td>
				</tr>
				<tr>
					<td valign="top">4</td>
					<td valign="top">1.&nbsp;Garvert,&nbsp;Starnes</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=4">Results</a></td>
				</tr>
				<tr>
					<td valign="top">5</td>
					<td valign="top">1.&nbsp;Hsu<BR>2. Hamilton</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=5">Results</a></td>
				</tr>
				<tr>
					<td valign="top">6</td>
					<td valign="top">1&nbsp;Darling<BR>2. Tamasi</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=6">Results</a></td>
				</tr>
				<tr>
					<td valign="top">7</td>
					<td valign="top">1.&nbsp;Darling, Korona, Rahner</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=7">Results</a></td>
				</tr>
			</table>
		</td>
		<td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr>
					<td valign="top">8</td>
					<td valign="top">1.&nbsp;Hardesty<BR>2. Lauer</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=8">Results</a></td>
				</tr>
				<tr>
					<td valign="top">9</td>
					<td valign="top">1.&nbsp;Bauer<BR>2.&nbsp;Becker</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=9">Results</a></td>
				</tr>
				<tr>
					<td valign="top">10</td>
					<td valign="top">1.&nbsp;Strawn B<br>2.&nbsp;Hsu,&nbsp;Korona,&nbsp;Starns</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=10">Results</a></td>
				</tr>
				<tr>
					<td valign="top">11</td>
					<td valign="top">1.&nbsp;Rhoden<br />2.&nbsp;Hisey</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=11">Results</a></td>
				</tr>
				<tr>
					<td valign="top">12</td>
					<td valign="top">1.&nbsp;Blachly<br />2.&nbsp;Hisey</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=12">Results</a></td>
				</tr>
				<tr>
					<td valign="top">13</td>
					<td valign="top">1.&nbsp;Hsu<br />2.&nbsp;Teater</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=13">Results</a></td>
				</tr>
				<%if now()>cdate("11/30/2013 10:59:59 AM") then%>
				<tr>
					<td valign="top">14</td>
					<td valign="top">1.&nbsp;<br />2.&nbsp;</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=14">Results</a></td>
				</tr>
				<%end if%>
				<%if now()>cdate("12/7/2013 10:59:59 AM") then%>
				<tr>
					<td valign="top">15</td>
					<td valign="top">1.&nbsp;<br />2.&nbsp;</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2013.asp?w=15">Results</a></td>
				</tr>
				<%end if%>
			</table>
		</td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Mandatory<br>Correct</th><th>Average<br>Score</th><th>Weeks<br>Played</th><th>Last Week<br />Played</th><!--<th>Total<br>Cleared</th><th>Average<br>Cleared</th>--></tr>
<%
	
	totalResults=qryTotalsV2("2013")
	for tLoop=0 to ubound(totalResults) - 1
		set tObj=totalResults(tLoop)
%>
				<tr class="total-results"><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("mandatoryCorrect")%></td><td><%=round(round(tObj("average"),2))%></td><td><%=tObj("weeksPlayed")%></td><td><%=tObj("lastWeekPlayed")%></td><!--<td><%=tObj("total")%></td><td><%=round(tObj("average"),2)%></td>--></tr>
<%
	next
%>
                <tr><td colspan="5"><a class="show-all">... show all</a></td></tr>
			</table>
		</td>
	</tr></table></td></tr>
	<tr><td colspan="2" class="old-results"><font size="+1"><b>2012 Results</b></font><div style="float:right"><font size="+1"><b><a href="rg12.asp">2012-13 Bowl Results</a></b></font></div></td></tr>
	<tr><td colspan="2"><table width="100%"><tr>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr>
					<td valign="top">1</td>
					<td valign="top">1.&nbsp;Darling<br>2. Lewison/Tierney</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=1">Results</a></td>
				</tr>
				<tr>
					<td valign="top">2</td>
					<td valign="top">1.&nbsp;Link<br>2. Gibson</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=2">Results</a></td>
				</tr>
				<tr>
					<td valign="top">3</td>
					<td valign="top">1.&nbsp;Lewison<br>2. Hsu</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=3">Results</a></td>
				</tr>
				<tr>
					<td valign="top">4</td>
					<td valign="top">1.&nbsp;Tierney<br>2. Lewison/Garvert</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=4">Results</a></td>
				</tr>
				<tr>
					<td valign="top">5</td>
					<td valign="top">1.&nbsp;Niehues<br />2. Garvert/Lewison/Rhoden</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=5">Results</a></td>
				</tr>
				<tr>
					<td valign="top">6</td>
					<td valign="top">1.&nbsp;Bob<br />2. J Strawn/Tierney</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=6">Results</a></td>
				</tr>
				<tr>
					<td valign="top">7</td>
					<td valign="top">1.&nbsp;Blachly<br />2.&nbsp;Rhoden</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=7">Results</a></td>
				</tr>
			</table>
		</td>
		<td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr>
					<td valign="top">8</td>
					<td valign="top">1.&nbsp;Niehues<br />2.&nbsp;Domenico</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=8">Results</a></td>
				</tr>
				<tr>
					<td valign="top">9</td>
					<td valign="top">1.&nbsp;Rhoden<br />2.&nbsp;Link/Blachly</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=9">Results</a></td>
				</tr>
				<tr>
					<td valign="top">10</td>
					<td valign="top">1.&nbsp;Rhoden<br />2.&nbsp;Tamasi</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=10">Results</a></td>
				</tr>
				<tr>
					<td valign="top">11</td>
					<td valign="top">1.&nbsp;Crowe<br />2.&nbsp;Strawn/Tierney</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=11">Results</a></td>
				</tr>
				<tr>
					<td valign="top">12</td>
					<td valign="top">1.&nbsp;Garvert<br />2.&nbsp;May/Rhoden</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=12">Results</a></td>
				</tr>
				<tr>
					<td valign="top">13</td>
					<td valign="top">1.&nbsp;May<br />2.&nbsp;Garvert</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=13">Results</a></td>
				</tr>
				<tr>
					<td valign="top">14</td>
					<td valign="top">1.&nbsp;Crowe<br />2.&nbsp;Rhoden</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2012.asp?w=14">Results</a></td>
				</tr>
			</table>
		</td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Mandatory<br>Correct</th><th>Average<br>Score</th><th>Weeks<br>Played</th><th>Last Week<br />Played</th><!--<th>Total<br>Cleared</th><th>Average<br>Cleared</th>--></tr>
<%
	
	totalResults=qryTotalsV2("2012")
	for tLoop=0 to ubound(totalResults) - 1
		set tObj=totalResults(tLoop)
%>
				<tr class="total-results"><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("mandatoryCorrect")%></td><td><%=round(round(tObj("average"),2))%></td><td><%=tObj("weeksPlayed")%></td><td><%=tObj("lastWeekPlayed")%></td><!--<td><%=tObj("total")%></td><td><%=round(tObj("average"),2)%></td>--></tr>
<%
	next
%>
                <tr><td colspan="5"><a class="show-all">... show all</a></td></tr>
			</table>
		</td>
	</tr></table></td></tr>
	<tr><td colspan="2" class="old-results"><font size="+1"><b>2011 Results</b></font><div style="float:right"><font size="+1"><b><a href="rg11.asp">2011-12 Bowl Results</a></b></font></div></td></tr>
	<tr><td colspan="2">
	<table width="100%"><tr>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr>
					<td valign="top">1</td>
					<td valign="top">1.&nbsp;Maltbie<br>2. Strawn, J</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=1">Results</a></td>
				</tr>
				<tr>
					<td valign="top">2</td>
					<td valign="top">1.&nbsp;Tierney<br>2. Darling</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=2">Results</a></td>
				</tr>
				<tr>
					<td valign="top">3</td>
					<td valign="top">1.&nbsp;Teater<br>2. Clark</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=3">Results</a></td>
				</tr>
				<tr>
					<td valign="top">4</td>
					<td valign="top">1.&nbsp;Domenico<br>2. Blach, Gib, Tamasi</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=4">Results</a></td>
				</tr>
				<tr>
					<td valign="top">5</td>
					<td valign="top">1.&nbsp;Tamasi<br>2. Lewinson</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=5">Results</a></td>
				</tr>
				<tr>
					<td valign="top">6</td>
					<td valign="top">1.&nbsp;Tierney<br>2. Gibby</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=6">Results</a></td>
				</tr>
				<tr>
					<td valign="top">7</td>
					<td valign="top">1.&nbsp;Crowe<br>2. Tierney, Maltbie</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=7">Results</a></td>
				</tr>
			</table>
		</td>
		<td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr>
					<td valign="top">8</td>
					<td valign="top">1.&nbsp;Gibby<br>2. Eddie, Newcomb</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=8">Results</a></td>
				</tr>
				<tr>
					<td valign="top">9</td>
					<td valign="top">1.&nbsp;Mallot<br />2. Darling</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=9">Results</a></td>
				</tr>
				<tr>
					<td valign="top">10</td>
					<td valign="top">1.&nbsp;Domenico<br />2. Rhoden</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=10">Results</a></td>
				</tr>
				<tr>
					<td valign="top">11</td>
					<td valign="top">1.&nbsp;Tamasi<br />2. Becker, Dempsey</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=11">Results</a></td>
				</tr>
				<tr>
					<td valign="top">12</td>
					<td valign="top">1.&nbsp;Strawn<br />2. Maltbie</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=12">Results</a></td>
				</tr>
				<tr>
					<td valign="top">13</td>
					<td valign="top">1. Darling&nbsp;<br />2. Maltbie</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=13">Results</a></td>
				</tr>
				<tr>
					<td valign="top">14</td>
					<td valign="top">1. Clark&nbsp;<br />2. Rhoden</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2011.asp?w=14">Results</a></td>
				</tr>
			</table>
		</td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Mandatory<br>Correct</th><th>Average<br>Score</th><th>Weeks<br>Played</th><!--<th>Total<br>Cleared</th><th>Average<br>Cleared</th>--></tr>
<%
	
	totalResults=qryTotals("2011")
	for tLoop=0 to ubound(totalResults) - 1
		set tObj=totalResults(tLoop)
%>
				<tr class="total-results"><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("mandatoryCorrect")%></td><td><%=round(round(tObj("average"),2)+200)%></td><td><%=tObj("weeksPlayed")%></td><!--<td><%=tObj("total")%></td><td><%=round(tObj("average"),2)%></td>--></tr>
<%
	next
%>
                <tr><td colspan="5"><a class="show-all">... show all</a></td></tr>
			</table>
		</td>
	</tr></table></td></tr>
	<tr><td colspan="2" class="old-results"><font size="+1"><b>2010 Results</b></font><div style="float:right"><font size="+1"><b><a href="rg10.asp">2010-11 Bowl Results</a></b></font></div></td></tr>
	
	<tr><td colspan="2"><table width="100%"><tr>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr>
					<td valign="top">1</td>
					<td valign="top">1.&nbsp;Greene<br>&nbsp;&nbsp;Pederson</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2010.asp?w=1">Results</a></td>
				</tr>
				<tr>
					<td valign="top">2</td>
					<td valign="top">1.&nbsp;Clark<br>&nbsp;Pederson<br>&nbsp;T Dreiling</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2010.asp?w=2">Results</a></td>
				</tr>
				<tr>
					<td valign="top">3</td>
					<td valign="top">1.&nbsp;Tierney<br>2.&nbsp;Windham</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2010.asp?w=3">Results</a></td>
				</tr>
				<tr>
					<td valign="top">4</td>
					<td valign="top">1.&nbsp;Darling<br>2.&nbsp;Clark</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2010.asp?w=4">Results</a></td>
				</tr>
				<tr>
					<td valign="top">5</td>
					<td valign="top">1.&nbsp;Florie<br>2.&nbsp;Bogart</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2010.asp?w=5">Results</a></td>
				</tr>
				<tr>
					<td valign="top">6</td>
					<td valign="top">1.&nbsp;Bogart<br>2.&nbsp;Rhoden</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2010.asp?w=6">Results</a></td>
				</tr>
			</table>
		</td>
		<td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr>
					<td valign="top">7</td>
					<td valign="top">1.&nbsp;Newcombe<br>2.&nbsp;Dempsey</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2010.asp?w=7">Results</a></td>
				</tr>
				<tr>
					<td valign="top">8</td>
					<td valign="top">1.&nbsp;Tierney<br>2.&nbsp;Bliss</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2010.asp?w=8">Results</a></td>
				</tr>
				<tr>
					<td valign="top">9</td>
					<td valign="top">1.&nbsp;Windham<br>2.&nbsp;Rhoden</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2010.asp?w=9">Results</a></td>
				</tr>
				<tr>
					<td valign="top">10</td>
					<td valign="top">1.&nbsp;Tierney<br>2.&nbsp;Dempsey</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2010.asp?w=10">Results</a></td>
				</tr>
				<tr>
					<td valign="top">11</td>
					<td valign="top">1.&nbsp;Tierney<br>2.&nbsp;Dreiling</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2010.asp?w=11">Results</a></td>
				</tr>
				<tr>
					<td valign="top">12</td>
					<td valign="top">1.&nbsp;Dempsey<br>2.&nbsp;Brockhoff</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2010.asp?w=12">Results</a></td>
				</tr>
				<tr>
					<td valign="top">13</td>
					<td valign="top">1.&nbsp;Rhoden<br>2.&nbsp;Pederson</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2010.asp?w=13">Results</a></td>
				</tr>
			</table>
		</td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Mandatory<br>Correct</th><th>Average<br>Score</th><th>Weeks<br>Played</th><!--<th>Total<br>Cleared</th><th>Average<br>Cleared</th>--></tr>
<%
	
	totalResults=qryTotals("2010")
	for tLoop=0 to ubound(totalResults) - 1
		set tObj=totalResults(tLoop)
%>
				<tr class="total-results"><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("mandatoryCorrect")%></td><td><%=round(round(tObj("average"),2)+200)%></td><td><%=tObj("weeksPlayed")%></td><!--<td><%=tObj("total")%></td><td><%=round(tObj("average"),2)%></td>--></tr>
<%
	next
%>
                <tr><td colspan="5"><a class="show-all">... show all</a></td></tr>
			</table>
		</td>
	</tr></table></td></tr>
	<tr><td colspan="2" class="old-results"><font size="+1"><b>2009 Results</b></font><div style="float:right"><font size="+1"><b><a href="rg10.asp">2009-10 Bowl Results</a></b></font></div></td></tr>
	<tr><td colspan="2"><table width="100%"><tr>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr>
					<td valign="top">1</td>
					<td valign="top">1. Greene<br>2. Tierney</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2009.asp?w=1">Results</a></td>
				</tr>
				<tr>
					<td valign="top">2</td>
					<td valign="top">1. Barnett<br>2. Berard</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2009.asp?w=2">Results</a></td>
				</tr>
				<tr>
					<td valign="top">3</td>
					<td valign="top">1. Mallot<br>&nbsp;&nbsp;&nbsp;&nbsp;Florie</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2009.asp?w=3">Results</a></td>
				</tr>
				<tr>
					<td valign="top">4</td>
					<td valign="top">1. Berard<br>2. Greene</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2009.asp?w=4">Results</a></td>
				</tr>
				<tr>
					<td valign="top">5</td>
					<td valign="top">1. Brockhoff<br>&nbsp;&nbsp;&nbsp;Bob Strawn</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2009.asp?w=5">Results</a></td>
				</tr>
				<tr>
					<td valign="top">6</td>
					<td valign="top">1. Tierney<br>2. Maltbie</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2009.asp?w=6">Results</a></td>
				</tr>
			</table>
		</td>
		<td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr>
					<td valign="top">7</td>
					<td valign="top">1. Rhoden<br>2. Becker/Tierney</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2009.asp?w=7">Results</a></td>
				</tr>
				<tr>
					<td valign="top">8</td>
					<td valign="top">1. Barnett<br>2. Blachly/Darling</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2009.asp?w=8">Results</a></td>
				</tr>
				<tr>
					<td valign="top">9</td>
					<td valign="top">1. Berard<br>2. Barnett/StrawnJ</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2009.asp?w=9">Results</a></td>
				</tr>
				<tr>
					<td valign="top">10</td>
					<td valign="top">1. Berard<br>2. Becker</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2009.asp?w=10">Results</a></td>
				</tr>
				<tr>
					<td valign="top">11</td>
					<td valign="top">1. Hisey<br>2. Dempsey</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2009.asp?w=11">Results</a></td>
				</tr>
				<tr>
					<td valign="top">12</td>
					<td valign="top">1. Blachly<br>2. Bogart</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2009.asp?w=12">Results</a></td>
				</tr>
			</table>
		</td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Total</th><th>Weeks</th><th>Average</th></tr>
<%
	
	totalResults=qryTotals("2009")
	for tLoop=0 to ubound(totalResults) - 1
		set tObj=totalResults(tLoop)
%>
				<tr class="total-results"><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("total")%></td><td><%=tObj("weeksPlayed")%></td><td><%=round(tObj("average") + 200)%></td></tr>
<%
	next
%>
                <tr><td colspan="5"><a class="show-all">... show all</a></td></tr>
			</table>
		</td>
	</tr></table></td></tr>
	<tr><td colspan="2" class="old-results"><font size="+1"><b>2007 Results</b></font><div style="float:right"><font size="+1"><b><a href="rg07.asp">2007-08 Bowl Results</a></b></font></div></td></tr>
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
			</table>
		</td>
	  <td width="33%" align=center valign="top">
			<table border="1" cellpadding="3" cellspacing="0" class="results">
				<tr><th width="40">Week</th><th width="98">Winners</th><th width="44">View</th></tr>
				<tr>
					<td valign="top">8</td>
					<td valign="top">1. Darling<br>2. Mallot</td>
			  	 	<td align="center" valign="top"><a href="results_grid_2007_8.asp">Results</a></td>
				</tr>
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
				</table>
		</td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Total</th><th>Weeks</th><th>Average</th></tr>
<%
	totalResults=qryTotals("2007")
	for tLoop=0 to ubound(totalResults) - 1
		set tObj=totalResults(tLoop)
%>
				<tr class="total-results"><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("total")%></td><td><%=tObj("weeksPlayed")%></td><td><%=round(tObj("average")+200)%></td></tr>
<%
	next
%>
                <tr><td colspan="5"><a class="show-all">... show all</a></td></tr>
			</table>
		</td>
	</tr></table></td></tr>
	<tr><td colspan="2" class="old-results"><font size="+1"><b>2006 Results</b></font><div style="float:right"><font size="+1"><b><a href="rg06.asp">2006-07 Bowl Results</a></b></font></div></td></tr>
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
      </table></td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Total</th><th>Weeks</th><th>Average</th></tr>
<%
	totalResults=qryTotals("2006")
	for tLoop=0 to ubound(totalResults) - 1
		set tObj=totalResults(tLoop)
%>
				<tr class="total-results"><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("total")%></td><td><%=tObj("weeksPlayed")%></td><td><%=round(tObj("average")+200)%></td></tr>
<%
	next
%>
                <tr><td colspan="5"><a class="show-all">... show all</a></td></tr>
			</table>
		</td>
	  
	</tr></table></td></tr>
	
	
	<tr><td colspan="2" class="old-results"><font size="+1"><b>2005 Results</b></font><div style="float:right"><font size="+1"><b><a href="results_grid_2005_14.asp">2005-06 Bowl Results</a></b></font></div></td></tr>
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
			    
		</table>		</td>
		<td>
			<table border="1" cellpadding="3" cellspacing="0" class="results"><tr><th>Name</th><th>Total</th><th>Weeks</th><th>Average</th></tr>
<%
	totalResults=qryTotals("2005")
	for tLoop=0 to ubound(totalResults) - 1
		set tObj=totalResults(tLoop)
%>
				<tr class="total-results"><td style="white-space:nowrap"><%=tObj("lname")%>, <%=left(tObj("fname"),1)%></td><td><%=tObj("total")%></td><td><%=tObj("weeksPlayed")%></td><td><%=round(tObj("average")+200)%></td></tr>
<%
	next
%>
                <tr><td colspan="5"><a class="show-all">... show all</a></td></tr>
			</table>
		</td></tr></table></td>
	</tr>
</table>
<script language="javascript" type="text/javascript">
    $(document).ready(function() {
        $('table.results').each(function() {
            $(this).find('.total-results').each(function(i) {
                if (i > 14) { $(this).hide() }
            });
        });
        $('a.show-all').click(function() {
            $(this).closest('table.results').find('.total-results').each(function(i) {
                if (i > 14) { $(this).show() }
            });
            $(this).closest('tr').remove();
        });
        $('td.old-results').each(function() {
            var $this = $(this), $results = $this.closest('tr').next(), $control = $this.find('b').first();
            $results.hide();
            $control.css('cursor', 'pointer');
            $control.append('<span class="show-hide">+</span>')
                .click(function() {
                    $results.toggle();
                    var $showHide = $control.find('span.show-hide');
                    if ($showHide.text() == '+') $showHide.text('-')
                    else $showHide.text('+')
                });

        });

    });
</script>
</body>
</html>
