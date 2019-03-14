<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	String connectionURL = "jdbc:sqlserver://121.179.212.213:1433;databaseName=sqlmaster;user=sqlmaster;password=rkdqkr2)!7";
	Connection con = DriverManager.getConnection(connectionURL);

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String suserid = request.getParameter("userid");
	String spasswd = request.getParameter("passwd");
	
	String SQL = "select usernm from members where userid = ? and passwd = ?";
	pstmt = con.prepareStatement(SQL);
	
	pstmt.setString(1, suserid);
	pstmt.setString(2, spasswd);
	
	rs = pstmt.executeQuery();
	
	
	
	if(rs.next() == true)
	{
		session.setAttribute("G_MEMID", suserid);
		session.setAttribute("G_MEMNM", rs.getString("usernm"));
		if(suserid.equals("admin"))
		{
			session.setAttribute("G_ADMIN", "A");
		}
		
		else
		{
			session.setAttribute("G_ADMIN", "U");
		}
		session.setMaxInactiveInterval(60 * 60);
		
		response.sendRedirect("index.jsp");
		
	}
	
	else
	{
		out.println("<script language=javascript>");
		out.println("alert('로그인에 실패 하였습니다.');");
		out.println("</script>");
		
		response.sendRedirect("mem_login.jsp");
	}
	
	pstmt.close();
	rs.close();
	con.close();
	
%>
