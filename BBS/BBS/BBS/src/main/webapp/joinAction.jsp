<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/> <%-- Login �������� userID�� �޾ƿ� --%>
<jsp:setProperty name="user" property="userPassword"/> <%-- Login �������� userPassword�� �޾ƿ� --%>
<jsp:setProperty name="user" property="userName"/> <%-- Login �������� userName�� �޾ƿ� --%>
<jsp:setProperty name="user" property="userEmail"/> <%-- Login �������� userEmail�� �޾ƿ� --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� ����Ʈ</title>
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
			script.println("alert('�̹� �α����� �Ǿ� �ֽ��ϴ�.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserEmail() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�Է��� �� �� �׸��� �ֽ��ϴ�.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('����� ���̵��Դϴ�.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else if (result == 1) {
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				%>
				<script>alert("ȸ������ ��� �鸸 ����Ʈ�� �־��Ƚ��ϴ�.\n������������ Ȯ�����ּ���")
				location.href = 'main.jsp'</script>
				<%
				script.println("</script>");
			}
		}
	%>
</body>
</html>