﻿<%@ page contentType="text/html" language="java" import="java.util.*,java.sql.*,javax.servlet.http.Cookie" pageEncoding="utf-8"%>
<html>
<head>
    <title>LOG&nbsp;IN</title>
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>

<body>

<%
		String DBDRIVER = "sun.jdbc.odbc.JdbcOdbcDriver" ;
		String DBURL="jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ=C:\\Program Files (x86)\\Apache Software Foundation\\Tomcat 7.0\\webapps\\BookStorePoweredbyAccess\\Access\\db.mdb";
		Connection conn = null ;//should import java.sql.*
		Statement stmt = null ;
		String sql = null ;
		String sqlQuery = null;
		ResultSet rs = null;
		
		try
		{
			Class.forName(DBDRIVER) ;
		}
		catch(Exception e)
		{
			out.println("<div class='db-info alert alert-danger' role='alert'>数据库驱动程序加载失败！</div>") ;
			e.printStackTrace();
		}

		try
		{
			conn = DriverManager.getConnection(DBURL) ;
			stmt = conn.createStatement();
			out.println("<div class='db-info alert alert-success' role='alert'>数据库连接成功.</div>") ;
			
		}
		catch(Exception e)
		{
			out.println("<div class='db-info alert alert-danger' role='alert'>数据库连接失败！</div>") ;
			e.printStackTrace();
		}

		try{
			sqlQuery = "select * from person";
			rs = stmt.executeQuery(sqlQuery);
		}
		catch(Exception e){
			out.println("<div class='db-info alert alert-danger' role='alert'>数据库查詢失败！</div>");
			e.printStackTrace();
		}

%>

<div class="Form Jumbotron"><!-- from dark blue to light blue -->
</div>
<div class="Middle Jumbotron"><!-- from light blue to white -->
</div>
<div class="Footer Jumbotron"><!-- from white to brown -->
</div>
<div class="container">
	<div class="table-background">
		<table style="width:100%">
			<tbody>
				<tr>
					<td align="center">
						<form id="LoginForm" action="login.jsp" method="post">
							<div class="FormLine input-group input-group-lg">
								<span class="input-group-addon" id="sizing-addon1">username</span>
								<input type="text" name="username" class="form-control" placeholder="required" aria-describedby="sizing-addon1">
							</div>
							<br>
							<div class="FormLine input-group input-group-lg">
								<span class="input-group-addon" id="sizing-addon1">password</span>
								<input type="password" name="password" class="form-control" placeholder="required" aria-describedby="sizing-addon1">
							</div>
							<br>
							<div class="FormLine">
								<div class="btn-group btn-group-justified" role="group" aria-label="...">
									<div class="btn-group" role="group">
										<input type="button" class="btn btn-success btn-lg" value="log in" onclick="login_form_submit('LoginForm')" id="btn_login">
									</div>
									<div class="btn-group" role="group">
										<input type="reset" class="btn btn-primary btn-lg" value="reset" onclick="login_form_reset('LoginForm')" id="btn_reset">
									</div>
								</div>
							</div>
							<div class="FormLine" style="margin-top:40px;">
										<div class="input-group">
											<input class="form-control"  type="text" readonly="true" disabled="true" name="remember_password" value=" remember my password ">
											<div class="input-group-btn">
												<button type="button" class="btn btn-default" name="remember_password" value ="false" onclick="remember_password_switch(this)" id="remember_password_off">No</button>
												<button type="button" class="btn btn-default" name="remember_password" value ="false" onclick="remember_password_switch(this)" id="remember_password_on">Yes</button>
											</div>
										</div>
							</div>
						</form>
					</td>
				</tr>
			</tbody>
		</table>
	</div><!-- table background -->
