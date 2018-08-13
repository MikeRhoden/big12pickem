<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="funcs.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
CONST constYear="2018"
dim week,i
sub writeGameForInput(gm)
	dim rs,sql,params(2),vis,visitor,ho,home,fav,line,notes,priority
	params(0)=week
	params(1)=gm
	sql="SELECT [Vis],[Visitor],[Ho],[Home],[Fav],[Line],[Note],[dtiKickOff],[Priority] FROM [dbo].[pkmGames] where year='"&constYear&"' and week=? and game=?"
	vis="":visitor="":ho="":home="":fav=0:line=0:notes="":set kickoff=getBlankKickOff(): priority=""
	set rs=execPreparedStatement(sql,params)
	if not rs.eof then
		vis=rs("vis").value
		visitor=rs("visitor").value
		ho=rs("ho").value
		home=rs("home").value
		fav=rs("fav").value
		line=rs("line").value
		notes=rs("Note").value
		set kickoff=getKickOffObjFromVal(nz(rs("dtiKickoff").value,""))
		priority=rs("Priority").value
	end if
	%>
	<tr>
		<td><%=gm%></td>
		<td><input type="text" name="vis<%=gm%>" value="<%=vis%>" size="5" /></td>
		<td><input type="text" name="visitor<%=gm%>" value="<%=visitor%>" size="25"  /></td>
		<td><input type="text" name="ho<%=gm%>" value="<%=ho%>" size="5" /></td>
		<td><input type="text" name="home<%=gm%>" value="<%=home%>" size="25"  /></td>
		<td><input type="radio" name="fav<%=gm%>" value="0" <%if fav=0 then%> checked="checked"<%end if%> />vis<br /><input type="radio" name="fav<%=gm%>" value="1" <%if fav=1 then%> checked="checked"<%end if%> />ho</td>
		<td><input type="text" name="line<%=gm%>" value="<%=line%>"  size="4" /></td>
		<td><input type="text" name="notes<%=gm%>" value="<%=notes%>" size="30" /></td>
		<td><input name="kickoffdate<%=gm%>" type="text" size="15" value="<%=kickoff("date")%>" readonly><a href="javascript:show_calendar('entergames.kickoffdate<%=gm%>');" onMouseOver="window.status='Date Picker'; overlib('Click here to choose a date from a one month pop-up calendar.'); return true;" onMouseOut="window.status=''; nd(); return true;"><img src="../util/images/calendar.gif" width=20 height=15 border=0></a></td>
		<td><input type="text" name="kickofftime<%=gm%>" value="<%=kickoff("time")%>" size="12" /></td>
		<td><input type="text" name="priority<%=gm%>" value="<%=priority%>" size="2" /></td>
	</tr>
	<%	
end sub
sub insertgame(gm)
	dim rs,sql,params(12),vis,visitor,ho,home,fav,line,notes,kickoff
	vis=request.Form("vis"&gm)
	visitor=request.Form("visitor"&gm)
	ho=request.Form("ho"&gm)
	home=request.Form("home"&gm)
	fav=request.Form("fav"&gm)
	line=request.Form("line"&gm)
	if request.Form("notes"&gm)="" then
		notes=NULL
	else
		notes=request.Form("notes"&gm)
	end if
	if request.Form("kickoffdate"&gm)<>"" and request.Form("kickofftime"&gm)<>"" then
		kickoff=request.Form("kickoffdate"&gm)&" "&request.Form("kickofftime"&gm)
	else
		kickoff=request.Form("kickoffdate0")&" "&request.Form("kickofftime0")
	end if
	priority = request.Form("priority"&gm)
	if vis<>"" and visitor<>"" and ho<>"" and home<>"" then
		sql="INSERT INTO [dbo].[pkmGames]([Week],[Game],[Vis],[Visitor],[Ho],[Home],[Fav],[Line],[Note],[dtiKickOff],[Year],[Priority]) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"
		params(0)=week
		params(1)=gm
		params(2)=vis
		params(3)=visitor
		params(4)=ho
		params(5)=home
		params(6)=fav
		params(7)=line
		params(8)=notes
		params(9)=kickoff
		params(10)=constYear
        if priority = "" then priority = "0"
		params(11)=priority
		execPreparedStatement sql,params	
	end if
end sub

sub deletegames
	dim sql,params(2)
	sql="delete from [dbo].[pkmGames] where year=? and week=?"
	params(0)=constYear
	params(1)=week
	execPreparedStatement sql,params	
end sub
sub entergames
	dim i
	deletegames
	for i=1 to 20
		insertgame i	
	next
end sub
function getKickOffObjFromVal(val)
	dim objRV,d,t,tmp
	if nz(val,"")<>"" then
		set objRV=server.CreateObject("scripting.dictionary")
		tmp=split(val)
		d=tmp(0)
		t=tmp(1)&" "&tmp(2)
		objRV.add "date",d
		objRV.add "time",t
		set getKickOffObjFromVal=objRV
	else
		set getKickOffObjFromVal=getBlankKickOff
	end if
end function
function getBlankKickOff()
	dim objRV
	set objRV=server.CreateObject("scripting.dictionary")
	objRV.add "date",""
	objRV.add "time",""
	set getBlankKickOff=objRV
end function

week=request.QueryString("w")

if week="" then
	%>enter the w parameter at the end of the querystring to proceed.<br /><br />url should be http://gtmsportswear.com/pickem/entergames.asp?w=!<br /><br />where ! is the week of games you are trying to enter<%
	response.End()
end if

connect
if request.QueryString("e")="1" then entergames
%>
<title>Enter Games For Week <%=week%></title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="overlib_mini.js"></script>
<script language="JavaScript" src="calendarfunctions.js"></script>
</head>
<body><div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<strong>GAMES FOR WEEK <%=WEEK%></strong>
<form name="entergames" action="entergames.asp?w=<%=week%>&e=1" method="post">
<table border="1">
	<tr><th colspan="10" align="center">
		<table align="center">
			<tr>
				<td align="center">default kick off time (deadline) for week (date/time): </td>
				<td><input name="kickoffdate0" type="text" size="15" readonly><a href="javascript:show_calendar('entergames.kickoffdate0');" onMouseOver="window.status='Date Picker'; overlib('Click here to choose a date from a one month pop-up calendar.'); return true;" onMouseOut="window.status=''; nd(); return true;"><img src="../util/images/calendar.gif" width=20 height=15 border=0></a></td>
				<td>/<input type="text" name="kickofftime0" size="12" /> (e.g. 6:30 PM or 11:00 AM)</td>
			</tr>
		</table>
	</th></tr>
	<tr>
		<th>game</th><th>vis</th><th>visitor</th><th>ho</th><th>home</th><th>fav</th><th>line</th><th>notes</th><th>ko date</th><th>ko time</th><th>priority</th>
	</tr>
	<%for i=1 to 20%><%writeGameForInput i%><%next%>
</table>
<input type="submit" value="update" />
</form>
</body>
</html>
