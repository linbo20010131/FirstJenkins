<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.4.1.js"></script><!-- 引用jquery.js -->
<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/Myjs/Query.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/Myjs/serializeObject.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/Myjs/Update.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/Myjs/Delete.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/Myjs/Add.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/validate/dist/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="../../js/2d/waifu.css"/>
<link rel="stylesheet" type="text/css" src="../../js/2d/flat-ui.min.css">


<style type="text/css">
	.error{
	 color:#F00;
	 border: 1px solid #CE7979;
	 background:#FFF7FA;
     } 
     
  
     
  

</style>
<title>平萝莉管理学生系统</title>
</head>
<script type="text/javascript">
	 $(function(){
		//判断用户是否存在
	 	/* $("#name").blur(function(){
			var addName = $("#name").val();
			$.ajax({
				url:"GetUserCount",
				data:{"addname":addName},
				dataType:"json",
				success:function(aa){
					
					if(aa.count >=1){
						alert("该用户已存在");
						$("#addname").css("color","red");
						$("#add").attr("disabled",true);
					}else{
						$("#addname").css("color","blue");
						$("#add").attr("disabled",false);
					}
				},
				error:function(){
					alert("错误")
				}
			});
		});  */



		
		//查询列表
		Query(1);
	 	//新增
		Add();
		

		

		//国际化
		
		var locale = '<%=session.getAttribute("locale")%>';
		$("#language").find("option[value="+locale+"]").attr("selected",true); 
		
		$("#language").change(function(){
			window.location.href="i18n?locale="+ $(this).val();
		});
	
		//显示添加div
		$("#addButton").click(function(){
			$("#Div").show();
			cal();
			getsch();
			$("#update").hide();
			$("#add").show();
			//$("#head").hide();
		});
		//隐藏添加div
		$("#qxadd").click(function(){
			$("#Div").hide();
			cal();
		});
		
		//首页
		$("#first").click(function(){
			Query(1);
		});
		//下页
		$("#down").click(function(){
			var pageNo = $("#pageNo").val();
			var pageCount = $("#pageCount").val();
			if(pageNo != pageCount){
				//转int相加
				Query(parseInt(pageNo)+1); 
			}
		//上页
		$("#up").click(function(){
			var pageNo = $("#pageNo").val();
			if(pageNo != 1){
				Query(parseInt(pageNo)-1);
			}
		});
		
		});
		//末页
		$("#last").click(function(){
			var count =$("#pageCount").val();
			Query(count);
		});
		//每页显示多少条数据
		$("#aa").change(function(){
			var pageSize = $("#aa").val();//获取下拉框选中的值
				$("#pageSize").val(pageSize);
				Query(1);
		});
		
	});
	 //在线预览图片
	 if (typeof FileReader == 'undefined') {
		 document.getElementById("xmTanDiv").InnerHTML = "<h1>当前浏览器不支持FileReader接口</h1>";
		 document.getElementById("file").setAttribute("disabled", "disabled");
	 }
	 //选择图片，马上预览
	 function xmTanUploadImg(obj) {
		 var file = obj.files[0];
		 console.log(obj);console.log(file);
		 console.log("file.size = " + file.size);
		 var reader = new FileReader();
		 reader.onloadstart = function (e) {
			 console.log("开始读取....");
		 }
		 reader.onprogress = function (e) {
			 console.log("正在读取中....");
		 }
		 reader.onabort = function (e) {
			 console.log("中断读取....");
		 }
		 reader.onerror = function (e) {
			 console.log("读取异常....");
		 }
		 reader.onload = function (e) {
			 console.log("成功读取....");
			 var img = document.getElementById("head");

			 img.src = e.target.result;
			 //或者 img.src = this.result;  //e.target == this
		 }
		 reader.readAsDataURL(file)
	 }

	//清理添加框的值
	function cal(){
		//清理文本框的值
		$("#id").val("");
		$("#name").val("");
		$("#emil").val("");
		$("#moeny").val("");
		$("#Time").val("");
		//清理单选框的值
		$(":radio:checked").each(function(){
			$(this).prop("checked",false);
		});
		$("#file").val("");
		$("#head").attr('src',"");
		
	
	}
	//动态加载学校下拉
	function getsch(){
		 $("select[name='school.id']").empty();
		$.ajax({
			url:"sch",
			Type:"get",
			dataType:"json",
			success:function(data){
			for (var i = 0; i < data.length; i++) {
				var sch = data[i];
				$("select[name='school.id']").append("<option value="+sch.id+">"+sch.schoolName+"</option>");
			} 
			},
			error:function(){
				alert("错误")
			}
		});
	}
	
