<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String rootPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../css/css_body.css" rel="stylesheet" type="text/css" />
<title>站点管理</title>
</head>

<body>   
<script type="text/javascript">
function jump(_sUrl){
	$('body').layout('panel','center').panel('refresh',_sUrl);
}

$(function(){
	$('#knowledgeconf').tabs({
		onSelect:function(title,index){
			var panels = $('#knowledgeconf').tabs('tabs');
			for(var i=0;i<panels.length;i++){
				var panel = panels[i];
				if(i==index){
					panel.panel('refresh',panel.attr('link'));
				}else{
					panel.html('');
				}
			}
		}
	});
});
</script>
<div id="knowledgeconf" fit="true" plain="true">
<div title="模板管理" style="overflow:auto;padding:5px;" selected="true" link="<%=rootPath%>site/templateselect.action?pageNum=1"></div>
<div title="模板详情" style="overflow:auto;padding:5px;" ></div>

</div>
</body>
</html>
