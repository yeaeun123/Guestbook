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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// Servlet으로부터 전달한 list 객체 얻어오기
List<GuestVo> list = null;
if (request.getAttribute("list") instanceof List) { // 전달 받은 list가 List인지 확인
	list = (List<GuestVo>)request.getAttribute("list");	// 다운 캐스팅
	
}


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>방명록</title>
</head>
<body>
	<form action="<%=request.getContextPath() %>/gb?a=insert" method="post">
	<table border=1 width=500>
		<tr>
			<td>이름</td> <td><input type="text" name="name"></td>
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
	
     
     <%
     for (GuestVo vo: list) {
     %>
	<table width=510 border=1>
		<tr>
			<td><%= vo.getNo() %></td>
			<td><%= vo.getName() %></td>
			<td>
				<form action="<%=request.getContextPath() %>/gb?a=delete" method="POST">
					<input type="hidden" name="no" value="<%= vo.getNo() %>" />
					<input type="submit" VALUE=" 삭제 ">	
				</form>
			</td>
			
		</tr>
		<tr>
			<td colspan=4><%= vo.getContent() %></td>
		</tr>
	</table>
        <br/>
<%
}
   
%>
 
</body>
</html>