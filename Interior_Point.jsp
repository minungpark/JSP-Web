<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%


	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

	String connectionURL = "jdbc:sqlserver://121.179.212.213:1433;databaseName=sqlmaster;user=sqlmaster;password=rkdqkr2)!7";
	Connection con = java.sql.DriverManager.getConnection(connectionURL);


	PreparedStatement pstmt = null;
	ResultSet rs = null;
	boolean fnd = false;


		int PostCode = Integer.parseInt(request.getParameter("pPostCode"));
		int PageNum = Integer.parseInt(request.getParameter("PageNum"));
		String id = (String)session.getAttribute("G_MEMID");
	

		String SQL = "select userid from PointUser where PostCode = ?";
		
		pstmt = con.prepareStatement(SQL);
		
		pstmt.setInt(1, PostCode);
		
		rs = pstmt.executeQuery();
		
		
		while(rs.next())
		{	
			String user = rs.getString("userid");
			
			if(id.equals(user))
			{
				fnd = true;
				break;
			}
		}
			
		if(fnd == true)
		{
			pstmt.close();
			con.close();
			
			response.sendRedirect("Interior_View.jsp?pPostCode=" + PostCode + "&pPageNum=" + PageNum);
		}
			
		else
		{
	
			SQL = "UPDATE Interior SET PostPoint = PostPoint + 1 WHERE PostCode = ?";
			pstmt = con.prepareStatement(SQL);
					
	
			pstmt.setInt(1, PostCode);
							
	
			int cnt = pstmt.executeUpdate();
							
			SQL = "INSERT PointUser VALUES(?, ?)";
			pstmt = con.prepareStatement(SQL);
							
			pstmt.setInt(1, PostCode);
			pstmt.setString(2, id);
				
			pstmt.executeUpdate();
					
	
			pstmt.close();
			con.close();
							
			response.sendRedirect("Interior_View.jsp?pPostCode=" + PostCode + "&pPageNum=" + PageNum);
		}
		

%>