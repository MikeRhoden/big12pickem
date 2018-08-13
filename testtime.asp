<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="funcs.asp" --->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" src="overlib_mini.js"></script>
<script language="JavaScript" src="calendarfunctions.js"></script>
</head>

<body>
<% 

function getKickOff(gm)
	%><p>request.Form("kickoffdate<%=gm%>"): <%=request.Form("kickoffdate"&gm)%></p><%
	%><p>request.Form("kickoffdate<%=gm%>"): <%=request.Form("kickofftime"&gm)%></p><%
	getKickOff=request.Form("kickoffdate"&gm)&" "&request.Form("kickofftime"&gm)
end function
sub insertgame(gm)
	dim rs,sql,params(1),kickoff
	kickoff=request.Form("kickoffdate"&gm)&" "&request.Form("kickofftime"&gm)
	sql="INSERT INTO [mrhoden].[tblTest]([dtiTest]) VALUES(?)"
	params(0)=kickoff
	execPreparedStatement sql,params	
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
		set getKickOffObjFromVal=nothing
	end if
end function
function getKickOffObj(gm)
	dim rs,sql,params(1)
	params(0)=gm
	sql="select dtiTest from mrhoden.tblTest where pkTest=?"
	set rs=execPreparedStatement(sql,params)
	if not rs.eof then
		set getKickOffObj=getKickOffObjFromVal(rs("dtiTest").value)
	else
		set getKickOffObj=nothing
	end if
end function
gm=0
connect
set kickoff=getKickOffObj(4)
if request.QueryString("e")="1" then insertgame gm
%>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<form name="entergames" action="testtime.asp?e=1" method="post">
<table><tr>
		<td><input name="kickoffdate<%=gm%>" type="text" size="15" readonly value="<%=kickoff("date")%>"><a href="javascript:show_calendar('entergames.kickoffdate<%=gm%>');" onMouseOver="window.status='Date Picker'; overlib('Click here to choose a date from a one month pop-up calendar.'); return true;" onMouseOut="window.status=''; nd(); return true;"><img src="../util/images/calendar.gif" width=20 height=15 border=0></a></td>
		<td><input type="text" name="kickofftime<%=gm%>" value="<%=kickoff("time")%>" size="30" /></td>
</tr></table>
<input type="submit" />
</form>
</body>
</html>
