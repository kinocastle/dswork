<%@page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<%@include file="/commons/include/get.jsp"%>
<script type="text/javascript">
function empower(account){
	$jskey.dialog.showDialog({url:"${ctx}/cms/permission/updPermission1.htm?account="+account,title:"分配权限",fit:true,draggable:false});
}
</script>
</head> 
<body>
<table border="0" cellspacing="0" cellpadding="0" class="listLogo">
	<tr>
		<td class="title">用户采编授权</td>
	</tr>
</table>
<div class="line"></div>
<form id="queryForm" method="post" action="getUser.htm">
<table border="0" cellspacing="0" cellpadding="0" class="queryTable">
	<tr>
		<td class="input">
			&nbsp;账号：<input type="text" name="account" value="${fn:escapeXml(param.account)}" />
			&nbsp;姓名：<input type="text" name="name" value="${fn:escapeXml(param.name)}" />
		</td>
		<td class="query"><input id="_querySubmit_" type="submit" class="button" value="查询" /></td>
	</tr>
</table>
</form>
<div class="line"></div>
<table id="dataTable" border="0" cellspacing="1" cellpadding="0" class="listTable">
	<tr class="list_title">
		<td>用户名(帐号)</td>
		<td style="width:50%">授权</td>
	</tr>
<c:forEach items="${pageModel.result}" var="d" varStatus="status">
	<tr>
		<td>${fn:escapeXml(d.name)}(${fn:escapeXml(d.account)})</td>
		<td class="menuTool"><a class="user" onclick="empower('${fn:escapeXml(d.account)}');return false;" href="#">授予权限</a></td>
	</tr>
</c:forEach>
</table>
<table border="0" cellspacing="0" cellpadding="0" class="bottomTable">
	<tr><td>${pageNav.page}</td></tr>
</table>
</body>
</html>
