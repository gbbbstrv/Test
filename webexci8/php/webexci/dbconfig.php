<?php
/**
 * Created by IntelliJ IDEA.
 * User: hpw
 * Date: 16/4/23
 * Time: 上午8:50
 */


//$host="localhost";
$host="172.19.55.239";
$db_user="root";
$db_pass="webexci2016";
$db_name="webexci";
$db_table_ec_job="EC_JOB";
$db_table_ec_step_job="EC_STEPJOB";
$db_table_ec_step_sequence="EC_STEPSEQUENCE";
$db_table_stash_git_commit="STASH_GIT_COMMIT";
$db_table_stash_pull_requests="STASH_PULL_REQUESTS";
$db_table_parameters="PARAMETERS";


$conn=mysql_connect($host,$db_user,$db_pass)or die(mysql_error());
mysql_select_db($db_name,$conn);
mysql_query("SET names UTF8");

header("Content-Type: text/html; charset=utf-8");


?>
