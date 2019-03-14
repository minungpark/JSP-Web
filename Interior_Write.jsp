<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>인테리어 글쓰기</title>
<link href="./includes/all.css" rel="stylesheet" type="text/css" />
</head>

<%
	String in_writernm = (String)session.getAttribute("G_MEMNM");
	String in_writerid = (String)session.getAttribute("G_MEMID");
%>

<script language="javascript">

function valid_check()
{
	if(document.frm1.writername.value == "")
	{
		alert("작성자명 입력바랍니다.");
		document.frm1.writername.focus();
		return false;
	}
	
	
	if(document.frm1.title.value == "")
	{
		alert("제목을 입력바랍니다.");
		document.frm1.title.focus();
		return false;
	}
	
	if(document.frm1.contents.value == "")
	{
		alert("내용을 입력바랍니다.");
		document.frm1.contents.focus();
		return false;
	}
	
	document.frm1.submit();
}

function submit_list()
{
	document.frm1.action = "Interior_List.jsp"
	document.frm1.submit();	
}
</script>
<body>

<form name = "frm1" action = "Interior_Write_ok.jsp" method = "post" enctype = "multipart/form-data">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="./includes/top.inc" %>
      		<tr>
        		<td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
       		<tr>
            	<td width="547" height="45" align="center" class="new_tit">게시물 작성</td>
          	</tr>
		  	<tr>
            	<td align="center">
							<table width="60%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
								<tr bgcolor = "cccccc">
									<td width = "20%" align = "left" bgcolor="#EEEEEE">작성자명</td>
									<td width = "80%" align = "left" bgcolor="#FFFFFF">
										<input type = "text" size = "15" maxlength = "10" name = "writername" value = "<%= in_writernm %>" READONLY>
									</td>
								</tr>
								<tr>
									<td width = "20%" align = "left" bgcolor="#EEEEEE">제목</td>
									<td width = "80%" align = "left" bgcolor="#FFFFFF">
										<input type = "text" size = "50" maxlength = "50" name = "title">
									</td>
								</tr>
								<tr>
									<td width = "20%" align = "left" bgcolor="#EEEEEE">내용</td>
									<td width = "80%" align = "left" bgcolor="#FFFFFF">
										<textarea type = "contents" rows=5 cols=50 name = "contents"></textarea>
									</td>
								</tr>
								<tr>
									<td width = "20%" align = "left" bgcolor="#EEEEEE">첨부파일1</td>
									<td width = "80%" align = "left" bgcolor="#FFFFFF">
										<input type = "file" name = "file1">
									</td>
								</tr>
								
								<tr>
									<td width = "20%" align = "left" bgcolor="#EEEEEE">첨부파일2</td>
									<td width = "80%" align = "left" bgcolor="#FFFFFF">
										<input type = "file" name = "file2">
									</td>
								</tr>

								<tr>
									<td width = "100%" align = "center" colspan = "2" bgcolor="#FFFFFF">
										<table>
											<tr>
												<td width = "33%" align = "center">
													<input type = "reset" value = "다시 작성">
												</td>
												<td width = "34%" align = "center">
													<input type = "button" value = "등록" onClick = "valid_check()"> 
												</td>
												<td width = "33%" align = "center">
													<input type = "button" value = "목록으로" onClick = "submit_list()">
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
</td>
</tr>
</table>
</form>
</body>
</html>