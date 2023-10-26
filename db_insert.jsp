<%@ page contentType="text/html" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<html>
<head>
	<title>db_table_person_insert</title>
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
<%
	if(session.getAttribute("userid")!=null){
%>
	<div class='db-info alert alert-danger' role='alert'>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
	</div>
	<script>
	function setAlert(alertClass,n,msg){
		var Alert = document.getElementsByClassName(alertClass)[0];
		var div = Alert.getElementsByTagName('div')[n];
		div.innerHTML = msg;
	}
	</script>
			<div style="margin-top:100px;text-align:center;">
				<div id='div-sql-error-msg' style="display:none;">
					<div class='row'>
						<div class='col col-sm-offset-3 col-sm-6 col-md-offset-3 col-md-6'>
							<div class='panel panel-danger'>
								<div class='panel-heading'>SQL Query Error</div>
								<div class='panel-body'></div>
								<div style="text-align:center">
									<table class="table">
										<tbody>
											<tr style="text-align:center">
												<td id='sql-error-msg-1'></td>
											</tr>
											<tr style="text-align:center">
												<td id='sql-error-msg-2'></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="panel-footer">
									<div class='btn-group btn-group-inside'>
										<div class='btn btn-default'
										onclick="hide_div('div-sql-error-msg','btn-group-outside');">
											Hide Error Information
										</div>
										<div class='btn btn-default' onclick="redirect('welcome.jsp')">
											Return to Homepage
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class='btn-group' id='btn-group-outside'>
					<div class='btn btn-default'
					onclick="show_div('div-sql-error-msg','btn-group-outside');">
						Show Error Information
					</div>
					<div class='btn btn-default' onclick="redirect('welcome.jsp')">
						Return to Homepage
					</div>
				</div>
			</div>
<%
		String DBDRIVER = "sun.jdbc.odbc.JdbcOdbcDriver" ;
		String DBURL="jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ=C:\\Program Files (x86)\\Apache Software Foundation\\Tomcat 7.0\\webapps\\BookStorePoweredbyAccess\\Access\\db.mdb";
		Connection conn = null ;//should import java.sql.*
		Statement stmt = null ;
		String sql = null ;
		String sqlQuery = null;
		ResultSet rs = null;
		boolean sql_success = true;
		
		// 1 Load Database Driver
		try
		{
			Class.forName(DBDRIVER) ;
		}
		catch(Exception e)
		{
%>
			<script>
				setAlert('db-info',0,'数据库驱动程序加载失败 !');
			</script>
<%
			e.printStackTrace();
			sql_success = false;
		}

		// 2 Connect Database
		try
		{
			conn = DriverManager.getConnection(DBURL) ;
			stmt = conn.createStatement();
		}
		catch(Exception e)
		{
%>
			<script>
				setAlert('db-info',1,'数据库连接失败 !');
			</script>
<%
			e.printStackTrace();
			sql_success = false;
		}

		// 3 Execute Query
		try {
			sqlQuery = "INSERT INTO person (id,name,identity,password,age) VALUES ("
			+ request.getParameter("db_insert_id") + ",'"
			+ request.getParameter("db_insert_username") + "','"
			+ request.getParameter("db_insert_identity") + "','"
			+ request.getParameter("db_insert_password") + "',"
			+ request.getParameter("db_insert_age") + ")";
			rs = stmt.executeQuery(sqlQuery);
		}
		catch(Exception e) {
			//String error_msg = new String(e.getMessage().getBytes(),"UTF-8");
			String error_msg = new String(e.getMessage().getBytes(),"GBK");
%>
			<script>
				setAlert('db-info',2,'SQL執行失败 !');
				document.getElementById('sql-error-msg-1').innerHTML = "<%=sqlQuery%>";
				document.getElementById('sql-error-msg-2').innerHTML = "<%=error_msg%>";
			</script>
<%
			e.printStackTrace();
			sql_success = false;
		}

		// 4 Shut Database Connection
		try
		{
			if (null != stmt) stmt.close();
			if (null != conn) conn.close();
		}
		catch(Exception e)
		{
%>
			<script>
				setAlert('db-info',3,'数据库关闭失败 !');
			</script>
<%
			e.printStackTrace();
			sql_success = false;
		}

		if( sql_success == true ){
			response.setHeader("refresh","0;URL=welcome.jsp");
		}

	}else{
%>
		<h3>to use the system, please <a href="login.jsp">login first</a></h3>
<%
	}
%>
	<script src="js/sql_error.js"></script>
	<script src="js/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>