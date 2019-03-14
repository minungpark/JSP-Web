<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>인테리어 상세보기</title>
<link href="./includes/all.css" rel="stylesheet" type="text/css" />
</head>

<script language=javascript>

function submit_modify(PageNum)
{
	document.frm1.action = "Interior_Modify.jsp?PageNum=" + PageNum
	document.frm1.submit();
}

function submit_delete()
{
	document.frm1.action = "Interior_Del.jsp"
	document.frm1.submit();
}

function submit_list(PageNum)
{
	
	document.frm1.action = "Interior_List.jsp?PageNum=" + PageNum
	document.frm1.submit();
}

function submit_point(PageNum)
{
	document.frm1.action = "Interior_Point.jsp?PageNum=" + PageNum
	document.frm1.submit();
}

</script>

<%@ include file = "dbinfo.inc" %>

<%
	
	String nm2 = (String)session.getAttribute("G_MEMNM");

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try
	{
		
		int PostCode = Integer.parseInt(request.getParameter("pPostCode"));
		int PageNum = Integer.parseInt(request.getParameter("pPageNum"));		
		
		String SQL = "SELECT PostCode, PostTitle, PostContents, PostWriter, upfile1, upfile2, " +
					 "CONVERT(char(10), PostUpdate, 120) PostDate, PostRead, PostPoint " +
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
			int PostPoint = rs.getInt("PostPoint");
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
			
			String PostDate = rs.getString("PostDate");
			int PostRead = rs.getInt("PostRead");
			
			SQL = "UPDATE Interior SET PostRead = PostRead + 1 WHERE PostCode = ?";
			
			pstmt = con.prepareStatement(SQL);
			
			pstmt.setInt(1, PostCode);
			
			pstmt.executeUpdate();
			
	
%>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="./includes/top.inc" %>
      		<tr>
        		<td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
       		<tr>
            	<td width="547" height="45" align="center" class="new_tit">게시물</td>
          	</tr>
		  	<tr>
            	<td align="center">
							<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
								<tr bgcolor = "cccccc">
									<td width = "10%" align = "left" bgcolor="#EEEEEE">작성자명</td>
									<td width = "90%" align = "left" bgcolor="#FFFFFF"><%= PostWriter %></td>
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
					out.print("<img src = '/WebContent/upfile/" + upfile1 + "' WIDTH = 100% HEIGHT = auto>");
				}
				
				else
				{
					out.print("<a href = 'Interior_Filedown.jsp?pPostCode=" + PostCode + "&ftype=1'><IMG src = '/WebContent/icon.png' WIDTH = 10 HEIGHT = auto> " + upfile1 + "</a>");
				}
			}
		
			if(upfile2 != null)
			{
				ext2 = ext2.toLowerCase();
				
				if(ext2.equals("jpg") || ext2.equals("bmp") || ext2.equals("gif") || ext2.equals("png"))
				{
					out.print("<br><img src = '/WebContent/upfile/" + upfile2 + "' WIDTH = 100% HEIGHT = auto>");
				}
				
				else
				{
					out.print("<br><a href = 'Interior_Filedown.jsp?pPostCode=" + PostCode + "&ftype=1'><IMG src = '/WebContent/icon.png' WIDTH = 10 HEIGHT = auto> " + upfile2 + "</a>");
				}
			}
%>
									</td>
								</tr>
								<tr>
									<td width = "10%" align = "left" bgcolor="#EEEEEE">내용</td>
									<td width = "90%" align = "left" bgcolor="#FFFFFF"><%= PostContents %></font></td>
								</tr>
								<tr>
									<td width = "10%" align = "left" bgcolor="#EEEEEE">추천수</td>
									<td width = "90%" align = "left" bgcolor="#FFFFFF"><%= PostPoint %></td>
								</tr>
								<tr>
									<td width = "100%" align = "center" colspan = "2" bgcolor="#FFFFFF">
										<form name = "frm1" method = "post">
											<input type = "hidden" name = pPostCode value = <%= PostCode %>>
											<table>
												<tr>			
<%
			if(nm2 == null)
			{
%>													<td width = "33%" align = "center">
														<input type = "button" value = "목록으로" onclick = "submit_list(<%= PageNum %>)">
													</td>
<%
			}

			else if(PostWriter.equals(nm2))	
			{
%>
													<td width = "33%" align = "center">
														<input type = "button" value = "수정하기" onclick = "submit_modify(<%= PageNum %>)">
													</td>
													<td width = "33%" align = "center">
														<input type = "button" value = "삭제하기" onclick = "submit_delete()">
													</td>
													<td width = "33%" align = "center">
														<input type = "button" value = "목록으로" onclick = "submit_list(<%= PageNum %>)">
													</td>
<%
			}

			else if(admin.equals("A"))
			{
				
%>
													<td width = "25%" align = "center">
														<input type = "button" value = "삭제하기" onclick = "submit_delete()">
													</td>
													<td width = "25%" align = "center">
														<input type = "button" value = "목록으로" onclick = "submit_list(<%= PageNum %>)">
													</td>
													<td width = "25%" align = "left">
														<input type = "button" value = "추천" onclick = "submit_point(<%= PageNum %>)">
													</td>
<% 
			}

			else
			{
%>
													<td width = "33%" align = "center">
														<input type = "button" value = "목록으로" onclick = "submit_list(<%= PageNum %>)">
													</td>
													<td width = "33%" align = "center">
														<input type = "button" value = "추천" onclick = "submit_point(<%= PageNum %>)">
													</td>
<%
			}
%>
												</tr>
											</table>
										</form>
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