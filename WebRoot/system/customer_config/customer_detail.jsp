<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
+ request.getServerName() + ":" + request.getServerPort()
+ path + "/";
String userid = (String) request.getSession()
.getAttribute("userid");//用户id
String username = (String) request.getSession().getAttribute(
"username"),//用户名
	customerId = request.getParameter("customer_id"),
	customerName = request.getParameter("customer_name");

	if(customerId == null){
		customerId = "";
	}
	if(customerName == null) customerName = "";
%>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>AdminLTE 2 | Starter</title>
		<!-- Tell the browser to be responsive to screen width -->
		<meta
		content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
		name="viewport">
		<!-- Bootstrap 3.3.6 -->
		<link rel="stylesheet"
			href="<%=basePath%>/node_modules/admin-lte/bootstrap/css/bootstrap.min.css">
			<!-- Font Awesome -->
			<link rel="stylesheet"
				href="<%=basePath%>/node_modules/font-awesome/css/font-awesome.min.css">
				<!-- Ionicons -->
				<link rel="stylesheet"
					href="<%=basePath%>/node_modules/ionicons/dist/css/ionicons.min.css">
					<!-- Theme style -->
					<link rel="stylesheet"
						href="<%=basePath%>/node_modules/admin-lte/dist/css/AdminLTE.min.css">
						<!-- AdminLTE Skins. We have chosen the skin-blue for this starter
						page. However, you can choose any other skin. Make sure you
						apply the skin class to the body tag so the changes take effect.
						-->
						<link rel="stylesheet"
							href="<%=basePath%>/node_modules/admin-lte/dist/css/skins/skin-blue.min.css">
							<!-- DataTables -->
							<link rel="stylesheet" href="<%=basePath%>node_modules/admin-lte/plugins/datatables/dataTables.bootstrap.css">
							<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
							<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
							<!--[if lt IE 9]>
							<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
							<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
							<![endif]-->
							<link rel="stylesheet" href="<%=basePath %>css/config.css"></link>
						</head>
						<!--
						BODY TAG OPTIONS:
						=================
						Apply one or more of the following classes to get the
						desired effect
						|---------------------------------------------------------|
						| SKINS         | skin-blue                               |
						|               | skin-black                              |
						|               | skin-purple                             |
						|               | skin-yellow                             |
						|               | skin-red                                |
						|               | skin-green                              |
						|---------------------------------------------------------|
						|LAYOUT OPTIONS | fixed                                   |
						|               | layout-boxed                            |
						|               | layout-top-nav                          |
						|               | sidebar-collapse                        |
						|               | sidebar-mini                            |
						|---------------------------------------------------------|
						-->
						<body class="hold-transition skin-blue layout-top-nav">
							<div class="wrapper">
								<div class="content-wrapper">
									<!-- Content Wrapper. Contains page content -->
									<!-- Content Header (Page header) -->
									<section class="content-header">
										<h1>
										客户 <small><%=customerName  %></small>
										</h1>
										<ol class="breadcrumb">
											<li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
											<li class="active">客户</li>
										</ol>
									</section>
									<!-- Main content -->
									<section class="content">
										<!-- Your Page Content Here -->
										<div class="box box-default" id="customerBox">
											<div class="box-header with-border">
												<h3 class="box-title">客户
												<span class="label label-default port-count-label"></span>
												</h3>
												<div class="box-tools"><button class="btn btn-box-tool" data-widget="collapse">
													<i class="fa fa-minus"></i>
													</button>
												</div>
											</div>
											<div class="box-body">
												<div class="container-fluid empty-container-gutter">
													<div class="row">
														<div class="col-md-4">
															<div class="input-group">
																<div class="input-group-addon">客户名称</div>
																<input type="text" class="form-control" value="<%=customerName  %>">
																<div class="input-group-btn">
																	<button type="button" class="btn btn-default" id="saveCustomer">保存</button>
																	<button class="btn btn-default" type="button" data-toggle="dropdown">
																	<span class="caret"></span>
																	</button>
																	<ul class="dropdown-menu">
																		<li class="unbound-customer disabled"><a href="#">下线</a></li>

																		<li class="delete-customer disabled"><a href="#">删除</a></li>
																	</ul>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-md-12">
														<hr>
													</div>
												</div>
												<div class="row">
													<div class="col-md-12">
													<table id="deviceSummaryTable" class="table"></table>
												</div>
											</div>
										</div>
										<!-- /.box-body -->
									</div>
									<div class="box box-default" id="deviceBox">
										<div class="box-header with-border">
											<h3 class="box-title">设备端口
											<span class="label label-default port-count-label"></span>
											</h3>
											<div class="box-tools"><button class="btn btn-box-tool" data-widget="collapse">
												<i class="fa fa-minus"></i>
												</button>
											</div>
										</div>
										<div class="box-body">
											<div class="container-fluid empty-container-gutter">
												<div class="row">
													<div class="col-md-4">
														<div class="input-group">
															<div class="input-group-addon">IP</div>
															<input type="text" class="form-control" placeholder="例如：192.168.0.1"></input>
															<span class="input-group-btn">
																<button type="button" class="btn btn-default" id="queryDeviceBtn">查询</button>
															</span>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-md-12">
														<hr>
													</div>
												</div>
												<div class="row">
													<div class="col-md-12">
														<div class="panel-group" id="deviceAccordion">
														暂无数据
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col-md-6">
														<span id="info"></span>
													</div>
													<div class="col-md-6 text-right panel-list">
														<ul class="pagination">
															<li class="disabled"><a href="#">上页</a></li>
													
															<li class="disabled"><a href="#">下页</a></li>
														</ul>
													</div>
												</div>
											</div>
											
										</div>
										<!-- /.box-body -->
									</div>
								</section>
								<!-- /.content -->
							</div>
						</div>
						
						<%@ include file="/system/commons/common_widgets.jsp"  %>
						
						<div class="modal fade modal-warning" id="confirmModal">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button class="close" type="button" data-dismiss="modal"><span>&times;</span></button>
										<h4 class="modal-title">警告</h4>
									</div>
									<div class="modal-body"></div>
									<div class="modal-footer">
										<button class="btn btn-outline pull-left" type="button" data-dismiss="modal">取消
										</button>
										<button class="btn btn-outline ok" type="button">确定</button>
									</div>
								</div>
							</div>
						</div>
						<script type="x-ejs-template" id="devicePaginationTmpl">
								<li data-page="prev"><a href="#">上页</a></li>
								
								<\%
									currentPageNumber += 1;
									if(totalPageCount >7){
								 		
								 		var active ='class=active';
								 	
								 		if(currentPageNumber<=4){
								   %>
								   		<li <\%=currentPageNumber===1?active:""  %> data-page="1"><a href="#">1</a></li>
								   		<li <\%=currentPageNumber===2?active:""  %> data-page="2"><a href="#">2</a></li>
								   		<li <\%=currentPageNumber===3?active:""  %> data-page="3"><a href="#">3</a></li>
								   		<li <\%=currentPageNumber===4?active:""  %> data-page="4"><a href="#">4</a></li>

								   		<li data-page="5"><a href="#">5</a></li>
								   		<li class="disabled"><a href="#">...</a></li>
								   		<li data-page="<\%=totalPageCount %>"><a href="#"><\%=totalPageCount  %></a></li>

								   <\%
								 		}else if(currentPageNumber>= (totalPageCount-2)){
								   %>
								   		<li data-page="1"><a href="#">1</a></li>
								   		<li class="disabled"><a href="#">...</a></li>
								   		<li data-page="<\%=totalPageCount-4 %>"><a href="#"><\%=totalPageCount-4  %></a></li>
								   		<li data-page="<\%=totalPageCount-3 %>"><a href="#"><\%=totalPageCount-3  %></a></li>

								   		<li <\%=currentPageNumber===totalPageCount-2?active:""  %> data-page="<\%=totalPageCount-2 %>"><a href="#"><\%=totalPageCount-2  %></a></li>
								   		<li <\%=currentPageNumber===totalPageCount-1?active:""  %> data-page="<\%=totalPageCount-1 %>"><a href="#"><\%=totalPageCount-1  %></a></li>
								   		
								   		<li <\%=currentPageNumber===totalPageCount?active:""  %> data-page="<\%=totalPageCount %>"><a href="#"><\%=totalPageCount  %></a></li>
								   <\%
								 		}else{
								   %>
								   		<li  data-page="1"><a href="#">1</a></li>
								   		<li class="disabled"><a href="#">...</a></li>
								   		<li data-page="<\%=currentPageNumber-1  %>"><a href="#"><\%=currentPageNumber-1  %></a></li>
								   		<li class="active"  data-page="<\%=currentPageNumber  %>"><a href="#"><\%=currentPageNumber %></a></li>

								   		<li  data-page="<\%=currentPageNumber+1  %>"><a href="#"><\%=currentPageNumber+1  %></a></li>
								   		<li class="disabled"><a href="#">...</a></li>
								   		
								   		<li data-page="<\%=totalPageCount  %>"><a href="#"><\%=totalPageCount  %></a></li>
								   <\%
								 		}
								
									}else{
										for(var i = 1;i<=totalPageCount;i++){
											var active = "";
											if(currentPageNumber === i)	active='class=active';
										%>
											<li <\%=active  %>  data-page="<\%=i  %>"><a href="#"><\%=i  %></a></li>
										<\%
										}
									}
								  %>
								<li data-page="next"><a href="#">下页</a></li>
						</script>
						<script type="x-ejs-template" id="deviceTmpl">
						<\%
							if(devices.length >0 ){

							for(var i = 0,size=devices.length;i<size;i++){
								var device = devices[i],
									ip = device.ip.replace(/\./g,"_"),
									ports = device.ports;

								var currentCustomerOccupy = 0,
									totalOccupy = 0;
								for(var j = 0,jSize  = ports.length;j<jSize;j++){
									var port = ports[j],
										customerIdForPort= port.customerId;
												
									if(customerId === customerIdForPort) //当前客户占用
										currentCustomerOccupy++;
									else if(customerIdForPort !== null)//其他客户占用
										totalOccupy++;
									
								}

								totalOccupy += currentCustomerOccupy;
						  %>
						<div class="panel panel-default">
							<div class="panel-heading">
									<h4 class="panel-title">
										<a href="#ip_<\%=ip  %>" data-toggle="collapse" data-parent="#deviceAccordion"><\%=device.ip  %></a>
										<small>当前客户占用
											<i><\%=currentCustomerOccupy  %></i>个 已占用<i><\%=totalOccupy  %></i>个
										</small>
									</h4>
							</div>
							<div class="panel-collapse collapse <\%=i==0?"in":""  %>" id="ip_<\%=ip  %>">
									<div class="panel-body" data-ip="<\%=device.ip  %>">
									<\%
										if(ports.length>0){
											for(var j=0,jSize = ports.length;j<jSize;j++){
												var port = ports[j],
													portId = port.id,
													portName = port.name,
													customerIdForPort= port.customerId;
												var active = "",
													disabled = "";
												if(customerId === customerIdForPort) 
													active = "active";
												else if(customerIdForPort === null)
													active = "";
												else
													disabled = 'disabled="disabled"'
									  %>
										<button class="btn btn-default <\%=active  %>" <\%= disabled %> type="button" data-port-id="<\%=portId  %>"><\%=portName  %></button>
									<\% 
											}
										}else{
									%>
										<p>没有端口</p>
									<\% 
										}
									 %>
									</div>
							</div>							
						</div>
						<\%
							}
						}
						  %>
						</script>

						<script type="x-ejs-template" id="unboundDeviceTmpl">
							<button data-ip="<\%=host.host.ipAddress  %>" data-port-count="<\%=host.portCount  %>" class="btn btn-default btn-sm" type="button">下线</button>
						</script>
						<!-- REQUIRED JS SCRIPTS -->
						<!-- jQuery 2.2.3 -->
						<script
						src="<%=basePath%>/node_modules/admin-lte/plugins/jQuery/jquery-2.2.3.min.js"></script>
						<!-- Bootstrap 3.3.6 -->
						<script
						src="<%=basePath%>/node_modules/admin-lte/bootstrap/js/bootstrap.min.js"></script>
						<!-- DataTables -->
						<script src="<%=basePath%>node_modules/admin-lte/plugins/datatables/jquery.dataTables.js"></script>
						<script src="<%=basePath  %>/node_modules/admin-lte/plugins/datatables/dataTables.bootstrap.js"></script>

						<!-- validator -->
						<script src="<%=basePath  %>node_modules/validator/validator.js"></script>
						<script src="<%=basePath  %>node_modules/ejs/ejs.js"></script>
						<!-- AdminLTE App -->
						<script src="<%=basePath%>/node_modules/admin-lte/dist/js/app.min.js"></script>
						<script>
							var basePath = "<%=basePath  %>",
								customerId ="<%=customerId  %>";
						</script>
						<script src="<%=basePath%>js/customer_detail.js"></script>
					</body>
				</html>