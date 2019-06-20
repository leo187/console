<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String rootPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>超市管理</title>
<link href="admin/css/css_body.css" rel="stylesheet" type="text/css" />
</head>
  
<body>
<script type="text/javascript">
function checkAll(){
	m_checked = !m_checked;
	$("input[name='roleid']").attr("checked",m_checked); 
}
</script>
<div id="addConsoleUser" class="easyui-tabs" plain="true" style="width:426px;height:400px; padding: 5px;">  
    <div title="用户信息"  style="overflow:auto;padding:20px;">
	    <form id="addConsoleUserForm" method="post" onsubmit="return check(this)" name="frm" >
		<table width="100%" cellpadding="0" cellspacing="4">
			<tr>
				<td>用户名:</td>
				<td><input type="text" name="userName"  class="easyui-validatebox" required="true" data-options="validType:'userNameRex'" missingMessage="请填写用户名"/></td>
			</tr>
			<tr>
				<td>真实姓名:</td>
				<td><input type="text" name="trueName" required="true" class="easyui-validatebox"  missingMessage="请填写真实姓名"/></td>
			</tr>
			<tr>
				<td>移动电话:</td>
				<td><input type="text" name="mobil" class="easyui-validatebox" missingMessage="请填写手机号码" data-options="validType:'mobile'" /></td>
			</tr>
			<tr>
				<td>固定电话:</td>
				<td><input type="text" name="userTel" class="easyui-validatebox" missingMessage="请填写固定电话" data-options="validType:'phoneRex'" /></td>
			</tr>
			<tr>
				<td>用户邮箱:</td>
				<td><input type="text" name="userEmail" class="easyui-validatebox" missingMessage="请填写邮箱"   data-options="validType:'emailRex'"/></td>
			</tr>
			<!-- 
			<table >
			<tr>
			选择角色：
			<c:forEach items="${roleList}" var="role">
			
			<input type="checkbox" name="choose" id="role" value = "${role.id}"  <c:if test="${role.id>0}">checked="checked"</c:if> onblur="check();"/>
			
			<label for="choose">${role.rolename}</label>
			</c:forEach>
			
			</tr>
			</table>
			 -->
			<table>
			选择角色：
			<div>
			<c:forEach items="${roleList}" var="role">
			<input type="checkbox" name="cb1" class="easyui-validatebox" value = "${role.id}" onblur="check();" validType="checkbox['frm','cb1']" />${role.rolename}
			</c:forEach>
			</div>
			</table>
			
			<input type="hidden"  id="test" name="roleIds">
			 </table>
			<!-- 单选框
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
	</form>
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
    for(var k = 0 ;k < obj.length ; k++){
    if(obj[k].checked){
            check_val.push(obj[k].value);
        }
    }
    document.getElementById("test").value = check_val;
}

$.extend($.fn.validatebox.defaults.rules, {
 userNameRex: {
    validator: function(value){
 
    var rex=/^[a-zA-z][a-zA-Z0-9_]{5,17}$/;
    if(rex.test(value))
    {
      // alert('t'+value);
      return true;
    }else
    {
     //alert('false '+value);
       return false;
    }},
    message: '用户名必须以字母开头，长度在6-18之间，只能包含字符、数字和下划线！'
  }
});



//自定义用户名正则验证
$.extend($.fn.validatebox.defaults.rules, {
 userNameRex: {
    validator: function(value){
 
    var rex=/^[a-zA-z][a-zA-Z0-9_]{5,17}$/;
    if(rex.test(value))
    {
      // alert('t'+value);
      return true;
    }else
    {
     //alert('false '+value);
       return false;
    }},
    message: '用户名必须以字母开头，长度在6-18之间，只能包含字符、数字和下划线！'
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
   //自定义邮箱验证
  $.extend($.fn.validatebox.defaults.rules, {
  emailRex: {
    validator: function(value){
    var rex=/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/; 
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
