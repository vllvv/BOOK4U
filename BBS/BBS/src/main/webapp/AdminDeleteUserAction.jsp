<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import = "user.UserDAO" %>
<%@ page import = "user.User" %>
<%@ page import = "reserv.reservDAO" %>
<%@ page import = "reserv.reserv" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>관리자 페이지</title>
</head>
<body>
 <%
 	String[] deleteID = request.getParameterValues("checkId");
 	if(deleteID != null){
 		UserDAO userDAO = new UserDAO();
 		for(String id : deleteID){
 	 		userDAO.deleteMember(id);
 	 	}
 	}
 	 response.sendRedirect("Admin.jsp");
 	 %>
</body>
</html>