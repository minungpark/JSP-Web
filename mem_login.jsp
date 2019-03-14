<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>로그인</title>
<link href="./includes/all.css" rel="stylesheet" type="text/css" />
</head>

<script language = javascript>

function valid_check()
{
	if(document.frm1.userid.value == "")
	{
		alert("아이디를 입력하여 주시기 바랍니다.");
		document.frm1.userid.focus();
		return false;
	}
	
	if(document.frm1.passwd.value == "")
	{
		alert("비밀번호를 입력하여 주시기 바랍니다.");
		document.frm1.userid.focus();
		return false;
	}
		
	document.frm1.submit();
}

</script>

<BODY>
<FORM NAME = "frm1" ACTION = "mem_login_ok.jsp" METHOD = "post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="./includes/top.inc" %>
      <tr>
        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="547" height="45" align="center" class="new_tit">로그인</td>
          </tr>
		      <tr>
            <td align="center">
							<table width="30%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
								<tr>
									<td width="28%" align="left" bgcolor="#EEEEEE">아이디</td>
									<td width="72%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "15" MAXLENGTH = "10" NAME = "userid"></td>
								</tr>
								<tr>
									<td width="28%" align="left" bgcolor="#EEEEEE">비밀번호</td>
									<td width="72%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "password" SIZE = "15" MAXLENGTH = "18" NAME = "passwd"></td>
								</tr>
								<tr>
									<td colspan = 2 align=center bgcolor="#FFFFFF"><INPUT TYPE = "button" VALUE = "로그인" onclick="valid_check()"></td>
								</tr>
							</table>
            </td>
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