</div><!-- container -->

		<script type="text/javascript" language="javascript">
			function loginPageInit(){
					console.log("function loginPageInit():");
					document.getElementsByClassName("Form")[0].style.height = window.innerHeight / 3;
					document.getElementsByClassName("Middle")[0].style.height = window.innerHeight / 3 - 100;
					document.getElementsByClassName("Footer")[0].style.height = window.innerHeight / 3;
					console.log("colorful background div height set");
					document.getElementsByClassName("table-background")[0].style.top = - parseInt((window.innerHeight+40)*2/3);
					console.log("login form position set");
			}
			loginPageInit();
			function remember_password_switch_on(){
					var btn = document.getElementById("remember_password_on");
					var btn_oppose = document.getElementById("remember_password_off");
					btn.setAttribute("value","true");
					btn.setAttribute("class","btn btn-success active");
					btn_oppose.setAttribute("value","false");
					btn_oppose.setAttribute("class","btn btn-default");
			}
			function remember_password_switch_off(){
					var btn = document.getElementById("remember_password_off");
					var btn_oppose = document.getElementById("remember_password_on");
					btn.setAttribute("value","true");
					btn.setAttribute("class","btn btn-danger active");
					btn_oppose.setAttribute("value","false");
					btn_oppose.setAttribute("class","btn btn-default");
			}
			function remember_password_switch(btn){
				if( btn.id=="remember_password_off" && btn.value=="false"
				|| btn.id=="remember_password_on" && btn.value=="true" ){
					remember_password_switch_off();
				} else {
					remember_password_switch_on();
				}
			}

			function login_form_submit(form_name){
				var myForm = document.getElementById(form_name);
				var remember_password = "false";
				if(document.getElementById("remember_password_on").getAttribute("value") == "true"
				|| document.getElementById("remember_password_off").getAttribute("value") == "false"){
					remember_password = "true";
				}
				var myInput = document.createElement("input");
				myInput.setAttribute("name","remember_password");
				myInput.setAttribute("value",remember_password);
				myInput.setAttribute("type","text");
				myInput.setAttribute("class","hidden");
				myForm.appendChild(myInput);
				myForm.submit();
				myInput.removeChild(myInput);
			}

			function login_form_reset(form_name){
				var myForm = document.getElementById(form_name);
				myForm.reset();
				// codes below fixed the bug that
				// <input type='reset'> cannot reset <input name='password'>.value
				// when <input name='remember_password'>.value == "true"
				var InputUsername = document.getElementsByName("username")[0];
				InputUsername.removeAttribute("value");
				var InputPassword = document.getElementsByName("password")[0];
				InputPassword.removeAttribute("value");
			}
		</script>

