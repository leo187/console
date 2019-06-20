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

<div id="menuEdit" class="easyui-tabs" plain="true" style="width:476px;height:450px; padding: 5px;">  
    <div title="菜单信息" selected="true" style="overflow:auto;padding:20px;">
	    <form id="editMenuForm" method="post">
	     <input type="hidden" value="${menu.id}" name="menuid"/>
		<table width="100%" cellpadding="0" cellspacing="4">
			<tr>
				<td width="100px">菜单名称：</td>
				<td><input type="text" name="menuname" value="${menu.menuName}" class="easyui-validatebox" required="true"  missingMessage="请填菜单名称" /></td>
			</tr>
			<tr>
				<td>菜单描述:</td>
				<td>
				
				<input type="text" name="menudesc" value="${menu.menuDesc}" class="easyui-validatebox" required="true"  missingMessage="请填菜单描述"/>
				
				</td>
			</tr>
			<tr>
				<td  >链接:</td>
				<td >
				<!-- 
				<input width="120%" height="120px" type="text" name="buttonHtmlcontent" value="${menu.buttonHtmlcontent}" class="easyui-validatebox" required="true"  missingMessage="请填写链接"/>
				 -->
				<textarea style="width:240px; height:120px;" name="buttonHtmlcontent"    required="true"  missingMessage="请填写链接">${menu.buttonHtmlcontent}</textarea>
				
				</td>
			</tr>
			<tr>
					<td>可否授权:</td>
					<td>	
					<input type="radio" name="isadminMenu" value="0" <c:if test='${menu.isadminMenu==0}'>checked="checked"</c:if>>可授权
					<input type="radio" name="isadminMenu" value="1" <c:if test='${menu.isadminMenu==1}'>checked="checked"</c:if>>不可授权
					</td>
             </tr>
             <tr>
					<td>可否修改:</td>	
             		<td>
					<input type="radio" name="iscanUpdate" value="0" <c:if test='${menu.iscanUpdate==0}'>checked="checked"</c:if>>可修改
					<input type="radio" name="iscanUpdate" value="1" <c:if test='${menu.iscanUpdate==1}'>checked="checked"</c:if>>不可修改
					</td>
             </tr>
             <tr>
					<td>是否为菜单:</td>	
					<td>
					<input type="radio" name="ismenu" value="0" <c:if test='${menu.ismenu==0}'>checked="checked"</c:if>>菜单
					<input type="radio" name="ismenu" value="1" <c:if test='${menu.ismenu==1}'>checked="checked"</c:if>>功能
					</td>
             </tr>
			
		</table>
	</form>
    </div>

</div>  
</body>
</html>
