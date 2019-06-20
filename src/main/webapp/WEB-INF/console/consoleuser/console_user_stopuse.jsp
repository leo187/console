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
<title>已停用用户管理</title>
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

//启用选择的用户
function startUser(){
	var userids = "";
	//var isAdmin = false;
	$("input[name='userid']:checked").each(function(){
		
			userids+=','+this.value;
			/*
		if(this.value!=3){
		}else{
			$.messager.alert("提示信息","系统管理员不能停用，请重新选择。","error");
			isAdmin = true;
		}
		*/
	});
	//if(!isAdmin){
		if(userids){
    		userids = userids.substring(1);
    		$.messager.confirm('提示信息','是否要启用这些用户？',function(r){   
    		    if(r){
   		    		$.ajax({
   	    				url: "<%=rootPath %>superadmin/ConsoleUser/startConsoleUserStatusByUserids?type="+0+"",
   	    			   	type: "POST",
   	    			   	data: {userIds: userids},
   	    			   	success: function(msg){
   	    			   		$.messager.alert("提示信息","成功启用了"+msg+"个用户","info");
   	    			   		$('body').layout('panel','center').panel('refresh');
   	    			   	}
   		    		});
    		    }
    		});
    	}else{
    		$.messager.alert("提示信息","请选择要启用的用户。","warning");
    	}
	//}
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

function importExcel(){
	var dialogDiv = document.createElement("div");
	dialogDiv.id="importExcel";
	document.body.appendChild(dialogDiv);
	$('#importExcel').dialog({   
	    modal:true,
	    href:'<%=rootPath%>superadmin/user/getDatagrid?url=user/import_user_excel',
	    title:'导入Excel',
	    width:450,
	    height:300,
	    resizable:true,
	    buttons: [{
	    	id: 'btnUpload',
	    	text: '开始导入', 
	    	iconCls: 'icon-ok', 
	    	handler: function() {
	    		var tds = $('#uploadInfo').find('td[name="fileName"]');
	    		if(tds.length>0){
	    			$.messager.progress({
	    				text:'文档转换中...'
	    			});
	    			
	    			$.each(tds, function(i, n){
	    				var upFileName = $(n).attr('_upFileName');
		    			var upTrueName = $(n).attr('title');
		    			var ustatus = $('#uploadDoc').find('input[name="userStatus"]:checked').val();
		    			var r = convertExcel(upFileName, upTrueName, ustatus);
		    			if(r>0){
		    				$(n).css('color','green');
		    			}else{
		    				$(n).css('color','red');
		    			}
		    			var bar = $.messager.progress('bar');
	    				if(bar){
	    					var barVal = 100/tds.length*(i+1);
	    					bar.progressbar('setValue', parseInt(barVal));
	    				}
	    			});
	    			$.messager.progress('close');
		    		$('#btnUpload').linkbutton('disable');
		    		$('#btnClose').linkbutton({text: '关闭'});
	    		}else{
	    			$.messager.alert('提示信息','请选择上传的文件','warning');
	    		}
	    	} 
	    },{ 
	    	id : 'btnClose',
	    	text: '取消', 
	    	iconCls: 'icon-cancel', 
	    	handler: function() { 
	    		$('#importExcel').dialog('destroy');
	    		refresh();
	    	} 
	    }],
	    onClose:function(){
	    	$('#importExcel').dialog('destroy');
	    	refresh();
	    }
	});
}

function convertExcel(fileName, trueName, userStatus){
	var r = $.ajax({
		type:"post",
    	url:"<%=rootPath%>file/convert_user_excel.action",
    	data : {
    		'fileName' : fileName,
    		'fileTrueName' : trueName,
    		'irpUser.status' : userStatus
    	},
    	cache:false,
    	async:false,
    	error:function (XMLHttpRequest, textStatus, errorThrown) {
    	   alert(textStatus);
    	}
	}).responseText;
	return r;
}


</script>

<div id="listSearchType" style="width:120px;">  
    <!-- <div data-options="name:'all'">全部&nbsp;&nbsp;&nbsp;&nbsp;</div> -->
    <div data-options="name:'username'">用户名&nbsp;&nbsp;</div>
    <div data-options="name:'usertruename'">真实姓名</div>
</div> 
   
<table width="100%"  border="0" align="center" cellpadding="10" cellspacing="1" bgcolor="#cad9ea">

	<tr class="list_th" style="position: relative;">
   	  	<td colspan="5" align="left" style="padding-left: 10px;" nowrap="nowrap">
   	  		<a href="javascript:void(0)" onclick="startUser()">启用用户 </a>
			<a href="javascript:void(0)" onclick="refresh()">刷新 </a>
   	  	</td>
   	  	<td colspan="15" align="right" style="padding-right: 2px;"><input id='listSearchText' value="${searchWord}"/></td>
	</tr>
   <tr>
	    <td width="5%" align="center" bgcolor="#F5FAFE" class="main_bright"><a href="javascript:void(0)" onclick="checkAll()">全选</a></td>
	    <td width="5%" align="center" bgcolor="#F5FAFE" class="main_bright"><a href="javascript:void(0)" >用户名</a></td>
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >用户角色</a></td>
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >创建时间</a></td>
	    <td width="5%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >状态</a></td>	    
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >移动电话</a></td>
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >固定电话</a></td>
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" >用户详情</a></td>
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright">操作</td>
    </tr>
    
	<c:forEach items="${userList}" var="user">
    <tr>
	    <td width="5%" align="center" bgcolor="#F5FAFE" class="main_bright"><input type="checkbox" name="userid" value="${user.id}" /></td>
	    <td width="5%" align="center" bgcolor="#F5FAFE" class="main_bright">${user.username}</td>
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright">${user.userParm2}</td>
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright"><fmt:formatDate value="${user.userCreattime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
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
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright">${user.mobile}</td>
	    <td width="10%" align="center" bgcolor="#F5FAFE"  class="main_bright">${user.telephone}</td>
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright"><a href="javascript:void(0)" onclick="userDetail('${user.id}')">查看</a></td>
	    <td width="8%" align="center" bgcolor="#F5FAFE"  class="main_bright"><img border="0" src="./images/icons/pencil.png" title="修改" style="cursor:pointer; margin: 0 5px;" onclick="userEdit('${user.id}')"/></td>
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
					jump("<%=rootPath%>superadmin/ConsoleUser/getAllConsoleUser?pageNum="+pageNum+"&pageSize="+pageSize+"&searchWord="+searchWord+"&searchType="+searchType+"&type="+3+"&userState=${userState}"); 
				}  
	});
	});
</script>
</body>
</html>
