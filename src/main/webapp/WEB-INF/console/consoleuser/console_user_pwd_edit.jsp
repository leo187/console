<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户管理</title>
<link href="../css/css_body.css" rel="stylesheet" type="text/css" />
</head>

<body>
<script type="text/javascript">
/* 扩展验证  */
$.extend($.fn.validatebox.defaults.rules, {
    eqPassword : {/* 扩展验证两次密码 */
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '输入两次密码不一致'
	},
    passwordCheck : {/* 扩展验证两次密码 */
		validator : function(value, param) {
			var st = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{6,12}$/;
			return st.test(value);
		},
		message : '请输入6~12位的数字与字母的组合'
	}
}); 
</script>
<form id="pwdForm" method="post">
<input type="hidden" name="userIds" id="userIds" value="${userIds}"/>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#cad9ea">
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">输入新密码：</td>
		<td bgcolor="#FFFFFF" class="main_bright"><input name="passWord" class="easyui-validatebox" required="true" validType="passwordCheck" missingMessage="请填写新密码" type="password" value="" /></td>
	</tr>
	<tr>
		<td align="right" bgcolor="#f5fafe" class="main_bleft">确认新密码：</td>
		<td bgcolor="#FFFFFF" class="main_bright"><input name="rePassWord" class="easyui-validatebox" required="true" validType="eqPassword['#pwdForm input[name=passWord]']" type="password" value="" /></td>
	</tr>
</table>
</form>
</body>
</html>
