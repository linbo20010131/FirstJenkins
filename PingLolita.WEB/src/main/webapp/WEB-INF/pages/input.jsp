<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script type="text/javascript" src="<%=request.getContextPath() %>/scripts/jquery-3.4.1.js"></script>
<title>学生添加/修改</title>
</head>
<script type="text/javascript">

	$(function(){
		
	});
</script>

<body>

		<form:form action="${pageContext.request.contextPath }/stu" method="post" modelAttribute="student" enctype="multipart/form-data">
		
		
		<c:if test="${student.id ==null }">
		<!-- 学生姓名-->
			<fmt:message key="i18n.stuname"></fmt:message>:
			<form:input path="name"/>
			<font color="red"><form:errors path="name"></form:errors></font><br>
		</c:if>
			<c:if test="${student.id !=null }">
				<input type="hidden" name="_method" value="put">
				<form:hidden path="id"/>
			</c:if>
			<!-- 邮箱 -->
			<fmt:message key="i18n.stuemail"></fmt:message>：
			<form:input path="emil"/>
			<font color="red"><form:errors path="emil"></form:errors></font><br>
			
			<fmt:message key="i18n.stusex"></fmt:message>：
			<form:radiobuttons path="sex" items="${sexs}"/>
			<font color="red"> <form:errors path="sex"></form:errors></font><br>
			<!-- 学校 -->
			<fmt:message key="i18n.stuschool"></fmt:message>：
			<form:select path="school.code" items="${schools}" itemLabel="schoolName" itemValue="code"> 
			</form:select>
			<font color="red"> <form:errors path="school.code"></form:errors></font> <br>
			<!-- 时间 -->
			 <fmt:message key="i18n.stutime"></fmt:message>
			 ：<form:input path="Time"/>
			<font color="red"> <form:errors path="Time"></form:errors></font><br>
			<!-- 金钱 -->
			<fmt:message key="i18n.stumoeny"></fmt:message>：
			<form:input path="moeny"/>
			<font color="red"> <form:errors path="moeny"></form:errors></font><br>
			<!--头像上传  -->
			<fmt:message key="i18n.stuhead"></fmt:message>:
			<input id="choose-file" type="file" name="file" accept="image/*" ><br>
			<!-- 头像预览-->
			<c:if test="${student.id !=null }">
				<div id="box-1">
					<img  id="show-img" alt="" src="<%=request.getContextPath() %>/download?fileName=${student.head}"  height="200px" width="200px"><br>
				</div>
			</c:if>
			 <input type="submit" value='<fmt:message key="i18n.submit"></fmt:message>'> <br>
		</form:form>
		
</body>
</html>