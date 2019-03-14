<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "dbinfo.inc" %>
<%
	String realFolder = "";
	String saveFolder = "/WebContent/upfile";
	String encType = "utf-8";
	
	int sizeLimit = 10 * 1024 * 1024;
	realFolder = application.getRealPath(saveFolder);
	MultipartRequest multi	= new MultipartRequest(request, realFolder, sizeLimit, encType);
	
	Statement stmt = null;
	
	int PostCode		= Integer.parseInt(multi.getParameter("pPostCode"));
	int PageNum		= Integer.parseInt(multi.getParameter("pPageNum"));
	/* String in_search_key = request.getParameter("search_key");
	String in_search_value = request.getParameter("search_value"); */
	
	try
	{
		
		String PostTitle		= multi.getParameter("title");
		String PostContents		= multi.getParameter("contents").replace("\r\n", "<br>");
		String fileName1	= multi.getFilesystemName("file1");
		String fileName2	= multi.getFilesystemName("file2");
	
		stmt = con.createStatement();
	
		Calendar dateIn = Calendar.getInstance();
		String indate = Integer.toString(dateIn.get(Calendar.YEAR))		+ "-";
		indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1)	+ "-";
		indate = indate + Integer.toString(dateIn.get(Calendar.DATE))		+ " ";
		indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY))	+ ":";
		indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE))		+ ":";
		indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));
	
		String SQL	= "UPDATE Interior SET ";
		SQL			=  SQL + "  PostTitle	= '" + PostTitle     + "'";
		SQL			=  SQL + ", PostContents	= '" + PostContents  + "'";
		SQL			=  SQL + ", PostDate	= '" + indate	 + "'";
	
		if (fileName1 != null) 
			SQL		=  SQL + ", upfile1 	= '" + fileName1 + "'";
		if (fileName2 != null) 
			SQL		=  SQL + ", upfile2 	= '" + fileName2 + "'";
	
		SQL			=  SQL + " WHERE PostCode	= " + PostCode;
		
		stmt.executeUpdate(SQL);
	
	} //try end
	
	catch(SQLException e1){
		out.println(e1.getMessage());
	} // catch SQLException end
	
	catch(Exception e2){
		e2.printStackTrace();
	} // catch Exception end
	
	finally{
		if (stmt  != null) stmt.close();
		if (con   != null) con.close();
		
		response.sendRedirect("Interior_View.jsp?pPostCode=" + PostCode + "&pPageNum=" + PageNum/*  + "&search_key=" + in_search_key + "&search_value=" + in_search_value */);
	}
%>