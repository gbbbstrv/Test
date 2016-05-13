/*==============================================================*/
/* DBMS name:      SAP SQL Anywhere 16                          */
/* Created on:     5/12/2016 8:13:51 PM                         */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_EC_JOB_L_REFERENCE_EC_JOB') then
    alter table EC_JOB_LOG
       delete foreign key FK_EC_JOB_L_REFERENCE_EC_JOB
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EC_STEPJ_REFERENCE_EC_JOB') then
    alter table EC_STEPJOB
       delete foreign key FK_EC_STEPJ_REFERENCE_EC_JOB
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EC_STEPJ_REFERENCE_EC_STEPS') then
    alter table EC_STEPJOB
       delete foreign key FK_EC_STEPJ_REFERENCE_EC_STEPS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EC_STEPJ_REFERENCE_EC_STEPJ') then
    alter table EC_STEPJOB_LOG
       delete foreign key FK_EC_STEPJ_REFERENCE_EC_STEPJ
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_STASH_PU_REFERENCE_STASH_PU') then
    alter table STASH_PULL_REQUESTS_LOG
       delete foreign key FK_STASH_PU_REFERENCE_STASH_PU
end if;

drop table if exists EC_JOB;

drop table if exists EC_JOB_LOG;

drop table if exists EC_STEPJOB;

drop table if exists EC_STEPJOB_LOG;

drop table if exists EC_STEPSEQUENCE;

drop table if exists PARAMETERS;

drop table if exists STASH_GIT_COMMIT;

drop table if exists STASH_PULL_REQUESTS;

drop table if exists STASH_PULL_REQUESTS_LOG;

/*==============================================================*/
/* Table: EC_JOB                                                */
/*==============================================================*/
create table EC_JOB 
(
   JOBID                varchar(40)                    not null,
   JOBNAME              varchar(100)                   null,
   COMPONENTNAME        varchar(100)                   null,
   BUILDNUMBER          varchar(20)                    null,
   VERSION              varchar(10)                    null,
   BUILDOPTION          int                            null,
   WAITTIME             datetime                       null,
   COMMITID             varchar(50)                    null,
   STASHPROJECT         varchar(60)                    null,
   REPOSITORY           varchar(60)                    null,
   BRANCH               varchar(60)                    null,
   FEATUREID            varchar(20)                    null,
   constraint PK_EC_JOB primary key clustered (JOBID)
);

/*==============================================================*/
/* Table: EC_JOB_LOG                                            */
/*==============================================================*/
create table EC_JOB_LOG 
(
   ID                   int                            not null,
   JOBID                varchar(40)                    not null,
   LOGTIME              datetime                       null,
   STATUS               int                            null,
   LOG                  text                           null,
   constraint PK_EC_JOB_LOG primary key clustered (ID)
);

/*==============================================================*/
/* Table: EC_STEPJOB                                            */
/*==============================================================*/
create table EC_STEPJOB 
(
   STEPID               varchar(40)                    not null,
   JOBID                varchar(40)                    not null,
   STEPSEQUENCEID       int                            not null,
   WAITTIME             datetime                       null,
   RESOURCENAME         varchar(200)                   null,
   AUTHORNAME           varchar(200)                   null,
   constraint PK_EC_STEPJOB primary key clustered (STEPID)
);

/*==============================================================*/
/* Table: EC_STEPJOB_LOG                                        */
/*==============================================================*/
create table EC_STEPJOB_LOG 
(
   ID                   int                            not null,
   STEPID               varchar(40)                    not null,
   LOGTIME              datetime                       null,
   STATUS               int                            null,
   LOG                  text                           null,
   constraint PK_EC_STEPJOB_LOG primary key clustered (ID)
);

/*==============================================================*/
/* Table: EC_STEPSEQUENCE                                       */
/*==============================================================*/
create table EC_STEPSEQUENCE 
(
   STEPSEQUENCEID       int                            not null,
   STEPINDEX            int                            null,
   STEPNAME             varchar(100)                   null,
   constraint PK_EC_STEPSEQUENCE primary key clustered (STEPSEQUENCEID)
);

