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

$starttime=$_POST['starttime1'];
$endtime=$_POST['endtime1'];
$starttime1=$starttime;
$endtime1=$endtime;
$now=$_POST['now'];
$project=$_POST['project1'];
$repository=$_POST['repository1'];





if($starttime=="" and $endtime==""){

    for($i=0;$i<=30;$i=$i+1  ) {
        $days[] = date("Y-m-d", strtotime($now)-$i*24*3600);
    }
}
if($starttime=="" and $endtime!=""){

    for($i=0;$i<=30;$i=$i+1  ) {
        $days[] = date("Y-m-d", strtotime($endtime)-$i*24*3600);
    }
}
if($endtime==""){
    $endtime=$now;
}
if($starttime!="" ){

    for($i = strtotime($endtime); $i >= strtotime($starttime); $i -= 86400)
    {
        $days[]=date("Y-m-d",$i);
    }
}




if($project==''){
    $project="cctg";
}
$str="select DATE_FORMAT(time,'%Y-%m-%d') as 'date_format',count(*) as 'count'  from ".$db_table." where project='cctg'  and repository not in('myTest','cctg-sandbox') ";
$str2="select DATE_FORMAT(time,'%Y-%m-%d') as 'date_format',count(*) as 'count'  from ".$db_table." where project='cctg-fork'  and repository not in('myTest','cctg-sandbox') ";
if($starttime1!=''){
    $str=$str." and time>='".$starttime1." 00:00:00'";
    $str2=$str2." and time>='".$starttime1." 00:00:00'";
}
if($endtime1!=''){
    $str=$str." and time<='".$endtime1." 23:59:59'";
    $str2=$str2." and time<='".$endtime1." 23:59:59'";
}
if($repository!=''){
    $str=$str." and repository like '%".$repository."%'";
    $str2=$str2." and repository like '%".$repository."%'";
}
$str=$str."and  type='UPDATE'  and branch ='refs/heads/master' group by date_format order by date_format desc limit 30";
$str2=$str2."and  type='UPDATE'  and branch like 'refs/heads/gate%' group by date_format order by date_format desc limit 30";

//$result  = mysql_query("select DATE_FORMAT(time,'%Y-%m-%d') as 'date_format',count(*) as 'count'  from commitinfo where project='".$project."' and repository='webex-web-applicationframework' ".
//                 " and  branch='refs/heads/gate/ealo' group by date_format order by date_format desc limit 30");

$result  = mysql_query($str);
$result2  = mysql_query($str2);
$data =array();
$j=0;
while ($row= mysql_fetch_array($result, MYSQL_ASSOC))
{
    do{

        if($row["date_format"]==$days[$j]){
            $count[]=$row["count"];
        }else{
            $count[]="0";
        }
        $j=$j+1;
    }while($row["date_format"]!=$days[$j-1] and $j<=30);
}
$j=0;
while ($row2= mysql_fetch_array($result2, MYSQL_ASSOC))
{
    do{

        if($row2["date_format"]==$days[$j]){
            $count2[]=$row2["count"];
        }else{
            $count2[]="0";
        }
        $j=$j+1;
    }while($row2["date_format"]!=$days[$j-1] and $j<=30);
}
$labelsjson=json_encode($days);
$countjson=json_encode($count);
$countjson2=json_encode($count2);
echo "{"."labels".":".$labelsjson.","."data".":".$countjson.","."data1".":".$countjson2."}";
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
