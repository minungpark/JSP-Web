<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원 리스트</title>
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
		            	<td width="547" height="45" align="center" class="new_tit">회원 리스트</td>
		          	</tr>
				  	<tr>
		            	<td align="center">
							<table width="30%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
								<tr bgcolor = "cccccc">
									<th width="50%" bgcolor="#EEEEEE"><font size = 2><center><b>회원ID</b></center></font></th>
									<th width="50%" bgcolor="#EEEEEE"><font size = 2><center><b>회원명</b></center></font></th>
								</tr>
			
			<%
			
				String strPageNum = request.getParameter("PageNum");
			
				if(strPageNum == null)
				{
					strPageNum = "1";
				}
				
				int currentPage = Integer.parseInt(strPageNum);
				int pageSize = 5;
				
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				String connectionURL = "jdbc:sqlserver://121.179.212.213:1433;databaseName=sqlmaster;user=sqlmaster;password=rkdqkr2)!7";
				Connection con = DriverManager.getConnection(connectionURL);
				ResultSet rs = null, rs2 = null;
				
				Statement stmt = con.createStatement();
				
				String SQL = "select count(*) from members left outer join jobinfo " + " on members.jobcd = jobinfo.jobcd";
				
				if(in_search_value.equals("") == false)
				{
					SQL = SQL + " where " + in_search_key + " like '%" + in_search_value + "%'";
				}
				
				rs2 = stmt.executeQuery(SQL);
				
				int totalRecords = 0;
				
				if(rs2.next() == false)
				{
			%>	
								<tr>
									<td colspan = 5 bgcolor="#FFFFFF"><center>등록된 회원이 없습니다</center></td>
								</tr>
			<% 
				}
				
				else
				{
					totalRecords = rs2.getInt(1);
				
					SQL = "select top " + pageSize + " userid, usernm, ";
					SQL = SQL + "case gender when '1' then '남' when '2' then '여' else '' end gender, ";
					SQL = SQL + "jumin, jobnm ";
					SQL = SQL + "from members left outer join jobinfo " + "on members.jobcd = jobinfo.jobcd where userid not in (select top ";
					SQL = SQL + ((currentPage - 1) * pageSize) + " userid from members " + "left outer join jobinfo on members.jobcd = jobinfo.jobcd ";
					
					if(in_search_value.equals("") == false)
					{
						SQL = SQL + " where " + in_search_key + " like '%" + in_search_value + "%'";
					}
					
					SQL = SQL  + " ORDER BY userid ASC)";
				
					if(in_search_value.equals("") == false)
					{
						SQL = SQL + " and " + in_search_key + " like '%" + in_search_value + "%'";
					}
					
					SQL = SQL  + " ORDER BY userid ASC";
					
					rs = stmt.executeQuery(SQL);
					
					int pageSize_temp = pageSize;
					
					while(rs.next() && pageSize_temp > 0)
					{
						String userid = rs.getString("userid");
						String usernm = rs.getString("usernm");
						String jumin = rs.getString("jumin");
						String jumin1 = "";
						String jumin2 = "";
						String jumin3 = "";
						
						if(jumin1 != null)
						{
							jumin1 = jumin.substring(0,2);
							jumin2 = jumin.substring(2,4);
							jumin3 = jumin.substring(4,6);
						}
						
						String gender = rs.getString("gender");
						
						if(gender == null)
						{
							gender = "";
						}
					
						String job = rs.getString("jobnm");
						
						if(job == null)
						{
							job = "";
						}	
					
				
			%>
			
								<tr>
									<td bgcolor="#FFFFFF"><a href = "mem_info.jsp?puserid=<%= userid %>"><%= userid %></a></td>
									<td bgcolor="#FFFFFF"><%= usernm %></td>
								</tr>
			
			<%
						pageSize_temp = pageSize_temp - 1;
					}
				}
			%>
							</table>
							
							<form name=frm1 action="mem_list4_1.jsp?" method=get>
								<select name = "search_key">
									<option value = "usernm" <% if(in_search_key.equals("usernm")) out.print( "selected"); %>>회원명</option>
									<option value = "userid" <% if(in_search_key.equals("userid")) out.print( "selected"); %>>회원ID</option>
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
					[<a href ="mem_list4_1.jsp?PageNum=<%= intGrpStartPage - 1 %>&search_key=<%= in_search_key %>&search_value=<%= in_search_value %>">이전</a>]
			<%
				}
				
				int intGrpPageCount = intGrpSize;
				int intIndex = intGrpStartPage;
				
				while(intGrpPageCount > 0 && intIndex <= intGrpEndPage)
				{
			%>
					[<a href ="mem_list4_1.jsp?PageNum=<%= intIndex %>&search_key=<%= in_search_key %>&search_value=<%= in_search_value %>"><%= intIndex %></a>] &nbsp;
			<% 
					intIndex = intIndex + 1;
					intGrpPageCount = intGrpPageCount - 1;
				}
				
				if(intIndex <= intTotPages)
				{
			%>
					[<a href ="mem_list4_1.jsp?PageNum=<%= intIndex %>&search_key=<%= in_search_key %>&search_value=<%= in_search_value %>">다음</a>]
					</td>
					</tr>
					</table>
			<%
				}
				
				stmt.close();
				rs.close();
				rs2.close();
				con.close();
			%>
</body>
</html>