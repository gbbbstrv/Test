<?php
/**
 * Created by PhpStorm.
 * User: hpw
 * Date: 16/5/13
 * Time: 上午11:28
 */

if ($_SERVER['REQUEST_METHOD'] == 'POST'){
    $json_string =file_get_contents("php://input");
//    $json_string = $_POST["data"];
    $json=json_decode($json_string);
    echo 'test';
    echo $json[1]->{"b"};
    $fh = fopen("test.txt", "w");
    echo fwrite($fh, $json->{"b"});

}

?>