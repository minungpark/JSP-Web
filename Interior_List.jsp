<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>인테리어 리스트</title>
<link href="./includes/all.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%
	String in_search_key = request.getParameter("search_key");
	
	if(in_search_key == null)
	{
		in_search_key = "";
	}
	
	String in_search_value = request.getParameter("search_value");
	
	if(in_search_value == null)
	{
		in_search_value = "";
	}
%>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="./includes/top.inc" %>
      <tr>
        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="547" height="45" align="center" class="new_tit">인테리어 공유</td>
          </tr>
		  <tr>
            <td align="center">
							<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
								<tr bgcolor = "cccccc">
									<th width = 10% bgcolor="#EEEEEE"><font size = 2><center><b>번호</b></center></font></th>
									<th width = *% bgcolor="#EEEEEE"><font size = 2><center><b>제목</b></center></font></th>
									<th width = 10% bgcolor="#EEEEEE"><font size = 2><center><b>첨부</b></center></font></th>
									<th width = 15% bgcolor="#EEEEEE"><font size = 2><center><b>작성자</b></center></font></th>
									<th width = 17% bgcolor="#EEEEEE"><font size = 2><center><b>등록일</b></center></font></th>
									<th width = 10% bgcolor="#EEEEEE"><font size = 2><center><b>조회수</b></center></font></th>
									<th width = 10% bgcolor="#EEEEEE"><font size = 2><center><b>추천수</b></center></font></th>
								</tr>
<%@ include file = "dbinfo.inc" %>

