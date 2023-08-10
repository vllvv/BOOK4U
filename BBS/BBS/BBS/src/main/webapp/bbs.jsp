	<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html>
<html lang="en">
<head>
<style>
p {
   font-family: sans-serif, serif;
   font-size: 13px;
}

#btn_before {
   
   float:left;

    display: inline-block;
    padding: 0.375rem 0.75rem;

    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #fff;
    text-align: center;
    text-decoration: none;
    vertical-align: middle;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    user-select: none;
    border: 1px solid transparent;
    border-radius: 0.375rem;
    background-color: #198754;;
    transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

#btn_after {

   float:right;
   
    display: inline-block;
    padding: 0.375rem 0.75rem;

    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #fff;
    text-align: center;
    text-decoration: none;
    vertical-align: middle;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    user-select: none;
    border: 1px solid transparent;
    border-radius: 0.375rem;
    background-color: #198754;;
    transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}


</style>
<meta charset="utf-8" />
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>QnA :: Book 4 U</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/img/web-book4u.png" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
   crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
   rel="stylesheet" type="text/css" />
<link
   href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
   rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles_main.css" rel="stylesheet" />
</head>
<body id="page-top">
   <%
   String userID = null;
   if (session.getAttribute("userID") != null) {
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
   %>
   <!-- Navigation-->
   <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
      <div class="container">
         <!-- 로고 이미지 수정!!! -->
         <a class="navbar-brand" href="main.jsp"><img
            src="assets/img/book4u.png" alt="..." /></a>
         <button class="navbar-toggler" type="button"
            data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
            aria-controls="navbarResponsive" aria-expanded="false"
            aria-label="Toggle navigation">
            Menu <i class="fas fa-bars ms-1"></i>
         </button>
         <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
               <li class="nav-item"><a class="nav-link" href="lodging.jsp">숙소</a></li>
               <li class="nav-item"><a class="nav-link" href="bbs.jsp">QnA</a></li>

               <%
               if (userID == null) {
               %>
               <li class="nav-item"><a class="nav-link" href="login.jsp">로그인</a></li>
               <li><a
                  style="display: inline-block; padding: 10px 10px; border-radius: 10%; margin-top: -5px; border: 1px solid #ccc; text-decoration: none; background-color: #FCC600; color: #000000;"
                  href="join.jsp">회원가입</a></li>
            </ul>
            <%
            } else {
            %>
            <ul class="nav navbar-nav navbar-right">
               <li class="nav-item"><a class="nav-link" href="myPage.jsp">마이페이지</a></li>
               <li class="nav-item"><a class="nav-link"
                  style="color: #B0B0B0;" href="logoutAction.jsp">로그아웃</a></li>
            </ul>
            <%
            }
            %>
         </div>
      </div>
   </nav>
   <header class="masthead"
      style="height: 5px; margin: 0 0 30px 0; background-image: url('assets/map-bg.jpg');">
      <div class="container">
         <div class="masthead-heading text-uppercase">QnA</div>
      </div>
   </header>
   <section class="page-section bg-none">

      <div class="container">
         <div class="row">
         
            <form method="post" name="search" action="searchBbs.jsp">
                     <a href="write.jsp" class="btn btn-primary pull-left"
               style="border: none; background-color: #F8C848; float:left; color: #595959;">글쓰기</a>
               <table class="pull-right"
                  style="margin-bottom: 5px; border-spacing: 5px; float:right;">
                  <tr>
                     <td><select class="form-control" name="searchField"
                        style="width: 95%">
                           <option value="bbsTitle">제목</option>
                           <option value="userID">작성자</option>
                           <option value="bbsContent">내용</option>
                     </select></td>
                     <td><input type="text" class="form-control"
                        placeholder="검색어 입력" name="searchText" maxlength="100"
                        style="width: 98%"></td>
                     <td><button type="submit" class="btn btn-success">검색</button></td>
                              
                  </tr>
               </table>
            </form>
            <table class="table table-striped"
               style="text-align: center; border: 1px solid #dddddd">
               <thead>
                  <tr>
                     <th style="background-color: #eeeeee; text-align: center;">
                        <a style="text-decoration: none;"
                        href="bbs.jsp?pageNumber=<%=pageNumber%>&orderBy=bbsID&orderDir=<%=(orderBy.equals("bbsID") && orderDir.equals("DESC")) ? "ASC" : "DESC"%>">
                           <font color="#595959">번호</font> <%
 if (orderBy.equals("bbsID")) {
    if (orderDir.equals("ASC")) {
 %> <span
                           class="glyphicon glyphicon-triangle-top"></span> <%
 } else {
 %> <span
                           class="glyphicon glyphicon-triangle-bottom"></span> <%
 }
 }
 %>
                     </a>
                     </th>
                     <th style="background-color: #eeeeee; text-align: center;">
                        <a style="text-decoration: none;"
                        href="bbs.jsp?pageNumber=<%=pageNumber%>&orderBy=bbsTitle&orderDir=<%=(orderBy.equals("bbsTitle") && orderDir.equals("DESC")) ? "ASC" : "DESC"%>">
                           <font color="#595959">제목</font> <%
 if (orderBy.equals("bbsTitle")) {
    if (orderDir.equals("ASC")) {
 %> <span
                           class="glyphicon glyphicon-triangle-top"></span> <%
 } else {
 %> <span
                           class="glyphicon glyphicon-triangle-bottom"></span> <%
 }
 }
 %>
                     </a>
                     </th>
                     <th style="background-color: #eeeeee; text-align: center;">
                        <a style="text-decoration: none;"
                        href="bbs.jsp?pageNumber=<%=pageNumber%>&orderBy=userID&orderDir=<%=(orderBy.equals("userID") && orderDir.equals("DESC")) ? "ASC" : "DESC"%>">
                           <font color="#595959">작성자</font> <%
 if (orderBy.equals("userID")) {
    if (orderDir.equals("ASC")) {
 %> <span
                           class="glyphicon glyphicon-triangle-top"></span> <%
 } else {
 %> <span
                           class="glyphicon glyphicon-triangle-bottom"></span> <%
 }
 }
 %>
                     </a>
                     </th>

                     <th style="background-color: #eeeeee; text-align: center;">
                        <a style="text-decoration: none;"
                        href="bbs.jsp?pageNumber=<%=pageNumber%>&orderBy=bbsDate&orderDir=<%=(orderBy.equals("bbsDate") && orderDir.equals("DESC")) ? "ASC" : "DESC"%>">
                           <font color="#595959">작성일</font> <%
 if (orderBy.equals("bbsDate")) {
    if (orderDir.equals("ASC")) {
 %> <span
                           class="glyphicon glyphicon-triangle-top"></span> <%
 } else {
 %> <span
                           class="glyphicon glyphicon-triangle-bottom"></span> <%
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
                  ArrayList<Bbs> list = bbsDAO.getList(pageNumber, orderBy, orderDir); // 정렬 기준과 방향을 매개변수로 전달
                  for (int i = 0; i < list.size(); i++) {
                  %>
                  <tr>
                     <td><%=list.get(i).getBbsID()%></td>
                     <td><a style="text-decoration: none;"
                        href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle()%></a></td>
                     <td><%=list.get(i).getUserID()%></td>
                     <td><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시"
      + list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
                  </tr>
                  <%
                  }
                  %>
               </tbody>
            </table>


         </div>
                     <%
            if (pageNumber != 1) {
            %>
            <a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>"
               id='btn_before' style="background-color: #595959;">이전</a>
            <%
            }
            if (bbsDAO.nextPage(pageNumber + 1)) {
            %>
            <a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>"
               id='btn_after' style="background-color: #595959;">다음</a>
            <%
            }
            %>
      </div>
   </section>
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
   <script src="js/scripts_main.js"></script>
   <!-- Footer-->
   <footer class="footer py-4">
      <div class="container">
         <div class="row align-items-center">
            <div class="col-lg-4 text-lg-start">Copyright &copy; H4ck for
               U 2023</div>
            <div class="col-lg-4 my-3 my-lg-0"></div>
            <div class="col-lg-4 text-lg-end">
               <img class="img-static" src="assets/img/teamlogo.png"
                  style="width: 200px;" alt="..." />
            </div>
         </div>
      </div>
   </footer>
</body>
</html>