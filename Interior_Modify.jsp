<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>인테리어 수정</title>
<link href="./includes/all.css" rel="stylesheet" type="text/css" />
</head>

<script language=javascript>

function submit_modify()
{
	document.frm1.action = "Interior_Modify_ok.jsp"
	document.frm1.submit();
}

function submit_list(PageNum)
{
	document.frm1.action = "Interior_List.jsp?PageNum=" + PageNum 
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
		int PageNum = Integer.parseInt(request.getParameter("PageNum"));
		/* String in_search_key = request.getParameter("search_key");
		String in_search_value = request.getParameter("search_value"); */
		
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
			String PostContents = rs.getString("PostContents").replace("<br>", "\r\n");
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
<form name = "frm1" action = "Interior_Modify_ok" method = "post" enctype = "multipart/form-data">
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
									<td width = "10%" align = "left" bgcolor="#EEEEEE">번호</td>
									<td width = "90%" align = "left" bgcolor="#FFFFFF"><%= PostCode %></td>
									<input type = "hidden" name = pPostCode value = <%= PostCode %>>
									<input type = "hidden" name = pPageNum value = <%= PageNum %>>
									<%-- <input type = "hidden" name = psearch_key value = <%= in_search_key %>>
									<input type = "hidden" name = psearch_value value = <%= in_search_value %>> --%>
								</tr>
								<tr>
									<td width = "10%" align = "left" bgcolor="#EEEEEE">작성자명</td>
									<td width = "90%" align = "left" bgcolor="#FFFFFF"><%= PostWriter %></td>
								</tr>
								<tr>
									<td width = "10%" align = "left" bgcolor="#EEEEEE">제목</td>
									<td width = "90%" align = "left" bgcolor="#FFFFFF">
										<input type = "text" size = "50" maxlength = "50" name = "title" value = "<%= PostTitle %>">
									</td>
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
			out.print("<img src = '/Project/icon_file.gif>" + upfile1);
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
			out.print("<br><img src = '/Project/icon_file.gif>" + upfile1);
		}
	}
%>
			</td>
		</tr>
		<tr>
			<td width = "10%" align = "left" bgcolor="#EEEEEE">내용</td>
			<td width = "90%" align = "left" bgcolor="#FFFFFF">
			 <textarea name = "contents" rows=5 cols=50><%= PostContents %></textarea>
			</td>
		</tr>
		<tr>
			<td width = "10%" align = "left" bgcolor="#EEEEEE">첨부파일1</td>
			<td width = "90%" align = "left" bgcolor="#FFFFFF">
				<input type = "file" name = "file1">
			</td>
		</tr>
		<tr>
			<td width = "10%" align = "left" bgcolor="#EEEEEE">첨부파일2</td>
			<td width = "90%" align = "left" bgcolor="#FFFFFF">
				<input type = "file" name = "file2">
			</td>
		</tr>
		<tr>
			<td width = "100%" align = "center" colspan = "2" bgcolor="#FFFFFF">
				<table>
					<tr>
						<td width = "50%" align = "center">
							<input type = "button" value = "수정완료" onclick = "submit_modify()">
						</td>
						<td width = "50%" align = "center">
							<input type = "button" value = "목록으로" onclick = "submit_list(<%= PageNum %> <%-- <%= in_search_key %>, <%= in_search_value %> --%>)">
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