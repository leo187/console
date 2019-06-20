<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String rootPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="admin/css/css_body.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="userInfo" class="easyui-tabs" plain="true" style="width:400px;height:450px; padding: 5px;">  
    <div title="用户信息" selected="true" style="overflow:auto;padding:20px;">
	     <input type="hidden" value="${user.id}" name="userid"/>
		<table width="100%" cellpadding="0" cellspacing="4">
			<tr>
				<td width="100">用户名：</td>
				<td><input type="text" name="username" value="${user.username}" disabled="disabled" /></td>
			</tr>
			<tr>
				<td>真实姓名:</td>
				<td><input type="text" name="trueName" value="${user.truename}"  disabled="disabled" class="easyui-validatebox" /></td>
			</tr>
			<tr>
				<td>移动电话:</td>
				<td><input type="text" name="mobile" value="${user.mobile}"  disabled="disabled" class="easyui-validatebox" /></td>
			</tr>
			<tr>
				<td>固定电话:</td>
				<td><input type="text" name="telephone" value="${user.telephone}"  disabled="disabled" class="easyui-validatebox"/></td>
			</tr>
			<tr>
				<td>用户邮箱:</td>
				<td><input type="text" name="email" value="${user.userEmail}"  disabled="disabled" class="easyui-validatebox" /></td>
			</tr>
			<tr >
			<td>密码修改:</td>
			<td>
			<img border="0" src="./images/icons/editPass.png" title="修改"  style="cursor:pointer; margin: 0 5px;width:60px;height:27px;" onclick="toUpdatePassWord()"/>
<!-- 			<button type ="button" style="clear:both;cursor: pointer;margin-right:4px;padding-left: 0px;margin-top: 20px;" onclick = "toUpdatePassWord()">修改</button>
 -->			</td>
			</tr>
			</table>
	</form>
	<script type="text/javascript">
 function toUpdatePassWord(){
	 var dialogdiv=document.createElement("div");
	 dialogdiv.id="storeOrders";
	 document.body.appendChild(dialogdiv);
	 $('#storeOrders').dialog({
		 modal:true,
		 title:'重置密码',
		 href:'<%=rootPath %>superadmin/ConsoleUser/toInputNewPassWord',
		 width:400,
		 height:160,
		 resizable:false,
		 buttons:[{
			 text:'关闭',
			 iconCls:'icon-cancel',
			 handler:function()
			 {
			$('#storeOrders').dialog('destroy');	 
			 }
		 }],
		 onClose:function(){
		$('#storeOrders').dialog('destroy');
		 }
	 });
}
</script>
</div>
</div>  
</body>
</html>
