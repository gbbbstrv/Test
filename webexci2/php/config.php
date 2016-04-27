<?php
/**
 * Created by IntelliJ IDEA.
 * User: hpw
 * Date: 16/4/23
 * Time: 上午8:50
 */


$host="localhost";
$db_user="root";
$db_pass="123456";
$db_name="webexci";


$conn=mysql_connect($host,$db_user,$db_pass)or die(mysql_error());
mysql_select_db($db_name,$conn);
mysql_query("SET names UTF8");

header("Content-Type: text/html; charset=utf-8");


?>
