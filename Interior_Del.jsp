<%@ page language="java" import="java.util.*" import ="java.io.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>인테리어 삭제</title>
<link href="./includes/all.css" rel="stylesheet" type="text/css" />
</head>

<script language=javascript>

function submit_delete()
{
	document.frm1.action = "Interior_Del_ok.jsp"
	document.frm1.submit();
}

function submit_list()
{
	document.frm1.action = "Interior_List.jsp"
	document.frm1.submit();
}

</script>

<%@ include file = "dbinfo.inc" %>

<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try
	{
		int PostCode = Integer.parseInt(request.getParameter("pPostCode"));
		
		String SQL = "SELECT PostCode, PostTitle, PostContents, PostWriter, upfile1, upfile2 " +
					 "FROM Interior WHERE PostCode = ?";
		
		pstmt = con.prepareStatement(SQL);
		
		pstmt.setInt(1, PostCode);
		
		rs = pstmt.executeQuery();
		
		if(rs.next() == false)
		{
			out.print("등록된 공지가 없습니다.");
		}
		
		else
		{
			String PostWriter = rs.getString("PostWriter");
			String PostTitle = rs.getString("PostTitle");
			String PostContents = rs.getString("PostContents");
			String upfile1 = rs.getString("upfile1");
			String upfile2 = rs.getString("upfile2");
			String ext1 = null;
			if(upfile1 != null)
			{
				ext1 = upfile1.substring(upfile1.indexOf(".") + 1);
			}
			
			String ext2 = null;
			if(upfile2 != null)
			{
				ext2 = upfile2.substring(upfile2.indexOf(".") + 1);
			}
%>
<body>
<form name = "frm1" method = "post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="./includes/top.inc" %>
     		 <tr>
       			 <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
         	 <tr>
           		 <td width="547" height="45" align="center" class="new_tit">게시물 삭제</td>
          	 </tr>
		 	 <tr>
           		 <td align="center">
							<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
								<tr bgcolor = "cccccc">
									<td width = "10%" align = "left" bgcolor="#EEEEEE">번호</td>
									<td width = "90%" align = "left" bgcolor="#FFFFFF"><%= PostCode %></td>
									<input type = "hidden" name = "pPostCode" value ="<%= PostCode %>">
								</tr>
								<tr>
									<td width = "10%" align = "left" bgcolor="#EEEEEE">작성자명</td>
									<td width = "90%" align = "left" bgcolor="#FFFFFF" ><%= PostWriter %></td>
								</tr>
								<tr>
									<td width = "10%" align = "left" bgcolor="#EEEEEE">제목</td>
									<td width = "90%" align = "left" bgcolor="#FFFFFF"><%= PostTitle %></td>
								</tr>
								<tr>
									<td width = "10%" align = "left" bgcolor="#EEEEEE">첨부</td>
									<td width = "90%" align = "left" bgcolor="#FFFFFF">
<% 
	if(upfile1 != null)
	{
		ext1 = ext1.toLowerCase();
		
		if(ext1.equals("jpg") || ext1.equals("bmp") || ext1.equals("gif") || ext1.equals("png"))
		{
			out.print("<img src = '/Project/upfile/" + upfile1 + "' WIDTH = 100% HEIGHT = auto>");
		}
		
		else
		{
			out.print("<a href = 'Interior_Filedown.jsp?pPostCode=" + PostCode + "&ftype=1'><IMG src = '/Project/icon_file.gif'> " + upfile1 + "</a>");
		}
	}

	if(upfile2 != null)
	{
		ext2 = ext2.toLowerCase();
		
		if(ext2.equals("jpg") || ext2.equals("bmp") || ext2.equals("gif") || ext2.equals("png"))
		{
			out.print("<br><img src = '/Project/upfile/" + upfile2 + "' WIDTH = 100% HEIGHT = auto>");
		}
		
		else
		{
			out.print("<br><a href = 'Interior_Filedown.jsp?pPostCode=" + PostCode + "&ftype=1'><IMG src = '/Project/icon_file.gif'> " + upfile2 + "</a>");
		}
	}
%>
									</td>
								</tr>
								<tr>
									<td width = "10%" align = "left" bgcolor="#EEEEEE">내용</td>
									<td width = "90%" align = "left" bgcolor="#FFFFFF"><%= PostContents %></td>
								</tr>
								<tr>
									<td width = "100%" align = "center" colspan = "2" bgcolor="#FFFFFF">
											<table>
												<tr>
													<td width = "50%" align = "center">
														<input type = "button" value = "삭제하기" onclick = "submit_delete()">
													</td>
													<td width = "50%" align = "center">
														<input type = "button" value = "목록으로" onclick = "submit_list()">
													</td>
												</tr>
											</table>
									</td>
								</tr>
							</table>
						</td>
		  			</tr>
				 </table>
			 </td>
		</tr>
  	 </table>
  </td>
</tr>
</table>
</form>
</body>
<%
		}
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
		
		if(rs != null)
		{
			rs.close();
		}
		
		if(con != null)
		{
			con.close();
		}
	}
%>
</html>