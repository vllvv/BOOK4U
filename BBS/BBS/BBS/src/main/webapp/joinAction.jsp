<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/> <%-- Login 페이지의 userID를 받아옴 --%>
<jsp:setProperty name="user" property="userPassword"/> <%-- Login 페이지의 userPassword를 받아옴 --%>
<jsp:setProperty name="user" property="userName"/> <%-- Login 페이지의 userName를 받아옴 --%>
<jsp:setProperty name="user" property="userEmail"/> <%-- Login 페이지의 userEmail를 받아옴 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>숙소 예약 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어 있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserEmail() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 항목이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재된 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else if (result == 1) {
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				%>
				<script>alert("회원가입 기념 백만 포인트를 넣어드렸습니다.\n마이페이지를 확인해주세요")
				location.href = 'main.jsp'</script>
				<%
				script.println("</script>");
			}
		}
	%>
</body>
</html>