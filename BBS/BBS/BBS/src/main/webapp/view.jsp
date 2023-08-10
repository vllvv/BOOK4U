<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

<link rel="stylesheet" href="css/custom.css">
<title>숙소 예약 사이트</title>
<style>
    p{
       font-family: sans-serif, serif;
       font-size: 13px;
    }
    </style>
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
      int bbsID = 0;
      if(request.getParameter("bbsID") != null) {
         bbsID = Integer.parseInt(request.getParameter("bbsID"));
      }
      if(bbsID == 0) {
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('유효하지 않은 글입니다.')");
         script.println("location.href = 'bbs.jsp'");
         script.println("</script>");
      }
      Bbs bbs = new BbsDAO().getBbs(bbsID);
   %>
   <!-- Navigation-->
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
               <li class="nav-item"><a class="nav-link" href="myPage.jsp">마이페이지</a></li>
               <li class="nav-item"><a class="nav-link" style="color: #B0B0B0;" href="logoutAction.jsp">로그아웃</a></li>
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
         <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            <thead>
               <tr>
                  <th colspan="3" style="background-color: snowblue; text-align: center;">QNA</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <td style="width: 20%;">글 제목</td>
                  <td colspan="2"><%= bbs.getBbsTitle() %></td>
               </tr>
               <tr>
                  <td>작성자</td>
                  <td colspan="2"><%= bbs.getUserID() %></td>
               </tr>
               <tr>
                  <td>작성일자</td>
                  <td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
               </tr>
               <tr>
  <td>내용</td>
  <td colspan="2" style="text-align: left;">
    <div id="content" style="height: 15em; overflow-y: scroll;">
      <%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
    </div>
  </td>
</tr>
               <tr>
                   <td>다운로드</td>
                   <td>
                   <%
                       BbsDAO bbsDAO = new BbsDAO();
                       ArrayList<String> fileList = bbsDAO.getFileList(bbsID);
                       
                       String directory = "c:/uploads/";
                       for(String file : fileList){
                           out.write("<a href=\"" + request.getContextPath() + "/downloadAction?file=" + java.net.URLEncoder.encode(file, "UTF-8") + "\">" + file + "</a><br>");
                       }
                   %>
                   </td>
               </tr>
            </tbody>
         </table>
         </div>
         </div></div>
<div class="container">
  <div class="row">
    <div class="col-lg-6">
      <a href="bbs.jsp" class="btn btn-primary">목록</a>
      <% if(userID != null && userID.equals(bbs.getUserID())) { %>
        <a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
      <% } %>
    </div>
    <div class="col-lg-6 text-lg-end">
      <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
    </div>
  </div>
</div>

   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
   </section>
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
    <script src="js/scripts_main.js"></script>
 <!-- Footer-->
        <footer class="footer py-4">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-4 text-lg-start">Copyright &copy; H4ck for U 2023</div>
                   <div class="col-lg-4 my-3 my-lg-0">
                    </div>
                <div class="col-lg-4 text-lg-end">
                   <img class="img-static" src="assets/img/teamlogo.png" style="width:200px;" alt="..." />
                </div>
            </div>
            </div>
        </footer>
</body>
</html>