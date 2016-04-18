<%--
  Created by IntelliJ IDEA.
  User: huwei
  Date: 16/4/11
  Time: 下午5:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>title</title>
    <link type="text/css" href="css/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
    <link type="text/css" href="css/jquery-ui-timepicker-addon.css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
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
        })
    </script>
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/4.2.0%20font%20awesome/css/font-awesome.min.css">
</head>
<body>
<div class="header">
    <a href=""><strong class=""></strong>添加</a>
    <a href=""><strong class=""></strong>详情</a>
</div>
<div class="content">
    <form action="" method="post">
        <li>
            <span>名字:</span>
        <select name="">
            <option value=""><-请选择-></option>
            <option value="向服务器发送的数据">我是动态生成的</option>
        </select>
        </li>
        <li>
        <span>发布时间:</span><input type="text" name="startTime" class="ui_timepicker" value="">
        </li>
        <li>
            <span>结束时间:</span>
        <input type="text" name="endTime" class="ui_timepicker" value="">
        </li>
        <li>
            <span>信息:</span>
            <input type="text" name="">
        </li>
        <li>
            <input type="submit" value="保存">
        </li>


    </form>

</div>
</body>
</html>
