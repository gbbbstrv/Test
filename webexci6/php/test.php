<?php
/**
 * Created by IntelliJ IDEA.
 * User: hpw
 * Date: 16/4/23
 * Time: 上午8:50
 */
include_once("config.php");



$action = $_GET['action'];

$sql=$_POST['sql'];
$page=$_POST['page'];
if($sql==""){
    $result  = mysql_query("select * from ".$db_table);
}else {

    $result = mysql_query($sql);
}
//$result  = mysql_query("select * from commitinfo where id=1");
$data =array();
while ($row= mysql_fetch_array($result, MYSQL_ASSOC))
{
    $commit =new Commitinfo();
    $commit->id = $row["id"];
    $commit->time = $row["time"];
    $commit->project = $row["project"];
    $commit->repository = $row["repository"];
    $commit->branch = $row["branch"];
    $commit->type = $row["type"];
    $commit->author = $row["author"];
    $commit->email = $row["email"];
    $commit->commits = $row["commits"];
    $data[]=$commit;
}

$json=json_encode($data);

echo "{".'"data"'.":".$json.",".'"options"'.":[]".",".'"file"'.":[]"."}";
mysql_close($conn);


class Commitinfo
{
    public  $id ;
    public $time ;
    public $project ;
    public $repository ;
    public $branch ;
    public $type ;
    public $author ;
    public $email ;
    public $commits ;

}

?>
