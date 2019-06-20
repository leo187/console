<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String rootPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>    	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
<title>首页</title>
<%
	String menuJson = (String)request.getAttribute("menuJson");
%>
<style type="text/css">
.ztree li span.button.add {margin-left:10px; margin-right: -1px; background-position:-144px 0; vertical-align:top; vertical-align:middle}
</style>
</head>
<body>

<script type="text/javascript">
function jump(_sUrl){
	$('body').layout('panel','center').panel('refresh',_sUrl);
}

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
            async: {
				enable: false
			},
            callback: {
        		onClick: zTreeOnClick
        	}
         
           
	};
	

$(function(){
	//生成分类树 
	  var zNodes = <%=menuJson%>;
	   var menuIds="${sMenuIds}";
	   var menuIdds = eval('('+menuIds+')');
	   for(var k=0;k<menuIdds.length;k++){
		   for(var n=0;n<zNodes.length;n++){
			   if(menuIdds[k]==zNodes[n].id){
				   zNodes[n]["open"] = "true"; 
			   }
		   }
	   }
	   
 	$.fn.zTree.init($("#menuTree"), setting, zNodes);
	var allMenuIds="${allMenuIds}";
	var allMenuIdds = eval('('+allMenuIds+')');
	
	for(var i=0;i<menuIdds.length;i++){
		for(var j=0;j<allMenuIdds.length;j++){
			if(allMenuIdds[j]==menuIdds[i]){
			
				$("input[name='menuId'][value='"+menuIdds[i]+"']").attr("checked",true); 
				//$("input[name='menuId'][value='"+menuIdds[i]+"']").parent().parent().parent().parents().each(function(i,inputNode){
					//$(inputNode).find(":input").first().attr("checked",true); 
				//});
			}
		}
	}
});




function addDiyDom(treeId, treeNode) {
	var aObj = $("#" + treeNode.tId + "_a");
	var editStr = "<input type=\"checkbox\" value=\""+treeNode.id+"\" name=\"menuId\"  />";
	aObj.prepend(editStr);
	
};
var menuidds = "";
function checkAllParents(treeNode){
	if (treeNode==null || treeNode.pId==null) {
	     return ;
	}
	else
	{
		menuidds+=','+treeNode.getParentNode()["id"];
		checkAllParents(treeNode.getParentNode());
	}
 }

function checkedJs(){
   $("input[name='menuId']:checked").each(function(){
		menuidds+=','+this.value;
		var treeObj = $.fn.zTree.getZTreeObj("menuTree");
		var treeNode=treeObj.getNodeByParam("id", this.value, null);
		checkAllParents(treeNode);
	});
   var roleId="${roleId}";
   if(menuidds){
		menuidds=menuidds.substring(1);
		$.messager.confirm('提示信息','是否要将这些权限菜单赋予给该角色？',function(r){   
		    if(r){
		    		$.ajax({
	    				url: "<%=rootPath %>superadmin/ConsoleRoleMenu/addConsoleRoleMenu?roleId="+roleId+"",
	    				data: {menuIds: menuidds},
	    			   	type: "POST",
	    			   	success: function(msg){
	    			   		$.messager.alert("提示信息","添加菜单成功","info");
	    			   	    $('#editRight').dialog('destroy');
	    			   	}
		    		});
		    }
		});
   
  
   }
  
}
 $(function(){
	    var muenId = $("input[name='menuId']");
		muenId.change(function(){       
		
			 if($(this).attr("checked")=="checked") {
			
			    checkedInput(this);
			 }else{
			    checkedIn(this);
			 }
		});
	 });
	  
	   function checkedIn(checked){
			   
	      var ul = $(checked).parent().next();
		        var li = $(ul).children();
			    var inputArr = [];
	                    
			    $.each(li,function(i,n){    
			        var tempInput = $(n).find("input");
			        tempInput.removeAttr("checked");     
			        inputArr.push(tempInput);
			    });
	  };
	  function checkedInput(checked){
		  var ul = $(checked).parent().next();
		        var li = $(ul).children();
			    var inputArr = [];
	                    
			    $.each(li,function(i,n){
			        var tempInput = $(n).find("input");
			        tempInput.attr("checked","checked");      
			        inputArr.push(tempInput);
			    });   
	  }
function  zTreeOnClick(event, treeId, treeNode){
	  var treeObj = $.fn.zTree.getZTreeObj("menuTree");	 
	  var nodes = treeObj.getSelectedNodes();
		if (nodes.length>0) {
			treeObj.expandNode(nodes[0], true, true, true,true);
			 var ul = $("input[name='menuId'][value='"+nodes[0].id+"']").parent().next();
		        var li = $(ul).children();
			    var inputArr = [];
	                    
			    $.each(li,function(i,n){
			        var tempInput = $(n).find("input");
			        tempInput.attr("checked","checked");      
			        inputArr.push(tempInput);
			    }); 
		}
}
</script>
<div id="tree" class="content_wrap">
	<div class="zTreeDemoBackground left">
		<div id="menuTree" class="ztree" style="background-color: white;height: 100%;border: none;overflow-y:auto;" ></div>
	</div>
</div>
</body>
</html>