<%
		Cookie[] cookies = request.getCookies();
		String[] Remember_Password = request.getParameterValues("remember_password");
		if( Remember_Password != null && Remember_Password[0].equalsIgnoreCase("false") ){// delete cookie password
%>
		<script type="text/javascript">
			console.log("remember_password == '" + <%=Remember_Password[0]%> + "'");
			console.log("deleting cookie");
		</script>
<%
			if( cookies != null ){
				for(int i = 0; i < cookies.length; i++){
					if( cookies[i].getName().equalsIgnoreCase("Account_Name") ){// no need to delete cookie username
					} else if( cookies[i].getName().equalsIgnoreCase("Account_Password") ){
%>
		<script type="text/javascript">
			console.log("deleting cookie password");
		</script>
<%
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
					}
				}
			}
		}// delete cookie password
		// get cookie.username and cookie.password
		String Account_Name = null;
		String Account_Key = null;
		if( cookies != null ){
			for(int i = 0; i < cookies.length; i++){
				if( cookies[i].getName().equalsIgnoreCase("Account_Name") ){
					Account_Name = cookies[i].getValue();
				} else if( cookies[i].getName().equalsIgnoreCase("Account_Password") ){
					Account_Key = cookies[i].getValue();
				}
			}
		}
		if( Account_Name != null && !Account_Name.equals("")
		&& Account_Key != null && !Account_Key.equals("") ){
%>
		<script type="text/javascript" language = "javascript" >
				// Set <input name="username">.value = Cookie_Account_Username
				var InputUsername = document.getElementsByName("username")[0];
				InputUsername.setAttribute("value","<%=Account_Name%>");
				// Set <input name="password">.value = Cookie_Account_Password
				var InputPassword = document.getElementsByName("password")[0];
				InputPassword.setAttribute("value","<%=Account_Key%>");
				remember_password_switch_on();
		</script>
<%
		} else {
%>
		<script type="text/javascript">
			remember_password_switch_off();
		</script>
<%
		}

	String name = request.getParameter("username");
	String password = request.getParameter("password");
	String[] Remember_Account_Password = request.getParameterValues("remember_password");

	if(name!=null && !name.equals("") && password!=null && !password.equals("")){
			boolean Success = false;
			String db_name = "", db_pwd = "", db_identity = "";
			int db_id = 0;
			while(rs.next()){
				db_id = rs.getInt("id");
				db_name = rs.getString("name");
				db_pwd = rs.getString("password");
				db_identity = rs.getString("identity");
				if(db_name.equals(name) && db_pwd.equals(password)){
					Success = true;
					break;
				}
			}
		if(Success == true){// login succeeded

			if(Remember_Account_Password!=null
			&& Remember_Account_Password.length == 1
			&& Remember_Account_Password[0].equalsIgnoreCase("true"))
			{
				Cookie Cookie_Account_Name = new Cookie("Account_Name",name);
				Cookie Cookie_Account_Key = new Cookie("Account_Password",password);
				Cookie_Account_Name.setMaxAge(30*24*60*60);
				Cookie_Account_Key.setMaxAge(30*24*60*60);
				response.addCookie(Cookie_Account_Name);
				response.addCookie(Cookie_Account_Key);
			}

			session.setAttribute("userid",db_id);
			session.setAttribute("username",db_name);
			session.setAttribute("useridentity",db_identity);

			String redirect_timer = "5", redirected_url = "error.jsp";
			if( db_identity!=null ){
				if(db_identity.equals("normal")){
					redirected_url = "account.jsp";
					redirect_timer = "0";
				}
				else if(db_identity.equals("dba")) redirected_url = "welcome.jsp";
				else if(db_identity.equals("sysdba")) redirected_url = "welcome.jsp";
				else if(db_identity.equals("sys")) redirected_url = "welcome.jsp";
			}
			response.setHeader("refresh", redirect_timer + ";URL=" + redirected_url);
%>

		<script type="text/javascript" language="javascript">
            window.onload = function () {
				var div_db_info = document.getElementsByClassName("db-info")[0];
				div_db_info.setAttribute("class","db-info alert alert-success");
				div_db_info.innerHTML = "user login succeeded";

				document.getElementsByName("username")[0].setAttribute("disabled","true");
				document.getElementsByName("password")[0].setAttribute("disabled","true");
				document.getElementById("remember_password_on").setAttribute("disabled","true");
				document.getElementById("remember_password_off").setAttribute("disabled","true");
				document.getElementById("btn_login").setAttribute("disabled","true");
				document.getElementById("btn_reset").setAttribute("disabled","true");

                var i = 5;
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

		<table id="login-redirect-info" style="width:100%;position:relative;top:-350px;">
			<tr>
				<td align="center">
					<h4>will redirect to welcome page in <span class="timeShow" id="TimeRemains">5</span> seconds</h4>
					<h4>if page wasn't redirected, please click <a href="<%=redirected_url%>">here</a></h4>
				</td>
			</tr>
		</table>
		<script type="text/javascript">
			document.getElementById("login-redirect-info").style.top=-parseInt((window.innerHeight+100)/2);
		</script>
<%
		}else{// login failed
			Cookie Cookie_Account_Password = new Cookie("Account_Password","");
			Cookie_Account_Password.setMaxAge(0);
			response.addCookie(Cookie_Account_Password);
%>
			<script>
			window.onload = function () {
				var div_db_info = document.getElementsByClassName("db-info")[0];
				div_db_info.setAttribute("class","db-info alert alert-warning");
				div_db_info.innerHTML = "wrong user name or password";
				login_form_reset("LoginForm");
			}
			</script>
<%
		}
	}
// Shut Database Connection
	try
	{
		if (null != stmt) stmt.close();
		if (null != conn) conn.close();
	}
	catch(Exception e)
	{
		out.println("<div class='db-info alert alert-danger' role='alert'>数据库关闭失败！</div>");
		e.printStackTrace();
	}
%>
	<script src="js/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>