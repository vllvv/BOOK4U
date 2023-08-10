
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>

<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="search.lodgingDAO"%>

<%@ page import="search.Lodging"%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>



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
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		//추가한 부분
		String orderBy = request.getParameter("orderBy");
		String orderDir = request.getParameter("orderDir");
		if (orderBy == null || orderBy.isEmpty()) {
			orderBy = "title"; // 기본 정렬 기준
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

   <!-- Masthead-->
   <header class="masthead bg-light" style="padding-bottom:0;">
      <div class="container">
         <div class="masthead-heading text-uppercase">check suite!</div>
      </div>

      <!-- Portfolio Grid-->
      <section class="page-section bg-light" id="portfolio">
      <form method="post" name="search" action="searchLodging.jsp">
      <table class="pull-right" style="position:absolute;top:430px;right:139px">
         <tr>
            <td><select class="form-control" name="searchField" style="width:80px; margin-right:3px">
               <option value="title">이름</option>
               <option value="location">위치</option>
            </select></td>
            <td><input type="text" class="form-control"
               placeholder="검색어 입력" name="searchText" maxlength="100" style="width:98%"></td>
            <td><button type="submit" class="btn btn-success">검색</button></td>
         </tr>
      </table>
   </form>
         <div class="container bg-light">
            <div class="text-center bg-light">
               <h2 class="section-heading text-uppercase" style="color: #623703;">숙소 목록</h2>
            </div>
            			<div style="margin-right: 58px;" align="right" class="select-container" >
			    <select class="form-control" name="sorting" style="width: 140px; max-width: 100%; min-width: 140px;" onchange="handleSortingChange(this)">
			        <option value="title_desc" <%= orderBy.equals("title_desc") ? "selected" : "" %>>이름 (내림차순)</option>
			        <option value="title_asc" <%= orderBy.equals("title_asc") ? "selected" : "" %>>이름 (오름차순)</option>
			        <option value="price_desc" <%= orderBy.equals("price_desc") ? "selected" : "" %>>가격 (내림차순)</option>
			        <option value="price_asc" <%= orderBy.equals("price_asc") ? "selected" : "" %>>가격 (오름차순)</option>
			        <option value="location_desc" <%= orderBy.equals("location_desc") ? "selected" : "" %>>장소 (내림차순)</option>
			        <option value="location_asc" <%= orderBy.equals("location_asc") ? "selected" : "" %>>장소 (오름차순)</option>
			    </select>
			</div>
			<div style="height: 25px;"></div>
			<script>
			    function handleSortingChange(select) {
			        var selectedValue = select.value;
			        location.href = 'lodging.jsp?orderBy=' + selectedValue.split('_')[0] + '&orderDir=' + selectedValue.split('_')[1];
			    }
			</script>
            <div class="row">
               <div class="col-lg-4 col-sm-6 mb-4">

                  <%
                  search.lodgingDAO lodgingDAO = new search.lodgingDAO();
                  List<search.Lodging> lodgings = lodgingDAO.getAllLodgings(orderBy, orderDir);

                  for (search.Lodging lodging : lodgings) {
                  %>
                  <div class="portfolio-item"  style="background-color: none;">
                     <a href="lodgingDetails.jsp?id=<%=lodging.getId()%>">
                        <img src="<%=lodging.getImg()%>" alt="Lodging Image" style="width: 300px; height: 200px;">
                     </a>
                     <div class="portfolio-caption" style="background-color: transparent;">
                        <div class="portfolio-caption-heading" style="color: black;"><%=lodging.getTitle()%></div>
                        <div class="portfolio-caption-subheading text-muted" style="margin-left:9%; margin-bottom:9%; float:left;">
                           ₩
                           <%=lodging.getPrice()%></div>
                           <span class="portfolio-caption-subheading text-muted" style="margin-right:9%; margin-bottom:9%; float:right;"><%=lodging.getLocation()%></span>
                     </div>
                  </div>
                  </div>
                  <div class="col-lg-4 col-sm-6 mb-4">
                  <%
                  }
                  %>
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