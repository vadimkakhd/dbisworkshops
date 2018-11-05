/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     03.11.2018 22:16:31                          */
/*==============================================================*/


alter table Information
   drop constraint "FK_INFORMAT_USER GET _USER";

alter table Information
   drop constraint "FK_INFORMAT_INF CORRE_RESOURSE";

alter table Information
   drop constraint "FK_INFORMAT_INF CORRE_LECTION_";

alter table "User has lection theme"
   drop constraint "FK_USER HAS_USER HAS _LECTION_";

alter table "User has lection theme"
   drop constraint "FK_USER HAS_THEME";

alter table "User has resourses"
   drop constraint "FK_USER HAS_USER HAS _RESOURSE";

alter table "User has resourses"
   drop constraint "FK_USER HAS_RESOURSES";

drop index "User get inf_FK";

drop index "inf correspond theme_FK";

drop index "inf correspond resourse_FK";

drop table Information cascade constraints;

drop table Lection_theme cascade constraints;

drop table Resourse cascade constraints;

drop table "User" cascade constraints;

drop index "User has lection theme_FK";

drop index "User has lection theme2_FK";

drop table "User has lection theme" cascade constraints;

drop index "User has resourses_FK";

drop index "User has resourses2_FK";

drop table "User has resourses" cascade constraints;

/*==============================================================*/
/* Table: Information                                           */
/*==============================================================*/
create table Information 
(
   nickname             VARCHAR2(25)         not null,
   Lection_name         VARCHAR2(150)        not null,
   resource_name        VARCHAR2(100)        not null,
   Information_link     VARCHAR2(200)        not null,
   "Date"               DATE                 not null,
   constraint PK_INFORMATION primary key (nickname, Lection_name, resource_name)
);

/*==============================================================*/
/* Index: "inf correspond resourse_FK"                          */
/*==============================================================*/
create index "inf correspond resourse_FK" on Information (
   resource_name ASC
);

/*==============================================================*/
/* Index: "inf correspond theme_FK"                             */
/*==============================================================*/
create index "inf correspond theme_FK" on Information (
   Lection_name ASC
);

/*==============================================================*/
/* Index: "User get inf_FK"                                     */
/*==============================================================*/
create index "User get inf_FK" on Information (
   nickname ASC
);

/*==============================================================*/
/* Table: Lection_theme                                         */
/*==============================================================*/
create table Lection_theme 
(
   Lection_name         VARCHAR2(150)        not null,
   constraint PK_LECTION_THEME primary key (Lection_name)
);

/*==============================================================*/
/* Table: Resourse                                              */
/*==============================================================*/
create table Resourse 
(
   resource_name        VARCHAR2(100)        not null,
   constraint PK_RESOURSE primary key (resource_name)
);

/*==============================================================*/
/* Table: "User"                                                */
/*==============================================================*/
create table "User" 
(
   login                VARCHAR2(40)         not null,
   pass                 VARCHAR2(20)         not null,
   nickname             VARCHAR2(25)         not null,
   name                 VARCHAR2(20),
   surname              VARCHAR2(40),
   faculty_name         VARCHAR2(50)         not null,
   course_number        INTEGER              not null,
   constraint PK_USER primary key (nickname)
);

/*==============================================================*/
/* Table: "User has lection theme"                              */
/*==============================================================*/
create table "User has lection theme" 
(
   Lection_name         VARCHAR2(150)        not null,
   nickname             VARCHAR2(25)         not null,
   constraint "PK_USER HAS LECTION THEME" primary key (Lection_name, nickname)
);

/*==============================================================*/
/* Index: "User has lection theme2_FK"                          */
/*==============================================================*/
create index "User has lection theme2_FK" on "User has lection theme" (
   nickname ASC
);

/*==============================================================*/
/* Index: "User has lection theme_FK"                           */
/*==============================================================*/
create index "User has lection theme_FK" on "User has lection theme" (
   Lection_name ASC
);

/*==============================================================*/
/* Table: "User has resourses"                                  */
/*==============================================================*/
create table "User has resourses" 
(
   resource_name        VARCHAR2(100)        not null,
   nickname             VARCHAR2(25)         not null,
   constraint "PK_USER HAS RESOURSES" primary key (resource_name, nickname)
);

/*==============================================================*/
/* Index: "User has resourses2_FK"                              */
/*==============================================================*/
create index "User has resourses2_FK" on "User has resourses" (
   nickname ASC
);

/*==============================================================*/
/* Index: "User has resourses_FK"                               */
/*==============================================================*/
create index "User has resourses_FK" on "User has resourses" (
   resource_name ASC
);

alter table Information
   add constraint "FK_INFORMAT_USER GET _USER" foreign key (nickname)
      references "User" (nickname);

alter table Information
   add constraint "FK_INFORMAT_INF CORRE_RESOURSE" foreign key (resource_name)
      references Resourse (resource_name);

alter table Information
   add constraint "FK_INFORMAT_INF CORRE_LECTION_" foreign key (Lection_name)
      references Lection_theme (Lection_name);

alter table "User has lection theme"
   add constraint "FK_USER HAS_USER HAS _LECTION_" foreign key (Lection_name)
      references Lection_theme (Lection_name);

alter table "User has lection theme"
   add constraint "FK_USER HAS_THEME" foreign key (nickname)
      references "User" (nickname);

alter table "User has resourses"
   add constraint "FK_USER HAS_USER HAS _RESOURSE" foreign key (resource_name)
      references Resourse (resource_name);

alter table "User has resourses"
   add constraint "FK_USER HAS_RESOURSES" foreign key (nickname)
      references "User" (nickname);

alter table Lection_theme
    add CONSTRAINT Theme_check CHECK (REGEXP_LIKE(Lection_name,'^[A-Z][A-Za-z]*\s([A-Za-z]*\s?)+'));
    
alter table RESOURSE
    add CONSTRAINT Resourse_name_check CHECK (REGEXP_LIKE(resource_name,'^www\.[a-z]*\.[0-9a-z\.\/\-]+'));
    
alter table "User"
    add CONSTRAINT User_name_check CHECK (REGEXP_LIKE(Name,'^[A-Z][A-Za-z]+'));
alter table "User"
    add CONSTRAINT User_surname_check CHECK (REGEXP_LIKE(SURNAME,'^[A-Z][A-Za-z]+'));
alter table "User"
    add CONSTRAINT User_nickname_check CHECK (REGEXP_LIKE(SURNAME,'^[A-Za-z].*'));
alter table "User"
    add CONSTRAINT faculty_name_check CHECK (REGEXP_LIKE(FACULTY_NAME,'^[A-Z][A-Za-z]+(\s[A-Za-z]*)*'));
    
alter table INFORMATION
    add CONSTRAINT INFORMATION_LINK_check CHECK (REGEXP_LIKE(INFORMATION_LINK,'^https:\/\/telegra\.ph\/[A-Za-z\-]+'));

    