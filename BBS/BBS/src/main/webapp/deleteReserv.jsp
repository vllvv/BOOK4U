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
		   UserDAO uD = new UserDAO();
	%>

	
	<div class="container">


    <%	
  		String btnid = request.getParameter("reservID");
    	String numString = request.getParameter("num");
    	int num = Integer.parseInt(numString);
    	reservDAO reservdao = new reservDAO();
    	UserDAO userdao = new UserDAO();
    	ArrayList<User> ulist = userdao.selectMember(userID);
		ArrayList<reserv> rlist = reservdao.Listreserv(userID);
        int paying = ulist.get(0).getUserPoint()+ rlist.get(num).getprice();
		int number = reservdao.deleteReserv(btnid);
		if (number>0){
	        userdao.payCalc(userID, Integer.toString(paying));
			%>
			<script>alert("예약이 취소되었습니다")
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
