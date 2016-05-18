<?php
/**
 * Created by IntelliJ IDEA.
 * User: hpw
 * Date: 16/5/10
 * Time: 下午1:01
 */

include_once("dbconfig.php");




$action = $_GET['action'];


$jobindex=array();
$stepindex=array();


//$result  = mysql_query(
//   " select
// com.commitid,com.timestamp,com.stashproject,com.repository,com.branch,com.type,com.author,com.email,
//req.ID as 'prid',req.title,req.status as 'prstate',req.reviewers,req.CREATETIME as 'prcreatetime',req.UPDATETIME as 'prupdatetime',req.approver,
//ecj.jobid,ecj.jobname,ecj.componentname,ecj.buildnumber,ecj.version,ecj.buildoption,ecj.STARTTIME as 'jobstime',ecj.ENDTIME as 'jobetime',ecj.WAITTIME as 'jobwtime',ecj.status as 'jobstate',
//ecs.stepid,ecs.stepname,ecs.starttime as 'stepstime',ecs.ENDTIME as 'stepetime',ecs.WAITTIME as 'stepwtime',ecs.status as 'stepstate',ecs.comments,ecs.resourcename,ecs.authorname
//
// from ".$db_table_stash_git_commit." com
// left join  ".$db_table_stash_pull_requests." req
//  on  req.CommitId=com.CommitId
//  left join ".$db_table_ec_job." ecj
//  on req.CommitId=ecj.CommitId
// left join
// (
// select JOBID,STEPID,STEPNAME,STARTTIME,ENDTIME,WAITTIME,status,COMMENTS,RESOURCENAME,AUTHORNAME from EC_StepJob ecs,".$db_table_parameters." param,".$db_table_ec_step_sequence." seq
//where ecs.stepSequenceID=param.paramkey and paramgroup='ECStatus' and ecs.STEPSEQUENCEID=seq.STEPINDEX
//) ecs
// on  ecj.JobId=ecs.JobId
//where com.Author='penghu'  ORDER BY com.CommitId,ecj.JOBID,ecs.RESOURCENAME desc "
//);

$result  = mysql_query("

select com.COMMITID,com.STASHPROJECT,com.REPOSITORY,com.BRANCH,com.TIMESTAMP,com.TYPE,com.AUTHOR,com.EMAIL,
pr.PRSTATUS,pr.NUMBER,pr.PRLOGTIME,pr.APPROVER,
ecjob.JOBID,ecjob.JOBNAME,ecjob.COMPONENTNAME,ecjob.BUILDNUMBER,ecjob.VERSION,ecjob.BUILDOPTION,ecjob.JOBLOGTIME,ecjob.JOBWAITTIME,ecjob.JOBSTATUS,
st.STEPID,st.STEPNAME,st.STEPLOGTIME,st.STEPWAITTIME,st.STEPSTATUS,
ma.MERGESTASHPROJECT, ma.MERGETIMESTAMP,ma.MERGETYPE 
from Stash_Git_Commit com left join 
(
select * from
(select spr.COMMITID,spr.STASHPROJECT,spr.REPOSITORY,spr.BRANCH,NUMBER,status as 'PRSTATUS',REVIEWERS,LOGTIME as 'PRLOGTIME',APPROVER,log from Stash_Pull_Requests spr,Stash_Pull_Requests_Log sprlog 
where spr.COMMITID=sprlog.COMMITID and spr.BRANCH=sprlog.BRANCH and spr.REPOSITORY=sprlog.REPOSITORY and spr.STASHPROJECT=sprlog.STASHPROJECT
order by spr.STASHPROJECT,spr.COMMITID,spr.REPOSITORY,spr.BRANCH,LOGTIME desc
) req
group by req.STASHPROJECT,req.COMMITID,req.REPOSITORY,req.BRANCH

) pr  on  com.COMMITID=pr.COMMITID

left join
(
select * from 
(select j.COMMITID,j.JOBID,JOBNAME,COMPONENTNAME,BUILDNUMBER,VERSION, BUILDOPTION ,LOGTIME as 'JOBLOGTIME',WAITTIME as 'JOBWAITTIME',STATUS as 'JOBSTATUS',log  as 'JOBLOG'
from EC_Job j,EC_Job_Log log  where j.JOBID=log.JOBID ORDER BY j.jobid,log.LOGTIME
) job GROUP BY job.jobid
) ecjob  on ecjob.CommitId=com.CommitId

left join 
(
select * from 
(select ecs.JOBID,ecs.STEPID,STEPNAME,LOGTIME as 'STEPLOGTIME',WAITTIME as 'STEPWAITTIME',PARAMVALUE,status as 'STEPSTATUS',log.LOG,RESOURCENAME,AUTHORNAME from EC_STEPJOB ecs,PARAMETERS param,EC_STEPSEQUENCE seq,EC_STEPJOB_log log
where log.status=param.paramkey and param.paramgroup='ECStatus' and ecs.STEPSEQUENCEID=seq.STEPINDEX and ecs.STEPID=log.STEPID order by STEPID,LOGTIME desc 
) step group by step.STEPID
) st on st.jobid=ecjob.jobid
left join
(select  COMMITID,REPOSITORY,BRANCH,STASHPROJECT as 'MERGESTASHPROJECT',TIMESTAMP as 'MERGETIMESTAMP',TYPE as 'MERGETYPE' from Stash_Git_Commit me 
where me.branch like '%master%'
) ma on com.COMMITID=ma.COMMITID and com.STASHPROJECT=ma.MERGESTASHPROJECT and com.REPOSITORY=ma.REPOSITORY
where com.BRANCH like '%gate%' and com.CommitId='llllllllllllll' and com.STASHPROJECT='cctg' and com.REPOSITORY='webex' and com.BRANCH='refs/heads/gate/penghu'

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
        $checkin->name = "checkin";
        $checkin->timestamp = $row["TIMESTAMP"];
        $checkin->status = $row["TYPE"];
        $checkin->url = "https://bitbucket-eng-chn-sjc1.cisco.com/bitbucket/projects/" . $row["STASHPROJECT"] . "/repos/" . $row["REPOSITORY"] . "/commits/" . $row["COMMITID"];
    }
   if($row["PRLOGTIME"]!=null) {
       $pr->name = "pr";
       $pr->timestamp = $row["PRLOGTIME"];
       $pr->status = $row["PRSTATUS"];
       $pr->url = "https://bitbucket-eng-chn-sjc1.cisco.com/bitbucket/projects/" . $row["STASHPROJECT"] . "/repos/" . $row["REPOSITORY"] . "/pull_requests/" . $row["NUMBER"] . "/overview";
   }
    if($row["MERGETIMESTAMP"]!=null) {
        $merge->name = "merge";
        $merge->timestamp = $row["MERGETIMESTAMP"];
        $merge->status = $row["MERGETYPE"];
        $merge->url = "https://bitbucket-eng-chn-sjc1.cisco.com/bitbucket/projects/" . $row["MERGESTASHPROJECT"] . "/repos/" . $row["REPOSITORY"] . "/commits/" . $row["COMMITID"];
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
            array_push($jobindex, $row["JOBID"]);
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
            array_push($stepindex, $row["STEPID"]);
            array_push($stepbuildjob, $ecstepjob);
        }
    }

}



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