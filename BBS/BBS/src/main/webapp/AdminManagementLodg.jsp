<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import = "user.UserDAO" %>
<%@ page import = "user.User" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "reserv.reservDAO" %>
<%@ page import = "reserv.reserv" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>관리자 페이지</title>
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
<script>

var temp = null;

function toggleAll(source) {
    var checkboxes = document.getElementsByName('checkId');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = source.checked;
    }
}

function validateForm() {
    var checkboxes = document.getElementsByName('checkId');
    var isChecked = false;
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            isChecked = true;
            break;
        }
    }

    if (!isChecked) {
        alert("예약내역을 변경할 회원을 선택해주세요.");
        return false;
    }
    
    if (confirm("선택한 예약내역을 취소하겠습니까?")){
    	return true;
    }else{
    	alert("예약취소가 완료되지 않았습니다.")
    	return false;
    	
    }

    return true;
}
</script>
</head>
<body id="page-top">
<%
    String userID = null;
    if(session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    
	String orderBy = request.getParameter("orderBy");
	String orderDir = request.getParameter("orderDir");
	if (orderBy == null || orderBy.isEmpty()) {
		orderBy = "userID"; // 기본 정렬 기준
	}
	if (orderDir == null || orderDir.isEmpty()) {
		orderDir = "DESC"; // 기본 정렬 방향
	}
	String searchField = request.getParameter("searchField");
    if (searchField == null || searchField.isEmpty()) {
       searchField = "userID";
    }
    String searchText = request.getParameter("searchText");
    if (searchText == null || searchText.isEmpty()) {
       searchText = "";
    }
    // pagination
    int userPage = 1;
    int usersPerPage = 10; // 데이터를 10개씩 출력
    if(request.getParameter("page") != null) {
    	userPage=Integer.parseInt(request.getParameter("page"));
    }
    int start = (userPage-1) * usersPerPage;
    int total = 0;
    int numOfPages = 0;
    UserDAO uD = new UserDAO();
    
    if (uD.getRole(userID) != 1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'main.jsp'");
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
        <div class="masthead-heading text-uppercase">Admin</div>
    </div>
</header>
<section class="page-section bg-none" id="portfolio">

    <div class="container">
        <div class="row">

            <nav class="navbar bg-body-tertiary">
            
            
			  <div class="container-fluid center-div">
			    <ul class="nav justify-content-end">
				  <li class="nav-item">
				    <a class="nav-link active" aria-current="page" href="Admin.jsp" style="color:#000000">회원 관리</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link active" href="AdminManagementPoint.jsp" style="color:#000000">포인트 관리</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link active" href="AdminManagementQna.jsp" style="color:#000000">QnA 관리</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link active" href="AdminManagementLodg.jsp">예약 관리</a>
				  </li>
				</ul>
			  </div>
			</nav>
            <div style="height: 25px;"></div>

            
			
			
			<form id="Management" action="AdminDeleteReservAction.jsp" method="post" onsubmit="return validateForm();" class="admin-form">
                <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                    <thead>
                    
                        <tr>
                            <th colspan="7" style="background-color: #eeeeee; text-align: center" >예약 관리</th>
                        </tr>
                        <!-- --------------------------			검색 및 정렬		---------------------------------- -->
                    	<tr>
                            <td>
							<div style="margin-right: 58px;" align="right" class="select-container" >
							    <select class="form-control" name="sorting" style="width: 170px; max-width: 100%; min-width: 170px;" onchange="handleSortingChange(this)">
							    	<option value="reservID_desc" <%= (orderBy + "_" + orderDir).equals("reservID_desc") ? "selected=\"selected\"" : "" %>>예약번호 (내림차순)</option>
									<option value="reservID_asc" <%= (orderBy + "_" + orderDir).equals("reservID_asc") ? "selected=\"selected\"" : "" %>>예약번호 (오름차순)</option>
									<option value="userID_desc" <%= (orderBy + "_" + orderDir).equals("userID_desc") ? "selected=\"selected\"" : "" %>>회원ID (내림차순)</option>
									<option value="userID_asc" <%= (orderBy + "_" + orderDir).equals("userID_asc") ? "selected=\"selected\"" : "" %>>회원ID (오름차순)</option>
									<option value="title_desc" <%= (orderBy + "_" + orderDir).equals("title_desc") ? "selected=\"selected\"" : "" %>>숙소명 (내림차순)</option>
									<option value="title_asc" <%= (orderBy + "_" + orderDir).equals("title_asc") ? "selected=\"selected\"" : "" %>>숙소명 (오름차순)</option>
							    </select>
							</div>
							
							<script>
							    function handleSortingChange(select) {
							        var selectedValue = select.value;
							        location.href = 'AdminManagementLodg.jsp?orderBy=' + selectedValue.split('_')[0] + '&orderDir=' + selectedValue.split('_')[1]+'&formName=Management';
							    }
							</script>
							</td>
							
							
							

							<td><select class="form-control" id="searchFiled" name="searchField" style="width:100px;">
				               <option value="userID">회원ID</option>
				               <option value="title">숙소명</option>
				               <option value="reservID">예약번호</option>
				            </select></td>
				            <td><input type="text" class="form-control"
				               placeholder="검색어 입력" id="searchText" name="searchText" maxlength="100" style="width:98%;"></td>
				            <td><button type="button" class="btn btn-success" onclick="searching()">검색</button></td>
				            <td></td>
				            <td></td>
				            <td></td>
				            <script>
							    function searching() {
							    	var inputField = document.getElementById("searchFiled");
							        var inputText = document.getElementById("searchText");
							        searchText = inputText.value;
							        searchField = inputField.value;
							        location.href = 'AdminManagementLodg.jsp?searchField=' + searchField + '&searchText=' + searchText+'&formName=Management';
							    }
							</script>
							</tr>
							
							<!-- ------------------------------------------------------------------------- -->
                        <tr>
                            <th><input type="checkbox" name="allcheck" onchange="toggleAll(this)"></th>
                            <th> 회원ID </th>
	                        <th> 숙소명 </th>
	                        <th> 가격 </th>
	                        <th> 예약번호 </th>
	                        <th> 체크인 </th>
	                        <th> 체크아웃 </th>
                        </tr>
                    </thead>
                    
                    
                    <!-- --------------------------				페이징 처리 된 데이터 내용				 -->
                    <tbody align="center">
						<%
						if (searchText=="") {
							reservDAO reservdao = new reservDAO();
							reservDAO reservdao2 = new reservDAO(); // 페이징을 위한 sql
							total = reservdao2.getMax(searchField, searchText); // 검색한 모든 데이터
							numOfPages = (int) Math.ceil((double) total / usersPerPage);
							
							ArrayList<reserv> list = reservdao.AllListreserv(orderBy, orderDir, usersPerPage, start);
							for (int i = 0; i< list.size(); i++){
								%>
								<tr>
				                  	<td>
		                                <input type="checkbox" name="checkId" value="<%=list.get(i).getreservID()%>">
		                            </td>
				                  	<td> <%=list.get(i).getuserID() %></td>
				                  	<td> <%=list.get(i).gettitle() %></td>
				                  	<td> <%=list.get(i).getprice() %></td>
				                  	<td> <%=list.get(i).getreservID() %></td>
				                  	<td> <%=list.get(i).getcheckin() %></td>
				                  	<td> <%=list.get(i).getcheckout() %></td>
				                  </tr>
				                <%
				           	}
						} else {
							reservDAO reservdao = new reservDAO();
							reservDAO reservdao2 = new reservDAO(); // 페이징을 위한 sql
							total = reservdao2.getMax(searchField, searchText); // 검색한 모든 데이터
							numOfPages = (int) Math.ceil((double) total / usersPerPage);
							
							ArrayList<reserv> list = reservdao.SearchAllListreserv(searchField, searchText, orderBy, orderDir, usersPerPage, start);
							
							for (int i = 0; i< list.size(); i++){
								%>
								<tr>
				                  	<td>
		                                <input type="checkbox" name="checkId" value="<%=list.get(i).getreservID()%>">
		                            </td>
				                  	<td> <%=list.get(i).getuserID() %></td>
				                  	<td> <%=list.get(i).gettitle() %></td>
				                  	<td> <%=list.get(i).getprice() %></td>
				                  	<td> <%=list.get(i).getreservID() %></td>
				                  	<td> <%=list.get(i).getcheckin() %></td>
				                  	<td> <%=list.get(i).getcheckout() %></td>
				                  </tr>
				                <%
							}
						}
					
						%>
						</tbody>
						<!-- -------------------------------------------------- -->
                </table>
                <!-- -------------------			페이지 						-->
                <table align ="center">
				<tr>
				<%
				for (int i = 1; i <= numOfPages; i++) {
						    if (i == userPage) {
						%>
						        <td><%= i %></td> <!-- Current page number -->
						<%
						    } else {
						%>
						        <td><a href="?page=<%= i %>"><%= i %></a></td> <!-- Link to other pages -->
						<%
						    }
						}
						%>
					 </tr>
					 </table>
					 <!-- ------------------------------------------------------------- -->
                <table align="center">
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr align="center">
                    	<td><input type="submit" class="btn btn-primary pull-right" value="예약 삭제"></td>
                    </tr>
                </table>
            </form>
            
            
        </div>
    </div>
</section>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/scripts_main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Footer-->
<footer class="footer py-4">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-4 text-lg-start">Copyright &copy; H4CK FOR U 2023
            </div>
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