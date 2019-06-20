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
<script type="text/javascript">
function imgDetail(imageSource){
	 var dialogdiv=document.createElement("div");
	 dialogdiv.id="imgDetail";
	 document.body.appendChild(dialogdiv);
	 $('#imgDetail').dialog({
		 modal:true,
		 title:'查看大图',
		 href:'<%=rootPath %>superadmin/user/lookBigImage?&imageSource='+imageSource,
		 width:450,
		 height:400,
		 resizable:true,
		 maximizable:false,
		 buttons:[{
			 text:'关闭',
			 iconCls:'icon-cancel',
			 handler:function()
			 {
			$('#imgDetail').dialog('destroy');	 
			 }
		 }],
		 onClose:function(){
		$('#imgDetail').dialog('destroy');
		 }
		 
	 });
	 
}
</script>

<div id="userEdit" class="easyui-tabs" plain="true" style="width:476px;height:450px; padding: 5px;">  
    <div title="用户信息" selected="true" style="overflow:auto;padding:20px;">
	    <form id="editUserForm" method="post"  onsubmit="return check(this)" name="frm">
	     <input type="hidden" value="${user.id}" name="userid"/>
		<table width="100%" cellpadding="0" cellspacing="4">
			<tr>
				<td width="100">用户名：</td>
				<td><input type="text" name="username" value="${user.username}" disabled="disabled" /></td>
			</tr>
			<tr>
				<td>真实姓名:</td>
				<td><input type="text" name="trueName" value="${user.truename}" class="easyui-validatebox" required="true" validType="length[1,20]" missingMessage="请填写真实姓名" /></td>
			</tr>
			<tr>
				<td>移动电话:</td>
				<td><input type="text" name="mobile" value="${user.mobile}" class="easyui-validatebox" missingMessage="请填写手机号码"  data-options="validType:'mobile'" /></td>
			</tr>
			<tr>
				<td>固定电话:</td>
				<td><input type="text" name="telephone" value="${user.telephone}" class="easyui-validatebox" missingMessage="请填写固定电话"  data-options="validType:'phoneRex'" /></td>
			</tr>
			<tr>
				<td>用户邮箱:</td>
				<td><input type="text" name="email" value="${user.userEmail}" class="easyui-validatebox" missingMessage="请填写用户邮箱"  data-options="validType:'emailRex'" /></td>
			</tr>
			<tr>
				<td>用户停用状态:</td>
				<td>
					<input id="_log_type" type="radio" name="userStatus" value="0" <c:if test='${user.userStatus==0}'>checked="checked"</c:if>>停用
					<input id="_log_type" type="radio" name="userStatus" value="1" <c:if test='${user.userStatus==1}'>checked="checked"</c:if>>启用
             </td>
			</tr>
			<!-- 
			<tr>
			<td width="100">选择角色:</td>
			<td>
			<select id="select" style="border:1px solid #CCC;" name="userRoleId" required="true"  value="a" onchange="showWord()">
			<c:forEach items="${roleList}" var="role">
			<option value = "${role.id}" >${role.rolename}</option>
			</c:forEach>
			</select>
			</td>
			</tr>
			 -->
			<!-- 
		</table>
			<table>
			<tr>
			选择角色：
			<td>
			<c:forEach items="${roleList}" var="role">
			
			<input type="checkbox" name="choose" id="roleId" <c:forEach items="${userRole}" var="userR"><c:if test="${userR==role.id }">checked="checked"</c:if></c:forEach> value = "${role.id}"  onblur="check();"/>
			<label for="choose">${role.rolename}</label>
			</c:forEach>
			</td>
			</tr>
			</table>
			 -->
			 <table>
			选择角色：
			<div>
			<c:forEach items="${roleList}" var="role">
			<input type="checkbox" name="cb1" class="easyui-validatebox" value = "${role.id}" onblur="check();" <c:forEach items="${userRole}" var="userR"><c:if test="${userR==role.id }">checked="checked"</c:if></c:forEach>  validType="checkbox['frm','cb1']" />${role.rolename}
			</c:forEach>
			</div>
			</table>
			
			 
			<input type="hidden"  id="test" name="roleIds">
	</form>
    </div>

</div>  


<script>
        $.extend($.fn.validatebox.defaults.rules, {
            checkbox: {
                validator: function (value, param) {
                    var frm = param[0], groupname = param[1], checkNum = 0;
                    $('input[name="' + groupname + '"]', document[frm]).each(function () { //查找表单中所有此名称的checkbox
                        if (this.checked) checkNum++;
                    });
 
                    return checkNum > 0 ;
                },
                message: '请选择用户角色！'
            }
        });
        function check(f) {
		     
 
            o = $(f.cb1[0]);
            if (!o.validatebox('isValid')) o.parent().addClass('validatebox-invalid');
            else o.parent().removeClass('validatebox-invalid');
            return false
        }
    </script>
 




<script>

function check(){

    obj = document.getElementsByName("cb1");
    check_val = [];
    for(var k = 0 ; k<obj.length ; k++){
        if(obj[k].checked)
            check_val.push(obj[k].value);
    }
    document.getElementById("test").value = check_val;
}


 //自定义手机号码验证
  $.extend($.fn.validatebox.defaults.rules, {
  mobile: {
    validator: function(value){
   var rex=/^1[3-8]+\d{9}$/;
    if(rex.test(value))
    {
      // alert('t'+value);
      return true;
    }else
    {
     //alert('false '+value);
       return false;
    }},
    message: '请输入正确手机号码'
  }
});

  //自定义固定电话码验证
  $.extend($.fn.validatebox.defaults.rules, {
  phoneRex: {
    validator: function(value){
    
    //var rex=/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
    //区号：前面一个0，后面跟2-3位数字 ： 0\d{2,3}
    //电话号码：7-8位数字： \d{7,8
    //分机号：一般都是3位数字： \d{3,}
     //这样连接起来就是验证电话的正则表达式了：/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/		 
    var rex2=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
    if(rex2.test(value))
    {
      // alert('t'+value);
      return true;
    }else
    {
     //alert('false '+value);
       return false;
    }},
    message: '请输入正确电话号码'
  }
});
  //自定义邮箱验证
  $.extend($.fn.validatebox.defaults.rules, {
  emailRex: {
    validator: function(value){
    var rex=/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/	 
    if(rex.test(value))
    {
 
      return true;
    }else
    {

       return false;
    }},
    message: '请输入正确邮箱账号'
  }
});
</script>
</body>
</html>
