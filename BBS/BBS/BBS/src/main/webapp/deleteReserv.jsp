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
  		String btnid = request.getParameter("reservID");
    	System.out.println(btnid);
    	reservDAO reservdao = new reservDAO();
		int number = reservdao.deleteReserv(btnid);
		if (number==1){
		%>
		<script>alert("예약취소가 완료되었습니다")
		location.href = 'myPage.jsp'
		</script>
		
		<%	
		}
		
			else {
					%>
					<script>alert("예약이 취소되지 않았습니다. 고객센터에 문의하세요"
							location.href = 'myPage.jsp')</script>
					
					<%
		}
		%>
			
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>


</body>
</html>
