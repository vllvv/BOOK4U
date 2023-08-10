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
<title>Book 4 U</title>
<link rel="icon" type="image/x-icon" href="assets/img/web-book4u.png" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
   crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
   rel="stylesheet" type="text/css" />
<link
   href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
   rel="stylesheet" type="text/css" />
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
         <a class="navbar-brand" href="#page-top"><img
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
               <li class="nav-item"><a class="nav-link" style="color: #B0B0B0;" href="logoutAction.jsp">로그아웃</a></li>
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
         <div class="masthead-subheading">Welcome To Our Website!</div>
         <div class="masthead-heading text-uppercase">WE ARE H4CK FOR U</div>
         <a class="btn btn-primary btn-xl text-uppercase" href="#services">Tell
            Me More</a>
      </div>
   </header>
   <!-- Portfolio Grid-->
   <section class="page-section bg-light" id="portfolio">
      <div class="container">
         <div class="text-center">
            <h2 class="section-heading text-uppercase">Tours</h2>
            <h3 class="section-subheading text-muted">Please choose the
               place you want to go</h3>
         </div>
         <div class="row">
            <div class="col-lg-4 col-sm-6 mb-4">
               <!-- Portfolio item 1-->
               <div class="portfolio-item">
                  <a class="portfolio-link" data-bs-toggle="modal"
                     href="#portfolioModal1">
                     <div class="portfolio-hover">
                        <div class="portfolio-hover-content">
                           <i class="fas fa-plus fa-3x"></i>
                        </div>
                     </div> <img class="img-fluid" src="assets/img/portfolio/state.jpg"
                     alt="..." />
                  </a>
                  <div class="portfolio-caption">
                     <div class="portfolio-caption-heading">State</div>
                     <div class="portfolio-caption-subheading text-muted">New
                        York, LA ...</div>
                  </div>
               </div>
            </div>
            <div class="col-lg-4 col-sm-6 mb-4">
               <!-- Portfolio item 2-->
               <div class="portfolio-item">
                  <a class="portfolio-link" data-bs-toggle="modal"
                     href="#portfolioModal2">
                     <div class="portfolio-hover">
                        <div class="portfolio-hover-content">
                           <i class="fas fa-plus fa-3x"></i>
                        </div>
                     </div> <img class="img-fluid" src="assets/img/portfolio/korea.jpg"
                     alt="..." />
                  </a>
                  <div class="portfolio-caption">
                     <div class="portfolio-caption-heading">Korea</div>
                     <div class="portfolio-caption-subheading text-muted">Seoul,
                        Busan ...</div>
                  </div>
               </div>
            </div>
            <div class="col-lg-4 col-sm-6 mb-4">
               <!-- Portfolio item 3-->
               <div class="portfolio-item">
                  <a class="portfolio-link" data-bs-toggle="modal"
                     href="#portfolioModal3">
                     <div class="portfolio-hover">
                        <div class="portfolio-hover-content">
                           <i class="fas fa-plus fa-3x"></i>
                        </div>
                     </div> <img class="img-fluid" src="assets/img/portfolio/china.jpg"
                     alt="..." />
                  </a>
                  <div class="portfolio-caption">
                     <div class="portfolio-caption-heading">China</div>
                     <div class="portfolio-caption-subheading text-muted">Beijing,
                        Shanghai ...</div>
                  </div>
               </div>
            </div>



         </div>
      </div>
      </div>
   </section>
   <!-- SKILLS-->
   <section class="page-section" id="services">
      <div class="container">
         <div class="text-center">
            <h2 class="section-heading text-uppercase">Skills</h2>
            <h3 class="section-subheading text-muted">웹 모의해킹을 위한 필요 역량</h3>
         </div>
         <div class="row text-center">
            <div class="col-md-4">
               <span class="fa-stack fa-4x"> <i
                  class="fas fa-circle fa-stack-2x text-primary"></i> <i
                  class="fas fa-shopping-cart fa-stack-1x fa-inverse"></i>
               </span>
               <h4 class="my-3">Communication</h4>
               <p class="text-muted">아무래도 팀원간의 소통이 가장 중요하겠죠? 저희는 정요순님을 팀장으로,
                  김건웅, 김세진, 김소정, 김호겸, 박지윤, 박형우, 배다현, 송원종, 신은비, 이지혜, 최윤석, 홍주연 총 13명으로
                  구성된 팀입니다:)</p>
            </div>
            <div class="col-md-4">
               <span class="fa-stack fa-4x"> <i
                  class="fas fa-circle fa-stack-2x text-primary"></i> <i
                  class="fas fa-laptop fa-stack-1x fa-inverse"></i>
               </span>
               <h4 class="my-3">Web Development</h4>
               <p class="text-muted">모의해킹을 할 수 있는 환경 구축도 중요합니다! 그럼 웹 개발은
                  필수~!XD 어떤 언어로 개발했을까요? 맞춰보세요</p>
            </div>
            <div class="col-md-4">
               <span class="fa-stack fa-4x"> <i
                  class="fas fa-circle fa-stack-2x text-primary"></i> <i
                  class="fas fa-lock fa-stack-1x fa-inverse"></i>
               </span>
               <h4 class="my-3">Web Security</h4>
               <p class="text-muted">우리의 목표는 뭐다? 바로 해킹이다! 바로 해킹 츄라이 츄라이~</p>
            </div>
         </div>
      </div>
   </section>


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
   <!-- Portfolio Modals-->
   <!--  여행지 클릭하면 숙박 사이트의 해당 국가 검색 페이지로 이동하도록 -->
   <!-- Portfolio item 1 modal popup-->
   <div class="portfolio-modal modal fade" id="portfolioModal1"
      tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="close-modal" data-bs-dismiss="modal">
               <img src="assets/img/close-icon.svg" alt="Close modal" />
            </div>
            <div class="container">
               <div class="row justify-content-center">
                  <div class="col-lg-8">
                     <div class="modal-body">
                        <!-- Project details-->
                        <h2 class="text-uppercase">State</h2>
                        <p class="item-intro text-muted">New York, LA ...</p>
                        <img class="img-fluid d-block mx-auto"
                           src="assets/img/portfolio/state.jpg" alt="..." />
                        <p>다양한 명소와 자연 경관: 미국은 자연의 아름다움과 다양한 명소로 유명합니다. 그렇기 때문에 그랜드
                           캐니언, 요세미티 국립공원, 뉴욕의 자유의 여신상 등과 같이 세계적으로 유명한 관광지를 포함한 다양한 자연 경관을
                           즐길 수 있습니다. 각 도시마다 고유한 문화와 역사가 있어서 미국 여행은 다양한 문화 체험의 기회를 제공합니다.
                           뉴욕의 브로드웨이 공연, 뉴올리언스의 재즈 음악, 샌프란시스코의 중국타운 등 여러 문화 체험을 즐길 수 있습니다.</p>
                        <ul class="list-inline">
                           <li><strong>Language:</strong> English</li>
                           <li><strong>Capital:</strong> Washington D.C.</li>
                        </ul>
                        <button class="btn btn-primary btn-xl text-uppercase"
                           data-bs-dismiss="modal" type="button">
                           <i class="fas fa-xmark me-1"></i> Close
                        </button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
   <div class="portfolio-modal modal fade" id="portfolioModal2"
      tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="close-modal" data-bs-dismiss="modal">
               <img src="assets/img/close-icon.svg" alt="Close modal" />
            </div>
            <div class="container">
               <div class="row justify-content-center">
                  <div class="col-lg-8">
                     <div class="modal-body">
                        <!-- Project details-->
                        <h2 class="text-uppercase">Korea</h2>
                        <p class="item-intro text-muted">Seoul, Busan ...</p>
                        <img class="img-fluid d-block mx-auto"
                           src="assets/img/portfolio/korea.jpg" alt="..." />
                        <p>한국은 오랜 역사와 풍부한 문화를 가지고 있습니다. 궁궐, 사찰, 전통 마을 등을 방문하여 한국의
                           고유한 역사와 문화를 체험할 수 있습니다. 또한 한국의 전통 의상인 한복을 입어보거나 한국의 전통 예술과 공예품을
                           감상할 수도 있습니다. 산, 바다, 호수 등 다양한 자연 지형을 즐길 수 있으며, 특히 가을에는 빛깔이 아름다운
                           단풍 구경을 즐길 수 있습니다. 또한 한국의 국립공원과 자연 보존 지역은 하이킹, 등산 등 야외 활동을 즐기기에
                           좋은 장소입니다.</p>
                        <ul class="list-inline">
                           <li><strong>Language:</strong> Korean</li>
                           <li><strong>Capital:</strong> Seoul</li>
                        </ul>
                        <button class="btn btn-primary btn-xl text-uppercase"
                           data-bs-dismiss="modal" type="button">
                           <i class="fas fa-xmark me-1"></i> Close
                        </button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- Portfolio item 3 modal popup-->
   <div class="portfolio-modal modal fade" id="portfolioModal3"
      tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="close-modal" data-bs-dismiss="modal">
               <img src="assets/img/close-icon.svg" alt="Close modal" />
            </div>
            <div class="container">
               <div class="row justify-content-center">
                  <div class="col-lg-8">
                     <div class="modal-body">
                        <!-- Project details-->
                        <h2 class="text-uppercase">China</h2>
                        <p class="item-intro text-muted">Lorem ipsum dolor sit amet
                           consectetur.</p>
                        <img class="img-fluid d-block mx-auto"
                           src="assets/img/portfolio/china.jpg" alt="..." />
                        <p>중국은 오랜 역사와 깊은 문화를 가진 나라로서, 중국 여행은 중국의 고대 유적지, 궁궐, 사찰 등을
                           방문하여 중국의 역사와 문화를 직접 체험할 수 있는 기회를 제공합니다. 또한 중국의 전통 예술, 공예품, 문화
                           행사 등도 매력적인 요소로 여행객들에게 인기가 있습니다. 절경이 아름다운 장소들이 많이 있어서 산, 강, 호수,
                           계곡 등을 탐험하거나 자연을 즐기는 등 야외 활동을 즐길 수 있습니다. 예를 들어, 장시간 걸리는 대만의 타로코
                           협곡이나 중국 남부의 금강 공원 등은 중국의 아름다운 자연 경관을 대표하는 명소입니다.</p>
                        <ul class="list-inline">
                           <li><strong>Language:</strong> Mandarin</li>
                           <li><strong>Capital:</strong> Beijing</li>
                        </ul>
                        <button class="btn btn-primary btn-xl text-uppercase"
                           data-bs-dismiss="modal" type="button">
                           <i class="fas fa-xmark me-1"></i> Close
                        </button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>

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