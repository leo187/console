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
<title>用户管理</title>
<link href="../css/css_body.css" rel="stylesheet" type="text/css" />
</head>
<body>
<script type="text/javascript">
//全局变量，
var m_checked = false;

//全选
function checkAll(){
	m_checked = !m_checked;
	$("input[name='menuid']").attr("checked",m_checked); 
}



//将选择的角色删除
function deleteMenus(){
	var menuids = "";
	$("input[name='menuid']:checked").each(function(){
		
		menuids+=','+this.value;

	});
		if(menuids){
			menuids = menuids.substring(1);
    		$.messager.confirm('提示信息','是否要将这些菜单删除？',function(r){   
    		    if(r){
   		    		$.ajax({
   	    				url: "<%=rootPath %>superadmin/ConsoleMenu/deleteConsoleMenus",
   	    			   	type: "POST",
   	    			   	data: {menuIds: menuids},
   	    			   	success: function(msg){
   	    			   		$.messager.alert("提示信息","成功将"+msg+"个菜单删除","info");
   	    			   		$('body').layout('panel','center').panel('refresh');
   	    			   	}
   		    		});
    		    }
    		});
    	}else{
    		$.messager.alert("提示信息","请选择要删除的菜单。","warning");
    	}
	}
	
//检索
function menu_CheckSearch(){
	   var menu_name=$('#menu_name').val();
	   jump('<%=rootPath%>superadmin/ConsoleMenu/getAllConsoleMenus?menuName='+menu_name);
}
//刷新
function refresh(){
	$('body').layout('panel','center').panel('refresh');
}




function menuDetail(_nMenuId){
	 var dialogdiv=document.createElement("div");
	 dialogdiv.id="menuDetail";
	 document.body.appendChild(dialogdiv);
	 $('#menuDetail').dialog({
		 modal:true,
		 title:'查看菜单详情',
		 href:'<%=rootPath %>superadmin/ConsoleMenu/getConsoleMenuDetailById?menuId='+_nMenuId,
		 width:400,
		 height:500,
		 resizable:true,
		 maximizable:false,
		 buttons:[{
			 text:'关闭',
			 iconCls:'icon-cancel',
			 handler:function()
			 {
			$('#menuDetail').dialog('destroy');	 
			 }
		 }],
		 onClose:function(){
		$('#menuDetail').dialog('destroy');
		 }
		 
	 });
	 }
	 

//菜单详情
function menuEdit(_nMenuId){
	var dialogDiv = document.createElement("div");
	dialogDiv.id="editMenu";
	document.body.appendChild(dialogDiv);
	$('#editMenu').dialog({   
	    modal:true,
	    href:'<%=rootPath %>superadmin/ConsoleMenu/getConsoleMenuById?menuId='+_nMenuId,
	    title:'修改菜单',
	    width:500,
	    height:531,
	    resizable:true,
	    buttons: [{
	    	text: '提交', 
	    	iconCls: 'icon-ok', 
	    	handler: function() {
	    		 
				$('#editMenuForm').form('submit',{
	    			url : "<%=rootPath %>superadmin/ConsoleMenu/updateConsoleMenuById",
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
	    				
	    				$('#editMenu').dialog('destroy');
	    				$.messager.progress('close');
	    				if(data==1){
	    					$.messager.alert("提示信息","修改菜单成功","info");
	    					$('body').layout('panel','center').panel('refresh');
	    				}else{
	    					$.messager.alert("提示信息","修改菜单信息失败！","error");
	    				}
	    			}
	    		});
	    	} 
	    },{ 
	    	text: '取消', 
	    	iconCls: 'icon-cancel', 
	    	handler: function() { 
	    		$('#editMenu').dialog('destroy');
	    	} 
	    }],
	    onClose:function(){
	    	$('#editMenu').dialog('destroy');
	    }
	});
}


//新增菜单

function addConsoleMenu(parentId){
	
	var dialogDiv = document.createElement("div");
	dialogDiv.id="addConsoleMenu";
	document.body.appendChild(dialogDiv);
	$('#addConsoleMenu').dialog({   
	    modal:true,
	    href:'<%=rootPath %>superadmin/ConsoleMenu/toAddConsoleMenu',
	    title:'新增菜单(<font color="red">*</font>为必填选项)',
	    width:450,
	    height:500,
	    resizable:true,
	    buttons: [{
	    	text: '提交', 
	    	iconCls: 'icon-ok', 
	    	handler: function() {
				$('#addConsoleMenuForm').form('submit',{
	    			url : '<%=rootPath %>superadmin/ConsoleMenu/addConsoleMenu?parentId='+parentId,
	    			method : 'post',
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
	    			console.log(data);
	    				if(data<0){
	    					$.messager.alert("提示信息","菜单已存在！","info");
	    					refresh();
	    				}else if(data>0){
	    					$.messager.alert("提示信息","新增菜单成功","info");
	    					$('#addConsoleMenu').dialog('destroy');
	    					refresh();
	    				}else{
	    					$.messager.alert("提示信息","新增菜单失败！","error");
	    					$('#addConsoleMenu').dialog('destroy');
	    					refresh();
	    				}
	    				$.messager.progress('close');
	    			}
	    		});
	    	} 
	    },{
	    	text: '取消', 
	    	iconCls: 'icon-cancel', 
	    	handler: function() { 
	    		$('#addConsoleMenu').dialog('destroy');
	    	} 
	    }],
	    onClose:function(){
	    	$('#addConsoleMenu').dialog('destroy');
	    }
	});
}

