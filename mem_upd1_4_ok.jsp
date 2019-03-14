<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
// 단계1 : JDBC 드라이버 로드

	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
// 단계2 : 커넥션 객체 생성
	String connectionURL = "jdbc:sqlserver://121.179.212.213:1433;databaseName=sqlmaster;user=sqlmaster;password=rkdqkr2)!7";
	Connection con = java.sql.DriverManager.getConnection(connectionURL);
//PLUSNS-PC\SQLEXPRESS
// 단계3 : PreparedStatement 객체 생성
	PreparedStatement pstmt = null;

// 단계4 :폼에서 입력한 값을 받아서 각각의 메모리 변수에 저장
		String suserid	= request.getParameter("userid");
		String susernm	= request.getParameter("usernm");
		String spasswd	= request.getParameter("passwd");
		String spasswd2	= request.getParameter("passwd2");
		
		// 주민번호 앞 6자와 뒷 7자를 각각  입력받아 합침
		String sjumin	= request.getParameter("jumin1") + "-" + request.getParameter("jumin2");
		String smailrcv	= request.getParameter("mailrcv");
		if (smailrcv != null && smailrcv.equals("on"))
			smailrcv = "Y";			// 수신을 동의함(체크함)
		else
			smailrcv = "N";			// 수신을 체크하지 않음

		String sgender	= request.getParameter("gender");
		String sjob		= request.getParameter("job");
		String sintro	= request.getParameter("intro").replace("\r\n", "<br>"); // CR, LF를 <br> 태그로 변환

// 단계5 : PreparedStatement 객체로 실행할 SQL 문 생성
		String SQL		= "update members set ";
		SQL = SQL + "usernm = ? ";
		SQL = SQL + ", jumin = ? ";
		SQL = SQL + ", mailrcv = ? ";
		SQL = SQL + ", gender = ? ";
		SQL = SQL + ", jobcd = ? ";
		SQL = SQL + ", intro = ? ";
		SQL = SQL + "where userid = ? and passwd = ?";
		pstmt = con.prepareStatement(SQL);


// 단계6 : PreparedStatement 객체로 실행할 SQL 문의 ? 위치에 각각의 값을 세팅
		pstmt.setString(1, susernm);
		pstmt.setString(2, sjumin);
		pstmt.setString(3, smailrcv);
		pstmt.setString(4, sgender);
		pstmt.setString(5, sjob);
		pstmt.setString(6, sintro);
		pstmt.setString(7, suserid);
		pstmt.setString(8, spasswd);
		
		
// 단계7 : PreparedStatement 객체 실행
		int cnt = pstmt.executeUpdate();
		
		SQL = "update Interior set PostWriter = ? where WriterID = ?";
		pstmt = con.prepareStatement(SQL);
		
		pstmt.setString(1, susernm);
		pstmt.setString(2, suserid);
		
		session.setAttribute("G_MEMNM", susernm);
		
		pstmt.executeUpdate();
		
// 단계8 :객체 종료
		pstmt.close();
		con.close();
		
		if(cnt > 0)
		{
			out.println("<script language=javascript>");
			out.println("alert('수정이 완료 되었습니다.');");
			out.println("</script>");
			
			response.sendRedirect("mem_view.jsp");		
		}
		
		else
		{
			out.println("<script language=javascript>");
			out.println("alert('수정을 실패했습니다.');");
			out.println("</script>");
			
			response.sendRedirect("mem_upd1_4.jsp");
		}
			

%>