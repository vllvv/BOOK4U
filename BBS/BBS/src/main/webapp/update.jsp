<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import = "user.UserDAO" %>
<%@ page import = "user.User" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

<title>숙소 예약 사이트</title>
<script src="https://sdk.amazonaws.com/js/aws-sdk-2.809.0.min.js"></script>
<script>
function checkFile()
{
      var fm  = document.fileForm;
      var fnm = fm.file;
      var ext = fnm.value;

      if( (ext.substr(ext.length-3) == 'jsp' || ext.substr(ext.length-3) == 'php' ||  ext.substr(ext.length-4) == 'jspx' || ext.substr(ext.length-3) == 'exe' || ext.substr(ext.length-4) == 'exec'))
      {
            alert("파일 확장자 명을 체크해주세요.");
            history.back();

            return false;
       }
       fm.submit();
}
</script>

 <style>
    p{
        font-family: sans-serif, serif;
        font-size: 13px;
    }
    </style>
    <meta name="description" content="" />
        <meta name="author" content="" />
        <title>BOOK 4 U</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/img/web-logo.png" />
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
                if (userID == null) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('먼저 로그인 해주세요.')");
                    script.println("location.href = 'bbs.jsp'");
                    script.println("</script>");
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
                UserDAO uD = new UserDAO();
                if(uD.getRole(userID) == 0 && !userID.equals(bbs.getUserID())) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('권한이 없습니다.')");
                    script.println("location.href = 'bbs.jsp'");
                    script.println("</script>");
                }
        %>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
            <!-- 로고 이미지 수정!!! -->
                <a class="navbar-brand" href="main.jsp"><img src="assets/img/horizon-logo.png" alt="..." /></a>
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
            }
          else if (uD.getRole(userID) == 1) {
                %>
                <ul class="nav navbar-nav navbar-right">
               <li class="nav-item"><a class="nav-link" href="Admin.jsp">관리자페이지</a></li>
               <li class="nav-item"><a class="nav-link" style="color: #B0B0B0;" href="logoutAction.jsp">로그아웃</a></li>
            </ul>
          <%

            } else{
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
                        <form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>" enctype="multipart/form-data" name="fileForm">
                                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                                        <thead>
                                                <tr>
                                                        <th colspan="2" style="background-color: #eeeeee; text-align: center;">QNA</th>
                                                </tr>
                                        </thead>
                                        <tbody>
                                                <tr>
                                                        <td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"></td>
                                                </tr>
                                                <tr>
                                                        <td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"><%= bbs.getBbsContent() %></textarea></td>
                                                </tr>
                                                <tr>

                                                        <td><input id="files" type="file" name="file" class="form-control"/></td>

                                                </tr>

                                        </tbody>

                                </table>
                                                <input id="button" type="submit" class="btn btn-primary pull-right" value="글 수정하기"  onclick="javascript:checkFile()">
                                                <script src="js/index.js"></script>
                                                <script src="js/putFile.js"></script>
                        </form>



                </div>
        </div>
</section>
        <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.js"></script>
    <script src="js/scripts_main.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
 <!-- Footer-->
        <footer class="footer py-4">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-4 text-lg-start">Copyright &copy; H4CK FOR U 2023</div>
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