<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
  String path = request.getContextPath();
%>
<head>
  <title>add</title>

  <link type="text/css" href="css/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
  <link type="text/css" href="css/jquery-ui-timepicker-addon.css" rel="stylesheet" />
    <%--<link type="text/css" href="css/bootstrap.min.css" rel="stylesheet" />--%>
    <link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css">
    <%--<link type="text/css" rel="stylesheet" href="css/bootstrap-table.css">--%>
    <link rel="stylesheet" type="text/css" href="css/DT_bootstrap.css">

    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <%--<script type="text/javascript" src="js/bootstrap-table.js"></script>--%>
    <script type="text/javascript" charset="utf-8" language="javascript" src="js/DT_bootstrap.js"></script>
    <script type="text/javascript" charset="utf-8" language="javascript" src="js/jquery.dataTables.js"></script>


    <script type="text/javascript" src="js/tableExport.js"></script>
    <script type="text/javascript" src="js/jquery.base64.js"></script>
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
    })


  </script>
  <link rel="stylesheet" href="css/index.css">
  <link rel="stylesheet" href="css/4.2.0fontawesome/css/font-awesome.min.css">

</head>



<body>
  <h1> </h1>

  <div class="container">
    <%--<a href="../webproject/componentlist.action"><strong class=""></strong>add</a>--%>
    <%--<a href="../webproject/detaillist.action"><strong class=""></strong>report</a>--%>
  <div class="tab-top" >
      <ul class="nav nav-tabs" id="main-tab">
          <li class="active"><a href="#batch-info" data-toggle="tab"><span class="glyphicon glyphicon-plus"></span> Add</a></li>
          <li class=""><a href="#batch-detail" data-toggle="tab"><span class="glyphicon glyphicon-th-list"></span> Report</a></li>
          <li class=""><a href="#batch-test" data-toggle="tab"><span class="glyphicon glyphicon-th-list"></span> Test</a></li>
      </ul>
  </div>
        </div>

  <div class="tab-content">

      <!-- ============================ -->
      <!-- batch info -->
      <!-- ============================ -->
      <div class="tab-pane fade " id="batch-info">

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

      </div>
    </td>

   </tr>
    </tbody>
  </table>
  </s:form>
          </div>


      <div class="tab-pane fade" id="batch-detail">

      <div class="table">
          <table class="table table-hover table-bordered table-condensed">
              <thead>
              <tr bgcolor="#F7F7F7">

                  <th width="75" ><div align="center">ID</div></th>
                  <th ><div align="center">Components</div></th>
                  <th ><div align="center">Deploy_time</div></th>
                  <th ><div align="center">Deadline</div></th>
                  <th ><div align="center">CMC</div></th>

              </tr>
              </thead>
              <tbody id="site-list" class="tbd">


              <s:iterator value="detaillsit" id="u">
                  <tr class="siteinfo" siteid="700299022" statcutover="INIT" statrename="INIT">
                      <td><div align="center"><s:property value="#u.id"/></div></td>
                      <td><div align="center"><s:property value="#u.componentName"/></div></td>
                      <td><div align="center"><s:property value="#u.deployTime"/></div></td>
                      <td><div align="center"><s:property value="#u.deadline"/></div></td>
                      <td width="400" style="word-break:break-all"><div align="center"><s:property value="#u.cmcVersion"/></div></td>
                          <%--<td><div align="center"><s:a href="find.action?id=%{#u.id}">修改</s:a> --%>
                          <%--<s:a href="delete.action?id=%{#u.id}">删除</s:a></div></td>--%>
                  </tr>
              </s:iterator>
              <tr id="emsg-700299022" class="hide siteemsg">
                  <td colspan="2">&nbsp;</td>
                  <td colspan="12">
                      <p>Cutover: INIT : Initial</p>
                      <p>Rename: INIT : initial</p>
                  </td>
              </tr>

              </tbody>
          </table>
          </div>

      </div>
      <div class="tab-pane fade" id="batch-test">
      <div class="container" style="margin-top: 10px">

          <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="example">
              <thead>
              <tr>
                  <th>Rendering engine</th>
                  <th>Browser</th>
                  <th>Platform(s)</th>
                  <th>Engine version</th>
                  <th>CSS grade</th>
              </tr>
              </thead>
              <tbody>
              <tr class="odd gradeX">
                  <td>Trident</td>
                  <td>Internet
                      Explorer 4.0</td>
                  <td>Win 95+</td>
                  <td class="center"> 4</td>
                  <td class="center">X</td>
              </tr>
              <tr class="even gradeC">
                  <td>Trident</td>
                  <td>Internet
                      Explorer 5.0</td>
                  <td>Win 95+</td>
                  <td class="center">5</td>
                  <td class="center">C</td>
              </tr>
              <tr class="odd gradeA">
                  <td>Trident</td>
                  <td>Internet
                      Explorer 5.5</td>
                  <td>Win 95+</td>
                  <td class="center">5.5</td>
                  <td class="center">A</td>
              </tr>
              <tr class="even gradeA">
                  <td>Trident</td>
                  <td>Internet
                      Explorer 6</td>
                  <td>Win 98+</td>
                  <td class="center">6</td>
                  <td class="center">A</td>
              </tr>
              <tr class="odd gradeA">
                  <td>Trident</td>
                  <td>Internet Explorer 7</td>
                  <td>Win XP SP2+</td>
                  <td class="center">7</td>
                  <td class="center">A</td>
              </tr>
              <tr class="even gradeA">
                  <td>Trident</td>
                  <td>AOL browser (AOL desktop)</td>
                  <td>Win XP</td>
                  <td class="center">6</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Firefox 1.0</td>
                  <td>Win 98+ / OSX.2+</td>
                  <td class="center">1.7</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Firefox 1.5</td>
                  <td>Win 98+ / OSX.2+</td>
                  <td class="center">1.8</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Firefox 2.0</td>
                  <td>Win 98+ / OSX.2+</td>
                  <td class="center">1.8</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Firefox 3.0</td>
                  <td>Win 2k+ / OSX.3+</td>
                  <td class="center">1.9</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Camino 1.0</td>
                  <td>OSX.2+</td>
                  <td class="center">1.8</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Camino 1.5</td>
                  <td>OSX.3+</td>
                  <td class="center">1.8</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Netscape 7.2</td>
                  <td>Win 95+ / Mac OS 8.6-9.2</td>
                  <td class="center">1.7</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Netscape Browser 8</td>
                  <td>Win 98SE+</td>
                  <td class="center">1.7</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Netscape Navigator 9</td>
                  <td>Win 98+ / OSX.2+</td>
                  <td class="center">1.8</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Mozilla 1.0</td>
                  <td>Win 95+ / OSX.1+</td>
                  <td class="center">1</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Mozilla 1.1</td>
                  <td>Win 95+ / OSX.1+</td>
                  <td class="center">1.1</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Mozilla 1.2</td>
                  <td>Win 95+ / OSX.1+</td>
                  <td class="center">1.2</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Mozilla 1.3</td>
                  <td>Win 95+ / OSX.1+</td>
                  <td class="center">1.3</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Mozilla 1.4</td>
                  <td>Win 95+ / OSX.1+</td>
                  <td class="center">1.4</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Mozilla 1.5</td>
                  <td>Win 95+ / OSX.1+</td>
                  <td class="center">1.5</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Mozilla 1.6</td>
                  <td>Win 95+ / OSX.1+</td>
                  <td class="center">1.6</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Mozilla 1.7</td>
                  <td>Win 98+ / OSX.1+</td>
                  <td class="center">1.7</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Mozilla 1.8</td>
                  <td>Win 98+ / OSX.1+</td>
                  <td class="center">1.8</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Seamonkey 1.1</td>
                  <td>Win 98+ / OSX.2+</td>
                  <td class="center">1.8</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Gecko</td>
                  <td>Epiphany 2.20</td>
                  <td>Gnome</td>
                  <td class="center">1.8</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Webkit</td>
                  <td>Safari 1.2</td>
                  <td>OSX.3</td>
                  <td class="center">125.5</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Webkit</td>
                  <td>Safari 1.3</td>
                  <td>OSX.3</td>
                  <td class="center">312.8</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Webkit</td>
                  <td>Safari 2.0</td>
                  <td>OSX.4+</td>
                  <td class="center">419.3</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Webkit</td>
                  <td>Safari 3.0</td>
                  <td>OSX.4+</td>
                  <td class="center">522.1</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Webkit</td>
                  <td>OmniWeb 5.5</td>
                  <td>OSX.4+</td>
                  <td class="center">420</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Webkit</td>
                  <td>iPod Touch / iPhone</td>
                  <td>iPod</td>
                  <td class="center">420.1</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Webkit</td>
                  <td>S60</td>
                  <td>S60</td>
                  <td class="center">413</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Presto</td>
                  <td>Opera 7.0</td>
                  <td>Win 95+ / OSX.1+</td>
                  <td class="center">-</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Presto</td>
                  <td>Opera 7.5</td>
                  <td>Win 95+ / OSX.2+</td>
                  <td class="center">-</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Presto</td>
                  <td>Opera 8.0</td>
                  <td>Win 95+ / OSX.2+</td>
                  <td class="center">-</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Presto</td>
                  <td>Opera 8.5</td>
                  <td>Win 95+ / OSX.2+</td>
                  <td class="center">-</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Presto</td>
                  <td>Opera 9.0</td>
                  <td>Win 95+ / OSX.3+</td>
                  <td class="center">-</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Presto</td>
                  <td>Opera 9.2</td>
                  <td>Win 88+ / OSX.3+</td>
                  <td class="center">-</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Presto</td>
                  <td>Opera 9.5</td>
                  <td>Win 88+ / OSX.3+</td>
                  <td class="center">-</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Presto</td>
                  <td>Opera for Wii</td>
                  <td>Wii</td>
                  <td class="center">-</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Presto</td>
                  <td>Nokia N800</td>
                  <td>N800</td>
                  <td class="center">-</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>Presto</td>
                  <td>Nintendo DS browser</td>
                  <td>Nintendo DS</td>
                  <td class="center">8.5</td>
                  <td class="center">C/A<sup>1</sup></td>
              </tr>
              <tr class="gradeC">
                  <td>KHTML</td>
                  <td>Konqureror 3.1</td>
                  <td>KDE 3.1</td>
                  <td class="center">3.1</td>
                  <td class="center">C</td>
              </tr>
              <tr class="gradeA">
                  <td>KHTML</td>
                  <td>Konqureror 3.3</td>
                  <td>KDE 3.3</td>
                  <td class="center">3.3</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeA">
                  <td>KHTML</td>
                  <td>Konqureror 3.5</td>
                  <td>KDE 3.5</td>
                  <td class="center">3.5</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeX">
                  <td>Tasman</td>
                  <td>Internet Explorer 4.5</td>
                  <td>Mac OS 8-9</td>
                  <td class="center">-</td>
                  <td class="center">X</td>
              </tr>
              <tr class="gradeC">
                  <td>Tasman</td>
                  <td>Internet Explorer 5.1</td>
                  <td>Mac OS 7.6-9</td>
                  <td class="center">1</td>
                  <td class="center">C</td>
              </tr>
              <tr class="gradeC">
                  <td>Tasman</td>
                  <td>Internet Explorer 5.2</td>
                  <td>Mac OS 8-X</td>
                  <td class="center">1</td>
                  <td class="center">C</td>
              </tr>
              <tr class="gradeA">
                  <td>Misc</td>
                  <td>NetFront 3.1</td>
                  <td>Embedded devices</td>
                  <td class="center">-</td>
                  <td class="center">C</td>
              </tr>
              <tr class="gradeA">
                  <td>Misc</td>
                  <td>NetFront 3.4</td>
                  <td>Embedded devices</td>
                  <td class="center">-</td>
                  <td class="center">A</td>
              </tr>
              <tr class="gradeX">
                  <td>Misc</td>
                  <td>Dillo 0.8</td>
                  <td>Embedded devices</td>
                  <td class="center">-</td>
                  <td class="center">X</td>
              </tr>
              <tr class="gradeX">
                  <td>Misc</td>
                  <td>Links</td>
                  <td>Text only</td>
                  <td class="center">-</td>
                  <td class="center">X</td>
              </tr>
              <tr class="gradeX">
                  <td>Misc</td>
                  <td>Lynx</td>
                  <td>Text only</td>
                  <td class="center">-</td>
                  <td class="center">X</td>
              </tr>
              <tr class="gradeC">
                  <td>Misc</td>
                  <td>IE Mobile</td>
                  <td>Windows Mobile 6</td>
                  <td class="center">-</td>
                  <td class="center">C</td>
              </tr>
              <tr class="gradeC">
                  <td>Misc</td>
                  <td>PSP browser</td>
                  <td>PSP</td>
                  <td class="center">-</td>
                  <td class="center">C</td>
              </tr>
              <tr class="gradeU">
                  <td>Other browsers</td>
                  <td>All others</td>
                  <td>-</td>
                  <td class="center">-</td>
                  <td class="center">U</td>
              </tr>
              </tbody>
          </table>

      </div>
  </div>
      </div>


  </div>






</body>
</html>