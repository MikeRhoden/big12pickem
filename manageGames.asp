<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<style type="text/css">
input {margin:.1em}
</style>
<table border="1" cellpadding="3" cellspacing="0" align="center">
	<tr>
    	<th align="left">Game</th>
    	<th align="left">Visitor Info</th>
    	<th align="left">Home Info</th>
    	<th align="left">Line</th>
    	<th align="left">Edit</th>
	</tr>   
    <%
	dim gLoop 
	for gLoop=1 to 20
	%>
    <tr>
    	<td align="center"><%=gLoop%></td>
        <td align="center">
        	<table align="left" border="0" id="game" cellpadding="1">
            	<tr>
                	<td align="right"><input type="text" name="vFull<%=gLoop%>" size="20" maxlength="20" /><br />Abrv.<input type="text" size="4" maxlength="4" name="v<%=gLoop%>" /></td>
                    <td align="left">Fav<br /><input type="radio" value="0" name="f<%=gLoop%>" /></td>
				</tr>
            </table>
        </td>
        <td align="center">
        	<table align="left" border="0" id="game" cellpadding="1">
            	<tr>
                	<td align="right"><input type="text" name="hFull<%=gLoop%>" size="20" maxlength="20" /><br />Abrv.<input type="text" size="4" maxlength="4" name="h<%=gLoop%>" /></td>
                    <td align="left">Fav<br /><input type="radio" value="1" name="f<%=gLoop%>" /></td>
				</tr>
            </table>
        </td>
        <td align="center">
        	<input type="text" name="l<%=gLoop%>" size="2" maxlength="2" />
        </td>
        <td align="center">
        	<%if editable then%><input type="button" name="Edit" onclick="editGame(this.form,<%=gLoop%>" /><%end if%>
        </td>
	</tr>
    <%
	next
	%>
</table>
</body>
</html>
