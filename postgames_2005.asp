<%@ language=vbscript %>
<!-- #include file="funcs.asp" --->
<%
Dim cnPick, Picks(20), Values(20), Deadlines(20), Weights(26), uid, num_games
CONST constYear=2017

Private Sub LoadPicks()
	Dim i, fieldName
	For i = 1 to 20
		fieldName = "game_" & i
		Picks(i-1) = Request.Form(fieldName)
		fieldName = "val_" & i
		Values(i-1) = Request.Form(fieldName)
		fieldName = "dl_" & i
		'fieldName = "weight" & i
		'Weights(i-1) = Request.Form(fieldName)
	Next
End Sub
sub setDeadlines()
	dim rs,sql,params(1)
	for i=1 to num_games
		params(0)=i
		sql="select dtiKickOff k from dbo.pkmGames where Year='"&constYear&"' and Week="&CInt(Request.Form("week"))&" AND Game=?"
		set rs=execPreparedStatement(sql,params)
		if not rs.eof then deadlines(i-1)=nz(rs("k").value,"")
	next	
end sub
connect
num_games = 20
uid = Request.QueryString("uid")
setDeadlines


Connect
LoadPicks
if uid="00189" then
%><p>uid: <%=uid%></p><%
%><p>Picks: <%=join(Picks,"<br>")%></p><%
%><p>Values: <%=join(Values,"<br>")%></p><%
%><p>week: <%=CInt(Request.Form("week"))%></p><%
%><p>constYear: <%=constYear%></p><%
%><p>Deadlines: <%=join(Deadlines,"<br>")%></p><%
end if

'DeletePicks uid, CInt(Request.Form("week")),constYear
InsertPicks uid, Picks, Values, CInt(Request.Form("week")), constYear, Deadlines
'WritePicks
Disconnect
Response.Redirect("games_"&constYear&".asp?uid=" & uid)
%>