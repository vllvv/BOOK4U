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
    
    String[] deletereservID = request.getParameterValues("checkId");
    
    UserDAO userdao = new UserDAO();
    reservDAO reservdao = new reservDAO();
    if(deletereservID != null){
       for (int i = 0; i < deletereservID.length; i++){
          String reservid = deletereservID[i];
          ArrayList<reserv> relist = reservdao.listreserv(reservid);   
          for(int j = 0; j < relist.size(); j++) {
             String userid=relist.get(j).getuserID();
             ArrayList<User> ulist = userdao.selectMember(userid);
             int paying = ulist.get(j).getUserPoint() + relist.get(j).getprice();
             userdao.payCalc(userid, Integer.toString(paying));
             reservdao.deleteReserv(reservid);
          }
          }
          
       }

     response.sendRedirect("AdminManagementLodg.jsp");
     %>
</body>
</html>