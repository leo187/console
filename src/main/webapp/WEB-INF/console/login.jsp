<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>权限后台</title>
<link rel="stylesheet" href="./css/css_login.css"  type="text/css" /></link>
<link rel="stylesheet" href="./css/icon.css" type="text/css"></link>
<link rel="stylesheet" href="./css/easyui.css" type="text/css"></link>

<script type="text/javascript" src="./js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="./js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="./js/jquery.easyui.min.js"></script>
	<div class="top1"></div>
	<div class="top2">
		<div class="logo">
			<img src="<%=basePath %>images/logo-index.png" width="230" height="80" />
		</div>
		<div class="right">
			<form action="<%=basePath%>adminlogin" id="adminLoginForm" method="post" onsubmit="return checkForm()">
				<input id="photoCode" name = "photoCode" type="hidden" />
				<input id="passwordSub" name="password" type="hidden" />
				<input id="usernameSub" name="username"  type="hidden" />
			</form>
			<span class="x">
				<input id="username"   class="easyui-validatebox" required="true" missingMessage="请填写登录名称" type="text" value=""  maxlength="20"  />
			</span>
			<span class="x">
				<input id="password"  class="easyui-validatebox" required="true" missingMessage="请填写登录密码" type="password" value="" maxlength="20" />
				
			</span>

			<c:if test="${mess!=null }">
				<span class="x">
					<font style="color: red">* &nbsp;${mess }</font>
				</span>
			</c:if>
			<span>
			<!-- <a  href="javascript:void(0);"   onclick="loginSubmit();" >登 录</a> -->
			 <button  class="dl"  onclick="checkForm()" >登 录</button>
			</span>
			<span>
			</span>
		</div>
	</div>
	<div class="end"></div>
<script type="text/javascript">
 function checkForm(){
       var username = document.getElementById("username").value;
	   var password = document.getElementById("password").value;
	   if(username == ""  ){
	     return false;
	   }
	   if(password == ""  ){
	     return false;
	   }
	  document.getElementById("passwordSub").value = password;
	  document.getElementById("usernameSub").value = username;
	  document.getElementById("adminLoginForm").submit();
} 
	function encode64(input) {
		var keyStr = "${keyStr}";
		var output = "";
		var chr1, chr2, chr3 = "";
		var enc1, enc2, enc3, enc4 = "";
		var i = 0;
		do {
			chr1 = input.charCodeAt(i++);
			chr2 = input.charCodeAt(i++);
			chr3 = input.charCodeAt(i++);
			enc1 = chr1 >> 2;
			enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
			enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
			enc4 = chr3 & 63;
			if (isNaN(chr2)) {
				enc3 = enc4 = 64;
			} else if (isNaN(chr3)) {
				enc4 = 64;
			}
			output = output + keyStr.charAt(enc1) + keyStr.charAt(enc2)
					+ keyStr.charAt(enc3) + keyStr.charAt(enc4);
			chr1 = chr2 = chr3 = "";
			enc1 = enc2 = enc3 = enc4 = "";
		} while (i < input.length);

		return output;
	}


</script>