/*==============================================================*/
/* Table: PARAMETERS                                            */
/*==============================================================*/
create table PARAMETERS 
(
   ID                   int                            not null,
   PARAMKEY             int                            null,
   PARAMVALUE           varchar(50)                    null,
   PARAMGROUP           varchar(20)                    null,
   constraint PK_PARAMETERS primary key clustered (ID)
);

/*==============================================================*/
/* Table: STASH_GIT_COMMIT                                      */
/*==============================================================*/
create table STASH_GIT_COMMIT 
(
   COMMITID             varchar(50)                    not null,
   STASHPROJECT         varchar(60)                    not null,
   REPOSITORY           varchar(60)                    not null,
   BRANCH               varchar(60)                    not null,
   "TIMESTAMP"          datetime                       null,
   TYPE                 int                            null,
   AUTHOR               varchar(200)                   null,
   EMAIL                varchar(200)                   null,
   COMMITS              text                           null,
   constraint PK_STASH_GIT_COMMIT primary key clustered (COMMITID, STASHPROJECT, REPOSITORY, BRANCH)
);

/*==============================================================*/
/* Table: STASH_PULL_REQUESTS                                   */
/*==============================================================*/
create table STASH_PULL_REQUESTS 
(
   COMMITID             varchar(50)                    not null,
   STASHPROJECT         varchar(60)                    not null,
   REPOSITORY           varchar(60)                    not null,
   BRANCH               varchar(60)                    not null,
   NUMBER               int                            null,
   REVIEWERS            varchar(200)                   null,
   APPROVER             varchar(200)                   null,
   USERNAME             varchar(200)                   null,
   USEREMAIL            varchar(200)                   null,
   constraint PK_STASH_PULL_REQUESTS primary key clustered (COMMITID, STASHPROJECT, REPOSITORY, BRANCH)
);

/*==============================================================*/
/* Table: STASH_PULL_REQUESTS_LOG                               */
/*==============================================================*/
create table STASH_PULL_REQUESTS_LOG 
(
   ID                   int                            not null,
   COMMITID             varchar(50)                    not null,
   STASHPROJECT         varchar(60)                    not null,
   REPOSITORY           varchar(60)                    not null,
   BRANCH               varchar(60)                    not null,
   LOGTIME              datetime                       null,
   STATUS               int                            null,
   LOG                  text                           null,
   constraint PK_STASH_PULL_REQUESTS_LOG primary key clustered (ID)
);

alter table EC_JOB_LOG
   add constraint FK_EC_JOB_L_REFERENCE_EC_JOB foreign key (JOBID)
      references EC_JOB (JOBID)
      on update restrict
      on delete restrict;

alter table EC_STEPJOB
   add constraint FK_EC_STEPJ_REFERENCE_EC_JOB foreign key (JOBID)
      references EC_JOB (JOBID)
      on update restrict
      on delete restrict;

alter table EC_STEPJOB
   add constraint FK_EC_STEPJ_REFERENCE_EC_STEPS foreign key (STEPSEQUENCEID)
      references EC_STEPSEQUENCE (STEPSEQUENCEID)
      on update restrict
      on delete restrict;

alter table EC_STEPJOB_LOG
   add constraint FK_EC_STEPJ_REFERENCE_EC_STEPJ foreign key (STEPID)
      references EC_STEPJOB (STEPID)
      on update restrict
      on delete restrict;

alter table STASH_PULL_REQUESTS_LOG
   add constraint FK_STASH_PU_REFERENCE_STASH_PU foreign key (COMMITID, STASHPROJECT, REPOSITORY, BRANCH)
      references STASH_PULL_REQUESTS (COMMITID, STASHPROJECT, REPOSITORY, BRANCH)
      on update restrict
      on delete restrict;

