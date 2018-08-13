<%@ language=vbscript %>
<!-- #include file="funcs.asp" --->
<%
	Dim cnPick, Picks(), Values(), Weights(), uid, num_games
	connect
	num_games = 30
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

	uid = Request.QueryString("uid")
	
	If CheckTime = False Then
		Response.Write("<font color=red><center>Sorry but it's too late to make picks.</center></font><br>")
		Response.Write("<center><a href='bowl_Games_2010.asp?toolate=yes&uid=" & uid & "'>Back to Games of the Week</a></center>")
	Else
		Connect
		LoadPicks
		DeletePicks uid, 14, 2010
		InsertPicksBowls uid, Picks, Values, 14, 2010
		'WritePicks
		Disconnect
		Response.Redirect("bowl_Games_2010.asp?uid=" & uid)
	End If
%>