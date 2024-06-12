﻿<%@page import="java.util.List"%>
<%@page import="GuestBookDao.GuestbookDao"%>
<%@page import="GuestBookDao.GuestBookOracleImpl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="GuestBookDao.GuestVo"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>방명록</title>
</head>
<body>
	<form action="add.jsp" method="post">
	<table border=1 width=500>
		<tr>
			<td>이름</td><td><input type="text" name="name"></td>
			<td>비밀번호</td><td><input type="password" name="pass"></td>
		</tr>
		<tr>
			<td colspan=4><textarea name="content" cols=60 rows=5></textarea></td>
		</tr>
		<tr>
			<td colspan=4 align=right><input type="submit" VALUE=" 확인 "></td>
		</tr>
	</table>
	</form>
	<br/>
	
		<table width=510 border=1>
		<tr>
			<td>[1]</td>
			<td>홍길동</td>
			<td>2018-01-15</td>
			<td><a href="delete.jsp">삭제</a></td>
		</tr>
		<tr>
			<td colspan=4>안녕하세요<br/>첫번째글입니다.</td>
		</tr>
	</table>
        <br/>
	<table width=510 border=1>
		<tr>
			<td>[1]</td>
			<td>장실산</td>
			<td>2018-01-15</td>
			<td><a href="delete.jsp">삭제</a></td>
		</tr>
		<tr>
			<td colspan=4>안녕하세요<br/>두번째글입니다.</td>
		</tr>
	</table>
        <br/>
        <%
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String content = request.getParameter("content");


ServletContext servletContext = getServletContext();
String dbuser = servletContext.getInitParameter("dbuser");
String dbpass = servletContext.getInitParameter("dbpass");

GuestbookDao dao = new GuestBookOracleImpl(dbuser, dbpass);
List<GuestVo> lst = dao.getList();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");

for (GuestVo node: lst) {
%>
	<table width=510 border=1>
		<tr>
			<td><%= node.getNo() %></td>
			<td><%= node.getName() %></td>
			<td>생성일시: <%= sdf.format(node.getDate()) %></td>
			<td><a href="deleteform.jsp?no=<%=node.getNo() %>">삭제</a></td>
		</tr>
		<tr>
			<td colspan=4><%= node.getContent() %></td>
		</tr>
	</table>
        <br/>
<%
}
%>
 
</body>
</html>