<%

	ResultSet rs = null, rs2 = null;
	Statement stmt = null;
	
	try
	{
		String strPageNum = request.getParameter("PageNum");
		
		if(strPageNum == null)
		{
			strPageNum = "1";
		}
		
		int currentPage = Integer.parseInt(strPageNum);
		int pageSize = 6;
		
		stmt = con.createStatement();
		
		String SQL = "select count(*) from Interior";
		
		if(in_search_value.equals("") == false)
		{
			SQL = SQL + " where " + in_search_key + " like '%" + in_search_value + "%'";
		}
		
		rs2 = stmt.executeQuery(SQL);
		
		int totalRecords = 0;
		
		rs2.next();
		
		if(rs2.getInt(1) == 0)
		{
%>
								<tr>
									<td colspan=6 bgcolor="#FFFFFF"><center>등록된 게시물이 없습니다</center></td>
								</tr>
<%

		}
		
		else
		{
			totalRecords = rs2.getInt(1);
			
			SQL = "select top " + pageSize + " PostCode, PostTitle, PostWriter, upfile1, upfile2, " + 
				  "convert(char(10), PostUpdate, 120) PostDate, PostRead, PostPoint " +
				  "from Interior where PostCode not in (select top ";
			SQL = SQL + ((currentPage - 1) * pageSize) + " PostCode from Interior ";
			
			if(in_search_value.equals("") == false)
			{
				SQL = SQL + " where " + in_search_key + " like '%" + in_search_value + "%'";
			}
			
			SQL = SQL  + " ORDER BY PostCode DESC)";
		
			if(in_search_value.equals("") == false)
			{
				SQL = SQL + " and " + in_search_key + " like '%" + in_search_value + "%'";
			}
			
			SQL = SQL  + " ORDER BY PostCode DESC";
			
			rs = stmt.executeQuery(SQL);
			
			int pageSize_temp = pageSize;
			
			while(rs.next() && pageSize_temp > 0)
			{
				int PostCode = rs.getInt("PostCode");
				String PostTitle = rs.getString("PostTitle");
				String PostWriter = rs.getString("PostWriter");
				String file1 = rs.getString("upfile1");
				String file2 = rs.getString("upfile2");
				String PostDate = rs.getString("PostDate");
				int PostRead = rs.getInt("PostRead");
				int PostPoint = rs.getInt("PostPoint");
%>

								<tr>
									<td align = "center" bgcolor="#FFFFFF"><%= PostCode %></a></td>
									<td bgcolor="#FFFFFF"><a href="Interior_View.jsp?pPostCode=<%= PostCode %>&pPageNum=<%= strPageNum %>"><%= PostTitle %></a></td>
									<td align = "center" bgcolor="#FFFFFF"><% if(file1 != null || file2 != null) { %>
										<img src = "icon.png" WIDTH = 10 HEIGHT = auto> <% } %>
									</td>
									<td align = "center" bgcolor="#FFFFFF"><%= PostWriter %></td>
									<td align = "center" bgcolor="#FFFFFF"><%= PostDate %></td>
									<td align = "center" bgcolor="#FFFFFF"><%= PostRead %></td>
									<td align = "center" bgcolor="#FFFFFF"><%= PostPoint %></td>
								</tr>
				
<%

				pageSize_temp = pageSize_temp - 1;
			} // while(rs.next() && pageSize_temp > 0) 끝
		} // if(rs2.getInt(1) == 0) 끝
%>

					</table>
					
					<form name=frm1 action="Interior_List.jsp?" method=get>
							<select name = "search_key">
								<option value = "PostTitle" <% if(in_search_key.equals("PostTitle")) out.print( "selected"); %>>제목</option>
								<option value = "PostWriter" <% if(in_search_key.equals("PostWriter")) out.print( "selected"); %>>작성자</option>
							</select>
							<input type = text name = "search_value" value = "<%= in_search_value %>">
							<input type = submit value = "검색">
					</form>
        	   </td>
           </tr>
		</table>
	</td>
   </tr>
</table>
</td>
</tr>
</table><br><br>
<table width="100%" border="0" cellspacing="0" cellpadding="7" bgcolor="#D7D7D7">
<tr>
<td align = "center" bgcolor="#FFFFFF">


<%
	
		int intTotPages = 0;
		int intR = totalRecords % pageSize;
		
		if(intR == 0)
		{
			intTotPages = totalRecords / pageSize;
		}
		
		else
		{
			intTotPages = totalRecords / pageSize + 1;
		}
		
		int intGrpSize = 2;
		int currentGrp = 0;
		intR = currentPage % intGrpSize;
		
		if(intR == 0)
		{
			currentGrp = currentPage / intGrpSize;
		}
		
		else
		{
			currentGrp = currentPage / intGrpSize + 1;
		}
		
		int intGrpStartPage = (currentGrp - 1) * intGrpSize + 1;
		int intGrpEndPage = currentGrp * intGrpSize;
		
		if(intGrpEndPage > intTotPages)
		{
			intGrpEndPage = intTotPages;
		}
		
		if(currentGrp > 1)
		{
%>
			[<a href ="Interior_List.jsp?PageNum=<%= intGrpStartPage - 1 %>&search_key=<%= in_search_key %>&search_value=<%= in_search_value %>">이전</a>]
<%
		}
		
		int intGrpPageCount = intGrpSize;
		int intIndex = intGrpStartPage;
		
		while(intGrpPageCount > 0 && intIndex <= intGrpEndPage)
		{
%>
			[<a href ="Interior_List.jsp?PageNum=<%= intIndex %>&search_key=<%= in_search_key %>&search_value=<%= in_search_value %>"><%= intIndex %></a>] &nbsp;
<% 
			intIndex = intIndex + 1;
			intGrpPageCount = intGrpPageCount - 1;
		}
		
		if(intIndex <= intTotPages)
		{
%>
			[<a href ="Interior_List.jsp?PageNum=<%= intIndex %>&search_key=<%= in_search_key %>&search_value=<%= in_search_value %>">다음</a>]
<%
		}
	} // try end
	
	catch(SQLException e1)
	{
		out.println(e1.getMessage());
	} // catch SQLException end
	
	catch(Exception e2)
	{
		e2.printStackTrace();
	} // catch Exception end
	
	finally
	{
		if(stmt != null)
		{
			stmt.close();
		}
		
		if(rs != null)
		{
			rs.close();
		}
		
		if(rs2 != null)
		{
			rs2.close();
		}
		
		if(con != null)
		{
			con.close();
		}
	} // finally end
%>

<br><br>
<%
	if(id == null || nm == null)
	{
%>
<%
	}

	else
	{
%>
		<form name = "frm1" action = "Interior_Write.jsp" method = "post">
			<Input type ="submit" value = "새글쓰기">
		</form>
<% 
	}
%>

</body>
</html>