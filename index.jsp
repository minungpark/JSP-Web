<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "dbinfo.inc" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인테리어 공유 사이트</title>

<link href="./includes/all.css" rel="stylesheet" type="text/css" />

</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="./includes/top.inc" %>
      <tr>
        <td height="284"><img src="main.jpg" width="815" height="284" alt="메인" /></td>
      </tr>
			<%
				ResultSet rs = null;
				Statement stmt  = con.createStatement();
			%>
      <tr>
        <td height="239" align="center" valign="top">
					<table width="800" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="45" align="left" class="new_tit">추천 게시물</td>
          </tr>
     
<tr>
					<%
						int cnt = 0;			
					
						String SQL = "select top 3 ROW_NUMBER() OVER (ORDER BY PostPoint desc) as Code, PostCode, PostTitle, PostWriter, PostContents, PostDate, upfile1, upfile2 from Interior";
					
						rs = stmt.executeQuery(SQL);						
					
						while (rs.next()){
							int PostCode = rs.getInt("PostCode");
							String PostTitle		= rs.getString("PostTitle");
					%>
            <td width="200" align="center" valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
             		 <td width = "40%" align = "center"><a href="Interior_View.jsp?pPostCode=<%= PostCode %>&pPageNum=1"><font size = 4><%= PostTitle %></font></a></td>
					<%

						}
						
						if (stmt  != null) stmt.close();
						if (rs    != null) rs.close();
						if (con   != null) con.close();
					%>
				</table>
			</td>
</tr>
	</table> 
</body>
</html>