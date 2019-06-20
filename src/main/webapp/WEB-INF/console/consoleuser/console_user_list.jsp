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
<link href="<%=rootPath%>admin/css/css_body.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="./css/easyui.css" />
<link rel="stylesheet" type="text/css" href="./css/icon.css" />
<link rel="stylesheet" type="text/css" href="./css/css_body.css" />

<script type="text/javascript" src="./js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="./js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=rootPath %>editor/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="<%=rootPath %>editor/applet/ckwordup.js"></script>
<script type="text/javascript" src="./js/json2.js"></script>
<style type="text/css">
.page{margin:2em;}
.page a{text-decoration:none;display:inline-block;line-height:14px;padding:2px 5px;color:#333;border:1px solid #ccc;margin:0 2px;}
.page a:hover,.page a.on{background:#999;color:#fff;border:1px solid #333;}
.page a.unclick,.page a.unclick:hover{background:none;border:1px solid #eee;color:#999;cursor:default;}
</style>
</head>
<body>
<script type="text/javascript">
//全局变量，
var m_checked = false;
//全选
function checkAll(){
	m_checked = !m_checked;
	$("input[name='userid']").attr("checked",m_checked);
}

//刷新
function refresh(){
	$('body').layout('panel','center').panel('refresh');
}

//停用选择的用户
function forbidUsers(){
	var userids = "";
	$("input[name='userid']:checked").each(function(){
			userids+=','+this.value;
	});

		if(userids){
    		userids = userids.substring(1);
    		$.messager.confirm('提示信息','是否要停用这些用户？',function(r){
    		    if(r){
   		    		$.ajax({
   	    				url: "<%=rootPath %>superadmin/ConsoleUser/updateConsoleUserStatusByUserids?type="+0+"",
   	    			   	type: "POST",
   	    			   	data: {userIds: userids},
   	    			   	success: function(msg){
   	    			   		$.messager.alert("提示信息","成功停用了"+msg+"个用户","info");
   	    			   		$('body').layout('panel','center').panel('refresh');
   	    			   	}
   		    		});
    		    }
    		});
    	}else{
    		$.messager.alert("提示信息","请选择要停用的用户。","warning");

	}
}


//修改密码
function updatePwd(){
	var userids = "";
	$("input[name='userid']:checked").each(function(){userids+=','+this.value;});
	if(userids){
		userids = userids.substring(1);
		var dialogDiv = document.createElement("div");
		dialogDiv.id="editPwd";
		document.body.appendChild(dialogDiv);
		$('#editPwd').dialog({
		    modal:true,
		    href:'<%=rootPath %>superadmin/ConsoleUser/getConsoleUserByIds?userIds='+userids,
		    title:'修改密码',
		    width:300,
		    height:140,
		    resizable:true,
		    buttons: [{
		    	text: '提交',
		    	iconCls: 'icon-ok',
		    	handler: function() {
		    		$('#pwdForm').form('submit',{
		    			url : "<%=rootPath %>superadmin/ConsoleUser/updatePwdByUserIds",
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
		    				$('#editPwd').dialog('destroy');
		    				$.messager.progress('close');
		    				if(data>0){
		    					$.messager.alert("提示信息","成功重置了"+data+"个用户密码","info");
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
		    		$('#editPwd').dialog('destroy');
		    	}
		    }],
		    onClose:function(){
		    	$('#editPwd').dialog('destroy');
		    }
		});
	}else{
		$.messager.alert("提示信息","请选择要修改密码的用户。","warning");
	}
}

//删除用户
function deleteUser(){
	var userids = "";
	$("input[name='userid']:checked").each(function(){
			userids+=','+this.value;
	});
		if(userids){
    		userids = userids.substring(1);
    		$.messager.confirm('提示信息','是否要删除这些用户？',function(r){
    		    if(r){
   		    		$.ajax({
   	    				url: "<%=rootPath %>superadmin/ConsoleUser/deleteConsoleUserByUserids?",
   	    			   	type: "POST",
   	    			   	data: {userIds: userids},
   	    			   	success: function(msg){
   	    			   		$.messager.alert("提示信息","成功删除了"+msg+"个用户","info");
   	    			   		$('body').layout('panel','center').panel('refresh');
   	    			   	}
   		    		});
    		    }
    		});
    	}else{
    		$.messager.alert("提示信息","请选择要删除的用户。","warning");
    	}

}








//修改用户
function userEdit(_nUserId){
	var dialogDiv = document.createElement("div");
	dialogDiv.id="editUser";
	document.body.appendChild(dialogDiv);
	$('#editUser').dialog({
	    modal:true,
	    href:'<%=rootPath %>superadmin/ConsoleUser/getEditConsoleUserById?type=1&userId='+_nUserId,
	    title:'修改用户',
	    width:500,
	    height:531,
	    resizable:true,
	    buttons: [{
	    	text: '提交',
	    	iconCls: 'icon-ok',
	    	handler: function() {

				$('#editUserForm').form('submit',{
	    			url : "<%=rootPath %>superadmin/ConsoleUser/updateConsoleUserById",
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

	    				$('#editUser').dialog('destroy');
	    				$.messager.progress('close');
	    				if(data==1){
	    					$.messager.alert("提示信息","修改用户成功","info");
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
	    		$('#editUser').dialog('destroy');
	    	}
	    }],
	    onClose:function(){
	    	$('#editUser').dialog('destroy');
	    }
	});
}

function userDetail(_nUserId){
	 var dialogdiv=document.createElement("div");
	 dialogdiv.id="userDetail";
	 document.body.appendChild(dialogdiv);
	 $('#userDetail').dialog({
		 modal:true,
		 title:'查看用户详情',
		 href:'<%=rootPath %>superadmin/ConsoleUser/getConsoleUserById?type=2&userId='+_nUserId,
		 width:400,
		 height:500,
		 resizable:true,
		 maximizable:false,
		 buttons:[{
			 text:'关闭',
			 iconCls:'icon-cancel',
			 handler:function()
			 {
			$('#userDetail').dialog('destroy');
			 }
		 }],
		 onClose:function(){
		$('#userDetail').dialog('destroy');
		 }

	 });

}


//分页
function page(_nPageNum){
	$('#pageNum').val(_nPageNum);
	var queryString = $('#pageForm').serialize();
	jump("<%=rootPath %>user/use_user_list.action?"+queryString);
}
//排序
function orderBy(_sFiled,_sOrderBy){
	$('#orderField').val(_sFiled);
	$('#orderBy').val(_sOrderBy);
	var queryString = $('#pageForm').serialize();
	jump("<%=rootPath %>user/use_user_list.action?"+queryString);
}
//处理搜索栏
$(function(){
	$('#listSearchText').searchbox({
		width:220,
	    searcher:function(value,name){
	    	jump("<%=rootPath %>superadmin/ConsoleUser/getAllConsoleUser?searchWord="+value+"&searchType="+name+"&type="+3+"&userState=${userState}");
	    },
	    menu:'#listSearchType',
	    prompt:'请输入检索词'
	});
});

//新增用户
function addConsoleUser(){
	var dialogDiv = document.createElement("div");
	dialogDiv.id="addConsoleUser";
	document.body.appendChild(dialogDiv);
	$('#addConsoleUser').dialog({
	    modal:true,
	    href:'<%=rootPath %>superadmin/ConsoleUser/toAddConsoleUser',
	    title:'新增用户(<font color="red">*</font>为必填选项)',
	    width:450,
	    height:500,
	    resizable:true,
	    buttons: [{
	    	text: '提交',
	    	iconCls: 'icon-ok',
	    	handler: function() {
				$('#addConsoleUserForm').form('submit',{
	    			url : '<%=rootPath %>superadmin/ConsoleUser/addConsoleUser',
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
	    					$.messager.alert("提示信息","用户已存在！","info");
	    					refresh();
	    				}else if(data>0){
	    					$.messager.alert("提示信息","新增用户成功","info");
	    					$('#addConsoleUser').dialog('destroy');
	    					refresh();
	    				}else{
	    					$.messager.alert("提示信息","新增用户失败！","error");
	    					$('#addConsoleUser').dialog('destroy');
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
	    		$('#addConsoleUser').dialog('destroy');
	    	}
	    }],
	    onClose:function(){
	    	$('#addConsoleUser').dialog('destroy');
	    }
	});
}

</script>

<div id="listSearchType" style="width:120px;">
   <!--  <div data-options="name:'all'">全部&nbsp;&nbsp;&nbsp;&nbsp;</div> -->
    <div data-options="name:'username'">用户名&nbsp;&nbsp;</div>
    <div data-options="name:'usertruename'">真实姓名</div>
</div>

<table width="100%"  border="0" align="center" cellpadding="10" cellspacing="1" bgcolor="#cad9ea">

	<tr class="list_th" style="position: relative;">
   	  	<td colspan="5" align="left" style="padding-left: 10px;" nowrap="nowrap">
   	  		<a href="javascript:void(0)" onclick="addConsoleUser()">新增用户</a>
   	  		<a href="javascript:void(0)" onclick="forbidUsers()">停用用户</a>
   	  		<a href="javascript:void(0)" onclick="updatePwd()">重置密码 </a>
   	  		<a href="javascript:void(0)" onclick="deleteUser()">删除用户 </a>






			<a href="javascript:void(0)" onclick="refresh()">刷新 </a>
   	  	</td>
   	  	<td colspan="15" align="right" style="padding-right: 2px;"><input id='listSearchText' value="${searchWord}"/></td>
	</tr>
   <tr>
	    <td width="5%" align="center" bgcolor="#F5FAFE" class="main_bright"><a href="javascript:void(0)" onclick="checkAll()">全选</a></td>
	    <td width="7%" align="center" bgcolor="#F5FAFE" class="main_bright"><a href="javascript:void(0)" >用户名</a></td>
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >状态</a></td>
	    <td width="6%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >移动电话</a></td>
	    <td width="6%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >固定电话</a></td>
	    <td width="10%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >用户角色</a></td>
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >创建时间</a></td>
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >用户详情</a></td>
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright">操作</td>
    </tr>
	<c:forEach items="${userList}" var="user">
    <tr>
	    <td width="5%" align="center" bgcolor="#F5FAFE" class="main_bright"><input type="checkbox" name="userid" value="${user.id}" /></td>
	    <td width="7%" align="center" bgcolor="#F5FAFE" class="main_bright">${user.username}</td>
	     <c:choose>
	    <c:when test="${user.userStatus==1}">
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright">已启用</td>
	    </c:when>
	    <c:when test="${user.userStatus==0}">
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright">已停用</td>
	    </c:when>
	    <c:otherwise>
	     <td width="12%" align="center" bgcolor="#F5FAFE"  class="main_bright"></td>
	      </c:otherwise>
	    </c:choose>
	    <td width="6%" align="center" bgcolor="#F5FAFE"  class="main_bright">${user.mobile}</td>
	    <td width="6%" align="center" bgcolor="#F5FAFE"  class="main_bright">${user.telephone}</td>
	    <td width="10%" align="center" bgcolor="#F5FAFE"  class="main_bright">${user.userParm2}</td>
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright"><fmt:formatDate value="${user.userCreattime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" onclick="userDetail('${user.id}')">查看</a></td>
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright"><img border="0" src="./images/icons/pencil.png" title="修改" style="cursor:pointer; margin: 0 5px;" onclick="userEdit('${user.id}')"/></td>
    </tr>
     
   </c:forEach>
    <tr bgcolor="#FFFFFF">
      <td  align="right" colspan="15">
		 <div id="pp" class="easyui-pagination" style="background:#efefef;border:1px solid #ccc;"></div>  
		</td>
	</tr>
</table>
<input id="pageNum" type="hidden" value="${pageNum}"/>
<input id="pageTotal" type="hidden" value="${pageTotal}"/>
<input id="pageSize" type="hidden" value="${pageSize}"/>
<input id="searchType" type="hidden" value="${searchType}"/>
<input id="userState" type="hidden" value="${userState}"/>
<script type="text/javascript">

	$(document).ready(function(){
		var sType = $("#searchType").val();
		$("#listSearchText").searchbox('selectName',sType);
		var searchType = $("#listSearchText").searchbox('getName');
		var searchWord = $("#listSearchText").searchbox('getValue');
		var userState=$("#userState").val();
	     $("#pp").pagination({  
				total:$("#pageTotal").val(),
				pageSize:$("#pageSize").val(),
				pageNumber:parseInt($("#pageNum").val()),
				pageList:[10,15,20],
				onSelectPage:function(pageNum, pageSize){
		
					jump("<%=rootPath%>superadmin/ConsoleUser/getAllConsoleUser?pageNum="+pageNum+"&pageSize="+pageSize+"&searchWord="+searchWord+"&searchType="+searchType+"&userState=${userState}"); 
				}  
	});
	});
</script>
</body>
</html>