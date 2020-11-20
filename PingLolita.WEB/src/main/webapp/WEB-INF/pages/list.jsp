<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="scripts/jquery-3.4.1.js"></script>
<head>
<meta charset="utf-8">
<title>学生列表</title>
</head>
<script type="text/javascript">
	$(function(){
		//删除
		$(".delete").click(function(){
			var href=$(this).attr("href");
			$("form").attr("action",href).submit();
			return false;
		});
		
		//国际化
		
		var locale = '<%=session.getAttribute("locale")%>';
		$("#language").find("option[value="+locale+"]").attr("selected",true); 
		
		$("#language").change(function(){
			window.location.href="stulist?locale="+ $(this).val();
		});
		
	})
</script>
<body>
	<form action="" method="post">
		<input type="hidden" name="_method" value="DELETE">
	</form>
	<c:if test="${empty requestScope.student }">
		<fmt:message key="i18n.stuinf"></fmt:message>
	</c:if>
	<c:if test="${!empty requestScope.student }">
		<table border="1" cellpadding="10" cellspacing="0">
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
			
			<c:forEach items="${requestScope.student}" var="stu">
				<tr>
					<td>${stu.id }</td>
					<td><img alt="图片不存在" src="download?fileName=${stu.head} " height="100px" width="100px" ></td>
					<td>${stu.name }</td>
					<td>${stu.emil }</td>
					<td>${stu.sex == 0 ? '女' : '男' }</td>
					<td>${stu.school.schoolName}</td>
					<td>${stu.moeny }</td>
					<td>${stu.time }</td>
					<td><a href="stu/${stu.id}">update</a></td>
					<td><a class="delete" href="stu/${stu.id}">delete</a></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<br><a href="stu" ><fmt:message key="i18n.addstu"></fmt:message></a>
	<fmt:message key="i18n.language"></fmt:message><select id="language">
		<option value="zh_CN">中文</option>
		<option value="en_US">English</option>
	</select>
</body>
</html>