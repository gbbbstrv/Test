<?php
/**
 * Created by IntelliJ IDEA.
 * User: hpw
 * Date: 16/5/10
 * Time: 下午1:01
 */

include_once("dbconfig.php");





$commitId = $_POST['commitId'];
$project = $_POST['project'];
$repository = $_POST['repository'];
$branch = $_POST['branch'];


$jobindex=array();
$stepindex=array();
$prindex=array();
$chindex=array();
$meindex=array();

$chlogindex=array();
$prlogindex=array();
$steplogindex=array();
$melogindex=array();

$result  = mysql_query("

select com.COMMITID,com.STASHPROJECT,com.REPOSITORY,com.BRANCH,com.TIMESTAMP,com.TYPE,com.AUTHOR,com.EMAIL,
pr.PRSTATUS,pr.PULLREQUESTID,pr.PRLOGTIME,pr.APPROVER,pr.PRLOG,pr.REVIEWERS,
ecjob.JOBID,ecjob.JOBNAME,ecjob.COMPONENTNAME,ecjob.BUILDNUMBER,ecjob.VERSION,ecjob.BUILDOPTION,ecjob.JOBLOGTIME,ecjob.JOBWAITTIME,ecjob.JOBSTATUS,
st.STEPID,st.STEPNAME,st.STEPLOGTIME,st.STEPWAITTIME,st.STEPSTATUS,st.STEPLOG,
ma.MERGESTASHPROJECT, ma.MERGETIMESTAMP,ma.MERGETYPE 
from 
(select * from scm_commit com 
where  com.BRANCH like '%gate%' and com.COMMITID='".$commitId."' and com.STASHPROJECT='".$project."' and com.REPOSITORY='".$repository."' and com.BRANCH='".$branch."'
) com
 left join 
(
select * from
(select spr.COMMITID,spr.STASHPROJECT,spr.REPOSITORY,spr.SOURCEBRANCH,spr.TARGETBRANCH,spr.PULLREQUESTID,status as 'PRSTATUS',para.PARAMVALUE as 'PRSTATE',REVIEWERS,LOGTIME as 'PRLOGTIME',APPROVER,log as 'PRLOG' from scm_pullrequest spr,scm_pullrequest_log sprlog ,parameters para 
where spr.PULLREQUESTID=sprlog.PULLREQUESTID and spr.STATUS=para.PARAMKEY and para.PARAMGROUP='StashPullRequestsStatus'
order by spr.PULLREQUESTID,LOGTIME desc
) req


) pr  on  com.COMMITID=pr.COMMITID and com.STASHPROJECT=pr.STASHPROJECT and com.REPOSITORY=pr.REPOSITORY and com.BRANCH=pr.SOURCEBRANCH

left join
(
select * from 
(select j.COMMITID,j.STASHPROJECT,j.REPOSITORY,j.BRANCH,j.JOBID,JOBNAME,COMPONENTNAME,BUILDNUMBER,VERSION, BUILDOPTION ,LOGTIME as 'JOBLOGTIME',WAITTIME as 'JOBWAITTIME',STATUS as 'JOBSTATUS',log  as 'JOBLOG',para.PARAMVALUE as 'JOBSTATE',para2.PARAMVALUE as 'BUILDNAME'
from ec_job j,ec_job_log log,parameters para ,parameters para2  where j.JOBID=log.JOBID and para.PARAMKEY=j.STATUS and para.PARAMGROUP='ECJobStatus' and para2.PARAMKEY=j.BUILDOPTION and para2.PARAMGROUP='ECJobBuildOption' ORDER BY j.jobid,log.LOGTIME
) job 
) ecjob  on ecjob.CommitId=com.CommitId and ecjob.STASHPROJECT=com.STASHPROJECT and ecjob.REPOSITORY=com.REPOSITORY and ecjob.BRANCH=com.BRANCH

left join 
(
select * from 
(select ecs.JOBID,ecs.STEPID,STEPNAME,LOGTIME as 'STEPLOGTIME',WAITTIME as 'STEPWAITTIME',PARAMVALUE,status as 'STEPSTATUS',log.LOG as 'STEPLOG',RESOURCENAME from ec_jobstep ecs,parameters param,ec_stepsequence seq,ec_jobstep_log log
where ecs.status=param.paramkey and param.paramgroup='ECStepJobStatus' and ecs.STEPSEQUENCEID=seq.STEPINDEX and ecs.STEPID=log.STEPID order by STEPID,LOGTIME desc 
) step 
) st on st.jobid=ecjob.jobid
left join
(select  COMMITID,REPOSITORY,BRANCH,STASHPROJECT as 'MERGESTASHPROJECT',TIMESTAMP as 'MERGETIMESTAMP',TYPE as 'MERGETYPE' from scm_commit me 
where me.branch like '%master%'
) ma on com.COMMITID=ma.COMMITID and com.STASHPROJECT=ma.MERGESTASHPROJECT and com.REPOSITORY=ma.REPOSITORY

"
);


