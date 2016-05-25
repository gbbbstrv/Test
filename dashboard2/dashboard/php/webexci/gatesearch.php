<?php
/**
 * Created by IntelliJ IDEA.
 * User: hpw
 * Date: 16/4/23
 * Time: 上午8:50
 */
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    include_once("dbconfig.php");
    include_once("utils.php");


//$starttime=$_POST['starttime'];
//$endtime=$_POST['endtime'];
//    $project = $_POST['project'];
    $repository = $_POST['repository'];
    $branch = $_POST['branch'];
    $author = $_POST['author'];


    $str = "select * from scm_commit where   STASHPROJECT='cctgfork'  and BRANCH like '%gate%'   ";

//$str="select * from ".$db_table." where project='".$project."'  and repository not in('myTest','cctg-sandbox')  ";
//if(!empty($starttime)){
//    $str=$str." and time>='".$starttime."'";
//}
//if(!empty($endtime)){
//    $str=$str." and time<='".$endtime."'";
//}
    if (!empty($repository)) {
        $str = $str . " and repository like '%" . $repository . "%'";
    }
    if (!empty($branch)) {
        $str = $str . " and branch like '%" . $branch . "%'";
    }
    if (!empty($author)) {
        $str = $str . " and author like '%" . $author . "%'";
    }

    $str = $str . " order by LOGTIME desc limit 50";

//$result = mysql_query($str);
    $result = $mysqli->query($str);

    if (!$mysqli->errno) {
        $mysqli->commit();

    } else {

        $mysqli->rollback();
        echo "Error: " . $mysqli->error;
        die('Error: ' . $mysqli->error);
    }

    $data = array();
    while ($row = $result->fetch_assoc()) {
        $commit = new Commit();
        $commit->id = $row["ID"];
        $commit->time = gmttogmt8($row["LOGTIME"]);
        $commit->commitId = $row["COMMITID"];
        $commit->project = $row["STASHPROJECT"];
        $commit->repository = $row["REPOSITORY"];
        $commit->branch = $row["BRANCH"];
        $commit->type = $row["TYPE"];
        $commit->author = $row["AUTHOR"];
        $commit->email = $row["EMAIL"];
        $data[] = $commit;
    }

    $json = json_encode($data);

    echo "{" . '"data"' . ":" . $json . "," . '"options"' . ":[]" . "," . '"file"' . ":[]" . "}";
    $mysqli->close();

}
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
