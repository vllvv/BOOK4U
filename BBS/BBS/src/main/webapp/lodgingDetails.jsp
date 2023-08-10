<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Random"%>
<%@ page import="org.apache.commons.lang3.RandomStringUtils"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="javax.servlet.*"%>

<%@ page import="search.lodgingDAO" %>
<%@ page import="search.Lodging" %>
<%@ page import="reserv.reservDAO" %>
<%@ page import="reserv.reserv" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>


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
<%--
.row {
   display: flex;
}
--%>
.row {
    padding-bottom: 100px;
}
.column {
   flex: 50%;
   padding: 10px;
   margin: 10px;
}
.flex-container {
    display: flex;
    justify-content: space-between;  /* Adjusts the spacing between the items */
}

.flex-item {
    margin: 10px; /* optional, just to add some spacing */
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
<%!
    public String urlConnection(String _url) throws Exception {
        URL url = null;
        BufferedReader reader = null;
        String image64 = "";
        
        url = new URL(_url);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        con.setReadTimeout(1000);
        con.connect();
        
        reader = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF8"));
        
        String inputLine = null;
        while ((inputLine = reader.readLine()) != null) {
            System.out.println(inputLine);
            image64 += inputLine;
        }
        
        reader.close();
        
        return image64;
    }
%>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		String orderBy = request.getParameter("orderBy");
		String orderDir = request.getParameter("orderDir");
		if (orderBy == null || orderBy.isEmpty()) {
			orderBy = "title"; // 기본 정렬 기준
		}
		if (orderDir == null || orderDir.isEmpty()) {
			orderDir = "DESC"; // 기본 정렬 방향
		}
		   UserDAO uD = new UserDAO();
		String img = request.getParameter("img");
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



	<!-- Masthead-->
	<header class="masthead bg-light" style="padding-bottom:10px;">
		<div class="container">
			<div class="masthead-heading text-uppercase">Check In Your Suite!<br></div>
		</div>
		
		</header>	

	<%
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("id"));
	} catch(Exception e) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근')");
		script.println("window.location.href = '/BBS/lodging.jsp'");
		script.println("</script>");
	}
 	int randomStrLen = 5;
	boolean useLetters = true;
	boolean useNumbers = true;
	String randomStr = RandomStringUtils.random(randomStrLen, useLetters, useNumbers);
	
	search.lodgingDAO lodgingDAO = new search.lodgingDAO();
	reservDAO reservDAO = new reservDAO();
	int reservCheck = reservDAO.reservCheck(request.getParameter("id"));
	if (reservCheck >= 10) {
		lodgingDAO.ConvReserv(request.getParameter("id"), false);
	}
	else {
		lodgingDAO.ConvReserv(request.getParameter("id"), true);
	}

	List<search.Lodging> lodging_info = lodgingDAO.getAllLodgingsDetail();
	for(int i = 0; i < lodging_info.size(); i++) {
		if(i+1 == Integer.parseInt(request.getParameter("id"))) {
	%>

		<script>
			var objPopup, reservid, payment, id, title, price, actionurl, checkIn, checkOut;
			id = <%= id %>;
			reservid = Date.now().toString() + "T" + "<%= randomStr %>";
			title = "<%= lodging_info.get(i).getTitle() %>";
			price = <%= lodging_info.get(i).getPrice() %>; // 암호화필요
		
			function openPop() {
				checkIn = document.getElementById('from').value;
				checkOut = document.getElementById('to').value;
				actionurl = "payment.jsp" + "?reservid=" + reservid + "&id=" + id + "&title=" + title
						+ "&price=" + price + "&checkIn=" + checkIn + "&checkOut=" + checkOut;
	
				objPopup = window.open(actionurl, "결제 중",
						'location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=579, height=526, left=600');
			}
			window.pay = function() {
				window.location.href = "paymentSuccess.jsp" + "?reservid=" + reservid + "&id=" + id + "&title=" + title
									+ "&price=" + price + "&checkIn=" + checkIn + "&checkOut=" + checkOut;
			}
			window.no = function() {
				window.location.href = "lodgingDetails.jsp?id=" + <%= lodging_info.get(i).getId() %> + "&img=" + "<%= lodging_info.get(i).getImg() %>";
			}
		</script>

		<section class="py-5">
			<div class="container px-4 px-lg-5 my-5">
				<div class="row gx-4 gx-lg-5 align-items-center">
					<div class="col-md-6">
						<img src="data:image/jpeg;base64,<%= urlConnection(request.getParameter("img")) %>" style="max-width: 100%; height: auto;"></img>
					</div>
					<div class="col-md-6">
						<h1 class="display-5 fw-bolder" style="margin-left:-10px;"><%=lodging_info.get(i).getTitle()%></h1>
						<div class="d-flex">
							<span style="margin-left:10px"><%= lodging_info.get(i).getPrice() %>원</span>
						</div>
						<div class="d-flex">
							<span style="margin-left:10px;">위치: <%= lodging_info.get(i).getLocation() %></span>
						</div>
						<%
						if (true == lodging_info.get(i).getReserv()) {
						%>
							<br>
							<span style="margin-left:10px;">예약 가능</span>
							<br><br>
							<div class="d-flex">
								<label for="from" style="margin-left:10px;">기간: &nbsp;</label>
								<input type="date" id="from" name="from">
								<label for="to">&nbsp;~&nbsp;</label>
								<input type="date" id="to" name="to">
							</div>
							<div class="d-flex">
							
								<button href="#;" class="btn btn-outline-primary" onclick="openPop();" style="margin-top:10px; margin-left:10px;">예약</button>
							</div>
							<br>
						<%
						} else {
						%>
							<span style="margin-left:10px;">예약 불가</span>
						<%
						}
						%>
						<br><br>
					</div>
					
					<div class="flex-container">
						<div class="flex-item" id="설명">
							<h2>설명</h2>
								<span class="portfolio-caption-subheading text-muted""><%= lodging_info.get(i).getDescription() %></span>
						</div>
						
						<div class="flex-item" id="후기">
							<h2>후기</h2>
							<span class="portfolio-caption-subheading text-muted">너무 좋았어요. ㅎㅎ</span>
						</div>
						<div>
						</div>
					</div>
				</div>
			</div>
		</section>
	<%
		}
	}
	%>
	
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