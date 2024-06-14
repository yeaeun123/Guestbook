<%@page import="GuestBookDao.GuestVo"%>
<%@page import="GuestBookDao.GuestbookDao"%>
<%@page import="GuestBookDao.GuestBookOracleImpl"%>
<%@ page import = "java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>

<% 
String name = request.getParameter("name");
if (name.equals(""))
	name = "익명";
String pass = request.getParameter("pass");
String content = request.getParameter("content");


ServletContext servletContext = getServletContext();
String dbuser = servletContext.getInitParameter("dbuser");
String dbpass = servletContext.getInitParameter("dbpass");

GuestbookDao dao = new GuestBookOracleImpl(dbuser, dbpass);
GuestVo vo = new GuestVo(name, pass, content);

boolean success = dao.insert(vo);

if (success)
	response.sendRedirect(request.getContextPath());
else {
	%>
	<h1>Error</h1>
	<p>데이터 입력 중 오류가 발생했습니다</p>
	<%
}

	%>