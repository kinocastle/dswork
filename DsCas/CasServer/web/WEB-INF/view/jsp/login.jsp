<%@page contentType="text/html; charset=UTF-8"%><%
response.setHeader("Cache-Control","no-store");
response.setDateHeader("Expires", 0);
response.setHeader("Pragma","no-cache"); 
%><%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><c:set var="ctx" value="${pageContext.request.contextPath}"
/><!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no,minimal-ui"/>
<title></title>
<script type="text/javascript" src="${ctx}/js/jskey/jskey_des.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/themes/share/fonts/dsworkfont.css"/>
<script type="text/javascript">
function _$(id){return document.getElementById(id);}
function setCookie(k,v,d){var x=new Date();x.setDate(x.getDate()+d);document.cookie=k+"="+escape(v)+((d==null)?"":";expires="+x.toGMTString());}
function getCookie(k){if(document.cookie.length>0){var x1=document.cookie.indexOf(k+"=");if(x1!=-1){x1=x1+k.length+1;x2=document.cookie.indexOf(";",x1);if(x2==-1){x2=document.cookie.length;}return unescape(document.cookie.substring(x1,x2));} }return "";}
if(top.location != this.location){top.location = this.location;}
function doclick(){
var s = "";
if(!_$('account').value){s += "账号不能为空\n";}
if(!_$('password').value){s += "密码不能为空\n";}
if(!_$('authcode').value){s += "验证码不能为空\n";}
if(s != ""){alert(s);return;}
if(_$("savename").checked){setCookie('savename',_$('account').value,365);}else{setCookie('savename','',0);}
try{_$('password').value = $jskey.encodeDes(_$('password').value, _$('authcode').value);}catch(e){}
_$('v').submit();
}
</script>
<style type="text/css">
html,body{height:100%;margin:0px auto;}*{padding:0;margin:0;font-family:arial,"宋体";}
body {background-color:#ffffff;}
div, input, a{font-weight:bold;font-size:20px;line-height:38px;}
div, input, label{color:#333;}
a{text-decoration:underline;outline:none;}
a:link,a:visited,a:active{color:#0000bb;outline:none;}
a:hover{color:#0000ff;text-decoration:underline;}

.title {color:#003c7b;font-size:38px;font-weight:bold;text-align:center;padding:50px 0px;}
.login{width:358px;padding:0;margin:0 auto;overflow:hidden;  height:338px;border:#003c7b solid 1px;position:absolute;left:595px;top:138px;}
.view{padding:10px 0;overflow:hidden;margin:0 auto;width:1000px;height:473px;position:relative;overflow:hidden;background:url(${ctx}/img/login.gif) no-repeat center center;}

.box{overflow:hidden;text-align:center;width:100%;margin:0 auto 15px auto;padding:0;border:none;}
.box .title{background-color:#003c7b;color:#fff;width:100%;padding:3px 0;line-height:50px;font-size:22px;text-align:center;margin:0 auto;}
.box .vbox{padding:0;overflow:hidden;text-align:left;vertical-align:middle;margin:0 0 0 45px;}
.box .vbox span{font-family:dsworkfont;margin:0 10px;}
.box .vbox input{width:198px;height:35px;margin:0 0 0 3px;padding:0 0 0 8px;vertical-align:middle;background-color:#fff;border:#ccc solid 1px;}
.box .vbox input.code{width:98px;}
.box .vbox img{border:none;cursor:pointer;vertical-align:middle;}
.box .button{background-color:#003c7b;color:#eee;width:280px;height:50px;line-height:50px;cursor:pointer;border:none;}
.box .button:hover{background-color:#da3b01;color:#fff;}
.box label{font-weight:bold;font-size:16px;line-height:18px;}

.cp{color:#666;font-size:12px;font-weight:bold;width:80%;overflow:hidden;text-align:center;padding:15px 0;margin:30px auto 0 auto;border-top:solid #ccc 1px;}
.cp a {font-size:12px;font-weight:normal;font-family:arial;}
</style>
</head>
<body>
<div class="view">
  <div class="title">统一认证平台</div>
  <form id="v" action="loginAction" method="post">
  <div class="login">
	<div class="box"><div class="title">用户登录</div></div>
	<div class="box"><div class="vbox">
		<span>&#xf0001;</span><input type="text" title="账号" id="account" name="account" value="" />
	</div></div>
	<div class="box"><div class="vbox">
		<span>&#xf0002;</span><input type="password" title="密码" id="password" name="password" value="" />
	</div></div>
	<div class="box"><div class="vbox">
		<span>&#xf0026;</span><input type="text" title="验证码" placeholder="" id="authcode" name="authcode" maxlength="4" class="code" value="" />
		<img src="${ctx}/authcode?width=90&height=38" onclick="this.src='${ctx}/authcode?width=90&height=38&id=' + Math.random();" />
	</div></div>
	<div class="box">
		<input type="button" class="button" value="登 录" onclick="doclick()" />
	</div>
	<div class="box">
		<label style="float:right;margin-right:38px;">&nbsp;&nbsp;<input id="savename" type="checkbox" class="checkbox" onclick="">&nbsp;记住用户名&nbsp;</label>
	</div>
  </div>
  <input type="hidden" name="service" value="${service}" />
  </form>
</div>
<div class="cp">
	Copyright &copy; 2015 skey_chen@163.com
</div>
</body>
<script type="text/javascript">
<c:if test="${errorMsg != ''}">alert("${errorMsg}");</c:if>
_$('account').focus();
_$('account').select();
var _x = getCookie('savename');
if(_x.length > 0){
	_$('account').value = _x;//"${fn:escapeXml(account)}"
	_$('savename').checked = true;
}
else {
	_$('account').value = "";
	_$('savename').checked = false;
}
_$('password').value="";
_$('authcode').value="";
</script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript">
function registKeydown(id) {
	$("#" + id).keydown(function(event) {
		if (event.keyCode == 13) {
			doclick();
		}
	});
}
registKeydown("account");
registKeydown("password");
registKeydown("authcode");
</script>
</html>
