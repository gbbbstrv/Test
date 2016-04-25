<?php
/**
 * Created by IntelliJ IDEA.
 * User: hpw
 * Date: 16/4/23
 * Time: 上午8:50
 */
include_once("config.php");



$action = $_GET['action'];

$starttime=$_POST['starttime'];
$endtime=$_POST['endtime'];
$project=$_POST['project'];
$repository=$_POST['repository'];
$branch=$_POST['branch'];
$author=$_POST['author'];
$str="select * from commitinfo where project='".$project."' ";
if($starttime!=""){
    $str=$str+" and time>='"+$starttime+"'";
}
if($endtime!=""){
    $str=$str+" and time<='"+$endtime+"'";
}
if($repository!=""){
    $str=$str." and repository=".$repository;
}
if($branch!=""){
    $str=$str." and  branch=".$branch;
}
if($author!=""){
    $str=$str." and author=".$author;
}



//$result = mysql_query($str);

$result  = mysql_query($str);
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
