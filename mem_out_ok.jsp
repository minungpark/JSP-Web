<%@ page language="java" import="java.util.*" import ="java.io.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%


		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

		String connectionURL = "jdbc:sqlserver://121.179.212.213:1433;databaseName=sqlmaster;user=sqlmaster;password=rkdqkr2)!7";
		Connection con = java.sql.DriverManager.getConnection(connectionURL);

		PreparedStatement pstmt = null;
		ResultSet rs = null;


		String suserid	= request.getParameter("userid");
		String susernm	= request.getParameter("usernm");
		

		String SQL = "SELECT upfile1, upfile2 FROM Interior WHERE PostWriter = ?";
		pstmt = con.prepareStatement(SQL);
		pstmt.setString(1, susernm);
		rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			String fileName1 = rs.getString("upfile1");
			String fileName2 = rs.getString("upfile2");
			
			String filePath = getServletContext().getRealPath("/upfile") + File.separator + fileName1;
			File f1 = new File(filePath);
			
			if(f1.exists())
			{
				new File(filePath).delete();
			}
			
			filePath = getServletContext().getRealPath("/upfile") + File.separator + fileName2;
			File f2 = new File(filePath);
			
			if(f2.exists())
			{
				new File(filePath).delete();
			}
		}
		
		SQL = "DELETE FROM Interior WHERE PostWriter = ?";
		
		pstmt = con.prepareStatement(SQL);
		
		pstmt.setString(1, susernm);
		
		pstmt.executeUpdate();
		
		
		SQL = " select PostCode from PointUser where ID = ?";
		
		pstmt = con.prepareStatement(SQL);
		
		pstmt.setString(1, suserid);
		
		rs = pstmt.executeQuery();		
		
		while(rs.next())
		{
			int postcode = rs.getInt("PostCode");
			
			SQL = " update Interior set PostPoint = PostPoint - 1 where PostCode = ?";
			
			pstmt = con.prepareStatement(SQL);
			
			pstmt.setInt(1, postcode);
			
			pstmt.executeUpdate();
		}
		
		
		SQL = " delete from PointUser where ID = ?";
		
		pstmt = con.prepareStatement(SQL);
		
		pstmt.setString(1, suserid);
		
		pstmt.executeUpdate();
		
		
		SQL = " delete from members";
		
		SQL = SQL + " where userid = ?";
		
		pstmt = con.prepareStatement(SQL);

		pstmt.setString(1, suserid);

		int cnt = pstmt.executeUpdate();

		pstmt.close();
		con.close();
		
		if(cnt > 0)
		{
			out.println("<script language=javascript>");
			out.println("alert('탈퇴가 완료 되었습니다.');");
			out.println("</script>");
			
			session.invalidate();
		}
		
		else
		{
			out.println("<script language=javascript>");
			out.println("alert('탈퇴를 하지 못 하였습니다.');");
			out.println("</script>");
		}
		
		response.sendRedirect("index.jsp");

%>
