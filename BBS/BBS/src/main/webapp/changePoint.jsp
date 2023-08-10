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
	String[] changeID = request.getParameterValues("checkId");
 	String point = request.getParameter("insertPoint");	

	int intPoint = 0;
 	try {
 		intPoint = Integer.parseInt(point);
 	} catch (NumberFormatException e) {
 		response.sendRedirect("AdminManagementPoint.jsp");
 		return;
 	}

 	if(changeID != null){
 		UserDAO change = new UserDAO();
 		for(String id : changeID){
 			change.changePoint(id, point);
 	 	}
 	}
 	response.sendRedirect("AdminManagementPoint.jsp");
 	 %>
</body>
</html>