$checkin =new Checkin();
$scmlog=new Log();

$property=new Property();
$pr=new Pullrequest();
$merge=new Merge();


$stage= array();
$buildjob=array();

$stepbuildjob=array();

$logs=array();

while ($row= mysql_fetch_array($result, MYSQL_ASSOC))
{
  
    if($row["COMMITID"]!=null) {
        $property->commitid = $row["COMMITID"];
        $property->stashproject = $row["STASHPROJECT"];
        $property->repository = $row["REPOSITORY"];
        $property->branch = $row["BRANCH"];
        $property->buildoption = 'gate';
        $property->author = $row["AUTHOR"];
        $property->email = $row["EMAIL"];
    }
    if($row["TIMESTAMP"]!=null) {
        if (in_array($row["COMMITID"], $prindex, true)) {
        } else {
            $checkin->name = "checkin";
            $checkin->timestamp = $row["TIMESTAMP"];
            $checkin->status = $row["TYPE"];
            $checkin->url = "https://bitbucket-eng-chn-sjc1.cisco.com/bitbucket/projects/" . $row["STASHPROJECT"] . "/repos/" . $row["REPOSITORY"] . "/commits/" . $row["COMMITID"];

        }
    }
   if($row["PRLOGTIME"]!=null) {
       if (in_array($row["PULLREQUESTID"], $prindex, true)) {
       } else {
           $pr->name = "pr";
           $pr->timestamp = $row["PRLOGTIME"];
           $pr->status = $row["PRSTATUS"];
           $pr->url = "https://bitbucket-eng-chn-sjc1.cisco.com/bitbucket/projects/" . $row["STASHPROJECT"] . "/repos/" . $row["REPOSITORY"] . "/pull_requests/" . $row["PULLREQUESTID"] . "/overview";

       }
   }
    if($row["MERGETIMESTAMP"]!=null) {
        if (in_array($row["COMMITID"], $prindex, true)) {
        } else {
            $merge->name = "merge";
            $merge->timestamp = $row["MERGETIMESTAMP"];
            $merge->status = $row["MERGETYPE"];
            $merge->url = "https://bitbucket-eng-chn-sjc1.cisco.com/bitbucket/projects/" . $row["MERGESTASHPROJECT"] . "/repos/" . $row["REPOSITORY"] . "/commits/" . $row["COMMITID"];

        }
    }
    if($row["JOBID"]!=null) {
        if (in_array($row["JOBID"], $jobindex, true)) {
        }else{
            $ecjob = new ECjob();
            $ecjob->jobid = $row["JOBID"];
            $ecjob->jobname = $row["JOBNAME"];
            $ecjob->componentname = $row["COMPONENTNAME"];
            $ecjob->buildnumber = $row["BUILDNUMBER"];
            $ecjob->version = $row["VERSION"];
            $ecjob->buildoption = $row["BUILDOPTION"];
            $ecjob->waittime = $row["JOBWAITTIME"];
            $ecjob->timestamp = $row["JOBLOGTIME"];
            $ecjob->status = $row["JOBSTATUS"];
            $ecjob->url = "http://cadada.com";

            array_push($buildjob, $ecjob);
        }

    }
    if($row["STEPID"]!=null) {
        if (in_array($row["STEPID"], $stepindex, true)) {
        }else {

            $ecstepjob = new ECstepjob();
            $ecstepjob->stepjob = $row["STEPID"];
            $ecstepjob->jobid = $row["JOBID"];
            $ecstepjob->stepname = $row["STEPNAME"];
            $ecstepjob->waittime = $row["STEPWAITTIME"];
            $ecstepjob->timestamp = $row["STEPLOGTIME"];
            $ecstepjob->status = $row["STEPSTATUS"];
            $ecstepjob->url = "http://cadada.com";

            array_push($stepbuildjob, $ecstepjob);
        }
    }


    if($row["TIMESTAMP"]!=null) {
        if (in_array($row["TIMESTAMP"], $chlogindex, true)) {
        } else {
            $log = new Log();
            $log->type = $row["TYPE"];
            $log->timestamp = $row["TIMESTAMP"];
            $log->log = "Checkin Success! URL:" . $checkin->url;
            array_push($logs, $log);
        }
    }
    if($row["PRLOGTIME"]!=null) {
        if (in_array($row["PRLOGTIME"], $prlogindex, true)) {
        } else {
            $log = new Log();
            $log->type = $row["PRSTATUS"];
            $log->timestamp = $row["PRLOGTIME"];
            $log->log = "PR " . $row["PRLOG"] . "! Reviewers :[ ".$row["REVIEWERS"]." ]. URL:" . $pr->url;
            array_push($logs, $log);
        }
    }
    if($row["MERGETIMESTAMP"]!=null) {
        if (in_array($row["MERGETIMESTAMP"], $melogindex, true)) {
        } else {
            $log = new Log();
            $log->type = $row["MERGETYPE"];
            $log->timestamp = $row["MERGETIMESTAMP"];
            $log->log = "Merge Success! URL:" . $merge->url;
            array_push($logs, $log);
        }
    }
    if($row["STEPID"]!=null) {
        if (in_array($row["STEPLOGTIME"], $steplogindex, true)) {
        } else {
            $log = new Log();
            $log->type = $row["STEPSTATUS"];
            $log->timestamp = $row["STEPLOGTIME"];
            $log->log = $row["STEPNAME"] . ":" . $row["STEPSTATUS"] . "--" . $row["STEPLOG"] . "  URL:" . $ecstepjob->url;
            array_push($logs, $log);
        }
    }


    array_push($chindex, $row["COMMITID"]);
    array_push($prindex, $row["PULLREQUESTID"]);
    array_push($meindex, $row["COMMITID"]);
    array_push($jobindex, $row["JOBID"]);
    array_push($stepindex, $row["STEPID"]);

    array_push($prlogindex, $row["PRLOGTIME"]);
    array_push($steplogindex, $row["STEPLOGTIME"]);
    array_push($chlogindex, $row["TIMESTAMP"]);
    array_push($melogindex, $row["MERGETIMESTAMP"]);
}



