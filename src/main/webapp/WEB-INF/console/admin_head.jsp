 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String rootPath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<style type="text/css">
  a,a:hover{text-decoration:none;}
</style>
</head>
<body>
<div class="topbg">
   <div class="logo">
			<%-- <img src="<%=rootPath%>images/logo_news_1.jpg" width="195" height="40" /> --%>
		</div>
	<div class="top">
		<div class="right">
			<div class="rt">
				<c:if test="${sessionScope.adminSessionInfo!=null}"><a style="color:#4395cf;cursor:pointer;" >${sessionScope.adminSessionInfo.consoleUser.username}</c:if>
				 <c:if test="${sessionScope.adminSessionInfo!=null}"><a href="${pageContext.request.contextPath }/adminLoginout" style="color:#4395cf;clear:both;margin-left:2px;">退出</a></c:if>
			</div>
		</div>
		<c:if test="${type == 'statistics' }">
			<div  class="right" style="padding-top:15px;padding-right:30px;">
				<%--<p style="font-size: 15px;color: #ffffff;">${time }</p>--%>
			 	<%--<p style="font-size: 15px;color: #ffffff;">实时在线人数：${count }</p>--%>
			 	<p style="font-size: 15px;color: #ffffff;">实时在线人数：
			 	<c:choose>
			 		<c:when test="${userCount > 0 }">${userCount }</c:when>
			 		<c:otherwise>0</c:otherwise>
			 	</c:choose>
			 	</p>
			</div>
		</c:if>
		<div style="padding-top:12px;left: 50px;">
<!-- 		<div style="padding-top:12px;padding-left:150px;"> -->
		  <ul style="padding-left:20px" class="left">
			  <c:forEach items="${sessionScope.topMenu}" var="menu">
			  		<li><a href="<%=rootPath%>${menu.menuHref}" style="color:#ffffff;">${menu.menuName}</a></li>
			  </c:forEach>
		  </ul>
		</div>
	</div>
	<div class="topend"></div>
</div>
<div class="br-1"></div>
<!-- <script type="text/javascript">
    $("a").click(function(){
    	alert("a");
	  $(this).addClass("selected");
	}
	);
 </script> -->
 <%--<script type="text/javascript">
function userDetail(){
	 var dialogdiv=document.createElement("div");
	 dialogdiv.id="userInfo";
	 document.body.appendChild(dialogdiv);
	 $('#userInfo').dialog({
		 modal:true,
		 title:'用户信息',
		 href:'<%=rootPath %>superadmin/ConsoleUser/adminUserInfo',
		 width:450,
		 height:550,
		 resizable:true,
		 maximizable:false,
		 buttons:[{
			 text:'关闭',
			 iconCls:'icon-cancel',
			 handler:function()
			 {
			$('#userInfo').dialog('destroy');	 
			 }
		 }],
		 onClose:function(){
		$('#userInfo').dialog('destroy');
		 }
	 });
}
</script>--%>
</body>
</html>