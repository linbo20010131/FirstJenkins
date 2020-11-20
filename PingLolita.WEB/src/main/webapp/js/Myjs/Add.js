/**
 * 添加

 */
function Add(){
	
	 
	 //添加数据
	$("#add").click(function(){
		
		/*//必须验证通过才能进行数据提交到后台
		  if (!$("#formAdd").valid()) {
		        return;
		     }*/
		var formData = new FormData();//这里需要实例化一个FormData来进行文件上传
		
		if($("#file")[0].files[0] != null){
			formData.append("file",$("#file")[0].files[0]);
		}
		
		
		//formData.append("student", JSON.stringify(student));
		//formData.append(student);
		
		//序列化表单不会序列化file字段.
		var student = $("#formAdd").serializeObject();
		
		//把json转换成formdate
		Object.keys(student).forEach((key) => {
			formData.append(key, student[key]);
		});
		
		
			$.ajax({
				url:"stu",
				type:"post",
				dataType:"json",
				data:formData,
				processData: false,//默认true,会转换成字符串,因为我们需要提交流,所以不能使用True
                contentType: false,//这个必须有，不然会报错
				success:function(data){
					$("#table").append("<tr><td>"+data.id+"</td>" +
							"<td><img alt='图片不存在' src='download?fileName="+data.head+" ' height='100px' width='100px' ></td>"+
							"<td>"+data.name+"</td>"+
							"<td>"+data.emil+"</td>"+
							"<td>"+(data.sex == 1?'男':'女')+"</td>"+
							"<td>"+data.school.schoolName+"</td>"+
							"<td>"+data.moeny+"</td>"+
							"<td>"+data.Time+"</td>"+
							"<td><input type='button' value='删除' class='delete' delid="+data.id+"></td>"+
							"<td><input type='button' value='修改'  class='update' updid="+data.id+" ></td>"+
							"<tr>");
					del();
					Update();
					Query(1);
					$("#Div").hide();//隐藏	
					cal();//清理	
				},
				error:function(){
					alert("错误");
				}
			});			
	});
}

