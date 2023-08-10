<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import = "user.UserDAO" %>
<%@ page import = "user.User" %>
<%@ page import = "reserv.reservDAO"%>
<%@ page import = "reserv.reserv"%>
<%@ page import = "search.lodgingDAO"%>
<%@ page import = "search.Lodging"%>
<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>마이페이지:: Book 4 U</title>
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

<style>  
   table {
    width: 100%;
    border-top: 1px solid #ffffff;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #dedede;
    padding: 10px;
  }
  a {
    color: black; 
    text-decoration: none; 
  }
  a:hover {
    color: #ffc800; 
    text-decoration: underline; 
  }
  .btn-container {
    text-align: right;
    margin-top: 10px;
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

<script>  
function deleteuserbtn(){
	  var gg = confirm('회원탈퇴하겠습니까?');
	  if (gg==true) {
		  location.href = 'deleteuser.jsp';
	  }
	  else {
		  alert('탈퇴 취소되었습니다.');
	  }
}

function deletereservbtn(btnid){
	  var gg = confirm('예약취소하겠습니까?');
	  if (gg==true) {
		  location.href = 'deleteReserv.jsp?reservID='+ btnid;
	  }
	  else {
		  alert('예약이 취소되지 않았습니다. 고객센터에 문의하세요');
	  }
}
 </script> 
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
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
   <header class="masthead"
      style="height: 5px; margin: 0 0 30px 0; background-image: url('assets/map-bg.jpg');">
      <div class="container">
         <div class="masthead-heading text-uppercase">MY PAGE</div>
      </div>
   </header>
	
	<div class="container">
	<h2 align="LEFT"> 회원정보 </h1>
	<hr style = "height:10px; border : 0px; border-top: 5px solid #000000 ">
       
    <table border="0", class="text-center" height=40 >
    <%
    UserDAO userdao = new UserDAO();
    ArrayList<User> list = userdao.selectMember(userID);
	for(int i = 0; i < list.size(); i++) {
	%>
		<tr style="height:10px;">
	         <td style="font-size:13pt; font-weight: bold;" height=40>회원이름</td>
	         <td style="font-size:13pt" ><%= list.get(i).getUserName() %></td>
	     </tr>
	     
	     <tr>
	         <td style="font-size:13pt; font-weight: bold;" height=40>ID</td>
	         <td style="font-size:13pt"><%out.println(userID);%></td>
	     </tr>
	     
	     <tr>
	         <td style="font-size:13pt; font-weight: bold;" height=40>이메일</td>
	         <td style="font-size:13pt" ><%= list.get(i).getUserEmail() %></td>
	     </tr>
	     <tr>
	         <td style="font-size:13pt; font-weight: bold;" height=40>적립 포인트</td>
	         <td style="font-size:13pt" ><%= list.get(i).getUserPoint()+"      point" %></td>
	         
	     </tr>
	     
	<% } %>
	 </table>
	 <hr style = "height:30px; border : 4px; border-top: 5px solid #FFFFFF ">
	 <div class="btn-container">
	 	<button class="btn btn-success" style="float:center;" onclick="deleteuserbtn()">회원탈퇴</button>
	 	<button class="btn btn-success" style="float:center;" onclick="location.href='changePassword.jsp'">비밀번호 변경</button>
	 </div>
	 <hr style = "height:40px; border : 0px; border-top: 5px solid #FFFFFF ">
	 <h2 align="LEFT" > 예약내역 </h1>
	 <hr style = "height:10px; border : 0px; border-top: 5px solid #000000 ">
	
	 		<div class="row">
	 		
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd"  >
			
				<thead>
				
					<tr >
						<th style="background-color: #eeeeee; text-align: center;">예약번호</th>
						<th style="background-color: #eeeeee; text-align: center;">숙소명</th>
						<th style="background-color: #eeeeee; text-align: center;">가격</th>
						<th style="background-color: #eeeeee; text-align: center;">체크인</th>
						<th style="background-color: #eeeeee; text-align: center;">체크아웃</th>
						<th style="background-color: #eeeeee; text-align: center;">예약취소</th>
					</tr>
				</thead>
				<tbody>
					<%
					reservDAO reservdao = new reservDAO();
					ArrayList<reserv> rlist = reservdao.Listreserv(userID);
					for(int i = 0; i < rlist.size(); i++) {
					%>
					<tr>
						<td><%= rlist.get(i).getreservID()%></td>
						
						<td><a href='lodgingDetails.jsp?id=<%=rlist.get(i).getid() %>'><%= rlist.get(i).gettitle() %></a></td>
						<td><%= rlist.get(i).getprice() %></td>
						<td><%= rlist.get(i).getcheckin()%></td>
						<td><%= rlist.get(i).getcheckout()%></td>
						<td><button class="btn btn-primary pull-left" onclick="deletereservbtn('<%= rlist.get(i).getreservID() %>')">취소</button></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>

		</div>
                
		
	</div>
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
