<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	dim cn, rs, cd
	dim wk, yr, gm, vis, ho, fav, line, winner
	dim iLoop
	
	uid=request.QueryString("uid")
	if uid<>"00027" and uid<>"00060" and uid<>"00077" then response.redirect("home.asp")

	wk = request.QueryString("w")
	yr = 2017

	If request.form("edit") = "y" then
		UpdateGame
	End If
	
	RetrieveGames
	
	Sub UpdateGame
		dim game, winner
		Connect
		cd.CommandText = "Update pkmGames Set Winner = '" & request.form("winner") & "' Where Year = '" & yr & "' AND Week = " & wk & " AND Game = " & request.Form("game")
		cd.Execute
		Disconnect
		if request.QueryString("rg")=1 then response.Redirect("results_grid_2009.asp?u=1&w="&wk)
	End Sub
	
	Sub RetrieveGames
		dim i
		Connect
		rs.Open "Select * From pkmGames Where Week = " & wk & " AND Year = '" & yr & "' Order By Game ASC"
		if rs.recordcount > 0 then
			redim gm(rs.recordcount)
			redim vis(rs.recordcount)
			redim ho(rs.recordcount)
			redim fav(rs.recordcount)
			redim line(rs.recordcount)
			redim winner(rs.recordcount)
			for i = 0 to ubound(gm) - 1
				gm(i) = rs.fields("Game").value
				vis(i) = rs.fields("Vis").value
				ho(i) = rs.fields("Ho").value
				fav(i) = rs.fields("Fav").value
				line(i) = rs.fields("Line").value
				winner(i) = rs.fields("Winner").value
				rs.movenext		
			next
		else
			redim gm(0)
			redim vis(0)
			redim ho(0)
			redim fav(0)
			redim line(0)
			redim winner(0)
		end if
		rs.close
		disconnect		
	End Sub
	
	Sub Connect
		Dim CS
		CS = "Driver={SQL Native Client}; Data Source=sldb.igtm.com;Initial Catalog=spocom;Uid=m.rhoden;Pwd=firehitsites"
		CS = "Driver={SQL Server};Server=P3NWPLSK12SQL23;Database=spocom;Uid=strawnj5;Pwd=pick3MMM5;"
		Set cn = Server.CreateObject("ADODB.Connection")
		cn.Open CS
		
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.LockType = 1
		rs.CursorType = 0
		rs.CursorLocation = 3
		rs.ActiveConnection = cn
		
		Set cd = Server.CreateObject("ADODB.Command")
		cd.ActiveConnection = cn
		cd.Commandtype = 1
	End Sub
	
	Sub Disconnect
		Set rs.ActiveConnection = Nothing
		Set rs = Nothing
		Set cd.ActiveConnection = Nothing
		Set cd = Nothing
		cn.Close
		Set cn = Nothing
	End Sub
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<table border="1" cellpadding="3" cellspacing="0" align="center">
	<tr>
		<th>Game</th>
		<th>Visitor</th>
		<th>Home</th>
		<th>Winner</th>
		<th>Update</th>
	</tr>
<%
	for iLoop = 0 to ubound(gm) - 1
'				gm(i) = rs.fields(1).value
'				vis(i) = rs.fields(2).value
'				ho(i) = rs.fields(4).value
'				fav(i) = rs.fields(6).value
'				line(i) = rs.fields(7).value
'				winner(i) = rs.fields(8).value				
%>
	<form action="updategames.asp?w=<%=request.QueryString("w")%>&uid=<%=request.QueryString("uid")%>" method="post" name="frm<%=iLoop%>">
	<input type="hidden" name="edit" value="y" />
	<tr>
		<td><input type="text" name="game" value="<%=gm(iLoop)%>" readonly="true" size="2" /></td>
		<td><input type="text" name="vis" value="<%=vis(iLoop)%>" readonly="true" size="4" />
<%
	If fav(iLoop) = 0 Then
%>
		&nbsp;<font size="-1">(-<%=line(iLoop)%>)</font>
<%
	End If
%>		
		</td>
		<td><input type="text" name="ho" value="<%=ho(iLoop)%>" readonly="true" size="4" />
<%
	If fav(iLoop) = 1 Then
%>
		&nbsp;<font size="-1">(-<%=line(iLoop)%>)</font>
<%
	End If
%>		
		</td>
		<!--<td><input type="text" name="winner" value="<%=winner(iLoop)%>" size="4" /></td>-->
		<td><select name="winner" value="<%=winner(iLoop)%>"/>
			<option value="0" <%if winner(iLoop) = "" then%>selected="selected"<%end if%>>???</option>
			<option value="<%=vis(iLoop)%>" <%if winner(iLoop) = vis(iLoop) then%>selected="selected"<%end if%>><%=vis(iLoop)%></option>
			<option value="<%=ho(iLoop)%>" <%if winner(iLoop) = ho(iLoop) then%>selected="selected"<%end if%>><%=ho(iLoop)%></option>
		</select></td>
		<td><input type="submit" value="Update" /></td>
	</form>
<%
	next
%>
</table>	
</body>
</html>