</script>
<body background="picture/02.jpg">
	<input type="hidden" name="pageSize" id="pageSize" value="5">
	<input type="hidden" name="pageNo" id="pageNo">
	<input type="hidden" name="pageCount" id="pageCount">
	<input type="hidden" name="sum" id="sum">
	<div align="center">

	<table id="table"  border="1" cellspacing="0" >
		<tr>
				<th><fmt:message key="i18n.stuid"></fmt:message></th>
				<th><fmt:message key="i18n.stuhead"></fmt:message></th>
				<th><fmt:message key="i18n.stuname"></fmt:message></th>
				<th><fmt:message key="i18n.stuemail"></fmt:message></th>
				<th><fmt:message key="i18n.stusex"></fmt:message></th>
				<th><fmt:message key="i18n.stuschool"></fmt:message></th>
				<th><fmt:message key="i18n.stumoeny"></fmt:message></th>
				<th><fmt:message key="i18n.stutime"></fmt:message></th>
				<th><fmt:message key="i18n.stuupdate"></fmt:message></th>
				<th><fmt:message key="i18n.studetele"></fmt:message></th>
		</tr>
	</table>
	<br>
	每页<span style="color: red" id="a"></span>条 &nbsp;&nbsp;&nbsp;
	第<span style="color: red" id="b"></span>页&nbsp;&nbsp;&nbsp;
	总共<span style="color: red" id="c"></span>页&nbsp;&nbsp;&nbsp;
	总共<span style="color: red" id="d"></span>条&nbsp;&nbsp;&nbsp;
	<br>
        <input type="button" value="新增" id="addButton"  >
	<input type="button" id="first" value="首页" >
	<input type="button" id="up" value="上页" >
	<input type="button" id="down" value="下页"  >
	<input type="button" id="last"  value="尾页" >
	每页显示<select id="aa">
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5" selected>5</option>
		<option value="10">10</option>
	</select>条&nbsp
	<fmt:message key="i18n.language"></fmt:message><select id="language">
		<option value="zh_CN">中文</option>
		<option value="en_US">English</option>
	</select>
	</div>
    <br>
		<div style="display: none;border-style:solid; border-width:2px; border-color:#e600ff;" id="Div" align="center">
		 		<img alt="" src="" id="head" height="200px" width="200px" class="img-circle img-thumbnail img-responsive" ><br>
		<form id="formAdd" >
				<input type="hidden" name="id" id="id">
			  选择头像:<input type="file" name="file" id="file" onchange="xmTanUploadImg(this)"><br />
			姓名：<input type="text" name="name" id="name" value="平萝莉 "><br>
			邮箱：<input type="text" name="emil" id="emil" value="493658400@qq.com"> 
			<br>
			性别：<input type="radio" name="sex" value="1" checked="checked"> 男
			<input type="radio" name="sex" value="0">女
			<br>
			学校：<select name="school.id" id="school.id">
			
				</select>
				<br>
				零花钱：<input type="text" name="moeny" id="moeny" value="25.0"> 
				<br>
			时间:<input type="text" name="Time" id="Time" readonly onfocus="WdatePicker({isShowWeek:true})" value="2001-01-01">	<br>
			<input type="button" value="新增" id="add" >
			<input type="button" value="修改" id="update" >
			<input type="button" value="取消" id="qxadd" >
			</form>
		</div>

	
	<!-- 板娘 -->
	<div class="waifu" >
　　<div class="waifu-tips" style="width: 250px;height: 70px;top: 0px;font-size: 12px;opacity: 0"></div>
　　<canvas id="live2d" width="280" height="250" class="live2d"></canvas>
　　<div class="waifu-tool">
　　　　<span class="fui-home"></span>
　　　　<span class="fui-chat"></span>
　　　　<span class="fui-eye"></span>
　　　　<span class="fui-user"></span>
　　　　<span class="fui-photo"></span>
　　　　<span class="fui-info-circle"></span>
　　　　<span class="fui-cross"></span>
　　</div>
</div>
        
<script src="../../js/2d/live2d.js"></script>
<script src="../../js/2d/waifu-tips.js"></script>
<script type="text/javascript">initModel()</script>



</body>
</html>