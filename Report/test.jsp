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
    <link type="text/css" href="css/jquery.dataTables.min.css" rel="stylesheet" />
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
    <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
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
        var dataSet = [
            [ "Tiger Nixon", "System Architect", "Edinburgh", "5421", "2011/04/25", "$320,800" ],
            [ "Garrett Winters", "Accountant", "Tokyo", "8422", "2011/07/25", "$170,750" ],
            [ "Ashton Cox", "Junior Technical Author", "San Francisco", "1562", "2009/01/12", "$86,000" ],
            [ "Cedric Kelly", "Senior Javascript Developer", "Edinburgh", "6224", "2012/03/29", "$433,060" ],
            [ "Airi Satou", "Accountant", "Tokyo", "5407", "2008/11/28", "$162,700" ],
            [ "Brielle Williamson", "Integration Specialist", "New York", "4804", "2012/12/02", "$372,000" ],
            [ "Herrod Chandler", "Sales Assistant", "San Francisco", "9608", "2012/08/06", "$137,500" ],
            [ "Rhona Davidson", "Integration Specialist", "Tokyo", "6200", "2010/10/14", "$327,900" ],
            [ "Colleen Hurst", "Javascript Developer", "San Francisco", "2360", "2009/09/15", "$205,500" ],
            [ "Sonya Frost", "Software Engineer", "Edinburgh", "1667", "2008/12/13", "$103,600" ],
            [ "Jena Gaines", "Office Manager", "London", "3814", "2008/12/19", "$90,560" ],
            [ "Quinn Flynn", "Support Lead", "Edinburgh", "9497", "2013/03/03", "$342,000" ],
            [ "Charde Marshall", "Regional Director", "San Francisco", "6741", "2008/10/16", "$470,600" ],
            [ "Haley Kennedy", "Senior Marketing Designer", "London", "3597", "2012/12/18", "$313,500" ],
            [ "Tatyana Fitzpatrick", "Regional Director", "London", "1965", "2010/03/17", "$385,750" ],
            [ "Michael Silva", "Marketing Designer", "London", "1581", "2012/11/27", "$198,500" ],
            [ "Paul Byrd", "Chief Financial Officer (CFO)", "New York", "3059", "2010/06/09", "$725,000" ],
            [ "Gloria Little", "Systems Administrator", "New York", "1721", "2009/04/10", "$237,500" ],
            [ "Bradley Greer", "Software Engineer", "London", "2558", "2012/10/13", "$132,000" ],
            [ "Dai Rios", "Personnel Lead", "Edinburgh", "2290", "2012/09/26", "$217,500" ],
            [ "Jenette Caldwell", "Development Lead", "New York", "1937", "2011/09/03", "$345,000" ],
            [ "Yuri Berry", "Chief Marketing Officer (CMO)", "New York", "6154", "2009/06/25", "$675,000" ],
            [ "Caesar Vance", "Pre-Sales Support", "New York", "8330", "2011/12/12", "$106,450" ],
            [ "Doris Wilder", "Sales Assistant", "Sidney", "3023", "2010/09/20", "$85,600" ],
            [ "Angelica Ramos", "Chief Executive Officer (CEO)", "London", "5797", "2009/10/09", "$1,200,000" ],
            [ "Gavin Joyce", "Developer", "Edinburgh", "8822", "2010/12/22", "$92,575" ],
            [ "Jennifer Chang", "Regional Director", "Singapore", "9239", "2010/11/14", "$357,650" ],
            [ "Brenden Wagner", "Software Engineer", "San Francisco", "1314", "2011/06/07", "$206,850" ],
            [ "Fiona Green", "Chief Operating Officer (COO)", "San Francisco", "2947", "2010/03/11", "$850,000" ],
            [ "Shou Itou", "Regional Marketing", "Tokyo", "8899", "2011/08/14", "$163,000" ],
            [ "Michelle House", "Integration Specialist", "Sidney", "2769", "2011/06/02", "$95,400" ],
            [ "Suki Burks", "Developer", "London", "6832", "2009/10/22", "$114,500" ],
            [ "Prescott Bartlett", "Technical Author", "London", "3606", "2011/05/07", "$145,000" ],
            [ "Gavin Cortez", "Team Leader", "San Francisco", "2860", "2008/10/26", "$235,500" ],
            [ "Martena Mccray", "Post-Sales support", "Edinburgh", "8240", "2011/03/09", "$324,050" ],
            [ "Unity Butler", "Marketing Designer", "San Francisco", "5384", "2009/12/09", "$85,675" ]
        ];

        $(document).ready(function() {
            $("#example1").DataTable( {
                data: dataSet,
                columns: [
                    { title: "Name" },
                    { title: "Position" },
                    { title: "Office" },
                    { title: "Extn." },
                    { title: "Start date" },
                    { title: "Salary" }
                ]
            } );
        } );


//        Papa.parse('./data/iris.csv', {
//            download: true,
//            complete: function(results) {
//                var data = results.data, html;
//                for(var i = 1, _l = data.length-1; i < _l; i++) {
//                    var item = data[i];
//                    html += '<tr><td>'+item[0].substring(1)+'</td><td>'+item[1].substring(1)+'</td><td>'+item[2].substring(1)+'</td><td>'+item[3].substring(1)+'</td><td>'+item[4].substring(1)+'</td></tr>';
//                }
//                $('#table tbody').append(html);
//            }
//        });



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
            <li class=""><a href="#batch-info" data-toggle="tab"><span class="glyphicon glyphicon-plus"></span> Add</a></li>
            <li class="active"><a href="#batch-report" data-toggle="tab"><span class="glyphicon glyphicon-th-list"></span> Report</a></li>
            <%--<li class=""><a href="#batch-test" data-toggle="tab"><span class="glyphicon glyphicon-th-list"></span> Test</a></li>--%>
        </ul>
    </div>
</div>

<div class="tab-content">






    <div class="tab-pane active" id="batch-report">

        <div class="container" >

            <table id="example1" class="display" width="100%">
            <thead>
            <tr>
                <th>Name</th>
                <th>Position</th>
                <th>Office</th>
                <th>Extn.</th>
                <th>Start date</th>
                <th>Salary</th>
            </tr>
            </thead>
            <tfoot>
            <tr>
                <th>Name</th>
                <th>Position</th>
                <th>Office</th>
                <th>Extn.</th>
                <th>Start date</th>
                <th>Salary</th>
            </tr>
            </tfoot>
            </table>
        </div>
    </div>
</div>
</body>
</html>