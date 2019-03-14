<%@ page language="java" contentType="text/html; charset=utf-8" import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE>마이페이지</TITLE>
  <link href="./includes/all.css" rel="stylesheet" type="text/css" />
 </HEAD>
 
 <script language = javascript src = 'func1.js'>

 <%
 
 
 
 	String in_userid = (String)session.getAttribute("G_MEMID");
 	String usernm = "";
	String jumin = "";
	String jumin1 = "";
	String jumin2 = "";
	String mailrcv = "";
	String gender = "";
	String job = "";
	String intro = "";
 	
 	if(in_userid == null)
 	{
 		out.print("로그인 후에 회원 정보를 변경 바랍니다.");
 	}
 	
 	else
 	{			 	
	 	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	 	String connectionURL = "jdbc:sqlserver://121.179.212.213:1433;databaseName=sqlmaster;user=sqlmaster;password=rkdqkr2)!7";
	 	Connection con = DriverManager.getConnection(connectionURL);
	
	 	PreparedStatement pstmt = null;
	 	ResultSet rs = null;
	 	
	 	String SQL = "select * from members where userid = ?";
	 	pstmt = con.prepareStatement(SQL);
	 	
	 	pstmt.setString(1, in_userid);
	 	
	 	rs = pstmt.executeQuery();
	 	
	 	rs.next();
	 	
		usernm = rs.getString("usernm");
		jumin = rs.getString("jumin");
	 		
	 	if(jumin != null)
	 	{
	 		jumin1 = jumin.substring(0,6);
	 		jumin2 = jumin.substring(7);
	 	}
	 		
	 	mailrcv = rs.getString("mailrcv");
	 		
	 	if(mailrcv == null)
	 	{
	 		mailrcv = "N";
	 	}
	 		
	 	gender = rs.getString("gender");
	 		
	 	if(gender == null)
	 	{
	 		gender = "";
	 	}
	 		
	 	job = rs.getString("jobcd");
	 		
	 	if(job == null)
	 	{
	 		job = "";
	 	}
	 		
	 	intro = rs.getString("intro"); 	
 	
 	}
 %>
 
</script>

<BODY>
<FORM NAME = "frm1" ACTION = "mem_upd1_4.jsp" METHOD = "post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="./includes/top.inc" %>
      <tr>
        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="547" height="45" align="center" class="new_tit">마이페이지</td>
          </tr>
		      <tr>
            <td align="center">
							<table width="50%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
							<tr>
								<td width="24%" align="left" bgcolor="#EEEEEE">아이디</td>
								<td width="76%" align="left" bgcolor="#FFFFFF">
									<%= in_userid %>
								</td>
							</tr>
							<tr>
								<td width="24%" align="left" bgcolor="#EEEEEE">이름</td>
								<td width="76%" align="left" bgcolor="#FFFFFF">
									<%= usernm %>
								</td>
							</tr>
							<TR>
								<TD WIDTH = "40%" ALIGN = "left" bgcolor="#EEEEEE">주민번호</TD>
								<TD WIDTH = "60%" ALIGN = "left" bgcolor="#FFFFFF">
									<%= jumin1 %> -	<%= jumin2 %>
								</TD>
							</TR>
							<TR>
								<TD WIDTH = "40%" ALIGN = "left" bgcolor="#EEEEEE">메일수신여부</TD>
								<TD WIDTH = "60%" ALIGN = "left" bgcolor="#FFFFFF">
									<% if(mailrcv.equals("Y")) out.print ("동의"); %>
									<% if(mailrcv.equals("N")) out.print ("비동의"); %>
								</TD>
							</TR>
							<TR>
								<TD WIDTH = "40%" ALIGN = "left" bgcolor="#EEEEEE">성별</TD>
								<TD WIDTH = "60%" ALIGN = "left" bgcolor="#FFFFFF">
									<% if(gender.equals("1")) out.print ("남"); 
									   if(gender.equals("2")) out.print ("여");%>
								</TD>
							</TR>
							<TR>
								<TD WIDTH = "40%" ALIGN = "left" bgcolor="#EEEEEE">직업</TD>
								<TD WIDTH = "60%" ALIGN = "left" bgcolor="#FFFFFF">
									 <% if(job.equals("1")) out.print ("학생");
									 	if(job.equals("2")) out.print ("회사원");
									 	if(job.equals("3")) out.print ("군인");
									 	if(job.equals("9")) out.print ("기타");%>
								</TD>
							</TR>
							<TR>
								<TD WIDTH = "40%" ALIGN = "left" bgcolor="#EEEEEE">자기소개</TD>
								<TD WIDTH = "60%" ALIGN = "left" bgcolor="#FFFFFF">
									<%= intro %>
								</TD>
							</TR>
							<TR>
								<TD WIDTH = "100%" ALIGN = "center" COLSPAN = "2" bgcolor="#FFFFFF">
									<INPUT TYPE = "submit" VALUE = "회원정보변경">
								</TD>
							</TR>
						</table>
            </td >
					</table>
				</td>
      </tr>
		</table>
		</td>
	</tr>
</table>
</FORM>
</BODY>
</HTML>