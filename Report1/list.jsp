<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<title>Detail</title>
	<link type="text/css" href="css/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
	<link type="text/css" href="css/jquery-ui-timepicker-addon.css" rel="stylesheet" />
	<link type="text/css" href="css/bootstrap.min.css" rel="stylesheet" />
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui-1.9.2.custom.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui-timepicker-addon.js"></script>
	<script type="text/javascript" src="js/jquery-ui-timepicker-zh-CN.js"></script>
	<script type="text/javascript">
		$(function () {
			$(".ui_timepicker").datetimepicker({
				//showOn: "button",
				//buttonImage: "./css/images/icon_calendar.gif",
				//buttonImageOnly: true,
				showSecond: true,
				timeFormat: 'hh:mm:ss',
				stepHour: 1,
				stepMinute: 1,
				stepSecond: 1
			})
		})
	</script>
	<link rel="stylesheet" href="css/index/index.css">
	<link rel="stylesheet" href="css/4.2.0fontawesome/css/font-awesome.min.css">


</head>
<body>

	<div class="header">
		<a href="../webproject/componentlist.action"><strong class=""></strong>add</a>
		<a href="../webproject/detaillist.action"><strong class=""></strong>report</a>
	</div>

	<div class="content">
		<div class="research">
			<form action="" method="post">
				<div class="inline">
					<span>Component:</span><input name="" type="text" value="">
				</div>

				<div class="inline">
					<span>deploytime:</span><input type="text" name="startTime" class="ui_timepicker" value="">
				</div>
				<div class="inline">
					<span>deadline:</span><input type="text" name="endTime" class="ui_timepicker" value="">
				</div>
				<div class="inline">
					<span>deploytime:</span><input name="" type="text" value="">
				</div>

				<input type="submit" value="search">
			</form>
		</div>
		<hr>
		<center>
<table border="1">
    <div class="tablehead">
	<tr >
	<td width="102" color="white"><div class="font" align="center">ID</div></td>
	<td width="102"><div class="font" align="center">Components</div></td>
	<td width="208"><div class="font" align="center">Deploy_time</div></td>
	<td width="208"><div  class="font" align="center">Deadline</div></td>
		<td width="208"><div class="font"  align="center">CMC</div></td>
	</tr>
	</div>
<s:iterator value="detaillsit" id="u">
	<tr>
	<td><div align="center"><s:property value="#u.id"/></div></td>
	<td><div align="center"><s:property value="#u.componentName"/></div></td>
	<td><div align="center"><s:property value="#u.deployTime"/></div></td>
		<td><div align="center"><s:property value="#u.deadline"/></div></td>
		<td><div align="center"><s:property value="#u.cmcVersion"/></div></td>
	<%--<td><div align="center"><s:a href="find.action?id=%{#u.id}">修改</s:a> --%>
	<%--<s:a href="delete.action?id=%{#u.id}">删除</s:a></div></td>--%>
	</tr>
</s:iterator>	
</table>
</div>
<br>

</center>
</body>
</html>