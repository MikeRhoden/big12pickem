<%@ language=vbscript %>
<!-- #include file="funcs.asp" --->
<%
	Dim cnPick, Picks(), Values(), Weights(), uid, num_games, deadlines()
	connect
	num_games = 30
	redim deadlines(num_games)
	redim Picks(num_games)
	redim Values(num_games)
%>
<%
	Private Sub LoadPicks()
		Dim i, fieldName
		For i = 1 to num_games
			fieldName = "game_" & i
			Picks(i-1) = Request.Form(fieldName)
			fieldName = "val_" & i
			Values(i-1) = Request.Form(fieldName)
		Next
	End Sub
	
    sub setDeadlines()
	    dim rs,sql,params(1)
	    for i=1 to num_games
		    params(0)=i
		    sql="select dtiKickOff k from dbo.pkmGames where Year='2011' and Week=15 AND Game=?"
		    set rs=execPreparedStatement(sql,params)
		    if not rs.eof then deadlines(i-1)=nz(rs("k").value,"")
	    next	
    end sub

	uid = Request.QueryString("uid")
	
	If CheckTime = False Then
		Response.Write("<font color=red><center>Sorry but it's too late to make picks.</center></font><br>")
		Response.Write("<center><a href='bowl_Games_2011.asp?toolate=yes&uid=" & uid & "'>Back to Games of the Week</a></center>")
	Else
		Connect
		setDeadlines
		LoadPicks
		'DeletePicks uid, 15, 2011
		InsertPicksBowls uid, Picks, Values, 15, 2011,deadlines
		'WritePicks
		Disconnect
		Response.Redirect("bowl_Games_2011.asp?uid=" & uid)
	End If
%>