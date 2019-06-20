<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String rootPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户管理</title>
<link href="admin/css/css_body.css" rel="stylesheet" type="text/css" />
</head>
  
<body>

<div id="roleEdit" class="easyui-tabs" plain="true" style="width:370px;height:200px; padding: 5px;">  
    <div title="角色信息" selected="true" style="overflow:auto;padding:20px;">
	    <form id="editRoleForm" method="post">
	     <input type="hidden" value="${role.id}" name="roleid"/>
		<table width="90%" cellpadding="0" cellspacing="4">
			<tr>
				<td width="100">角色名称：</td>
				<td><input type="text" name="rolename" value="${role.rolename}" class="easyui-validatebox" required="true" data-options="validType:'roleNameRex'"  missingMessage="请填角色名称" /></td>
			</tr>
			<tr>
				<td>角色描述:</td>
				<td><input type="text" name="roledesc" value="${role.roledesc}" class="easyui-validatebox" required="true"  missingMessage="请填角色描述"/></td>
			</tr>
			
			
		</table>
	</form>
    </div>

</div>
<script>
//新增角色名称验证
$.extend($.fn.validatebox.defaults.rules, {
 roleNameRex: {
    validator: function(value){
    var rex=/^[\u4E00-\u9FA5]{2,10}$/;
    
    if(rex.test(value))
    {
      // alert('t'+value);
      return true;
    }else
    {
     //alert('false '+value);
       return false;
    }},
    message: '角色名称只能包含中文汉字，长度在2-10个汉字之间！'
  }
});

</script>
</body>
</html>
