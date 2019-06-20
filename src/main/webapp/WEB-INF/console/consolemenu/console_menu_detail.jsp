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
      <td bgcolor="#F5FAFE" class="main_bright" width="30%">菜单名称:</td>
      <td bgcolor="#F5FAFE" class="main_bright" width="70%">${menu.menuName}</td>
      
    </tr>
 
    <tr>
      <td bgcolor="#F5FAFE" class="main_bright" width="30%">菜单描述:</td>
      <td bgcolor="#F5FAFE" class="main_bright" width="70%">${menu.menuDesc}</td>
    </tr>
    
     <tr>
      <td bgcolor="#F5FAFE" class="main_bright" width="30%" height="100px">链接:</td>
      <td bgcolor="#F5FAFE" class="main_bright" width="70%" height="120px">${menu.buttonHtmlcontent}</td>
    </tr>   
  </table >
</body>
</html>

