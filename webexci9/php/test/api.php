<?php

$json_string = $_POST["data"];

$json=json_decode($json_string);

$username='root';
$userpass='webexci2016';
$dbhost='172.19.55.239';
$db_name='webexci';
$db_connect=mysql_connect($dbhost,$username,$userpass) ;
if (!$db_connect)
{
    file_put_contents("test","Could not connect:".mysql_error());
    die('Could not connect: ' . mysql_error());
}
mysql_select_db($db_name,$db_connect);
$str="select PARAMKEY from parameters where PARAMGROUP='StashGitCommitType' and PARAMVALUE ='".$json[0]->{"data"}->{"type"}."'";
$result  = mysql_query($str);
$type=0;
while ($row= mysql_fetch_array($result, MYSQL_ASSOC)) {
    $type=$row["PARAMKEY"];
}

date_default_timezone_set("PRC");
$logtime=$json[0]->{"data"}->{"logTime"};
if($json[0]->{"data"}->{"logTime"}==""||$json[0]->{"data"}->{"logTime"}==null){

    $logtime=date('y-m-d h:i:s',time());
}

$sql="insert into stash_git_commit VALUES('','".$json[0]->{"data"}->{"commitId"}."','".$json[0]->{"data"}->{"stashProject"}."','".$json[0]->{"data"}->{"repository"}."','".$json[0]->{"data"}->{"branch"}."','".$json[0]->{"data"}->{"timeStamp"}."','".$type."','".$json[0]->{"data"}->{"author"}."','".$json[0]->{"data"}->{"email"}."','".$json[0]->{"data"}->{"commits"}."','".$logtime."')";


if (!mysql_query($sql,$db_connect))
{
    file_put_contents("test","Error: ".mysql_error());
    die('Error: ' . mysql_error());
}
echo "1 record added";
file_put_contents("test","1 record added");
mysql_close($db_connect);


?>