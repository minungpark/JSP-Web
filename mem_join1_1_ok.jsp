<%@ page language="java" import="java.util.*" import ="java.io.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
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
	ResultSet rs = null;
	Statement stmt = con.createStatement();
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

		String SQL		= "select count(*) cnt from members where userid = '" + suserid + "'";	
		pstmt = con.prepareStatement(SQL);
		
		rs = pstmt.executeQuery();
		
		rs.next();
		
		if(rs != null)
		{
			if(rs.getInt("cnt") > 0)
			{
				out.println("이 아이디는 이미 다른 사람이 사용하고 있으므로 사용할 수 없습니다.");
			}
			
			else
			{		
				java.util.Calendar cal = java.util.Calendar.getInstance();
				
				int year = cal.get(java.util.Calendar.YEAR);
				String strYear = Integer.toString(year);
				int intSeq = 0;
				String strSeq = "";
				String newNum = "";
				
				SQL = "select max(mem_num) from members " + "where left(mem_num, 4) = '" + strYear + "'";
				rs = stmt.executeQuery(SQL);
				
				rs.next();
				
				if(rs == null)
				{
					intSeq = 0;
				}
				
				else
				{
					String maxNum = rs.getString(1);
					
					if(maxNum == null)
					{
						intSeq = 0;
					}
					
					else
					{
						strSeq = maxNum.substring(4);
						intSeq = Integer.parseInt(strSeq);
					}
				}
				
				intSeq++;
				String newTemp = "0000" + Integer.toString(intSeq);
				int newLen = newTemp.length();
				newNum = strYear + newTemp.substring(newLen - 4, newLen);
				
				SQL		= "insert into members(userid, usernm, passwd, jumin, mailrcv, gender, jobcd, intro, mem_num) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(SQL);

				// 단계6 : PreparedStatement 객체로 실행할 SQL 문의 ? 위치에 각각의 값을 세팅
				pstmt.setString(1, suserid);
				pstmt.setString(2, susernm);
				pstmt.setString(3, spasswd);
				pstmt.setString(4, sjumin);
				pstmt.setString(5, smailrcv);
				pstmt.setString(6, sgender);
				pstmt.setString(7, sjob);
				pstmt.setString(8, sintro);
				pstmt.setString(9, newNum);
				
				// 단계7 : PreparedStatement 객체 실행
				pstmt.executeUpdate();

				// 단계8 :객체 종료
				pstmt.close();
				con.close();
				
				response.sendRedirect("mem_login.jsp");
			}
		}

%>
