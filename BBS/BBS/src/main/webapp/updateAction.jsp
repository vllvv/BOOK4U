<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import = "user.UserDAO" %>
<%@ page import = "user.User" %>
<%@ page import="java.io.PrintWriter" %>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.File" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="com.oreilly.servlet.MultipartRequest" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>숙소 예약 사이트</title>
<script src="https://sdk.amazonaws.com/js/aws-sdk-2.809.0.min.js"></script>
<script src="js/index.js"></script>
<script src="js/putFile.js"></script>
</head>
<body>
        <%
                String userID = null;

        String directory = "/home/ubuntu/tomcat/webapps/BBS/uploads";
        int maxSize = 1024 * 1024 * 100;
        String encoding = "UTF-8";

        MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());

        String fileName=multipartRequest.getOriginalFileName("file");
        String fileRealName = multipartRequest.getFilesystemName("file");
        String title=multipartRequest.getParameter("bbsTitle");
        String content=multipartRequest.getParameter("bbsContent");
        //String userId=multipartRequest.getParameter("userID");

                if(session.getAttribute("userID") != null) {
                        userID = (String) session.getAttribute("userID");
                }
                if(userID == null) {
                        PrintWriter script = response.getWriter();
                        script.println("<script>");
                        script.println("alert('먼저 로그인 해주세요.')");
                        script.println("location.href = 'login.jsp'");
                        script.println("</script>");
                }

                int bbsID = 0;
                String b_ID = multipartRequest.getParameter("bbsID");
                if(b_ID == null || b_ID.isEmpty() || b_ID == "0"){
                        PrintWriter script = response.getWriter();
                        script.println("<script>");
                        script.println("alert('유효하지 않은 글입니다.')");
                        script.println("location.href = 'bbs.jsp'");
                        script.println("</script>");
                }
                bbsID = Integer.valueOf(b_ID);
                if(request.getParameter("bbsID") != null) {
                        bbsID = Integer.parseInt(request.getParameter("bbsID"));
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
                else {
                        if(title == null || content == null || content.isEmpty() || title.isEmpty()) {
                                PrintWriter script = response.getWriter();
                                script.println("<script>");
                                script.println("alert('입력이 안 된 항목이 있습니다.')");
                                script.println("history.back()");
                                script.println("</script>");
                        } else {
                                BbsDAO bbsDAO = new BbsDAO();
                                int result = bbsDAO.update(bbsID, title, content, fileName, fileRealName);
                                if (result == -1) {
                                        PrintWriter script = response.getWriter();
                                        script.println("<script>");
                                        script.println("alert('글 수정에 실패했습니다.')");
                                        script.println("history.back()");
                                        script.println("</script>");
                                }
                                else if (result != -1 && uD.getRole(userID) == 0 && userID.equals(bbs.getUserID())){
                                        PrintWriter script = response.getWriter();
                                        script.println("<script>");
                                        script.println("location.href = 'bbs.jsp'");
                                        script.println("</script>");
                                }else if (result != -1 && uD.getRole(userID) == 1 ){
                                        PrintWriter script = response.getWriter();
                                        script.println("<script>");
                                        script.println("location.href = 'AdminManagementQna.jsp'");
                                        script.println("</script>");
                                }
                        }
                }
        %>
</body>
</html>