<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@page import="java.io.*"%>

<%@ page import = "reserv.reservDAO"%>
<%@ page import = "reserv.reserv"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "user.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">



<style>
body {
	style ="backgroud-image: url("assets/img/header-bg.jpg");
}

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
<title>Suite :: BOOK 4 U</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/img/web-logo.png" />
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
	String check = null;
	try {
		check = request.getParameter("id");
		check = request.getParameter("title");
		check = request.getParameter("checkIn");
		check = request.getParameter("checkOut");
		check = request.getParameter("price");
	} catch(Exception e) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근')");
		script.println("window.location.href = '/BBS/lodging.jsp'");
		script.println("</script>");
	}
	String id = request.getParameter("id");
	String title = request.getParameter("title");
	String checkIn = request.getParameter("checkIn");
	String checkOut = request.getParameter("checkOut");
	String price = request.getParameter("price"); // 암호화 해제 필요
	
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('먼저 로그인 해주세요.')");
		script.println("window.location.href = '/BBS/login.jsp';");
		script.println("</script>");
	}
   	UserDAO userdao = new UserDAO();
	ArrayList<User> user_info = userdao.selectMember(userID);
	int paying = user_info.get(0).getUserPoint() - Integer.parseInt(price);
	userdao.payCalc(userID, Integer.toString(paying));
	
	reservDAO reservdao = new reservDAO();
	ArrayList<reserv> rlist = reservdao.Listreserv(userID);
	reserv reserv_data = new reserv();
	
	reserv_data.setuserID(userID);
	reserv_data.setid(Integer.parseInt(id));
	reserv_data.setprice(Integer.parseInt(price));
	reserv_data.setcheckin(checkIn);
	reserv_data.setcheckout(checkOut);
	reserv_data.setreservID(request.getParameter("reservid"));
	reserv_data.settitle(title);
	
	reservdao.insertreserv(reserv_data);
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
          else if (userdao.getRole(userID) == 1) {
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



	<!-- Masthead-->
	<header class="masthead bg-light" style="padding-bottom:0;">
		<div class="container">
			<div class="masthead-heading text-uppercase">Complete!</div>
		</div>

		<!-- Portfolio Grid-->
		<section class="page-section bg-light" id="portfolio">
			<div class="container bg-light">
				<div class="text-center bg-light">
					<h2 class="section-heading text-uppercase" style="color: #623703;">결제에 성공했습니다.</h2>
				</div>
				<br>
					<h4 class="section-heading text-uppercase" style="color: #623703;">예약번호 <%= request.getParameter("reservid") %></h2>
				<br><br>
				<div class="d-flex justify-content-center">
					<div class="col-lg-4 col-sm-6 mb-4">
						<!-- TODO -->
						<div class="col-sm-8">
							<div class="card-header"></div>
						</div>
						<form method="post" action="myPage.jsp">
							<button href="myPage.jsp" type="submit" class="btn btn-outline-primary">마이 페이지로</button>
						</form>
						<div class="col-lg-4"></div>
					</div>
				</div>
		
		</section>
	</header>


	<!-- Footer-->
	<footer class="footer py-4">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-4 text-lg-start">Copyright &copy; H4CK FOR
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