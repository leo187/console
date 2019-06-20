<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map.Entry"%>
<%@ page import="com.rbac.console.entity.ConsoleMenu" %>
<%
	String rootPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
	String _type = (String)request.getAttribute("type");
	if(_type == null){
		List<ConsoleMenu> topMenu = (List<ConsoleMenu>)request.getSession().getAttribute("topMenu");
		_type = topMenu.get(0).getMenuParm3();
	}
	Map<Object, Map<Object, List<ConsoleMenu>>> menuMap1 = new LinkedHashMap<Object, Map<Object, List<ConsoleMenu>>>();
	menuMap1 = (Map<Object, Map<Object, List<ConsoleMenu>>>)request.getSession().getAttribute("allMenu");
	Map<Object, List<ConsoleMenu>> map = menuMap1.get(_type);
	String urll = null;
	if(map!=null && map.size()>0){
		Entry<Object, List<ConsoleMenu>> next = map.entrySet().iterator().next();
		ConsoleMenu ConsoleMenu = null;
		if(next.getValue()==null || next.getValue().size()==0 ){
			ConsoleMenu = (ConsoleMenu)next.getKey();
		}else{
			ConsoleMenu = next.getValue().get(0);
		}
		if(ConsoleMenu.getMenuHref()==null || ConsoleMenu.getMenuHref().equals("")){
			urll = "";
		}else{
			urll = rootPath+ConsoleMenu.getMenuHref();
		}
	}else{
		urll = "";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>授权管理</title>
<link rel="stylesheet" type="text/css" href="./css/easyui.css" />
<link rel="stylesheet" type="text/css" href="./css/icon.css" />
<link rel="stylesheet" type="text/css" href="./css/css_body.css" />
<link rel="stylesheet" type="text/css" href="./css/zTreeStyle.css"/>
<script type="text/javascript" src="./js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="./js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="./js/highcharts.js"></script>
<script type="text/javascript" src="./js/exporting.js"></script>
<script type="text/javascript" src="./js/zyz_easydatecheck.js"></script>
<script type="text/javascript" src="./js/json2.js"></script>
<script type="text/javascript" src="./js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="./js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="./js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/esl.js"></script>
<script type="text/javascript" src="./js/WdatePicker.js"></script>
<script type="text/javascript" src="./js/echarts.js"></script>
</head>

<body id="indexLayout" class="easyui-layout">
	<!-- head begin -->
	<div region="north" href="<%=rootPath%>superadmin/user/getDatagrTop?type=${type}" id="adminTop"
		split="false"
		style="height:65px;padding:0px;margin:0px; overflow: hidden;"></div>
	<div region="south" href="<%=rootPath%>superadmin/user/getDatagrid?url=admin_foot" split="false"
		style="height:30px;padding:0px;margin:0px;"></div>
	<div region="west"


<%if("console".equals(_type)){//授权管理%>
	href="<%=rootPath %>superadmin/ConsoleMenu/getConsoleMenu?url=consoleuser/console_user_menu"
<%}else if("item".equals(_type)){//待办%>
	href="<%=rootPath %>superadmin/ClassJd/getAllClass"
<%}%>
	split="true"
		title="
		<%if("console".equals(_type)){//授权管理%>
			授权管理
		<%}else if("item".equals(_type)){//待处理商品%>
			待办
		<%}%>
		" style="width:200px;padding1:1px;" id="uptitle"></div>
	<div region="center" id="centerBody"
	href="<%=urll %>" 
	title=" "
		split="false" style="overflow:auto;padding: 5px;"></div>
<script type="text/javascript">
		$(document).on("click","#menu li a",function(){
			$("#menu li a").each(function(){
				this.style.color="#244a78";
				this.style.fontWeight="normal";
			});
			this.style.fontWeight="bold";
			this.style.color="#FF0000";
		})
		function refresh(){
			$("#adminTop").load("${pageContext.request.contextPath}/getDatagrTop?type=statistics");
		}
</script>
</body>
</html>
