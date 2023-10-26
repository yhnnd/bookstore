<%@ page contentType="text/html" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<html>
<head>
	<title>db_table_person_delete</title>
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
<%
	if(session.getAttribute("userid")!=null){

		String DBDRIVER = "sun.jdbc.odbc.JdbcOdbcDriver" ;
		String DBURL="jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ=C:\\Program Files (x86)\\Apache Software Foundation\\Tomcat 7.0\\webapps\\BookStorePoweredbyAccess\\Access\\db.mdb";
		Connection conn = null ;//should import java.sql.*
		Statement stmt = null ;
		String sql = null ;
		String sqlQuery = null;
		ResultSet rs = null;
		
		// 1 Load Database Driver
		try
		{
			Class.forName(DBDRIVER) ;
		}
		catch(Exception e)
		{
			out.println("<div class='db-info alert alert-danger' role='alert'>数据库驱动程序加载失败！</div>") ;
			e.printStackTrace();
		}

		// 2 Connect Database
		try
		{
			conn = DriverManager.getConnection(DBURL) ;
			stmt = conn.createStatement();
		}
		catch(Exception e)
		{
			out.println("<div class='db-info alert alert-danger' role='alert'>数据库连接失败！</div>") ;
			e.printStackTrace();
		}

		if(request.getParameter("db_delete_id") == null){
			out.println("<div class='db-info alert alert-danger' role='alert'>無效的刪除對象！</div>");
		} else {// 3 Execute Query
			try {
				sqlQuery = "DELETE FROM person WHERE id=" + request.getParameter("db_delete_id");
				rs = stmt.executeQuery(sqlQuery);
			}
			catch(Exception e) {
				out.println("<div class='db-info alert alert-danger' role='alert'>SQL執行失败！</div>") ;
				e.printStackTrace();
			}
		}

		// 4 Shut Database Connection
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

		response.setHeader("refresh","0;URL=welcome.jsp");

	}else{
%>
		<h3>to use the system, please <a href="login.jsp">login first</a></h3>
<%
	}
%>
	<script src="js/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>