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
				alert("회원탈퇴가 완료되었습니다.")
				
				</script>
				<%
				}
				else {
					%>
					<script>alert("회원탈퇴가 완료되지 않았습니다.")</script>
					<%
				}
			}
		}
		if (nid.equals("")){
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
				<script>alert("회원탈퇴가 완료되지 않았습니다.")</script>
				<%
			}
		}
		%>
		
		
		
		

	

                
		
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>


</body>
</html>