foreach ($logs as $key=>$value){
    $id[$key] = $value->timestamp;
    $time[$key] = $value->log;
}

array_multisort($time,SORT_NUMERIC,SORT_ASC,$id,SORT_STRING,SORT_DESC,$logs);




if($checkin->name!=null) {
    array_push($stage, $checkin);
}
if($pr->name!=null) {
    array_push($stage, $pr);
}
if($merge->name!=null){
    array_push($stage,$merge);
}
$items = array();
//Packet
foreach($stepbuildjob as $item) {
    $jobid = $item->jobid;

    unset($item->jobid);
    if(!isset($items[$jobid])) {
        $items[$jobid] = array('jobid'=>$jobid, 'items'=>array());
    }
    $items[$jobid]['items'][] = $item;
}

foreach($buildjob as $value) {
    $value->stepjob=$items[$value->jobid]["items"];
}

$stage_json=json_encode($stage);

$pipelineData = array(
    "property" =>$property,
    "stage" =>$stage,
    "build" =>$buildjob,
    "logs"  =>$logs
);

$pipelineData_json=json_encode($pipelineData);
$json=json_decode($pipelineData_json);

//echo $json->{"build"}[0]->{"stepjob"};
echo $pipelineData_json;

//echo "{".'"property"'.":".$property_json.",".'"stage"'.":".$stage_json.",".'"file"'.":[]"."}";
mysql_close($conn);

class Pullrequest
{
    public $name ;
    public $timestamp ;
    public $status ;
    public $url ;
    public $logs ;

}

class Merge
{
    public $name ;
    public $timestamp ;
    public $status ;
    public $url ;
    public $logs ;

}

class Checkin
{
    public $name ;
    public $timestamp ;
    public $status ;
    public $url ;
    public $logs ;


}

class Log{
    public $type;
    public $timestamp ;
    public $log ;

}

class ECjob
{
    public $jobid ;
    public $jobname ;
    public $componentname ;
    public $buildnumber ;
    public $version ;
    public $buildoption ;
    public $waittime ;
    public $timestamp ;
    public $status ;
    public $url;
    public $stepjob ;

}
class ECstepjob
{
    public $stepjob ;
    public $jobid;
    public $stepname ;
    public $waittime ;
    public $timestamp ;
    public $status;
    public $url;
    public $logs;
}

class Property{

    public $commitid ;
    public $stashproject ;
    public $repository ;
    public $branch ;
    public $buildoption;
    public $author ;
    public $email ;
}