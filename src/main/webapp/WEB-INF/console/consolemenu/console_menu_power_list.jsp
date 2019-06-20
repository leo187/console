<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%
String rootPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=rootPath%>admin/css/css_body.css" rel="stylesheet" type="text/css" />
<title>站点管理</title> 
<%
	String menuJson = (String)request.getAttribute("menuJson");
%>
<link rel="stylesheet" href="<%=rootPath%>admin/css/icon.css" type="text/css"></link>
<script type="text/javascript" src="<%=rootPath%>admin/js/jquery-1.8.0.min.js"></script> 
<script type="text/javascript" src="<%=rootPath%>admin/js/jquery.easyui.min.js"></script>

<script type="text/javascript" src="<%=rootPath%>admin/js/easyui-lang-zh_CN.js"></script></head> 
<body>
<div id="tree">
<script type="text/javascript">

var zNodes = <%=menuJson%>;
var setting = {
		view: {
			showIcon: true,
			addDiyDom: addDiyDom
		},
		 data: {
                 simpleData : {
                     enable : true,
                     idKey : "id",
                     pIdKey : "pId"
                }
            },
         
           
	};
	

$(function(){ 
	//生成分类树 
		$.fn.zTree.init($("#menuTree"), setting, zNodes);
			
});



function addDiyDom(treeId, treeNode) {
	var aObj = $("#" + treeNode.tId + "_a");
	var editStr = "<input type=\"checkbox\" value=\""+treeNode.id+"\" name=\"menuId\" onclick=\"addPower()\" />";
	aObj.prepend(editStr);
	
};

function addPower(){

		if($("input[name='menuId']:checked")){
			var menuId=$("input[name='menuId']:checked").val();
    		$.messager.confirm('提示信息','是否要在该菜单下添加子菜单？',function(r){ 
    		    if(r){
    		    	var dialogDiv = document.createElement("div");
    		    	dialogDiv.id="addMenu";
    		    	document.body.appendChild(dialogDiv);
    		    	$('#addMenu').dialog({   
    		    	    modal:true,
    		    	    href:'<%=rootPath%>superadmin/user/getDatagrid?url=consolemenu/console_menu_add',
    		    	    title:'添加菜单',
    		    	    width:300,
    		    	    height:140,
    		    	    resizable:true,
    		    	    buttons: [{
    		    	    	text: '提交', 
    		    	    	iconCls: 'icon-ok', 
    		    	    	handler: function() {
    		    				$('#addMenuForm').form('submit',{
    		    	    			url : "<%=rootPath %>superadmin/ConsoleMenu/addConsoleMenu?parentMenuId="+menuId,
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
    		    	    				$('#addMenu').dialog('destroy');
    		    	    				$.messager.progress('close');
    		    	    				if(data==1){
    		    	    					$.messager.alert("提示信息","添加菜单成功","info");
    		    	    					$('#editRight').panel('refresh',"<%=rootPath%>superadmin/ConsoleMenu/getConsoleMenuZTree");
    		    	    					$('body').layout('panel','center').panel('refresh');
    		    	    					
    		    	    					
    		    	    				}else{
    		    	    					$.messager.alert("提示信息","添加菜单失败！","error");
    		    	    				}
    		    	    			}
    		    	    		});
    		    	    	} 
    		    	    },{ 
    		    	    	text: '取消', 
    		    	    	iconCls: 'icon-cancel', 
    		    	    	handler: function() { 
    		    	    		$('#addMenu').dialog('destroy');
    		    	    		$("input[name=menuId]").removeAttr('checked');
    		    	    	} 
    		    	    }],
    		    	    onClose:function(){
    		    	    	$('#addMenu').dialog('destroy');
    		    	    }
    		    	});
    		    }else{
    		    	$("input[name=menuId]").removeAttr('checked');
    		    	$.messager.alert("提示信息","请选择父级菜单。","warning");
    		    }
    		});
    	}
}
		    						    			
</script>  
<div id="tree" class="content_wrap">
	<div class="zTreeDemoBackground left">
		<div id="menuTree" class="ztree" style="background-color: white;height: 100%;border: none;overflow-y:auto;" ></div>
	</div>
</div>
</div>
</body>
</html>
