<%@page import="GuestBookDao.GuestBookOracleImpl"%>
<%@page import="GuestBookDao.GuestVo"%>
<%@page import="GuestBookDao.GuestbookDao"%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>



<%
String password = request.getParameter("password");

ServletContext servletContext = getServletContext();
String dbuser = servletContext.getInitParameter("dbuser");
String dbpass = servletContext.getInitParameter("dbpass");

GuestbookDao dao = new GuestBookOracleImpl(dbuser, dbpass);
Long no = null;
no = Long.parseLong((String) request.getAttribute("no"));
GuestVo vo = dao.get(no);

if (password.equals(vo.getPassword())) {
	boolean success = dao.delete(vo);
	response.sendRedirect(request.getContextPath());
} else {
	
	%>
	<h1>비밀번호가 일치하지 않습니다.</h1>
	<a href="<%= request.getContextPath() %>">메인으로 돌아가기</a>
<%
}
%>