</script>
<form id="roleList">
<table width="100%"  border="0" align="center" cellpadding="10" cellspacing="1" bgcolor="#cad9ea">

	<tr class="list_th" style="position: relative;">
	
   	  	<td colspan="2" align="left" style="padding-left: 10px;" nowrap="nowrap">
   	  	
   	  		<%-- <a href="javascript:void(0)" onclick="addConsoleMenu('${parentId}')">添加菜单</a> --%>
   	  		<!-- <a href="javascript:void(0)" onclick="deleteMenus()">删除菜单</a> -->
			<a href="javascript:void(0)" onclick="refresh()">刷新 </a>
   	  	</td>
   	  	
   	  	<td colspan="9" align="right" style="padding-right: 2px;">
   	  	菜单名称 : <input id="menu_name"  value="${menuName}"><a href="javascript:void(0)" id="log_search" class="easyui-linkbutton"
				data-options="iconCls:'icon-search'" onclick="menu_CheckSearch()">检索</a></td>
	</tr>
    <tr>
	    <td width="6%" align="center" bgcolor="#F5FAFE" class="main_bright"><a href="javascript:void(0)" onclick="checkAll()">全选</a></td>
	    <td width="8%" align="center" bgcolor="#F5FAFE" class="main_bright"><a href="javascript:void(0)" >菜单名称</a></td>
	    <td width="7%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >可否授权</a></td>
	    <td width="7%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >可否修改</a></td>
	    <td width="7%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >是否为菜单</a></td>
	    <td width="15%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >链接</a></td>
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >菜单详情</a></td>  
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright">操作</td>
    </tr>
    <c:forEach items="${menuList}" var="menu">
    <tr>
	    <td width="6%"  align="center" bgcolor="#F5FAFE"  class="main_bleft"><input type="checkbox" name="menuid" value="${menu.id}" /> </td>
	    <td width="8%"  align="center" bgcolor="#F5FAFE"  class="main_bright">${menu.menuName}</td>
	    
	     <c:choose>
	    <c:when test="${menu.isadminMenu==0}"> 
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright">可授权</td>
	    </c:when>
	  
	    <c:otherwise> 
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright">不可授权</td>
	      </c:otherwise>
	       </c:choose>	 
	        
	     <c:choose>
	    <c:when test="${menu.iscanUpdate==0}"> 
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright">可修改</td>
	    </c:when>
	  
	    <c:otherwise> 
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright">不可修改</td>
	      </c:otherwise>
	       </c:choose>	
	       
	          <c:choose>
	    <c:when test="${menu.ismenu==0}"> 
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright">菜单</td>
	    </c:when>
	  
	    <c:otherwise> 
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright">功能</td>
	      </c:otherwise>
	       </c:choose>
	    
   	    <td width="15%"  align="center" bgcolor="#F5FAFE"  class="main_bright">${menu.buttonHtmlcontent}</td>
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" ><a href="javascript:void(0)" onclick="menuDetail('${menu.id}')">查看</a></td>
	    <td width="8%"  align="center" valign="middle" bgcolor="#F5FAFE"  class="main_bright"><img border="0" src="./images/icons/pencil.png" title="修改" style="cursor:pointer; margin: 0 5px;" onclick="menuEdit('${menu.id}')"/></td>
    </tr>
   </c:forEach>
     <tr bgcolor="#FFFFFF">
      <td  align="right" colspan="9">
		 <div id="pp" class="easyui-pagination" style="background:#efefef;border:1px solid #ccc;"></div>  
		</td>
	</tr>
</table>
</form>
<input id="pageNum" type="hidden" value="${pageNum}"/>
<input id="pageTotal" type="hidden" value="${pageTotal}"/>
<input id="pageSize" type="hidden" value="${pageSize}"/>
<input id="menuName" type="hidden" value="${menuName}"/>
<script type="text/javascript">

	$(document).ready(function(){
	var id = ${parentId};
		var menuName=$("#menuName").val();
	     $("#pp").pagination({  
				total:$("#pageTotal").val(),
				pageSize:$("#pageSize").val(),
				pageNumber:parseInt($("#pageNum").val()),
				pageList:[10,15,20],
				onSelectPage:function(pageNum, pageSize){
	               jump("<%=rootPath%>superadmin/ConsoleMenu/getAllConsoleMenus?pageNum="+pageNum+"&pageSize="+pageSize+"&menuName="+menuName+"&id="+id+"");
				}  
	});
	
	});
</script>
</body>
</html>
