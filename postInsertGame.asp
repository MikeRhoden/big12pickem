<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	sub connect
		Dim CS
		CS=application("gtmspocom_dbCS")
		Set cn=Server.CreateObject("ADODB.Connection")
		cn.cursorlocation=3
		cn.Open CS
				
		Set psWeb=Server.CreateObject("ADODB.Command")
		psWeb.ActiveConnection=cn
		psWeb.CommandType=1
		psWeb.CommandTimeout=30
		psWeb.Prepared=True
	end sub
	Private Function execPreparedStatement(sql,params)
		dim i
		psWeb.CommandText=sql
		psWeb.parameters.refresh
		for i=0 to ubound(params)-1
			psWeb.parameters(i).value=params(i)
		next
		set execPreparedStatement=psWeb.execute
	End Function
	sub insertGame(w,g,v,vFull,h,hFull,f,l,y)
		dim sql,params(9)
		patams(0)=w
		patams(1)=g
		patams(2)=v
		patams(3)=vFull
		patams(4)=h
		patams(5)=hFull
		patams(6)=f
		patams(7)=l
		patams(8)=y
		sql="INSERT INTO [gtmspocom_db].[dbo].[pkmGames] ([Week],[Game],[Vis],[Visitor],[Ho],[Home],[Fav],[Line],[Year}) VALUES (?,?,?,?,?,?,?,?,?)"
		execPreparedStatement(sql,params)
	end sub
	sub editGame(w,g,v,vFull,h,hFull,f,l,y)
		dim sql,params(9)
		patams(0)=v
		patams(1)=vFull
		patams(2)=h
		patams(3)=hFull
		patams(4)=f
		patams(5)=l
		patams(6)=w
		patams(7)=g
		patams(8)=y
		sql="UPDATE [gtmspocom_db].[dbo].[pkmGames] SET [Vis] = ?,[Visitor] = ?,[Ho] = ?,[Home] = ?,[Fav] = ?,[Line] = ? WHERE Week=? AND Game=? AND Year=?"
		execPreparedStatement(sql,params)
	end sub
%>			
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Games Inserted</title>
</head>

<body>
</body>
</html>
