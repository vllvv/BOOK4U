<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import = "user.UserDAO" %>
<%@ page import = "user.User" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbs" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>관리자 페이지</title>
</head>
<body>
 <%
    String[] deleteuserID = request.getParameterValues("checkId");
    if (deleteuserID != null) {
        BbsDAO bbsdao = new BbsDAO();
     for (String id : deleteuserID) {
         int deleteId = Integer.parseInt(id);
         bbsdao.delete(deleteId);
     }
 }
    response.sendRedirect("AdminManagementQna.jsp");
     %>
</body>
</html>