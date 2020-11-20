/**
 * 查询

 * 
 * 
 */
//显示列表
function Query(pageNo){
	var pageSize = $("#pageSize").val();
		$.ajax({
			url:"stulist",
			Type:"get",
			dataType:"json",
			data:{"pageNo":pageNo,"pageSize":pageSize},
			success:function(page){
				var list = page.list;
				//如果每页显示数大于等于总条数，显示每页sum
				if(page.pageSize >= page.sum){
					$("#a").text(page.sum);
				}else{
					$("#a").text(page.pageSize);
				}
				//显示文本
				$("#b").text(pageNo);
				$("#c").text(page.pageCount);
				$("#d").text(page.sum);
				
				 //设置隐藏值,就是分页信息
				 $("#pageSize").val(page.pageSize);
	    		 $("#pageNo").val(page.pageNo);
	    		 $("#pageCount").val(page.pageCount);
	    		 $("#sum").val(page.sum);
	    		 
	    		 
	    		 $("#table").empty();//先清空内容,这里会给表头一起清空.
				 //所以给表头加上
				 $("#table").append("<tr><th>学生id</th>" +
				 		"<th>头像</th>" +
				 		"<th>姓名</th>" +
				 		"<th>邮箱</th>" +
				 		"<th>性别</th>" +
				 		"<th>学校名称</th>" +
				 		"<th>零花钱</th>" +
				 		"<th>时间</th>" +
				 		"<th>删除</th>" +
				 		"<th>修改</th>"+
				 		"</tr>");
				for (var i = 0; i < list.length; i++) {
					var stu = list[i];
					$("#table").append("<tr><td>"+stu.id+"</td>" +
							"<td><img alt='图片不存在' src='download?fileName="+stu.head+" 'height='100px' width='100px' ></td>"+
							"<td>"+stu.name+"</td>"+
							"<td>"+stu.emil+"</td>"+
							"<td>"+(stu.sex == 1?'男':'女')+"</td>"+
							"<td>"+stu.school.schoolName+"</td>"+
							"<td>"+stu.moeny+"</td>"+
							"<td>"+stu.Time+"</td>"+
							"<td><input type='button' value='删除' class='delete' delid="+stu.id+"></td>"+
							"<td><input type='button' value='修改'  class='update' updid="+stu.id+" ></td>"+
							"<tr>");
							
							
				}
				del();//删除样式
				Update();
				$(".update").click(function(){
					$("#addDiv").hide();
				});
			},
			error:function(){
				alert("错误");
			}
		});
		
}	


