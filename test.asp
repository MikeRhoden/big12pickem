<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
Function Bubble_Sort(arrShort)
	for i = UBound(arrShort) - 1 To 0 Step -1
			for j= 0 to i
					if arrShort(j)>arrShort(j+1) then
							temp=arrShort(j+1)
							arrShort(j+1)=arrShort(j)
							arrShort(j)=temp
					end if
			next
	next
	Bubble_Sort = arrShort
End Function
%>	
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<% Dim i, tmp, arr(20), newarr
		Randomize
		For i = 0 to 19
			tmp = Int((100 * Rnd) + 1)   ' Generate random value between 1 and total # of records.
			arr(i) = tmp
			Response.Write arr(i) & "<br>"
		Next
		Response.Write "<P>SORT</P><P>"
		newarr = Bubble_Sort(arr)
		For i = 0 to 19
			Response.Write newarr(i) & "<br>"
		Next
%>
</body>
</html>
