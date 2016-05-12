/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     5/11/2016 7:13:14 PM                         */
/*==============================================================*/


drop table if exists EC_JOB;

drop table if exists EC_STEPJOB;

drop table if exists EC_STEPSEQUENCE;

drop table if exists PARAMETERS;

drop table if exists STASH_GIT_COMMIT;

drop table if exists STASH_PULL_REQUESTS;

/*==============================================================*/
/* Table: EC_JOB                                                */
/*==============================================================*/
create table EC_JOB
(
   JOBID                varchar(40) not null,
   JOBNAME              varchar(100),
   COMPONENTNAME        varchar(100),
   BUILDNUMBER          varchar(20),
   VERSION              varchar(10),
   BUILDOPTION          int,
   COMMITID             varchar(50),
   STARTTIME            datetime,
   ENDTIME              datetime,
   WAITTIME             datetime,
   STATUS               int,
   primary key (JOBID)
);

/*==============================================================*/
/* Table: EC_STEPJOB                                            */
/*==============================================================*/
create table EC_STEPJOB
(
   STEPID               varchar(40) not null,
   JOBID                varchar(40),
   STEPSEQUENCEID       int,
   STARTTIME            datetime,
   ENDTIME              datetime,
   WAITTIME             datetime,
   STATUS               int,
   COMMENTS             longtext,
   RESOURCENAME         varchar(200),
   AUTHORNAME           varchar(200),
   primary key (STEPID)
);

/*==============================================================*/
/* Table: EC_STEPSEQUENCE                                       */
/*==============================================================*/
create table EC_STEPSEQUENCE
(
   STEPSEQUENCEID       int not null,
   STEPINDEX            int,
   STEPNAME             varchar(100),
   primary key (STEPSEQUENCEID)
);

/*==============================================================*/
/* Table: PARAMETERS                                            */
/*==============================================================*/
create table PARAMETERS
(
   ID                   int not null,
   PARAMKEY             int,
   PARAMVALUE           varchar(50),
   PARAMGROUP           varchar(20),
   primary key (ID)
);

/*==============================================================*/
/* Table: STASH_GIT_COMMIT                                      */
/*==============================================================*/
create table STASH_GIT_COMMIT
(
   ID                   int not null,
   COMMITID             varchar(50),
   TIMESTAMP            datetime,
   STASHPROJECT         varchar(60),
   REPOSITORY           varchar(60),
   BRANCH               varchar(60),
   TYPE                 int,
   AUTHOR               varchar(200),
   EMAIL                varchar(200),
   COMMITS              longtext,
   primary key (ID)
);

/*==============================================================*/
/* Table: STASH_PULL_REQUESTS                                   */
/*==============================================================*/
create table STASH_PULL_REQUESTS
(
   ID                   int not null,
   COMMITID             varchar(50),
   STASHPROJECT         varchar(60),
   REPOSITORY           varchar(60),
   BRANCH               varchar(60),
   TITLE                varchar(100),
   STATUS               int,
   REVIEWERS            varchar(200),
   CREATETIME           datetime,
   UPDATETIME           datetime,
   APPROVER             varchar(200),
   USERNAME             varchar(200),
   USEREMAIL            varchar(200),
   primary key (ID)
);

alter table EC_JOB add constraint FK_REFERENCE_3 foreign key (COMMITID)
      references STASH_GIT_COMMIT (ID) on delete restrict on update restrict;

alter table EC_STEPJOB add constraint FK_REFERENCE_1 foreign key (JOBID)
      references EC_JOB (JOBID) on delete restrict on update restrict;

alter table EC_STEPJOB add constraint FK_REFERENCE_5 foreign key (STEPSEQUENCEID)
      references EC_STEPSEQUENCE (STEPSEQUENCEID) on delete restrict on update restrict;

