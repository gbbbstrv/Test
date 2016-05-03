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
$topname=$_POST['topname'];

if($project==''){
    $project="cctg";
}

if($topname==''){
    $topname="20";
}
$str="select repository,count(*) as 'repo_count' from commitinfo where project='".$project."'  ";
if($starttime!=''){
    $str=$str." and time>='".$starttime."'";
}
if($endtime!=''){
    $str=$str." and time<='".$endtime."'";
}
if($project=='cctg'){
$str=$str."and  type='UPDATE'  and branch='refs/heads/master' group by repository order by repo_count desc limit ".$topname;
}
if($project=='cctg-fork'){
    $str=$str."and  type='UPDATE'  and branch like 'refs/heads/gate%' group by repository order by repo_count desc limit ".$topname;
}
$result  = mysql_query($str);

//
//$result  = mysql_query("select repository,count(*) as 'repo_count' from commitinfo where project='cctg' ".
//    " and  branch='refs/heads/master' group by repository order by repo_count desc limit 20");


$data =array();
while ($row= mysql_fetch_array($result, MYSQL_ASSOC))
{

    $labels[]=$row["repository"];
    $count[]=$row["repo_count"];
}
$labelsjson=json_encode($labels);
$countjson=json_encode($count);
//$json=json_encode($data);
echo "{"."labels".":".$labelsjson.","."data".":".$countjson."}";
//echo "{".'"data"'.":".$json.",".'"options"'.":[]".",".'"file"'.":[]"."}";
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
class Count
{
    public $date ;
    public $count;
}

?>
