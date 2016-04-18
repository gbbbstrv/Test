<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />

    <title>DataTables example</title>

    <%--<link rel="shortcut icon" type="image/ico" href="http://www.datatables.net/favicon.ico" />--%>
    <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/DT_bootstrap.css">
    <link type="text/css" href="css/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
    <link type="text/css" href="css/jquery-ui-timepicker-addon.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/4.2.0fontawesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/index.css">
    <script type="text/javascript" charset="utf-8" language="javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" charset="utf-8" language="javascript" src="js/jquery.dataTables.js"></script>
    <script type="text/javascript" charset="utf-8" language="javascript" src="js/DT_bootstrap.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.8.17.custom.min.js"></script>
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
        });


    </script>


</head>
<body>

<div class="navbar" style="margin-bottom:10px;">
    <div class="navbar-inner">
        <!-- ============================ -->
        <!-- logo -->
        <!-- ============================ -->
			<span class="brand" style="padding-top:7px;padding-bottom:5px;width:100px;">
				<img src="./img/cisco_logo.jpeg" style="width:38px;">
				Cisco
			</span>
        <!-- ============================ -->
        <!-- action buttons -->
        <!-- ============================ -->
        <div class="nav-collapse collapse navbar-responsive-collapse">
            <ul class="nav">
                <!-- ============================ -->
                <!-- create batch -->
                <!-- ============================ -->
                <li class="divider-vertical"></li>



            </ul>
            <!-- ============================ -->
            <!-- other info -->
            <!-- ============================ -->
            <ul class="nav" style="float:right">
                <!-- ============================ -->
                <!-- login user & logout -->
                <!-- ============================ -->
                <%--<li class="topbar-btn dropdown">--%>
                    <%--<a class="dropdown-toggle" data-toggle="dropdown" href="http://10.224.38.156:8021/SMSUIConsole/main?entry-point=clops#">--%>
                        <%--<i class="icon-user"></i>--%>
                        <%--penghu--%>
                        <%--<b class="caret"></b>--%>
                    <%--</a>--%>
                    <%--<ul class="dropdown-menu">--%>
                        <%--<li><a href="http://10.224.38.156:8021/SMSUIConsole/logout"><i class="icon-off"></i> Logout</a></li>--%>
                    <%--</ul>--%>
                <%--</li>--%>
                <!-- ============================ -->
                <!-- about -->
                <!-- ============================ -->
                <li class="divider-vertical"></li>
                <%--<li class="topbar-btn"><a href="http://10.224.38.156:8021/SMSUIConsole/main?entry-point=clops#modal-about" data-toggle="modal"><i class="icon-info-sign"></i> About</a></li>--%>
            </ul>
        </div><!-- /.nav-collapse -->
    </div>
</div>

<div class="container2" style="margin-top: 10px">
    <%--<a href="../webproject/componentlist.action"><strong class=""></strong>add</a>--%>
    <%--<a href="../webproject/detaillist.action"><strong class=""></strong>report</a>--%>
    <div class="tab-top1" >
        <ul class="nav nav-tabs" id="main-tab">
            <li class="active"><a href="#batch-info" data-toggle="tab"><span class="glyphicon glyphicon-plus"></span> Add</a></li>
            <li class=""><a href="#batch-report" data-toggle="tab"><span class="glyphicon glyphicon-th-list"></span> Report</a></li>
            <%--<li class=""><a href="#batch-test" data-toggle="tab"><span class="glyphicon glyphicon-th-list"></span> Test</a></li>--%>
        </ul>
    </div>
</div>

<div class="tab-content">

    <div class="tab-pane  active" id="batch-info">
        <s:form action="addDetail" method="post" namespace="/">

            <table align="center" cellSpacing="10" style="border-style:dashed;table-layout:fixed;border-width:0px; border-color:#000000;">
                <tbody>
                <tr widht="500">
                    <td width="100" height="25" ><div align="center" style="font-size:20px;">Components：</div></td>
                    <td>
                        <div>
                            <select name="name" id="name" onkeydown="doSearch(arguments[0]||event)"  style="height:31px;width:160px;font-size:20px">
                                <s:iterator value="components" id="n"  status="st">
                                    <option><s:property value="componentName"/></option>
                                </s:iterator>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr height="10"/>
                <tr>
                    <td width="100" height="25" ><div align="left" style="font-size:20px;">Deploytime：</div></td>
                    <td>
                        <div>
                            <input name="deploytime" id="deploytime" class="ui_timepicker"  type="text" style="width:160px"/>
                        </div>
                    </td>
                </tr>
                <tr height="10">
                </tr>

                <tr>
                    <td width="100" height="25" ><div align="left"  style="font-size:20px;">Deadline：</div></td>
                    <td>
                        <input name="endtime" id="endtime" class="ui_timepicker"  type="text" style="width:160px"/>
                    </td>
                </tr>
                <tr height="10">
                </tr>


                <tr>
                    <td width="100" height="25" ><div align="left" style="font-size:20px;">CMC version：</div></td>
                    <td>
                            <%--<textarea name="cmctext" style="width:200px;height:80px;"></textarea>--%>
                        <textarea name="cmctext" class="form-control" rows="3"></textarea>
                    </td>
                </tr>
                <tr height="10">
                </tr>

                <tr >
                    <td colspan="3" height="40"><div align="center" style="font-size:20px;">
                            <%--<input type="submit" style="font-size:20px;" name="subbtn" value="add" />--%>
                        <button type="submit" class="btn btn-default">add</button>
                            <%--<s:submit value="%{getText('add')}"/>--%>
                            <%--<s:submit value="%{getText('cannel')}" name="redirect-action:list" />--%>
                    </div>
                    </td>

                </tr>
                </tbody>
            </table>
        </s:form>
    </div>





    <div class="tab-pane " id="batch-report">

<div class="container" >

    <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="example">
        <thead>
        <tr>
            <th width="75" ><div align="center">ID</div></th>
            <th width="110"><div align="center">Components</div></th>
            <th width="150"><div align="center">Deploy_time</div></th>
            <th width="150"><div align="center">Deadline</div></th>
            <th ><div align="center">CMC</div></th>
        </tr>
        </thead>
        <tbody>
        <s:iterator value="detaillsit" id="u">
            <tr class="siteinfo" siteid="700299022" statcutover="INIT" statrename="INIT">
                <td width="75"><div align="center"><s:property value="#u.id"/></div></td>
                <td width="110"><div align="center"><s:property value="#u.componentName"/></div></td>
                <td width="150"><div align="center"><s:property value="#u.deployTime"/></div></td>
                <td width="150"><div align="center"><s:property value="#u.deadline"/></div></td>
                <td width="400" style="word-break:break-all"><div align="center"><s:property value="#u.cmcVersion"/></div></td>
                    <%--<td><div align="center"><s:a href="find.action?id=%{#u.id}">修改</s:a> --%>
                    <%--<s:a href="delete.action?id=%{#u.id}">删除</s:a></div></td>--%>
            </tr>
        </s:iterator>
        </tbody>
    </table>

</div>
        </div>
    </div>
</body>
</html>