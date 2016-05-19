<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    date_default_timezone_set("Etc/GMT");
    $json_string = $_POST["data"];

    $timestamp = date('y-m-d h:i:s', time());

    file_put_contents("commitapi.log", $timestamp . " , " . $json_string . "\n", FILE_APPEND);
    $json = json_decode($json_string);

    $username = 'root';
    $userpass = 'webexci2016';
    $dbhost = 'localhost';
    $db_name = 'webexci';
    $db_connect = mysql_connect($dbhost, $username, $userpass);
    if (!$db_connect) {
        file_put_contents("commitapi.log", $timestamp . " Could not connect:" . mysql_error() . "\n", FILE_APPEND);
        echo "Could not connect: " . mysql_error();
        die('Could not connect: ' . mysql_error());
    }
    mysql_select_db($db_name, $db_connect);
    $str = "select PARAMKEY from parameters where PARAMGROUP='SCMCommitType' and PARAMVALUE ='" . $json[0]->{"data"}->{"type"} . "'";
    $result = mysql_query($str);
    $type = 0;
    while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
        $type = $row["PARAMKEY"];
    }


    $logtime = $json[0]->{"data"}->{"logTime"};
    if ($json[0]->{"data"}->{"logTime"} == "" || $json[0]->{"data"}->{"logTime"} == null) {

        $logtime = $timestamp;
    }

    $sql = "insert into scm_commit VALUES('','" . $json[0]->{"data"}->{"commitId"} . "','" . $json[0]->{"data"}->{"stashProject"} . "','" . $json[0]->{"data"}->{"repository"} . "','" . $json[0]->{"data"}->{"branch"} . "','" . $json[0]->{"data"}->{"timeStamp"} . "','" . $type . "','" . $json[0]->{"data"}->{"author"} . "','" . $json[0]->{"data"}->{"email"} . "','" . $json[0]->{"data"}->{"commits"} . "','" . $logtime . "')";

    mysql_query("BEGIN");
    if (!mysql_query($sql, $db_connect)) {
        mysql_query("ROLLBACK");
        file_put_contents("commitapi.log", $timestamp . " Error: " . mysql_error() . "\n", FILE_APPEND);
        echo "Error: " . mysql_error();
        die('Error: ' . mysql_error());
    } else {
        mysql_query("COMMIT");
        file_put_contents("commitapi.log", $timestamp . " Success! 1 record added \n", FILE_APPEND);
        echo "1 record added";

    }
    mysql_query("END");
    mysql_close($db_connect);
}

?>