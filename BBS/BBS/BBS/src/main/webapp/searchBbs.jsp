<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="en">
    <head>
    <style>
    p{
    	font-family: sans-serif, serif;
    	font-size: 13px;
    }
    </style>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Book 4 U</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/img/web-book4u.png" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles_main.css" rel="stylesheet" />
    </head>
<body id="page-top">
   <%
   String userID = null;
        if(session.getAttribute("userID") != null) {
           userID = (String) session.getAttribute("userID");
        }
        int pageNumber = 1;
         if (request.getParameter("pageNumber") != null) {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
         }
         String orderBy = request.getParameter("orderBy");
         String orderDir = request.getParameter("orderDir");
         if (orderBy == null || orderBy.isEmpty()) {
            orderBy = "bbsID"; // 기본 정렬 기준
         }
         if (orderDir == null || orderDir.isEmpty()) {
            orderDir = "DESC"; // 기본 정렬 방향
         }
         String searchField = request.getParameter("searchField");
         if (searchField == null || searchField.isEmpty()) {
            searchField = "bbsTitle";
         }
         String searchText = request.getParameter("searchText");
         if (searchText == null || searchText.isEmpty()) {
            searchText = "";
         }
   %>
   <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
            <!-- 로고 이미지 수정!!! -->
                <a class="navbar-brand" href="main.jsp"><img src="assets/img/book4u.png" alt="..." /></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars ms-1"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
                        <li class="nav-item"><a class="nav-link" href="lodging.jsp">숙소</a></li>
                        <li class="nav-item"><a class="nav-link" href="bbs.jsp">QnA</a></li>
                    
                    			<%
				if(userID == null) {
			%>
				<li class="nav-item"><a class="nav-link" href="login.jsp">로그인</a></li>
				<li><a style="display: inline-block;padding: 10px 10px;border-radius: 10%;margin-top:-5px;border: 1px solid #ccc;text-decoration: none;background-color: #FCC600;color: #000000;" href="join.jsp">회원가입</a></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="myPage.jsp">마이페이지</a></li>
				<li><a href="logoutAction.jsp">로그아웃</a></li>
			</ul>
			<%
				}
			%>
                </div>
            </div>
        </nav>
        <header class="masthead" style="height:5px;  margin: 0 0 30px 0;">
            <div class="container">
                <div class="masthead-heading text-uppercase">QnA</div>
            </div>
        </header>
                <section class="page-section bg-none" id="portfolio">
   <div class="container">
      <div class="row">
      <!-- 여기부터 -->
         <form method="post" name="search" action="searchBbs.jsp">
         <table class="pull-right" style="margin-bottom:5px">
            <tr>
               <td><select class="form-control" name="searchField" style="width:90px; margin-right:3px">
                  <option value="bbsTitle">제목</option>
                  <option value="userID">작성자</option>
                  <option value="bbsContent">내용</option>
               </select></td>
               <td><input type="text" class="form-control"
                  placeholder="검색어 입력" name="searchText" maxlength="100" style="width:98%"></td>
               <td><button type="submit" class="btn btn-success">검색</button></td>
            </tr>
         </table>
       </form>
       <!-- 여기까지 -->
         <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            <thead>
             <tr>
                 <th style="background-color: #eeeeee; text-align: center;">
                     <a href="searchBbs.jsp?pageNumber=<%= pageNumber %>&orderBy=bbsID&orderDir=<%= (orderBy.equals("bbsID") && orderDir.equals("DESC")) ? "ASC" : "DESC" %>">
                         번호
                         <%
                             if (orderBy.equals("bbsID")) {
                                 if (orderDir.equals("ASC")) {
                         %>
                                     <span class="glyphicon glyphicon-triangle-top"></span>
                         <%
                                 } else {
                         %>
                                     <span class="glyphicon glyphicon-triangle-bottom"></span>
                         <%
                                 }
                             }
                         %>
                     </a>
                 </th>
                 <th style="background-color: #eeeeee; text-align: center;">
                     <a href="searchBbs.jsp?pageNumber=<%= pageNumber %>&orderBy=bbsTitle&orderDir=<%= (orderBy.equals("bbsTitle") && orderDir.equals("DESC")) ? "ASC" : "DESC" %>">
                         제목
                         <%
                             if (orderBy.equals("bbsTitle")) {
                                 if (orderDir.equals("ASC")) {
                         %>
                                     <span class="glyphicon glyphicon-triangle-top"></span>
                         <%
                                 } else {
                         %>
                                     <span class="glyphicon glyphicon-triangle-bottom"></span>
                         <%
                                 }
                             }
                         %>
                     </a>
                 </th>
                 <th style="background-color: #eeeeee; text-align: center;">
                     <a href="searchBbs.jsp?pageNumber=<%= pageNumber %>&orderBy=userID&orderDir=<%= (orderBy.equals("userID") && orderDir.equals("DESC")) ? "ASC" : "DESC" %>">
                         작성자
                         <%
                             if (orderBy.equals("userID")) {
                                 if (orderDir.equals("ASC")) {
                         %>
                                     <span class="glyphicon glyphicon-triangle-top"></span>
                         <%
                                 } else {
                         %>
                                     <span class="glyphicon glyphicon-triangle-bottom"></span>
                         <%
                                 }
                             }
                         %>
                     </a>
                 </th>
                 
                 <th style="background-color: #eeeeee; text-align: center;">
                     <a href="searchBbs.jsp?pageNumber=<%= pageNumber %>&orderBy=bbsDate&orderDir=<%= (orderBy.equals("bbsDate") && orderDir.equals("DESC")) ? "ASC" : "DESC" %>">
                         작성일
                         <%
                             if (orderBy.equals("bbsDate")) {
                                 if (orderDir.equals("ASC")) {
                         %>
                                     <span class="glyphicon glyphicon-triangle-top"></span>
                         <%
                                 } else {
                         %>
                                     <span class="glyphicon glyphicon-triangle-bottom"></span>
                         <%
                                 }
                             }
                         %>
                     </a>
                 </th>
             </tr>
         </thead>
            <tbody>
               <%
	               BbsDAO bbsDAO = new BbsDAO();
	               ArrayList<Bbs> list = bbsDAO.getSearch(pageNumber, orderBy, orderDir, searchField,
	                     searchText, response);
	               for (int i = 0; i < list.size(); i++) {
	                  %>
	                  <tr>
	                     <td><%=list.get(i).getBbsID()%></td>
	                     <%--현재 게시글에 대한 정보 --%>
	                     <td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
	                     .replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
	                     <td><%=list.get(i).getUserID()%></td>
	                     <td><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시"
	                     + list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
	                     <td style="display:none"><%=list.get(i).getBbsContent()%></td>
	                  </tr>
	                  <%
	               }

               %>
            </tbody>
         </table>
         <%
            if(pageNumber != 1) {
         %>
            <a href="searchBbs.jsp?pageNumber=<%= pageNumber - 1 %>&searchField=<%= searchField %>&searchText=<%= searchText %>" class="btn btn-success btn-arraw-left">이전</a>
         <%
            } 
            else if(bbsDAO.searchNextPage(pageNumber + 1, orderBy, orderDir, searchField, searchText)) {
         %>
            <a href="searchBbs.jsp?pageNumber=<%= pageNumber + 1 %>&searchField=<%= searchField %>&searchText=<%= searchText %>" class="btn btn-success btn-arraw-right">다음</a>
         <%
            }
         %>
         <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
      </div>
   </div>
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
   <script src="js/scripts_main.js"></script>
   <footer class="bg-dark mt-4 p-5 text-center" style="color: #000000;">
       Copyright &copy; H4ck for U All rights reversed.
   </footer>
</body>
</html> 