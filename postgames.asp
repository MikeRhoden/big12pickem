<%@ language=vbscript %>
<!-- #include file="funcs.asp" --->
<%
	Dim cnPick, Picks(13), Weights(26), uid
%>
<%
	Private Sub LoadPicks()
		Dim i, fieldName
		For i = 1 to 13
			fieldName = "" & i
			Picks(i-1) = Request.Form(fieldName)
			'fieldName = "weight" & i
			'Weights(i-1) = Request.Form(fieldName)
		Next
	End Sub

	uid = Request.QueryString("uid")
	
	If CheckTime = False Then
		Response.Write("<font color=red><center>Sorry but it's too late to make picks.</center></font><br>")
		Response.Write("<center><a href='games_2014.asp?toolate=yes&uid=" & uid & "'>Back to Games of the Week</a></center>")
	Else
		Connect
		LoadPicks
		DeletePicks uid
		InsertPicks uid, Picks
		WritePicks
		Disconnect
		Response.Redirect("games_2014.asp?uid=" & uid)
	End If
%>