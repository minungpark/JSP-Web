<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE>회원 정보 변경</TITLE>
  <link href="./includes/all.css" rel="stylesheet" type="text/css" />
 </HEAD>
 
 <script language = javascript>
 
 function valid_check()
 {

 	if (document.frm1.userid.value == "")
 	{
 		alert("아이디를 입력하여 주시기 바랍니다.");
 		document.frm1.userid.focus();
 		return false;
 	}

 	if (document.frm1.userid.value.length < 4)
 	{
 		alert("아이디는 4자 이상입니다.");
 		document.frm1.userid.focus();
 		return false;
 	}

 	if (document.frm1.usernm.value == "")
 	{
 		alert("이름을 입력하여 주시기 바랍니다.");
 		document.frm1.usernm.focus();
 		return false;
 	}

 	if (document.frm1.passwd.value == "")
 	{
 		alert("비밀번호를 입력하여 주시기 바랍니다.");
 		document.frm1.passwd.focus();
 		return false;
 	}

 	if (document.frm1.passwd.value != document.frm1.passwd2.value)
 	{
 		alert("비밀번호확인과 일치하지 않습니다.");
 		document.frm1.passwd.focus();
 		return false;
 	}

 	if (document.frm1.jumin1.value.length != 6)
 	{
 		alert("주민번호 앞 자릿수는 6자입니다.");
 		document.frm1.jumin1.focus();
 		return false;
 	}

 	if (document.frm1.jumin2.value.length != 7)
 	{
 		alert("주민번호 뒷 자릿수는 7자입니다.");
 		document.frm1.jumin2.focus();
 		return false;
 	}
 	
 	return true;
 }
 
 function submit_mem_upd()
 {
	if(valid_check() == true)
	{
	 	document.frm1.action = "mem_upd1_4_ok.jsp"
	 	document.frm1.submit();
	}
 }

 function submit_mem_out()
 {
	 if(valid_check() == true)
	{
	 	document.frm1.action = "mem_out_ok.jsp"
	 	document.frm1.submit();
	}
 }
 
 </script>

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
	 		jumin2 = jumin.substring(7,14);
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
	 		
	 	intro = rs.getString("intro").replace("<br>", "\r\n"); 	
 	
 	}
 %>


<BODY>
<FORM NAME = "frm1" ACTION = "mem_upd1_4_ok.jsp" METHOD = "post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="./includes/top.inc" %>
	      <tr>
	        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
	          <tr>
	            <td width="547" height="45" align="center" class="new_tit">회원정보 변경</td>
	          </tr>
			      <tr>
	            <td align="center">
					<table width="60%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
						<TR>
							<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">아이디</TD>
							<TD width = "80%" ALIGN = "left" bgcolor="#FFFFFF">
								<INPUT TYPE = "text" SIZE = "15" MAXLENGTH = "10" NAME = "userid" 
								VALUE = "<%= in_userid %>" ReadOnly>
							</TD>
						</TR>
						<TR>
							<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">이름</TD>
							<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
								<INPUT TYPE = "text" SIZE = "15" MAXLENGTH = "10" NAME = "usernm"
								VALUE = "<%= usernm %>">
							</TD>
						</TR>
						<TR>
							<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">비밀번호</TD>
							<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
								<INPUT TYPE = "password" SIZE = "10" MAXLENGTH = "10" NAME = "passwd">
							</TD>
						</TR>
						<TR>
							<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">비밀번호확인</TD>
							<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
								<INPUT TYPE = "password" SIZE = "10" MAXLENGTH = "10" NAME = "passwd2">
							</TD>
						</TR>
						<TR>
							<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">주민번호</TD>
							<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
								<INPUT TYPE ="text" NAME="jumin1" SIZE = "6" MAXLENGTH = "6"
								VALUE = "<%= jumin1 %>" readonly>-
								<INPUT TYPE ="text" NAME="jumin2" SIZE = "7" MAXLENGTH = "7"
								VALUE = "<%= jumin2 %>" readonly>
							</TD>
						</TR>
						<TR>
							<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">메일수신여부</TD>
							<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
								동의함 <INPUT TYPE ="checkbox" NAME="mailrcv" <% if(mailrcv.equals("Y")) out.print (" checked"); %>>
							</TD>
						</TR>
						<TR>
							<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">성별</TD>
							<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
								남<INPUT TYPE ="radio" NAME="gender" VALUE="1" <% if(gender.equals("1")) out.print (" checked"); %>>
								여<INPUT TYPE ="radio" NAME="gender" VALUE="2" <% if(gender.equals("2")) out.print (" checked"); %>>
							</TD>
						</TR>
						<TR>
							<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">직업</TD>
							<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
								 <SELECT NAME="job">
									<OPTION VALUE="">==직업을 선택하세요==</OPTION>
									<OPTION VALUE="1" <% if(job.equals("1")) out.print (" selected"); %>>학생</OPTION>
									<OPTION VALUE="2" <% if(job.equals("2")) out.print (" selected"); %>>회사원</OPTION>
									<OPTION VALUE="3" <% if(job.equals("3")) out.print (" selected"); %>>군인</OPTION>
									<OPTION VALUE="9" <% if(job.equals("9")) out.print (" selected"); %>>기타</OPTION>
								</SELECT>
							</TD>
						</TR>
						<TR>
							<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">자기소개</TD>
							<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
								<TEXTAREA NAME="intro" ROWS=5 COLS=50><%= intro %></TEXTAREA>
							</TD>
						</TR>
						<TR>
							<TD WIDTH = "100%" ALIGN = "center" COLSPAN = "2" bgcolor="#FFFFFF">
								<table>
									<tr>
										<td width = "50%" align = "center">
											<input type = "button" value = "변경" onclick = "submit_mem_upd()">
										</td>
										<td width = "50%" align = "center">
											<input type = "button" value = "탈퇴" onclick = "submit_mem_out()">
										</td>
									</tr>
								</table>
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