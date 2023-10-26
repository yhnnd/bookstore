﻿<%@ page contentType="text/html" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<html>
<head>
	<title>welcome</title>
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body onload="bodyonload()">
	<script src="js/dba_sql_select.js"></script>
	<script src="js/dba_sql_update.js"></script>
	<script src="js/dba_sql_delete.js"></script>
	<script src="js/dba_sql_insert.js"></script>
	<script src="js/dba_welcome.js"></script>
<%
	if(session.getAttribute("userid")!=null&&!session.getAttribute("useridentity").equals("normal")){
%>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="javascript:void(0)" onclick="location.reload()">HOME</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li class="active">
					<a href="account.jsp">
						Welcome <span style="color: #222;"><%=session.getAttribute("username")%></span>
						<span class="sr-only">(current)</span>
					</a>
				</li>
        <li><a href="http://getbootstrap.com/" target="_blank">Powered by Bootstrap 3.3.6</a></li>
      </ul>
      <form name="SearchForm" action="welcome.jsp" class="navbar-form navbar-left">
				<div class="input-group">
					<input name="db_select_value" type="text" class="form-control" placeholder="Search For" />
					<span class="input-group-btn">
						<div class="btn-group" role="group" aria-label="...">
							<button class="btn btn-default" onclick="db_select('SearchForm','string','name');" type="button">
								Search name
							</button>
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									&nbsp;<span class="caret"></span>&nbsp;
								</button>
								<ul class="dropdown-menu">
									<li>
										<a href="javascript: void(0);" onclick="db_select('SearchForm','Int','id');">Search id</a>
									</li>
									<li>
										<a href="javascript: void(0);" onclick="db_select('SearchForm','String','identity');">Search identity</a>
									</li>
									<li>
										<a href="javascript: void(0);" onclick="//db_select('SearchForm','String','password');"
										style="cursor:not-allowed;color:#BBB;"><s>Search password</s></a>
									</li>
									<li>
										<a href="javascript: void(0);" onclick="db_select('SearchForm','Int','age');">Search age</a>
									</li>
									<li>
										<a href="javascript: void(0);" onclick="db_select_AutoFillInputByInputName('SearchForm','db_select_value','String','identity','dba');">Select All DBA</a>
									</li>
									<li>
										<a href="javascript: void(0);" onclick="db_select_AutoFillInputByInputName('SearchForm','db_select_value','String','identity','normal');">Select All User</a>
									</li>
								</ul>
							</div>
						</div>
					</span>
				</div>
      </form>
      <ul class="nav navbar-nav navbar-right">
        <li>
					<a href="#">
						new&nbsp;messages&nbsp;&nbsp;
						<span class="glyphicon glyphicon-envelope" aria-hidden="true" style="position:relative;top:2px;"></span>
					</a>
				</li>
        <li>
					<a href="logout.jsp">
						log&nbsp;out&nbsp;&nbsp;
						<span class="glyphicon glyphicon-log-out" aria-hidden="true" style="position:relative;top:2px;"></span>
					</a>
				</li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>

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
		
		try {
			String Select_Type = request.getParameter("db_select_type");
			String Select_Value = request.getParameter("db_select_value");
			String Select_Type_Class = request.getParameter("db_select_type_class");
			sqlQuery = "select * from person";
			if( Select_Type != null && !Select_Type.equals("")
			&& Select_Value != null && !Select_Value.equals("")
			&& Select_Type_Class != null && !Select_Type_Class.equals("") ){
				sqlQuery += " where " + Select_Type + " = ";
				if(Select_Type_Class.equalsIgnoreCase("String")||Select_Type_Class.equalsIgnoreCase("text")){
					sqlQuery += "'";
				}
				sqlQuery += Select_Value;
				if(Select_Type_Class.equalsIgnoreCase("String")||Select_Type_Class.equalsIgnoreCase("text")){
					sqlQuery += "'";
				}
				out.println("<div style='text-align: center; color:white;'><h5>" + sqlQuery + "</h5></div>");
			}
			rs = stmt.executeQuery(sqlQuery);
			String name,password,identity;
			int id, age;
			out.println("<table id='table' class='table table-striped db-table'>");
			out.println("<thead><tr><th class='center'>ID</th>"
			+ "<th class='center'>NAME</th><th class='center'><kbd>identity</kbd></th>"
			+ "<th class='center'>PASSWORD</th><th class='center'>AGE</th>"
			+ "<th class='center'>PROFILE</th>"
			+ "<th class='center'>HISTORY</th>"
			+ "<th class='center'>CART</th>"
			+ "<th class='center' colspan='2'>OPTIONS</th></tr></thead>");
			while(rs.next()) {
				id = rs.getInt("id");
				name = rs.getString("name");
                password = rs.getString("password");
				identity = rs.getString("identity");
				String _password = "";
				for(int i=0;i<password.length();++i) _password += "&bull;";
				age = rs.getInt("age");
				out.println("<tr><td name='user_id'>"+id+"</td><td>"+name+"</td>"
				+"<td><code>"+identity+"</code></td>"
				+"<td>"+_password+"</td><td>"+age+"</td>"
				+"<td><button type='button' class='btn btn-sm btn-default' data-toggle='modal' data-target='#SelectModal' data-whatever='@profile'>&nbsp;<span class='glyphicon glyphicon-folder-open' aria-hidden='true'></span>&nbsp;</button></td>"
				+"<td><button type='button' class='btn btn-sm btn-default' data-toggle='modal' data-target='#SelectModal' data-whatever='@history'>&nbsp;<span class='glyphicon glyphicon-folder-open' aria-hidden='true'></span>&nbsp;</button></td>"
				+"<td><button type='button' class='btn btn-sm btn-default' data-toggle='modal' data-target='#SelectModal' data-whatever='@cart'>&nbsp;<span class='glyphicon glyphicon-folder-open' aria-hidden='true'></span>&nbsp;</button></td>"
				+"<td><div type='button' class='btn btn-sm btn-primary' onclick='updaterow(this)'>&nbsp;<span class='glyphicon glyphicon-edit'></span>&nbsp;</div></td>"
        +"<td><div type='button' class='btn btn-sm btn-danger' data-toggle='modal' data-target='#ModalDelete' onclick='deleterow(this)'>&nbsp;<span class='glyphicon glyphicon-trash'></span>&nbsp;</div></td></tr>");
			}
%>
		<tr>
			<form id="form_db_insert" action="db_insert.jsp" method="post">
				<td>
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" placeholder="required" id="db_insert_id" name="db_insert_id" />
					</div>
				</td>
				<td>
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" placeholder="required" id="db_insert_username" name="db_insert_username" />
					</div>
				</td>
				<td>
					<div class="form-group form-group-sm" style="width:168px;">
							<select class="form-control" id="db_insert_identity" name="db_insert_identity">
									<option value='' disabled selected style='display:none;'>critical</option>
									<option value="normal">normal</option>
									<option value="dba">dba</option>
									<option value="sys">sys</option>
									<option value="sysdba">sysdba</option>
							</select>
					</div>
				</td>
				<td>
					<div class="input-group input-group-sm">
						<input type="password" class="form-control" placeholder="required" id="db_insert_password" name="db_insert_password" />
					</div>
				</td>
				<td>
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" placeholder="optional" id="db_insert_age" name="db_insert_age" />
					</div>
				</td>
				<td>
					<div type="button" class="btn btn-sm btn-default" data-toggle='modal' data-target='#InsertModal' data-whatever='@profile'>
						&nbsp;<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp;
					</div>
				</td>
				<td>
					<div type="button" class="btn btn-sm btn-default" data-toggle='modal' data-target='#InsertModal' data-whatever='@history'>
						&nbsp;<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp;
					</div>
				</td>
				<td>
					<div type="button" class="btn btn-sm btn-default" data-toggle='modal' data-target='#InsertModal' data-whatever='@cart'>
						&nbsp;<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>&nbsp;
					</div>
				</td>
				<td>
					<div type="button" class="btn btn-sm btn-success" onclick="insert_submit('form_db_insert')">
						&nbsp;<span class='glyphicon glyphicon-plus'></span>&nbsp;
					</div>
				</td>
				<td>
					<div type="reset" class="btn btn-sm btn-warning" onclick="insert_reset();updaterow_reset();">
						&nbsp;<span class='glyphicon glyphicon-refresh'></span>&nbsp;
					</div>
				</td>
			</form>
		</tr>
	</table>

<!-- Delete Modal -->
<div class="modal fade bs-example-modal-lg" id="ModalDelete" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			do you really want to delete the data ?
		</div>
		<div class="alert-danger modal-body">
			deleted data cannot be recovered
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
			<button type="button" class="btn btn-danger" onclick="deleterow_submit()">Confirm</button>
		</div>
    </div>
  </div>
</div>

<!-- Insert Modal -->
<div class="modal fade" id="InsertModal" tabindex="-1" role="dialog" aria-labelledby="InsertModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">New message</h4>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
				<label for="recipient-name" class="control-label">Recipient:</label>
		  	<div class="input-group">
				<input type="text" class="form-control" id="recipient-name"  aria-describedby="basic-addon2">
				<div class='input-group-btn' id="basic-addon2">
					<input type="submit" class="btn btn-default" id="recipient-name-submit">
					<input type="reset" class="btn btn-default" id="recipient-name-reset">
				</div>
		  	</div>
		  </div>
          <div class="form-group">
            <label for="message-text" class="control-label">Message:</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Send message</button>
      </div>
    </div>
  </div>
</div>

<!-- Select Modal -->
<div class="modal fade" id="SelectModal" tabindex="-1" role="dialog" aria-labelledby="SelectModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">New message</h4>
      </div>
      <div class="modal-body">
			<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			<div class="panel panel-default">
				<div class="panel-heading" role="tab" id="headingOne">
				<h4 class="panel-title">
					<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
					Collapsible Group Item #1
					</a>
				</h4>
				</div>
				<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
				<div class="panel-body">
					Anim pariaturrunchim keexcepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
				</div>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading" role="tab" id="headingTwo">
				<h4 class="panel-title">
					<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
					Collapsible Group Item #2
					</a>
				</h4>
				</div>
				<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
				<div class="panel-body">
					Anim pariaturrunchim keexcepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
				</div>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading" role="tab" id="headingThree">
				<h4 class="panel-title">
					<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
					Collapsible Group Item #3
					</a>
				</h4>
				</div>
				<div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
				<div class="panel-body">
					Anim pariaturrunchim keexcepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
				</div>
				</div>
			</div>
			</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Send message</button>
      </div>
    </div>
  </div>
</div>

<%
		}
		catch(Exception e) {
			out.println("<div class='db-info alert alert-danger' role='alert'>数据库查詢失败！</div>") ;
			e.printStackTrace();
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

	}else{
%>
		<div style="padding-top:100px;text-align:center;">
			<h3>
				<kbd>unauthorized&nbsp;user</kbd>
			</h3>
			<h3>
				to use database management system
			</h3>
			<h3>
				please <a href="login.jsp">login</a> as <code>dba/sys/sysdba</code> first
			</h3>
		</div>
<%
	}
%>

	<!-- jQuery should be loaded before bootstrap -->
	<script src="js/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
<footer>
	<div style="height:100px;padding-top:20px;text-align:center;color:#f9f9f9;">
		id is unique number / name is non-nullable string / password is invisible string / age is nullable number
	</div>
</footer>
</html>