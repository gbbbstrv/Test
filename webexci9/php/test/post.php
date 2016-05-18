<?php
/**
 * Created by PhpStorm.
 * User: hpw
 * Date: 16/5/13
 * Time: 上午11:28
 */

function http_post_json($url, $jsonStr)
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonStr);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-Type: application/json; charset=utf-8',
            'Content-Length: ' . strlen($jsonStr)
        )
    );
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

    return array($httpCode, $response);
}

function send_post($url, $post_data) {

    $postdata = http_build_query($post_data);
    $options = array(
        'http' => array(
            'method' => 'POST',
            'header' => "Content-type:application/x-www-form-urlencoded \r\n" .
                        "Content-Length: " . strlen($postdata) . "\r\n",
            'content' => $postdata,
            'timeout' => 15 * 60
        )
    );
    $context = stream_context_create($options);
    $result = file_get_contents($url, false, $context);

    return $result;
}
$value =array();
$da=array('a' => 1, 'b' => "owomen");
$da11=array('a' => 2, 'b' => "222222");
//$value[]=$da;
$value[]=$da11;


$jsonStr = json_encode($value);

echo $jsonStr;


$committomysql_array=array(
    "commitId" => "sa",
    "stashProject" => "asas",
    "repository" => "sas",
    "branch" => "asas",
    "timeStamp" => "2016-05-15 19:41:37",
    "type" => "update",
    "author" =>"sasas",
    "email" =>"asasas",
    "commits" => "sasas",
    "logTime"=> "");

$committomysqlData=array(
    "actionType" => 0,
    "phaseType" =>0,
    "data" => $committomysql_array);
$value1[]=$committomysqlData;
$mysqldata = json_encode($value1,true);
echo $mysqldata;
$url = "http://localhost/webexci/php/test/api.php";
//$url = "http://172.19.55.239/webexci/api/CommitCompileLog.php";
//list($returnCode, $returnContent) = http_post_json($url, $mysqldata);
//echo $returnContent;

$post_data = array(
    'data' => $mysqldata
);
$result=send_post($url, $post_data);

echo $result;
//echo 'as';
//$pi="sa";
//$pi=$pi."sssss";
//$pi=$pi."asssa";
//
//
//echo $pi;
//date_default_timezone_set("PRC");
//$tiem='1463458874000';
//
//echo date('Y-m-d H:i:s', substr($tiem , 0 , 10));
?>