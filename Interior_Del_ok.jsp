<%@ page language="java" import="java.util.*" import ="java.io.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "dbinfo.inc" %>
<% 
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try
	{
		
		int PostCode = Integer.parseInt(request.getParameter("pPostCode"));
		String SQL = "SELECT upfile1, upfile2 FROM Interior WHERE PostCode = ?";
		pstmt = con.prepareStatement(SQL);
		pstmt.setInt(1, PostCode);
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
		
		SQL = "DELETE FROM Interior WHERE PostCode = ?";
		
		pstmt = con.prepareStatement(SQL);
		
		pstmt.setInt(1, PostCode);
		
		pstmt.executeUpdate();
	}
	
	catch(SQLException e1)
	{
		out.println(e1.getMessage());
	}
	
	catch(Exception e2)
	{
		e2.printStackTrace();
	}
	
	finally
	{
		if(pstmt != null)
		{
			pstmt.close();
		}
		
		if(con != null)
		{
			con.close();
		}
		
		response.sendRedirect("Interior_List.jsp");
	}
%>