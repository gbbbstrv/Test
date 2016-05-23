<?php
/**
 * Created by IntelliJ IDEA.
 * User: hpw
 * Date: 16/4/23
 * Time: 上午8:50
 */
include_once("dbconfig.php");
ini_set('date.timezone','PRC');



$result =$mysqli->query("select * from scm_commit where  STASHPROJECT='cctgfork'  and BRANCH like '%gate%' and TYPE ='2' order by LOGTIME DESC limit 50 ");

if (!$mysqli->errno) {
    $mysqli->commit();

} else {

    $mysqli->rollback();
    echo "Error: " . $mysqli->error;
    die('Error: ' . $mysqli->error);
}

$data =array();
while ($row = $result->fetch_assoc())
{
    $commit =new Commit();
    $commit->id = $row["ID"];
    $commit->time = $row["LOGTIME"];
    $commit->commitId = $row["COMMITID"];
    $commit->project = $row["STASHPROJECT"];
    $commit->repository = $row["REPOSITORY"];
    $commit->branch = $row["BRANCH"];
    $commit->type = $row["TYPE"];
    $commit->author = $row["AUTHOR"];
    $commit->email = $row["EMAIL"];
    $data[]=$commit;
}

$json=json_encode($data);

echo "{".'"data"'.":".$json.",".'"options"'.":[]".",".'"file"'.":[]"."}";
$mysqli->close();


class Commit
{
    public  $id ;
    public $time ;
    public $commitId;
    public $project ;
    public $repository ;
    public $branch ;
    public $type ;
    public $author ;
    public $email ;
    public $statue ;


}

?>
