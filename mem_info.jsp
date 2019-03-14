<%@ page language="java" contentType="text/html; charset=utf-8" import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE>회원 정보</TITLE>
  <link href="./includes/all.css" rel="stylesheet" type="text/css" />
 </HEAD>
 
 <script language = javascript src = 'func1.js'>

 <%
 
 	String in_userid = request.getParameter("puserid");
	String usernm = "";
	String intro = "";
	
 	
 	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
 	String connectionURL = "jdbc:sqlserver://121.179.212.213:1433;databaseName=sqlmaster;user=sqlmaster;password=rkdqkr2)!7";
 	Connection con = DriverManager.getConnection(connectionURL);

 	PreparedStatement pstmt = null;
 	ResultSet rs = null;
 	
 	String SQL = "select * from members where userid = ?";
 	pstmt = con.prepareStatement(SQL);
 	
 	pstmt.setString(1, in_userid);
 	
 	rs = pstmt.executeQuery();
 	
 	if(rs.next() == false)
 	{
 		out.print("등록되지 않은 회원입니다.");
 	}
 	
 	else
 	{	
		usernm = rs.getString("usernm");
 		
 		intro = rs.getString("intro"); 	
 	}
 %>
 
</script>
 
<BODY>
<FORM NAME = "frm1" ACTION = "mem_info_del.jsp" METHOD = "post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="./includes/top.inc" %>
      		<tr>
        		<td align="center" valign="top">
        		<table width="800" border="0" cellspacing="0" cellpadding="0">
       				<tr>
            			<td width="547" height="45" align="center" class="new_tit">회원 정보</td>
          			</tr>
		  			<tr>
            			<td align="center">
							<table width="50%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
								<tr bgcolor = "cccccc">
									<TD WIDTH = "40%" ALIGN = "left" bgcolor="#EEEEEE">아이디</TD>
									<TD width = "60%" ALIGN = "left" bgcolor="#FFFFFF"><%= in_userid %></TD>
									<input type = "hidden" name = userid value = <%= in_userid %>>
								</TR>
								<TR>
									<TD WIDTH = "40%" ALIGN = "left" bgcolor="#EEEEEE">이름</TD>
									<TD WIDTH = "60%" ALIGN = "left" bgcolor="#FFFFFF"><%= usernm %></TD>
									<input type = "hidden" name = usernm value = <%= usernm %>>
								</TR>
								<TR>
									<TD WIDTH = "40%" ALIGN = "left" bgcolor="#EEEEEE">자기소개</TD>
									<TD WIDTH = "60%" ALIGN = "left" bgcolor="#FFFFFF"><%= intro %></TD>
								</TR>
								<TR>
									<TD WIDTH = "100%" ALIGN = "center" COLSPAN = "2" bgcolor="#FFFFFF">
										<INPUT TYPE = "submit" VALUE = "강퇴">
									</TD>
								</TR>
							</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
	</td>
</tr>
</TABLE>
</FORM>
</BODY>
</HTML>