<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="admin/css/css_body.css" rel="stylesheet" type="text/css" />
<title>会员详细信息列表</title>
</head>
<body>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#cad9ea" id="Tdetail">
    <tr>
      <td bgcolor="#F5FAFE" class="main_bright" width="30%">用户名:</td>
      <td bgcolor="#F5FAFE" class="main_bright" width="70%">${user.username}</td>
      
    </tr>
 
    <tr>
      <td bgcolor="#F5FAFE" class="main_bright" width="30%">真实姓名:</td>
      <td bgcolor="#F5FAFE" class="main_bright" width="70%">${user.truename}</td>
    </tr>
  
      <tr>
      <td bgcolor="#F5FAFE" class="main_bright" width="30%">用户头像:</td>
      <td bgcolor="#F5FAFE" class="main_bright" width="70%">
      	<img width="30" height="30" src="${pageContext.request.contextPath }/images/headportrait.png" alt="" name="userHeadimg" id="userHeadimg"/>
      </td>
    </tr>
        <tr>
      <td bgcolor="#F5FAFE" class="main_bright" width="30%">用户邮箱:</td>
     <td bgcolor="#F5FAFE" class="main_bright" width="70%">${user.userEmail}</td>
    </tr>
        <tr >
      <td bgcolor="#F5FAFE" class="main_bright" width="30%">注册日期:</td>
      <td bgcolor="#F5FAFE" class="main_bright" width="70%"><fmt:formatDate value="${user.userCreattime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
    </tr>
     <tr>
      <td bgcolor="#F5FAFE" class="main_bright" width="30%">移动电话:</td>
      <td bgcolor="#F5FAFE" class="main_bright" width="70%">${user.mobile}</td>
    </tr>  	
      <tr>
      <td bgcolor="#F5FAFE" class="main_bright" width="30%">固定电话:</td>
      <td bgcolor="#F5FAFE" class="main_bright" width="70%">${user.telephone}</td>
    </tr>
     
  </table >
  
  <table>
			<tr>
			选择角色：
			<td>
			<c:forEach items="${roleList}" var="role">
			
			<input type="checkbox" name="choose" disabled="disabled" id="roleId" <c:forEach items="${userRole}" var="userR"><c:if test="${userR==role.id }">checked="checked"</c:if></c:forEach> value = "${role.id}" "/>
			<label for="choose">${role.rolename}</label>
			</c:forEach>
			</td>
			</tr>
			</table>
</body>
</html>

