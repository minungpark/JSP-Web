<%@ page contentType="text/html; charset=utf-8" language="java"  %>
      <tr>
        <td height="67"><table width="815" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="223" height="67" rowspan="2" align="center"><a href="index.jsp"><img src="logo.jpg" width="223" height="67" border="0" /></a></td>
            <td width="592" height="30" align="right">
	    
<%
		String id = (String)session.getAttribute("G_MEMID");
		String nm = (String)session.getAttribute("G_MEMNM");
		String admin = (String)session.getAttribute("G_ADMIN");	

		if (id == null)	
		{
%>
		    <a href="mem_join1_1.jsp">회원가입</a>| <a href="mem_login.jsp">로그인</a>
<%
		}

		else
		{
%>

<%
			if(admin == null)
			{
%>
            	 		<%= nm %> 님 환영합니다. | <a href="mem_logout.jsp">로그아웃</a>

				| <a href="mem_view.jsp">마이페이지</a></td>
<%
			}
		
			if(admin.equals("A"))
			{
%>
				관리자 로그인중 | <%= nm %> 님 환영합니다. | <a href="mem_logout.jsp">로그아웃</a>

				| <a href="mem_view.jsp">마이페이지</a></td>
<%
			}

			else if(admin.equals("U"))
			{
%>
				<%= nm %> 님 환영합니다. | <a href="mem_logout.jsp">로그아웃</a>

				| <a href="mem_view.jsp">마이페이지</a></td>
<%
			}
%>

<%			
		}
%>
	   
          </tr>
          <tr>
            <td>
            <ul class="ul">
<%
		if(admin == null)
		{
%>
             <li class="list">| <a href="Interior_List.jsp" class="navi">인테리어 공유</a></li>
	     <li class="list">| <a href="Color_com_link.jsp" class="navi">색 조합 사이트</a></li>
<%
		}
		
		else if(admin.equals("A"))
		{
%>
	     <li class="list">| <a href="Interior_List.jsp" class="navi">인테리어 공유</a></li>
	     <li class="list">| <a href="Color_com_link.jsp" class="navi">색 조합 사이트</a></li>
	     <li class="list">| <a href="mem_list4_1.jsp" class="navi">회원 리스트</a></li>	
<%
		}

		else if(admin.equals("U"))
		{
%>
	     <li class="list">| <a href="Interior_List.jsp" class="navi">인테리어 공유</a></li>
	     <li class="list">| <a href="Color_com_link.jsp" class="navi">색 조합 사이트</a></li>
<%
		}
%>
          </td>
          </tr>
        </table></td>
      </tr>