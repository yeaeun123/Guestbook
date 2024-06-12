<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
   String noStr = request.getParameter("no");
	System.out.println(noStr);
   int no = Integer.parseInt(noStr);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>방명록</title>
</head>
<body>
	<form method="post" action="delete.jsp?no=<%= request.getParameter("no") %>">
	<input type='hidden' name="id" value="">
	<table>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="password"></td>
			<td><input type="submit" value="확인"></td>
			<td><a href="<%= request.getContextPath() %>">메인으로 돌아가기</a></td>
		</tr>
	</table>
	</form>
</body>
</html>