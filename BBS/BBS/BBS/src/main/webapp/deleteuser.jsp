<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import = "user.UserDAO" %>
<%@ page import = "user.User" %>
<%@ page import = "reserv.reservDAO" %>
<%@ page import = "reserv.reserv" %>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width" initial-scale="1"> <%-- 모든 디바이스 최적화 --%>
<link rel="stylesheet" href="css/bootstrap.css"> <%-- bootstrap 불러오기 --%>
<link rel="stylesheet" href="css/custom.css">
<title>숙소 예약 사이트</title>



</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
			
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span> <%-- 햄버거 버튼 작대기 --%>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">숙소 예약 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="lodging.jsp">숙소</a></li>
				<li><a href="bbs.jsp">QnA</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="active"><a href="myPage.jsp">마이페이지</a></li>
				<li><a href="logoutAction.jsp">로그아웃</a></li>
			</ul>
		</div>
	</nav>
	
	<div class="container">


    <%	
  
    	String nid="";
    	reservDAO reservdao = new reservDAO();
    	ArrayList<reserv> rlist = reservdao.Listreserv(userID);
		for(int i = 0; i < rlist.size(); i++){
			nid=rlist.get(i).getuserID();
			if (nid.equals(userID)){
		%>
		<script>alert("예약내역 취소 후 탈퇴하세요")
		location.href = 'myPage.jsp'
		</script>
		
		<%	
		}
			else {
				UserDAO userdao = new UserDAO();
				int number = userdao.deleteMember(userID);
				if (number>0){
					HttpSession session1 = request.getSession();
					session1.invalidate();
					response.sendRedirect("main.jsp");
				%>
				<script>
				alert("회원탈퇴가 완료되었습니다")
				
				</script>
				<%
				}
				else {
					%>
					<script>alert("탈퇴되지 않았습니다 고객센터에 문의하세요")</script>
					<%
				}
			}
		}
		if (nid.equals("")){
			System.out.println("d");
			UserDAO userdao = new UserDAO();
			int number = userdao.deleteMember(userID);
			if (number>0){
				HttpSession session1 = request.getSession();
				session1.invalidate();
				response.sendRedirect("main.jsp");
			%>
			<script>
			alert("회원탈퇴가 완료되었습니다.")
			
			</script>
			<%
			}
			else {
				%>
				<script>alert("탈퇴되지 않았습니다 고객센터에 문의하세요")</script>
				<%
			}
		}
		%>
		
		
		
		

	

                
		
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>


</body>
</html>
