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
</style>
<meta charset="utf-8" />
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Login :: Book 4 U</title>
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
               <li><a href="myPage.jsp">마이페이지</a></li>
               <li><a href="logoutAction.jsp">로그아웃</a></li>
            </ul>
            <%
            }
            %>
         </div>
      </div>
   </nav>
   <!-- Masthead-->
   <header class="masthead"
      style="background-image: url('assets/map-bg.jpg')">
      <div class="container">
         <div class="masthead-heading text-uppercase">login</div>
      </div>

      <section class="page-section bg-none" style="padding: 0rem;">

         <div class="container">
            <div class="text-center" style="margin: 0 auto;">


               <div class="jumbotron" style="padding-top: 20px;">
                  <form method="post" action="loginAction.jsp">
                     <div class="form-group">
                        <input type="text" class="form-control"
                           style="width: 350px; height: 45px; margin: 0 auto;"
                           placeholder="아이디" name="userID" maxlength="20">
                     </div>
                     <div class="form-group">
                        <input type="password" class="form-control"
                           style="width: 350px; height: 45px; margin: 0 auto;"
                           placeholder="비밀번호" name="userPassword" maxlength="20">
                     </div>
                     <input type="submit" class="btn btn-primary form-control"
                        style="width: 350px; height: 45px; margin: 0 auto;" value="로그인">
                  </form>

               </div>
               <div class="col-lg-4"></div>
            </div>
         </div>
      </section>
   </header>
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

   <!-- Bootstrap core JS-->
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
   <!-- Core theme JS-->
   <script src="js/scripts_main.js"></script>
   <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
   <!-- * *                               SB Forms JS                               * *-->
   <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
   <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
   <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>

</body>
</html>