<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% 
	String id = request.getParameter("id");
	boolean fnd = false;
	
	if(id == null)
	{
		id = "";
	}
	
	else
	{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

		String connectionURL = "jdbc:sqlserver://121.179.212.213:1433;databaseName=sqlmaster;user=sqlmaster;password=rkdqkr2)!7";
		Connection con = java.sql.DriverManager.getConnection(connectionURL);
		ResultSet rs = null;
		
		PreparedStatement pstmt = null;
		String SQL = "select userid from members where userid ='" + id + "'";
		
		pstmt = con.prepareStatement(SQL);
		
		rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			fnd = true;
			
			pstmt.close();
			con.close();
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ID CHECK</title>
</head>

<script language="JavaScript">

function id_search()
{
	if(document.form1.id.value == "")
	{
		alert("ID를 입력해 주세요");
		document.form1.id.focus();
	}
	
	else
	{
		document.form1.submit();	
	}
}

function id_ok(a)
{
	opener.document.frm1.userid.value = a;
	self.close();
}
</script>

<body>
<center>
	<br>
		<p align="center">사용하고자 하는 ID를 검색 버튼을 누르세요.</p>
		<form name = "form1" action = "id_check.jsp" method = "post">
			<table width = "200">
				<tr>
					<td width = "150">ID</td>
					<td width = "100"><input type = "text" name = "id" size = "20" value = <%= id %>></td>
					<td width = "40"><input type = "button" value = "검색" onClick = "javascript:id_search()"></td>
				</tr>
			</table>
		</form>
		
		<%
			if(id != "" && fnd == false)
			{
		%>
		
				사용 가능한 ID입니다<p>
				확인을 누르시면 회원 등록 화면으로 돌아갑니다.
				<a href = "javascript:id_ok('<%= id %>')">확인</a>
		<%
			}
		
			else if(id != "" && fnd == true)
			{
		%>
				이미 사용 중인 ID입니다.
		<% 
			}
		%>	
</center>
</body>
</html>