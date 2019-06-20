<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加菜单</title>
<link href="../css/css_body.css" rel="stylesheet" type="text/css" />
</head>

<body>
<script type="text/javascript">

</script>
<form id="addConsoleMenuForm" method="post">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#cad9ea">
	<tr>
		<td align="right" bgcolor="#f5fafe" >菜单名称：</td>
		<td bgcolor="#FFFFFF" class="main_bright"><input name="menuname" class="easyui-validatebox" required="true"  missingMessage="请填菜单名称" type="text" value="" /></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#f5fafe" >菜单描述：</td>
		<td bgcolor="#FFFFFF" class="main_bright"><input name="menudesc" class="easyui-validatebox" required="true"  missingMessage="请填菜单描述" type="text" value="" /></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#f5fafe" >链接：</td>
		<td bgcolor="#FFFFFF" class="main_bright"><input name="buttonHtmlcontent" class="easyui-validatebox" required="true"  missingMessage="请填写链接" type="text" value="" /></td>
	</tr>
		<tr>
					<td  bgcolor="#f5fafe" align="right">可否授权：</td>
					<td bgcolor="#FFFFFF">	
					<input id="_log_type" type="radio" name="isadminMenu"  checked value="0" >可授权
					<input id="_log_type" type="radio" name="isadminMenu" value="1" >不可授权
					</td>
             </tr>
             <tr>
					<td bgcolor="#f5fafe" align="right">可否修改：</td>	
             		<td bgcolor="#FFFFFF">
					<input id="_log_type" type="radio" name="iscanUpdate" checked value="0" >可修改
					<input id="_log_type" type="radio" name="iscanUpdate" value="1" >不可修改
					</td>
             </tr>
	
	<tr>
					<td bgcolor="#f5fafe" align="right">是否为菜单：</td>	
					<td bgcolor="#FFFFFF">
					<input id="_log_type" type="radio" name="ismenu" checked value="0" >菜单
					<input id="_log_type" type="radio" name="ismenu" value="1" >功能
					</td>
             </tr>
</table>
</form>
</body>
</html>
