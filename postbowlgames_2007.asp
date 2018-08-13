<%@ language=vbscript %>
<!-- #include file="funcs.asp" --->
<%
	Dim cnPick, Picks(), Values(), Weights(), uid, num_games
	num_games = 32
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
			'fieldName = "weight" & i
			'Weights(i-1) = Request.Form(fieldName)
		Next
	End Sub

	uid = Request.QueryString("uid")
	
	If CheckTime = False Then
		Response.Write("<font color=red><center>Sorry but it's too late to make picks.</center></font><br>")
		Response.Write("<center><a href='bowl_Games_2006.asp?toolate=yes&uid=" & uid & "'>Back to Games of the Week</a></center>")
	Else
		Connect
		LoadPicks
		DeletePicks uid, 15, 2007
		InsertPicks uid, Picks, Values, 15, 2007
		'WritePicks
		Disconnect
		Response.Redirect("bowl_Games_2007.asp?uid=" & uid)
	End If
%>