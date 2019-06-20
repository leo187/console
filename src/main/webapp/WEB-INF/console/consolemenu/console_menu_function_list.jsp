<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
 String rootPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="admin/css/css_body.css" rel="stylesheet" type="text/css" />
<title>角色权限列表</title>
</head>
<body>
<script type="text/javascript">
//全局变量，
var m_checked = false;

//全选
function checkAll(){
	m_checked = !m_checked;
	$("input[name='functionid']").attr("checked",m_checked); 
}

//刷新
function refresh(){
	var menuId="${menuId}";
	$('#powerMenu').panel('refresh',"<%=rootPath %>superadmin/MenuFunctionLink/selectFunctionsByMenuId?menuId="+menuId+"");
	
}

//将选择的角色删除
function deleteFunctions(){
	var menuId="${menuId}";
	var functionids = "";
	$("input[name='functionid']:checked").each(function(){
		functionids+=','+this.value;
	});
		if(functionids){
			functionids = functionids.substring(1);
    		$.messager.confirm('提示信息','是否要将这些权限删除？',function(r){   
    		    if(r){
   		    		$.ajax({
   	    				url: "<%=rootPath %>superadmin/MenuFunctionLink/deleteFunctionsByFunctionIds?menuId="+menuId+"",
   	    			   	type: "POST",
   	    			   	data: {functionIds: functionids},
   	    			   	success: function(msg){
   	    			   		$.messager.alert("提示信息","成功将"+msg+"个权限删除","info");
   	    			   	    refresh();
   	    			   	}
   		    		});
    		    }
    		});
    	}else{
    		$.messager.alert("提示信息","请选择要删除的权限。","warning");
    	}
	}
	
	
//添加角色
function addFunctions(){
	var dialogDiv = document.createElement("div");
	var menuId="${menuId}";
	dialogDiv.id="addFunctions";
	document.body.appendChild(dialogDiv);
	$('#addFunctions').dialog({   
	    modal:true,
	    href:'<%=rootPath%>superadmin/Function/getAllFunctions?menuId='+menuId,
	    title:'添加权限',
	    width:900,
	    height:500,
	    resizable:false,
	    onClose:function(){
	    	$('#addFunctions').dialog('destroy');
	    }
	});
}
	
</script>
<form id="SpecValueForm" method="post">
 <table width="100%"  border="0" align="center" cellpadding="10" cellspacing="1" bgcolor="#cad9ea">

	<tr class="list_th" style="position: relative;">
	
   	  	<td colspan="2" align="left" style="padding-left: 10px;" nowrap="nowrap">
   	  	
   	  		<a href="javascript:void(0)" onclick="addFunctions()">添加权限</a>
   	  		<a href="javascript:void(0)" onclick="deleteFunctions()">删除权限</a>
			<a href="javascript:void(0)" onclick="refresh()">刷新 </a>
   	  	</td>
	</tr>
    <tr>
	    <td width="6%" align="center" bgcolor="#F5FAFE" class="main_bright"><a href="javascript:void(0)" onclick="checkAll()">全选</a></td>
	    <td width="35%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >权限名称</a></td>
	    <td  align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >权限描述</a></td>
    </tr>
    <c:forEach  items="${.FunctionList}" var=".Function" >
    <tr>
	    <td align="center" bgcolor="#F5FAFE"  class="main_bleft"><input type="checkbox" name="functionid" value="${.Function.functionid}" /> </td>
	    <td align="center" bgcolor="#F5FAFE"  class="main_bright">${.Function.functionname}</td>
	    <td align="center"  bgcolor="#F5FAFE" align="center" class="main_bright">${.Function.functiondesc}</td>
    </tr>
   </c:forEach>
</table>
</form>
</body>
</html>