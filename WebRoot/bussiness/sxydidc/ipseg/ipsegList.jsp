<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String userid=(String)request.getSession().getAttribute("userid");//用户id
String username=(String)request.getSession().getAttribute("username");//用户名
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>IDC／ISP流量统计与质量监测系统</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="<%=basePath  %>/node_modules/admin-lte/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="<%=basePath  %>/node_modules/font-awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="<%=basePath  %>/node_modules/ionicons/dist/css/ionicons.min.css">
   <!-- DataTables -->
  <link rel="stylesheet" href="<%=basePath  %>/node_modules/admin-lte/plugins/datatables/dataTables.bootstrap.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="<%=basePath %>/node_modules/admin-lte/dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="<%=basePath  %>/node_modules/admin-lte/dist/css/skins/_all-skins.min.css">
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
  <link rel="stylesheet" href="<%=basePath  %>/css/newAddStyle.css">
</head>
<body class="hold-transition">
<div class="wrapper">
  <!-- Content Wrapper. Contains page content -->
 
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
       IP段管理
      
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 资源管理</a></li>
        <li class="active"><a href="#">IP段管理</a></li>   
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-xs-12">
          <div class="box">
            <!-- /.box-header -->
            <div class="box-header">
               
	                <button type="button" class="btn btn-default btn-sm" id="add_user" >
	                 <span class="fa fa-user-plus"></span> 新增
	           		 </button>
		            <button type="button" class="btn btn-default btn-sm" id="edit_user">
		              <span class="fa fa-edit"></span> 编辑
		            </button>
		            <button type="button" class="btn btn-default btn-sm" id="detele_user">
		              <span class="fa fa-user-times"></span> 删除
		            </button>
		             <button type="button" class="btn btn-default btn-sm" id="detele_user">
		              <span class="fa fa-cut"></span> 网段拆分
		            </button>
		             <button type="button" class="btn btn-default btn-sm" id="detele_user">
		              <span class="fa fa-object-group"></span> 网段合并
		            </button>
             
               <div class="input-group col-xs-5 padding-right">
					  <input type="text" class="form-control" id="searchinfo">
					   <div class="input-group-btn">
					   <button type="button" class="btn1" title="模糊查询" id="btn-simple-search"><i class="fa fa-search"></i></button>
									<!-- 	<button type="button" class="btn1" title="高级查询" id="toggle-advanced-search">
											<i class="fa fa-angle-double-down"></i>
										</button>-->
					  </div>
				</div>
			<!-- 	<div class="col-xs-12 nopadding" style="display:none;" id="div-advanced-search">
					<form class="form-horizontal well" role="form">
						 <div class="form-group">
							 <label for="ipsegid" class="col-xs-1  control-label nopadding font-size">所属IP段
							    </label>
							    <div class="nopadding col-xs-3">
							       <input type="text" class="form-control" id="ipsegid"  />
							 </div>
							   <label for="deviceid" class=" col-xs-1 control-label nopadding font-size">所属设备
							    </label>
							    <div class="nopadding col-xs-3">
							       <input type="text" class=" form-control" id="deviceid" />
							 </div>
						 
						 
							  <label for="customerid" class=" col-xs-1 control-label nopadding font-size">所属客户
							    </label>
							    <div class="col-xs-3 nopadding">
							       <input type="text" class="  form-control" id="customerid">
							 </div>
						</div>
						  <div class="form-group">
							  <label for="statusName" class="col-xs-1  control-label nopadding font-size">IP状态
							    </label>
							    <div class="col-xs-3 nopadding">
							       <input type="text" class=" form-control" id="statusName">
							 </div>
							   <button type="button" class="btn1 col-xs-1" id="btn-advanced-search"><i class="fa fa-search"></i> 查询</button>
						 </div>		  					
					</form>
				</div>
            </div>
            -->
            <div class="box-body">
             
              <table id="example1" class="table table-bordered table-striped">
				           <thead>
					       <tr>
					           <th><input name="checked_all_info" type="checkbox" value=""></th>
					           <th>IP段名称</th>
					           <th>起始IP</th>
					           <th>终止IP</th>
					           <th>子网掩码</th>     
					           <th>所属客户</th> 
					           <th>所属数据中心</th>  
					           <th>状态</th> 
					           <th>总IP数</th> 
					           <th>空闲IP数</th>  
					           <th>预占IP数</th>  
					           <th>实占IP数</th>  
					       </tr>
					       </thead>
				           <tbody></tbody>
              </table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </section>
  <div class="control-sidebar-bg"></div>
</div>
<!-- 模态框（Modal） -->

<div class="modal fade" id="myModal" name="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">提示</h4>
            </div>
            <div class="modal-body" id="tipContent">请选择要数据</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


<div class="modal fade" name="myModal" id="confirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">提示</h4>
            </div>
            <div class="modal-body">确定要删除选中的数据</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="detletedate()">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<div class="modal fade" name="myModal" id="deleteSucess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">提示</h4>
            </div>
            <div class="modal-body">删除数据成功</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">确定</button> 
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!-- ./wrapper -->

<!-- jQuery 2.2.3 -->
<script src="<%=basePath  %>/node_modules/admin-lte/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="<%=basePath  %>/node_modules/admin-lte/bootstrap/js/bootstrap.min.js"></script>
<!-- DataTables -->
<script src="<%=basePath  %>/node_modules/admin-lte/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="<%=basePath  %>/node_modules/admin-lte/plugins/datatables/dataTables.bootstrap.min.js"></script>
<!-- SlimScroll -->
<script src="<%=basePath  %>/node_modules/admin-lte/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="<%=basePath  %>/node_modules/admin-lte/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="<%=basePath  %>/node_modules/admin-lte/dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="<%=basePath  %>/node_modules/admin-lte/dist/js/demo.js"></script>

<!-- page script -->   
<script  type="text/javascript"  src="<%=basePath  %>js/dateformat.js"></script>   
<script  type="text/javascript"  src="<%=basePath  %>js/moment.js"></script>   
<script  type="text/javascript"  src="<%=basePath  %>js/daterangepicker.js"></script>   


<script src="ipsegList.js"></script>


</body>
</html>
