<?php
/**
 * Created by IntelliJ IDEA.
 * User: hpw
 * Date: 16/4/23
 * Time: 上午8:50
 */
include_once("config.php");
ini_set('date.timezone','PRC');


$action = $_GET['action'];





$result  = mysql_query("select * from commitinfo  order by time DESC limit 500 ");
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
