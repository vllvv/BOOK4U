<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import = "user.User" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/> <%-- Login 페이지의 userID를 받아옴 --%>
<jsp:setProperty name="user" property="userPassword"/> <%-- Login 페이지의 userPassword를 받아옴 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSP 게시판 웹 사이트</title>
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
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		int role = userDAO.getRole(user.getUserID());
		if (result == 1 && role == 0) {
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'main.jsp';");
					script.println("</script>");
				}
		else if(result ==1 && role == 1){
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'main.jsp';");
					script.println("</script>");
		}	
		//else if (result == 0) {
		//	PrintWriter script = response.getWriter();
		//	script.println("<script>");
		//	script.println("alert('비밀번호가 틀립니다.')");
		//	script.println("history.back()");
		//	script.println("</script>");
		//}
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디 또는 비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>