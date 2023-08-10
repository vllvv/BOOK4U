<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%
    String userID = request.getParameter("userID");
    String newPassword = request.getParameter("newPassword");
	String csrfToken = request.getParameter("csrf");
    UserDAO userDAO = new UserDAO();
    
    if(csrfToken.equals("njknjhgvhfhj576")){
    		int changePasswordResult = userDAO.changePassword(userID, newPassword);
   			out.println("<script>alert('비밀번호가 성공적으로 변경되었습니다.'); location.href='login.jsp';</script>");
   			%>
   			<%
   			session.invalidate();
   			%>
   			<%
   	} 
    else{
	    	out.println("<script>alert('변경 권한이 없어 실패하였습니다.'); history.back();</script>");
	}
   	
%>
