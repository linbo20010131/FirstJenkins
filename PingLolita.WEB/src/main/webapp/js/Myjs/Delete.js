/**
 * 删除
 */
//删除数据
		
		function del(){
			$(".delete").click(function(){
				if(confirm("您确定要删除？")){
					var tr = $(this).parent().parent();
					var id = $(this).attr("delid");
					$.ajax({
						url:"stu/"+id,
						type:"delete",
						dataType:"text",
						success:function(data){
							tr.remove();
							cal();
							Query(1);
						},
						error:function(){
							alert("错误");
						}
					});
				}
			});
			
		}