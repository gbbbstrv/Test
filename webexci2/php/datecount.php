<?php
/**
 * Created by IntelliJ IDEA.
 * User: hpw
 * Date: 16/4/23
 * Time: 上午8:50
 */
include_once("config.php");



$action = $_GET['action'];

//$sql=$_POST['sql'];
//$page=$_POST['page'];
//if($sql==""){
//    $result  = mysql_query("select * from commitinfo");
//}else {
//
//    $result = mysql_query($sql);
//}
$result  = mysql_query("select DATE_FORMAT(time,'%Y-%m-%d') as 'date_format',count(*) as 'count'  from commitinfo where project='cctg' and repository='webex-web-applicationframework' ".
                 " and  branch='refs/heads/gate/ealo' group by date_format order by date_format desc");
$data =array();
while ($row= mysql_fetch_array($result, MYSQL_ASSOC))
{
//    $commit =new Commitinfo();
//    $commit->id = $row["id"];
//    $commit->time = $row["time"];
//    $commit->project = $row["project"];
//    $commit->repository = $row["repository"];
//    $commit->branch = $row["branch"];
//    $commit->type = $row["type"];
//    $commit->author = $row["author"];
//    $commit->email = $row["email"];
//    $commit->commits = $row["commits"];
//    $data[]=$commit;

    $date_count=new Count();
    $date_count->date =$row["date_format"];
    $date_count->count =$row["count"];
    $data[]= $date_count;

    $labels[]=$row["date_format"];
    $count[]=$row["count"];
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
