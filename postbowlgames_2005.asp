<%@ language=vbscript %>
<!-- #include file="funcs.asp" --->
<%
	Dim cnPick, Picks(25), Values(25), Weights(26), uid, num_games
	num_games = 25
%>
<%
	Private Sub LoadPicks()
		Dim i, fieldName
		For i = 1 to 25
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
		Response.Write("<center><a href='Games_2005.asp?toolate=yes&uid=" & uid & "'>Back to Games of the Week</a></center>")
	Else
		Connect
		LoadPicks
		DeletePicks uid, CInt(Request.Form("week"))
		InsertPicks uid, Picks, Values, CInt(Request.Form("week"))
		'WritePicks
		Disconnect
		Response.Redirect("bowl_Games_2005.asp?uid=" & uid)
	End If
%>