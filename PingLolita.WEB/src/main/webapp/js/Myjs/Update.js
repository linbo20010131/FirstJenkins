/**
 * 
 */
//修改
		function Update(){
			//数据回显
			$(".update").click(function(){
				$("#Div").show();
				//调用动态下拉框
				getsch();
				$("#add").hide();
				$("#update").show();
				$("#head").show();
				var id = $(this).attr("updid");
				$.ajax({
					url:"stu/"+id,
					type:"get",
					dataType:"json",
					success:function(stu){
					
					$("#id").val(stu.id);
					$("#name").val(stu.name);
					$(":radio[value="+stu.sex+"]").prop("checked",true);
					$("#moeny").val(stu.moeny);
					$("#Time").val(stu.Time);
					$("select[name='school.id'] option[value='"+stu.school.id+"']").prop("selected",true);
					$("#emil").val(stu.emil);
					var path = "download?fileName="+stu.head;
					$("#head").attr('src',path);
					
					
					},
					error:function(){
						alert("错误");
					}
				});
				
			});
			
			
			
			
			//修改数据库的值
			$("#update").click(function(){
				
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
				
				
				formData.append("_method", "put");
				
				
					$.ajax({
						url:"stu",
						type:"post",
						dataType:"json",
						data:formData,
						processData: false,//默认true,会转换成字符串,因为我们需要提交流,所以不能使用True
		                contentType: false,//这个必须有，不然会报错
						success:function(data){
							//循环所有的TR里面的第一个TD
				    		$("#table tr").find("td:eq(0)").each(function(){
								
				    			//如果第一个TD的值正好是我们需要修改的ID值，就表示我们刚才修改的就是这行
								if($(this).text() == data.id)
								{
									$(this).parent().find("td:eq(1)").html("<img alt='图片不存在' src='download?fileName="+data.head+" ' height='100px' width='100px' >");
									$(this).parent().find("td:eq(2)").text(data.name);
									$(this).parent().find("td:eq(3)").text(data.emil);
									$(this).parent().find("td:eq(4)").html((data.sex == 1?'男':'女'));
									$(this).parent().find("td:eq(5)").text(data.school.schoolName);
									$(this).parent().find("td:eq(6)").text(data.moeny);
									$(this).parent().find("td:eq(7)").text(data.Time);
								}
								cal();
								$("#Div").hide();
								
							});
						},
						error:function(){
							alert("错误");
						}
					});
			});
			
		}
	