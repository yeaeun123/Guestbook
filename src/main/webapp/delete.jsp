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
 /*
 String noStr = request.getParameter("no");
	System.out.println(noStr);
   int no = Integer.parseInt(noStr);
   */
%>



<%
String password = request.getParameter("password");

ServletContext servletContext = getServletContext();
String dbuser = servletContext.getInitParameter("dbuser");
String dbpass = servletContext.getInitParameter("dbpass");

GuestbookDao dao = new GuestBookOracleImpl(dbuser, dbpass);

Long no = Long.parseLong(request.getParameter("no"));
GuestVo vo = dao.get(no);

if (password.equals(vo.getPassword())) {
	dao.delete(vo);
	response.sendRedirect(request.getContextPath());
} else {
	
	%>
	<h1>비밀번호가 일치하지 않습니다.</h1>
	<a href="<%= request.getContextPath() %>">메인으로 돌아가기</a>
	<%
}

/*
    if(request.getMethod().equalsIgnoreCase("POST")) {
        request.setCharacterEncoding("UTF-8"); // POST 요청 인코딩 설정
        String password = request.getParameter("password");
        out.println("입력한 비밀번호: " + password + "<br>");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String url = "jdbc:oracle:thin:@localhost:1522:xe";
        String user = "himedia"; 
        String passwordDB = "himedia"; 

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, passwordDB);
            String sql = "SELECT password FROM guestbook WHERE no=?";
            pstmt = conn.prepareStatement(sql);
            System.out.println("good?");
            pstmt.setInt(1, no);
            System.out.println("good!");
            rs = pstmt.executeQuery();

            if(rs.next()) {
                String dbPassword = rs.getString("password");
                out.println("데이터베이스에 저장된 비밀번호: " + dbPassword + "<br>");
                if (dbPassword != null && dbPassword.equals(password)) {
                    sql = "DELETE FROM guestbook WHERE no=?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, no);
                    pstmt.executeUpdate();
                    response.sendRedirect("index.jsp");
                } else {
                    out.println("비밀번호가 틀립니다.");
                }
            } else {
                out.println("해당 번호의 글이 없습니다.");
            }
        } catch(Exception e) {
            e.printStackTrace();
            out.println("오류가 발생했습니다: " + e.getMessage());
        } finally {
            if(rs != null) try { rs.close(); } catch(SQLException e) {}
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
            if(conn != null) try { conn.close(); } catch(SQLException e) {}
        }
    }
*/
%>

