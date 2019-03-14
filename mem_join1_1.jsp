<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원가입</title>
<link href="./includes/all.css" rel="stylesheet" type="text/css" />
</head>
 
 <script language = javascript src = 'func1.js'>
 
 </script>

<BODY>
<FORM NAME = "frm1" ACTION = "mem_join1_1_ok.jsp" METHOD = "post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
					<%@ include file="./includes/top.inc" %>
      <tr>
        <td height="80" background="./icons/sub_bg.jpg">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="547" height="45" align="center" class="new_tit">회원가입</td>
          </tr>
		      <tr>
            <td align="center">
							<table width="67%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
								<TR>
									<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">아이디</TD>
									<TD width = "80%" ALIGN = "left" bgcolor="#FFFFFF">
										<INPUT TYPE = "text" SIZE = "15" MAXLENGTH = "10" NAME = "userid" readonly>
										<input type = button value="ID Check" onclick="check_id()" onmouseover="this.style.cursor='hand';">
									</TD>
								</TR>
								<TR>
									<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">이름</TD>
									<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
										<INPUT TYPE = "text" SIZE = "15" MAXLENGTH = "10" NAME = "usernm">
									</TD>
								</TR>
								<TR>
									<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">비밀번호</TD>
									<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
										<INPUT TYPE = "password" SIZE = "10" MAXLENGTH = "18" NAME = "passwd">
									</TD>
								</TR>
								<TR>
									<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">비밀번호확인</TD>
									<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
										<INPUT TYPE = "password" SIZE = "10" MAXLENGTH = "18" NAME = "passwd2">
									</TD>
								</TR>
								<TR>
									<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">주민번호</TD>
									<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
										<INPUT TYPE ="text" NAME="jumin1" SIZE = "6" MAXLENGTH = "6" onKeyDown="return KeyNumber(event)" onKeyUp="cursor_move(1)" onKeyUp="removeChar(event)">-
										<INPUT TYPE ="text" NAME="jumin2" SIZE = "7" MAXLENGTH = "7" onKeyDown="return KeyNumber(event)" onKeyUp="cursor_move(2)" onKeyUp="removeChar(event)">
									</TD>
								</TR>
								<TR>
									<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">메일수신여부</TD>
									<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
										동의함 <INPUT TYPE ="checkbox" NAME="mailrcv">
									</TD>
								</TR>
								<TR>
									<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">성별</TD>
									<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
										남<INPUT TYPE ="radio" NAME="gender" VALUE="1">여<INPUT TYPE ="radio" NAME="gender" VALUE="2">
									</TD>
								</TR>
								<TR>
									<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">직업</TD>
									<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
										 <SELECT NAME="job">
											<OPTION VALUE="">==직업을 선택하세요==</OPTION>
											<OPTION VALUE="1">학생</OPTION>
											<OPTION VALUE="2">회사원</OPTION>
											<OPTION VALUE="3">군인</OPTION>
											<OPTION VALUE="9">기타</OPTION>
										</SELECT>
									</TD>
								</TR>
								<TR>
									<TD WIDTH = "20%" ALIGN = "left" bgcolor="#EEEEEE">자기소개</TD>
									<TD WIDTH = "80%" ALIGN = "left" bgcolor="#FFFFFF">
										<TEXTAREA NAME="intro" ROWS=5 COLS=50></TEXTAREA>
									</TD>
								</TR>
								<TR>
									<TD WIDTH = "100%" ALIGN = "center" COLSPAN = "2" bgcolor="#FFFFFF">
										<INPUT TYPE = "button" VALUE = "가입" onclick="valid_check()">
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
