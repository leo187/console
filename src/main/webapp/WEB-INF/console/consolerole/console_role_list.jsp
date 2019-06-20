<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
 String rootPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理员角色管理</title>
<link href="../css/css_body.css" rel="stylesheet" type="text/css" />
</head>
<body>
<script type="text/javascript">
//全局变量，
var m_checked = false;
//全选
function checkAll(){
	m_checked = !m_checked;
	$("input[name='roleid']").attr("checked",m_checked); 
}
//添加角色
function addConsoleRole(){
	var dialogDiv = document.createElement("div");
	dialogDiv.id="addRole";
	document.body.appendChild(dialogDiv);
	$('#addRole').dialog({   
	    modal:true,
	    href:'<%=rootPath%>superadmin/user/getDatagrid?url=consolerole/console_role_add',
	    title:'添加角色',
	    width:400,
	    height:300,
	    resizable:true,
	    buttons: [{
	    	text: '提交', 
	    	iconCls: 'icon-ok', 
	    	handler: function() {
				$('#addRoleForm').form('submit',{
	    			url : "<%=rootPath %>superadmin/ConsoleRole/addConsoleRole",
	    			onSubmit: function(){
	    				var isValid = $(this).form('validate');
	    				if (isValid){
	    					$.messager.progress({
	    	    				text:'提交数据中...'
	    	    			});
	    				}
	    				return isValid;
	    			},
	    			success:function(data){
	    				$('#addRole').dialog('destroy');
	    				$.messager.progress('close');
	    				if(data<0){
	    					$.messager.alert("提示信息","角色已存在！","info");
	    					refresh();
	    				}else if(data==1){
	    					$.messager.alert("提示信息","添加角色成功","info");
	    					$('body').layout('panel','center').panel('refresh');
	    				}else{
	    					$.messager.alert("提示信息","添加角色信息失败！","error");
	    				}
	    			}
	    		});
	    	} 
	    },{ 
	    	text: '取消', 
	    	iconCls: 'icon-cancel', 
	    	handler: function() { 
	    		$('#addRole').dialog('destroy');
	    	} 
	    }],
	    onClose:function(){
	    	$('#addRole').dialog('destroy');
	    }
	});
}

//将选择的角色删除
function deleteConsoleRoles(){

	var roleids = "";
	$("input[name='roleid']:checked").each(function(){
		roleids+=','+this.value;
	});
		if(roleids){
			roleids = roleids.substring(1);
    		$.messager.confirm('提示信息','是否要将这些角色删除？',function(r){   
    		    if(r){
   		    		$.ajax({
   	    				url: "<%=rootPath %>superadmin/ConsoleRole/deleteConsoleRoles",
   	    			   	type: "POST",
   	    			   	data: {roleIds: roleids},
   	    			   	success: function(msg){
   	    			   		$.messager.alert("提示信息","成功将"+msg+"个角色删除","info");
   	    			   		$('body').layout('panel','center').panel('refresh');
   	    			   	}
   		    		});
    		    }
    		});
    	}else{
    		$.messager.alert("提示信息","请选择要删除的角色。","warning");
    	}
	}
	
//检索
function role_CheckSearch(){
	   var role_name=$('#role_name').val();
	   jump('<%=rootPath%>superadmin/ConsoleRole/getConsoleRoles?roleName='+role_name);
}
//刷新
function refresh(){
	
	$('body').layout('panel','center').panel('refresh');
}

