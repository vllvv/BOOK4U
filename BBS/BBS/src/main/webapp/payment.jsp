
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>

<%@ page import = "user.UserDAO" %>
<%@ page import = "user.User" %>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>



<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width" initial-scale="1"> <%-- 모든 디바이스 최적화 --%>
<link rel="stylesheet" href="css/bootstrap.css"> <%-- bootstrap 불러오기 --%>
<link rel="stylesheet" href="css/custom.css">
<title>숙소 예약 사이트</title>
<style type="text/css"> <%-- 글 제목 디자인 --%>
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}

		.result {
		width: 21%;
		height: 300px;
		float: left;
		margin-left: 50px;
		margin-bottom: 50px;
	}

        
</style>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<span class="navbar-brand" href="#">ePay | 예약 결제</span>
		</div>
	</nav>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

    <!-- TODO -->

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
	
 	String pattern = "(19|20)\\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])";
    if (!Pattern.matches(pattern, checkIn) || !Pattern.matches(pattern, checkOut)) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('날짜를 확인 해주세요.')");
		script.println("window.close();");
		script.println("</script>");
    }
	
	Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(checkIn);
    Date format2 = new SimpleDateFormat("yyyy-MM-dd").parse(checkOut);
    long diffSec = (format2.getTime() - format1.getTime()) / 1000; //초 차이
    long diffDays = diffSec / (24*60*60); //일자수 차이
    if (diffDays <= 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('날짜를 확인 해주세요.')");
		script.println("window.close();");
		script.println("</script>");
    }
    
    String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('먼저 로그인 해주세요.')");
		script.println("window.close();");
		script.println("</script>");
	}
   	UserDAO userdao = new UserDAO();
	ArrayList<User> user_info = userdao.selectMember(userID);
	
	if (user_info.get(0).getUserPoint() < Integer.parseInt(price)) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('금액 부족.');");
		script.println("window.close();");
		script.println("</script>");
		return;
	}
	%>

	<br>
	<br>
	<div class="container">
		<div class="row">
			<div class="card col-sm-8">
				<div class="card-header"><h1 style="margin-top:-20px"><%= title %></h1></div>
				<div class="card-header"><p><%= checkIn %>~<%= checkOut %></p></div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item">
						<div class="form-group row">
							<div class="col-sm-12 mt-2">
								<input class="form-check-input" type="checkbox" value=""
									id="agreeall"> <label class="form-check-label"
									for="agreeall"> <b>전체 동의하기</b>
								</label>
							</div>
							<div class="col-sm-12 mt-2">
								<input class="form-check-input agree" type="checkbox" value=""
									id="agree1"> <label class="form-check-label"
									for="agree1" style="font-size: x-small;"> 예약 상품의 상세정보 확인
									및 결제진행 동의 </label>
							</div>
							<div class="col-sm-12 mt-2">
								<input class="form-check-input agree" type="checkbox" value=""
									id="agree2"> <label class="form-check-label"
									for="agree2" style="font-size: x-small;"> 거래정보 제공 동의
									(제공 받는 판매자 : BOOK 4 U) </label>
							</div>
						</div>
				</ul>
			</div>
			<div class="card col-sm-4">
				<div class="card-header">총 결제금액</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item">
						<h3>
							<b><%= price %></b>원
						</h3>
					</li>
				</ul>
			</div>
		</div>
	</div>
		<br>
		<br>
		<div class="text-center">
			<button class="btn btn-dark" id="paybtn" type="button" disabled>결제</button>
			<button class="btn btn-light" id="nobtn" type="button">취소</button>
		</div>
	<script>
        $(document).ready(function () {
            $('#paybtn').click(function () {
                opener.pay();
                window.close();
            })
            $('#nobtn').click(function () {
                opener.no();
                window.close();
            })


            $(".agree").click(function () {

                if ($('#agree1').is(':checked') && $('#agree2').is(':checked')) {
                    $("#agreeall").prop("checked", true);
                } else {
                    $("#agreeall").prop("checked", false);
                }

                if ($("#agreeall").is(':checked')) {
                    $("#paybtn").removeAttr("disabled");
                } else {
                    $("#paybtn").attr("disabled", "1");
                }
            })

            $("#agreeall").click(function () {
                if ($(this).is(':checked')) {
                    $('#agree1').prop("checked", true);
                    $('#agree2').prop("checked", true);
                    $("#paybtn").removeAttr("disabled");
                } else {
                    $('#agree1').prop("checked", false);
                    $('#agree2').prop("checked", false);
                    $("#paybtn").attr("disabled", "1");
                }
            })

        });
    </script>
</body>
</html> 