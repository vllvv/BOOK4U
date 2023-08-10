<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">



<script>
$(document).ready(function(){
  $(".nav-link").click(function(e){
    e.preventDefault();
    var tab = $(this).text();

    $(".content").hide();
    $("#" + tab).show();
  });
});
</script>
<style>
body {
	style ="backgroud-image: url("assets/img/header-bg.jpg");
}

p {
	font-family: sans-serif, serif;
	font-size: 13px;
}
<%--
.row {
   display: flex;
}
--%>
.row {
   padding-left: 10%;
    padding-right: 10%;
    padding-bottom: 100px;
}
.column {
   flex: 50%;
   padding: 10px;
   margin: 10px;
}
</style>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Suite :: Book 4 U</title>
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
	
	<!-- Masthead-->
	<header class="masthead bg-light" style="padding-bottom:10px;">
		<div class="container">
			<div class="masthead-heading text-uppercase">Check In Your Suite!<br></div>
		</div>
		
		</header>	
	
	
	
   
   <%
      String id = request.getParameter("id");
       String url = "jdbc:mysql://localhost:3306/BBS";
       String user = "root";
       String password = "root";
       String lodgingLocation ="";
       
       try {
           Class.forName("com.mysql.cj.jdbc.Driver");
           Connection conn = DriverManager.getConnection(url, user, password);
           Statement stmt = conn.createStatement();
           ResultSet rs = stmt.executeQuery("SELECT title, price, location, reserv, img, description FROM lodging WHERE id = " + id);
   %>
      <% while (rs.next()) { %>
      <% lodgingLocation = rs.getString(6); %>
         <section class="py-5">
         <div class="container px-4 px-lg-5 my-5">
            <div class="row gx-4 gx-lg-5 align-items-center">
               <div class="col-md-6">
                  <img src="<%= rs.getString(5) %>" style="width:90%; height:90%; float:left;">
               </div>
                  <div class="col-md-6">
                        <h1 class="display-5 fw-bolder" style="margin-left:10px;"><%= rs.getString(1) %></h1>
                        <div class="fs-5 mb-5">
                           <span style="margin-left:10px"><%= rs.getString(2) %>원</span>
                        </div>
                        <p style="margin-left:10px;">위치: <%= rs.getString(3) %></p>
                           <%
                              if ("1".equals(rs.getString(4))) {
                           %>   <p style="margin-left:10px;">예약 가능</p> <%
                              } else {
                           %> <p style="margin-left:10px;">예약 불가</p> <%
                              }
                           %>
                           <div class="d-flex" style="margin-left:10px;">
                                  <form action="payment.jsp">
                                  <input type="hidden" id="id" name="id" value="<%= id %>">
                                  <button type="submit" class="btn btn-outline-primary">예약</button>
                           </form>
                               </div>
                               <br><br>
                           <ul class="nav nav-tabs" style="margin-left:10px;">
                          <li class="nav-item" style="margin-left:10px;">
                            <a class="nav-link active" aria-current="page" href="#">설명</a>
                          </li>
                          <li class="nav-item">
                            <a class="nav-link" href="#">후기</a>
                          </li>
                        </ul>
                        <div class="content" id="설명" style="display: block;" style="margin-left:10px;">
                        <%
                           BufferedReader reader = null;
                           try {
                              String filePath = application.getRealPath("./des/" + lodgingLocation);
                              reader = new BufferedReader(new FileReader(filePath));
                              while (true) {
                                 String str = reader.readLine();
                                 if (str == null)
                                    break;
                                 //--out.println(str + "<br>");
                                 %><p><%= str %></p>
                        <%
                              }
                           } catch (FileNotFoundException fnfe) {
                              out.println("&nbsp;&nbsp;&nbsp;파일이 존재하지 않습니다.");
                           } catch (IOException ioe) {
                              out.println("&nbsp;&nbsp;&nbsp;파일을 읽을수 없습니다.");
                           } finally {
                              try {
                                 reader.close();
                              } catch (Exception e) {
                     
                              }
                           }
                        %>
                        </div>
                        <div class="content" id="후기" style="display: none;"><p>너무 좋았어요. ㅎㅎ</p></div>
                       </div>

                  </div>
            </div>
       </section>
      <% } %>
   <%
           rs.close();
           stmt.close();
           conn.close();
       } catch (Exception e) {
           e.printStackTrace();
       }
   %>
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
				<div class="col-lg-4"></div>
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