//修改用户	
function roleEdit(_nRoleId){
	var dialogDiv = document.createElement("div");
	dialogDiv.id="editRole";
	document.body.appendChild(dialogDiv);
	$('#editRole').dialog({   
	    modal:true,
	    href:'<%=rootPath %>superadmin/ConsoleRole/getConsoleRoleById?roleId='+_nRoleId,
	    title:'修改角色',
	    width:400,
	    height:300,
	    resizable:true,
	    buttons: [{
	    	text: '提交', 
	    	iconCls: 'icon-ok', 
	    	handler: function() {
	    		 
				$('#editRoleForm').form('submit',{
	    			url : "<%=rootPath %>superadmin/ConsoleRole/updateConsoleRoleById",
	    			onSubmit: function(){
	    				var isValid = $(this).form('validate');
	    				if (isValid){
	    					$.messager.progress({
	    	    				text:'提交数据中...'
	    	    			});
	    				}
	    				return isValid;
	    			},
	    			success:function(data){
	    				
	    				$('#editRole').dialog('destroy');
	    				$.messager.progress('close');
	    				
	    				if(data==-1){
	    					$.messager.alert("提示信息","角色已存在！","info");
	    					refresh();
	    				}else if(data==1){
	    					$.messager.alert("提示信息","修改角色成功","info");
	    					$('body').layout('panel','center').panel('refresh');
	    				}else{
	    					$.messager.alert("提示信息","修改用户信息失败！","error");
	    				}
	    			}
	    		});
	    	} 
	    },{ 
	    	text: '取消', 
	    	iconCls: 'icon-cancel', 
	    	handler: function() { 
	    		$('#editRole').dialog('destroy');
	    	} 
	    }],
	    onClose:function(){
	    	$('#editRole').dialog('destroy');
	    }
	});
}
</script>
<script type="text/javascript">
//编辑权限
function setRight(_nRoleId) {
	var dialogDiv = document.createElement("div");
	dialogDiv.id="editRight";
	dialogDiv.style.padding="5px";
	document.body.appendChild(dialogDiv);
	$('#editRight').dialog({   
	    modal:true,
	    href:'<%=rootPath%>superadmin/ConsoleMenu/getConsoleMenuTree?roleId='+_nRoleId,
	    title:'编辑权限',
	    width:550,
	    height:450,
	    resizable:true,
	    buttons: [
	              {
	      	    	text: '确定', 
	      	    	iconCls: 'icon-ok', 
	      	    	handler: function() {
	      	    		  checkedJs();
	      	    	} 
	      	    }
	    ]
	   
	});
}
</script>
<form id="roleList">
<table width="100%"  border="0" align="center" cellpadding="10" cellspacing="1" bgcolor="#cad9ea">
	<tr class="list_th" style="position: relative;">
   	  	<td colspan="2" align="left" style="padding-left: 10px;" nowrap="nowrap">
   	  		<a href="javascript:void(0)" onclick="addConsoleRole()">新建角色</a>
   	  		<a href="javascript:void(0)" onclick="deleteConsoleRoles()">删除角色</a>
			<a href="javascript:void(0)" onclick="refresh()">刷新 </a>
   	  	</td>
   	  	<td colspan="4" align="right" style="padding-right: 2px;">
   	  	角色名称 : <input id="role_name"  value="${roleName}"><a href="javascript:void(0)" id="log_search" class="easyui-linkbutton"
				data-options="iconCls:'icon-search'" onclick="role_CheckSearch()">检索</a></td>
	</tr>
    <tr>
	    <td width="6%" align="center" bgcolor="#F5FAFE" class="main_bright"><a href="javascript:void(0)" onclick="checkAll()">全选</a></td>
	    <td width="21%" align="center" bgcolor="#F5FAFE" class="main_bright">角色名称</td>
	    <td width="15%" align="center" bgcolor="#F5FAFE"  class="main_bright">角色描述</td>
	    <td width="21%" align="center" bgcolor="#F5FAFE"  class="main_bright">创建时间</td>
	    <td width="12%" align="center" bgcolor="#F5FAFE"  class="main_bright">菜单管理</td>
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright">操作</td>
    </tr>
    <c:forEach items="${roleList}" var="role">
    <tr>
	    <td align="center" bgcolor="#F5FAFE"  class="main_bleft"><input type="checkbox" name="roleid" value="${role.id}" /> </td>
	    <td align="center" bgcolor="#F5FAFE"  class="main_bright">${role.rolename}</td>
	    <td align="center" bgcolor="#F5FAFE"  class="main_bright">${role.roledesc}</td>
	    <td align="center"  bgcolor="#F5FAFE" align="center" class="main_bright"><fmt:formatDate value="${role.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	     <td align="center"  bgcolor="#F5FAFE" align="center" class="main_bright"><a href="javascript:void(0)" onclick="setRight('${role.id}')">编辑菜单</a></td>
	    <td align="center" valign="middle" bgcolor="#F5FAFE"  class="main_bright"><img border="0" src="./images/icons/pencil.png" title="修改" style="cursor:pointer; margin: 0 5px;" onclick="roleEdit('${role.id}')"/></td>
    </tr>
   </c:forEach>
     <tr bgcolor="#FFFFFF">
      <td  align="right" colspan="10">
		 <div id="ppConsoleRoleList" class="easyui-pagination" style="background:#efefef;border:1px solid #ccc;"></div>  
		</td>
	</tr>
</table>
</form>
<input id="pageNum" type="hidden" value="${pageNum}"/>
<input id="pageTotal" type="hidden" value="${pageTotal}"/>
<input id="pageSize" type="hidden" value="${pageSize}"/>
<input id="roleName" type="hidden" value="${roleName}"/>
<script type="text/javascript">

	$(document).ready(function(){
		var roleName=$("#roleName").val();
	     $("#ppConsoleRoleList").pagination({  
				total:$("#pageTotal").val(),
				pageSize:$("#pageSize").val(),
				pageNumber:parseInt($("#pageNum").val()),
				pageList:[10,15,20],
				onSelectPage:function(pageNum, pageSize){
	               jump("<%=rootPath%>superadmin/ConsoleRole/getConsoleRoles?pageNum="+pageNum+"&pageSize="+pageSize+"&roleName="+roleName+"");
				}  
	  });
	
	});
</script>
</body>
</html>
