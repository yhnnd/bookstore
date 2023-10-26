<%@ page contentType="text/html" pageEncoding="utf-8"%>
<html>
<head>
<title>log out</title>
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body style="color:#333; font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif;">
        <script type="text/javascript">
            window.onload = function () {
                var i = 3;
                var TimeRemains = document.getElementById("TimeRemains");
                var timer = setInterval(function () {
                    if (i == 0) {
                        clearInterval(timer);
                    } else {
                        TimeRemains.innerHTML = i-1;
                        --i;
                    }
                }, 1000);
            }
        </script>
<%
	response.setHeader("refresh","3;URL=login.jsp");
	session.invalidate();
%>
    <div style="text-align:center;">
        <div class="alert alert-info" role="alert">you have quit the system</div>
        <h4>will be redirected to home page in <span class="timeShow" id="TimeRemains">3</span> seconds</h4>
        <h4>if page was not redirected, please click <a href="login.jsp">here</a></h4>
    </div>

	<script src="js/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
