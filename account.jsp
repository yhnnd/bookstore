<%@ page contentType="text/html"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.File"%>
<%@ page import="java.lang.String.*"%>
<html>
<head>
	<title>personal account</title>
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/styles.css">
	<style>
		.image{
			height:32px;width:20px;
			background-size: contain;
			background-repeat: no-repeat;
		}
	</style>
</head>
<body>
<%
	if(session.getAttribute("userid")!=null){
		String home_btn_redirected_url = "";
		String home_btn_onclick_attribute = "";
		Object identity = session.getAttribute("useridentity");
		if( identity != null ){
			if(identity.equals("normal")){
				home_btn_redirected_url = "javascript:void(0)";
				home_btn_onclick_attribute = "onclick='location.reload()'";
			}else if(identity.equals("dba")) home_btn_redirected_url = "welcome.jsp";
			else if(identity.equals("sys")) home_btn_redirected_url = "welcome.jsp";
			else if(identity.equals("sysdba")) home_btn_redirected_url = "welcome.jsp";
			else home_btn_redirected_url = "error.jsp";
		}
%>
	<style>
		.bs-table th small, .responsive-utilities th small {
			display: block;
			font-weight: 400;
			color: #999;
			font-size: 85%;
		}
		.responsive-utilities td.is-visible {
			color: #468847;
			background-color: #dff0d8!important;
		}
		.responsive-utilities td.is-hidden {
			color: #ccc;
			background-color: #f9f9f9!important;
		}
		.responsive-utilities td.collapse-is-visible {
			color: #357736;
			background-color: #c7dfc7!important;
		}
		.responsive-utilities td.collapse-is-hidden {
			color: #999;
			background-color: #e8e8e8!important;
		}
	</style>
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
	
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="collapsed navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-5" aria-expanded="false">
					<span class="sr-only">Toggle navigation</span> 
					<span class="icon-bar"></span> 
					<span class="icon-bar"></span> 
					<span class="icon-bar"></span> 
				</button>
				<a class="navbar-brand" href="<%=home_btn_redirected_url%>" <%=home_btn_onclick_attribute%> >HOME</a>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-5">
				<ul class="nav navbar-nav">
					<li class="active">
						<a href="<%=home_btn_redirected_url%>" <%=home_btn_onclick_attribute%> >
							Welcome 
							<span style="color: #222;"><%=session.getAttribute("username")%></span>
							<span class="sr-only">(current)</span>
						</a>
					</li>
					<li>
						<a href="http://getbootstrap.com/" target="_blank">
							Powered by Bootstrap 3.3.6
						</a>
					</li>
					<li>
						<a href="bookstore.jsp" class="navbar-link">
							book&nbsp;store&nbsp;&nbsp;
							<span class="glyphicon glyphicon-book" aria-hidden="true" style="position:relative;top:2px;"></span>
						</a>
					</li>
					<li>
						<a href="logout.jsp" class="navbar-link">
							log&nbsp;out&nbsp;&nbsp;
							<span class="glyphicon glyphicon-log-out" aria-hidden="true" style="position:relative;top:2px;"></span>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>

			<div class="container">
				<div class="row">
					<div class="col-sm-12 col-md-12">
						<div class="jumbotron">
							<div id="page-title" style="color:#666; font-size: 30px">
								<!--page title-->
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8 col-lg-8">
						<blockquote style='border-left-color:#c0c0e0;'>
              				<p id="user-profile"></p>
							<footer>
								<span id='user-profile-author'></span>&nbsp;in&nbsp;
								<cite id='user-profile-source' title=""></cite>
							</footer>
            			</blockquote>
						<blockquote style='border-left-color:#c0e0c0;'>
              				<p id="user-book-quote"></p>
							<footer>
								<span id='user-book-quote-author'></span>&nbsp;in&nbsp;
								<cite id='user-book-quote-source' title=""></cite>
							</footer>
            			</blockquote>
					</div>
					<div class="col-md-4 col-lg-4">
						<div id='user-info'>
								<ul class='list-group'>
									<li class='list-group-item active'>
										<div clsss="list-group-item-header"></div>
										<div class="list-group-item-text">
											<dl class="dl-horizontal" style="position:relative;top:7px;">
												<dt>identity</dt>
												<dd id='user-identity'><!-- user identity --></dd>
											</dl>
										</div>
									</li>
									<li class='list-group-item list-group-item-success'>
										<div class="list-group-item-text">
											<dl class="dl-horizontal" style="position:relative;top:7px;">
												<dt>id</dt>
												<dd id='user-id'><!-- user id --></dd>
											</dl>
										</div>
									</li>
									<li class='list-group-item list-group-item-warning'>
										<div class="list-group-item-text">
											<dl class="dl-horizontal" style="position:relative;top:7px;">
												<dt>name</dt>
												<dd id='user-name'><!-- user name --></dd>
											</dl>
										</div>
									</li>
									<li class='list-group-item list-group-item-success'>
										<div class="list-group-item-text">
											<dl class="dl-horizontal" style="position:relative;top:7px;">
												<dt>password</dt>
												<dd id='user-password'><!-- user password --></dd>
											</dl>
										</div>
									</li>
									<li class='list-group-item list-group-item-warning'>
										<div class="list-group-item-text">
											<dl class="dl-horizontal" style="position:relative;top:7px;">
												<dt>age</dt>
												<dd id='user-age'><!-- user age --></dd>
											</dl>
										</div>
									</li>
								</ul>
						</div>
					</div>
					<div class="col-sm-12">
						<div class="table-responsive">
							<table class="table table-bordered table-striped responsive-utilities">
								<thead>
									<tr>
										<th> Item ID <small>Item ID</small> </th>
										<th> Product ID <small>Book ID / No.</small> </th>
										<th> Image <small>Cover</small> </th>
										<th> Product Name <small>Book Title</small> </th>
										<th> Manufacturer <small>Book Author</small> </th>
										<th> Country <small>Language</small> </th>
										<th> Copyright <small>Publisher</small> </th>
										<th> MFD <small>Publishing Date</small> </th>
										<th> Actions <small>Actions</small> </th>
									</tr>
								</thead>
								<tbody>
<%
	// this code block is to distinguish variables inside it from those below
 	{
		String DBDRIVER = "sun.jdbc.odbc.JdbcOdbcDriver" ;
		String DBURL="jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ=C:\\Program Files (x86)\\Apache Software Foundation\\Tomcat 7.0\\webapps\\BookStorePoweredbyAccess\\Access\\db.mdb";
		Connection conn = null ;//should import java.sql.*
		Statement stmt = null ;
		String sql = null ;
		String sqlQuery = null;
		ResultSet rs = null;
		// step 1
		try
		{
			Class.forName(DBDRIVER) ;
		}
		catch(Exception e)
		{
			out.println("<script>console.log('数据库驱动程序加载失败！');</script>") ;
			e.printStackTrace();
		}
		// step 2
		try
		{
			conn = DriverManager.getConnection(DBURL) ;
			stmt = conn.createStatement();
			out.println("<script>console.log('数据库连接成功.');</script>") ;
			
		}
		catch(Exception e)
		{
			out.println("<script>console.log('数据库连接失败！');</script>") ;
			e.printStackTrace();
		}
		// step 3
		try {
			sqlQuery = "select book.*, item.id as itemID, item.number as itemNumber, "
			+ "item.ownerid as ownerID, item.available as itemAvailable "
			+ "from item INNER JOIN book ON item.typeid = book.id "
			+ "where item.id IN "
			+ " ( SELECT id FROM item WHERE ownerid = " + session.getAttribute("userid") + " ) ";
			rs = stmt.executeQuery(sqlQuery);

			// table book
			int book_id = 0;
			String book_name, book_author, book_publisher, book_language, book_publishDate;
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			boolean book_available = false;
			String book_price;
			int book_amount = 0, book_chapterCount = 0, book_wordCount = 0;
			String book_cover_image, book_ISBN, item_EAN, item_UPC;

			// table item
			int item_id = 0, item_number = 0, item_ownerID;
			boolean item_available = false;

			while(rs.next()) {
				book_id = rs.getInt("id");
				book_name = rs.getString("name");
				book_author = rs.getString("author");
				book_language = rs.getString("language");
				book_publisher = rs.getString("publisher");
				book_publishDate = format.format(rs.getDate("publishDate"));
				book_available = rs.getBoolean("available");
				book_price = rs.getObject("price").toString();
				book_amount = rs.getInt("amount");
				book_chapterCount = rs.getInt("chapterCount");
				book_wordCount = rs.getInt("wordCount");
				book_cover_image = rs.getString("coverImage");
				book_ISBN = "null";
				item_UPC = "null";
				item_EAN = "null";
				item_id = rs.getInt("itemID");
				item_number = rs.getInt("itemNumber");
				item_ownerID = rs.getInt("ownerID");
				item_available = rs.getBoolean("itemAvailable");
				String collapse_td_class = book_available && item_available == true ? 
				"collapse-is-visible" : "collapse-is-hidden";
				String collapse_btn_class = book_available && item_available == true ?
				"btn-primary" : "btn-default";
				String book_filename = book_name + " by " + book_author + ".txt";
				String book_file_relative_path = "docs/" + book_filename;
				String book_file_real_path = request.getRealPath("\\") + book_file_relative_path;
				String download_disabled = "disabled";
				String download_btn_class = "btn-default";
				String download_btn_onclick_script = "alert('the link you click is not valid\\n"
					+ "Cannot find file " + book_file_relative_path +"');";
				File book_file = new File(book_file_real_path);
				if( book_file.exists() ){
					download_disabled = "";
					download_btn_onclick_script = "this.children[0].click();";
					download_btn_class = "btn-success";
				} else {
					String book_file_real_path_modified = "";
					for( int i=0; i < book_file_real_path.length(); ++i ){
						if( book_file_real_path.charAt(i) == '\\' ) book_file_real_path_modified += '\\';
						book_file_real_path_modified += book_file_real_path.charAt(i);
					}
		%>
					<script type="text/javascript">
						console.log('cannot open file');
						console.log('<%=book_filename%>');
						console.log('<%=book_file_real_path_modified%>');
					</script>
		<%
				}
		%>
					<tr>
						<th scope="row"><code><%=item_id%></code></th>
						<td class="is-hidden"><%=book_id%>/<%=item_number%></td>
						<td class="is-visible">
							<div class="image" style="background-image: url(&quot;img/<%=book_cover_image%>&quot;);"></div>
						</td>
						<td class="is-visible"><%=book_name%></td>
						<td class="is-visible"><%=book_author%></td>
						<td class="is-visible"><%=book_language%></td>
						<td class="is-visible"><%=book_publisher%></td>
						<td class="is-visible"><%=book_publishDate%></td>
						<td class="is-hidden">
							<div class="btn-group btn-group-md" role="group" aria-label="...">
								<div class='btn <%=download_btn_class%> glyphicon glyphicon-save' 
								onclick="<%=download_btn_onclick_script%>" <%=download_disabled%> >
									<a href="<%=book_file_relative_path%>" target='_blank' download="<%=book_filename%>">
									</a>
								</div>
								<button aria-controls="collapse<%=item_id%>" aria-expanded="false" 
								class="btn btn-primary collapsed glyphicon glyphicon-search" 
								data-target="#collapse<%=item_id%>" data-toggle="collapse" type="button"
								onclick="togglecollapse('#collapse<%=item_id%>')">
								</button>
								<div tabindex="<%=item_id%>" class='btn btn-info glyphicon glyphicon-heart-empty' role="button" 
								data-container="body" data-toggle="popover" data-trigger="focus" data-placement="left" 
								title="message" data-content="Add this item to my favorite list&nbsp;&nbsp;"
								onmouseover="$(this).popover('show')" onmouseout="$(this).popover('hide');">
								</div>
								<div class='btn btn-danger glyphicon glyphicon-trash' onclick="book_item_delete(<%=item_id%>)">
								</div>
							</div>
						</td>
					</tr>

<tr hidden>
<td colspan="9">
  <div class="collapse" id="collapse<%=item_id%>" aria-expanded="false" style="height: 0px;"> 
	<div class="well" style="width:97.5%;padding-bottom:0px;">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>ISBN <small>String</small></th>
					<th>EAN <small>String</small></th>
					<th>UPC <small>String</small></th>
					<th>Available <small>Bool</small></th>
					<th>Amount <small>Count</small></th>
					<th>Price <small>Currency</small></th>
					<th>Chapter <small>Count</small></th>
					<th>Word <small>Count</small></th>
					<th>Owner <small>ID</small></th>
					<th>Item Available <small>Bool</small></th>
					<th>Track Shipment<small>Button</small></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="<%=collapse_td_class%>"><%=book_ISBN%></td>
					<td class="<%=collapse_td_class%>"><%=item_EAN%></td>
					<td class="<%=collapse_td_class%>"><%=item_UPC%></td>
					<td class="<%=collapse_td_class%>"><%=book_available%></td>
					<td class="<%=collapse_td_class%>"><%=book_amount%></td>
					<td class="<%=collapse_td_class%>">
						<span class='glyphicon glyphicon-usd'></span>
						<%=book_price%>
					</td>
					<td class="<%=collapse_td_class%>"><%=book_chapterCount%></td>
					<td class="<%=collapse_td_class%>"><%=book_wordCount%></td>
					<td class="<%=collapse_td_class%>"><%=item_ownerID%></td>
					<td class="<%=collapse_td_class%>"><%=item_available%></td>
					<td class="<%=collapse_td_class%>">
						<div class='btn btn-xs <%=collapse_btn_class%> glyphicon glyphicon-plane'>
						</div>
						<div class='btn btn-xs <%=collapse_btn_class%> glyphicon glyphicon-info-sign'>
						</div>
						<div class='btn btn-xs <%=collapse_btn_class%> glyphicon glyphicon-calendar'>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div> 
  </div>
</td>
</tr>

<%
			}// while( rs.next() )
		}// try step 3
		catch ( Exception e ) {
			String error_msg_UTF8 = new String(e.getMessage().getBytes(),"UTF-8");
			String error_msg_GBK = new String(e.getMessage().getBytes(),"GBK");
			out.println("<script>");
			out.println("console.log('数据库查詢失败!');");
			out.println("console.log('" + error_msg_UTF8 + "');");
			out.println("console.log('" + error_msg_GBK + "');");
			out.println("</script>");
			e.printStackTrace();
		}

		// Step 4 Shut Database Connection
		try
		{
			if (null != stmt) stmt.close();
			if (null != conn) conn.close();
		}
		catch(Exception e)
		{
			out.println("<script>console.log('数据库关闭失败!');</script>");
			e.printStackTrace();
		}
	}// block
%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class='row'>
					<div class='col-lg-offset-1 col-lg-10'>
						<div class="panel panel-default">
							<div class="panel-body" style="text-align: center;">
								<nav aria-label="..."> 
									<ul class="pagination"> 
										<li class="disabled">
											<a href="#" aria-label="Previous">
												<span aria-hidden="true">«</span>
											</a>
										</li> 
										<li class="active">
											<a href="#">
												1 <span class="sr-only">(current)</span>
											</a>
										</li>
										<li>
											<a href="#">2</a>
										</li> 
										<li>
											<a href="#">3</a>
										</li> 
										<li>
											<a href="#">4</a>
										</li> 
										<li>
											<a href="#">5</a>
										</li> 
										<li>
											<a href="#" aria-label="Next">
												<span aria-hidden="true">»</span>
											</a>
										</li> 
									</ul> 
								</nav>
							</div>
						</div>
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
			sqlQuery = "SELECT name,age FROM person where id = "
			+ session.getAttribute("userid");
			rs = stmt.executeQuery(sqlQuery);
		}
		catch(Exception e) {
%>
			<script>
				setAlert('db-info',2,'SQL執行失败 !');
			</script>
<%
			e.printStackTrace();
			sql_success = false;
		}
		String name = "", password = "&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;";
		int age = 0;
		Object id = session.getAttribute("userid");
		if(rs.next()) {
			name = rs.getString("name");
			age = rs.getInt("age");
			if( name.equals(session.getAttribute("username")) ){
%>
		<script>
			document.getElementById("user-profile").innerHTML = "<strong>My Profile</strong> <var>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </var>";
			document.getElementById("user-profile-author").innerHTML = "User Name";
			document.getElementById("user-profile-source").innerHTML = "User Profile";
			document.getElementById("user-profile-source").setAttribute("title","User Profile");

			document.getElementById("user-book-quote").innerHTML = "<strong>My Book Quote</strong> <var>Anim pariaturrunchim keexcepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt accusamus labore. </var>";
			document.getElementById("user-book-quote-author").innerHTML = "Author Name";
			document.getElementById("user-book-quote-source").innerHTML = "Book Name";
			document.getElementById("user-book-quote-source").setAttribute("title","Book Name");
			
			document.getElementById("page-title").innerHTML = "<%=name%>'s home page";
			document.getElementById("user-identity").innerHTML = "<code><%=identity%></code>";
			document.getElementById("user-id").innerHTML = "<%=id%>";
			document.getElementById("user-name").innerHTML = "<%=name%>";
			document.getElementById("user-password").innerHTML = "<%=password%>";
			document.getElementById("user-age").innerHTML = "<%=age%>";
		</script>
<%
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
%>
			<script>
				setAlert('db-info',3,'数据库关闭失败 !');
			</script>
<%
			e.printStackTrace();
			sql_success = false;
		}

	}else{
%>
		<div style="padding-top:100px;text-align:center;">
			<h3>
				<kbd>unauthorized&nbsp;user</kbd>
			</h3>
			<h3>
				to check out user account
			</h3>
			<h3>
				please <a href="login.jsp">login</a> as <code>normal</code> first
			</h3>
		</div>
<%
	}
%>

	<script type="text/javascript">
		function togglecollapse(btnid){
			var tr = $(btnid)[0].parentElement.parentElement;
			if( tr.hasAttribute('hidden') ) tr.removeAttribute('hidden');
			else{
				var timer = setTimeout(function() {
					$(btnid)[0].parentElement.parentElement.setAttribute('hidden','true');
					prev_btnid = undefined;
				}, 260 );
			}
		}
		function book_item_delete(itemid){
			if(confirm("do you want to delete this book?")){
				window.location.href="bookdelete.jsp?item-id="+itemid;
			}
		}
	</script>
	<script src="js/sql_error.js"></script>
	<script src="js/jquery.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>