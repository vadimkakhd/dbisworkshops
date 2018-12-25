/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     23.12.2018 15:05:10                          */
/*==============================================================*/


alter table Information
   drop constraint FK_INFORMAT_USER_GET__USER;

alter table Information
   drop constraint FK_INFORMAT_INF_CORRE_RESOURSE;

alter table Information
   drop constraint FK_INFORMAT_INFORMATI_LECTION_;

alter table User_has_theme
   drop constraint FK_USER_HAS_THEME_BEL_LECTION_;

alter table User_has_theme
   drop constraint FK_USER_AUTH_HAS_THEME;

alter table user_has_resourses
   drop constraint FK_USER_HAS_RESOURSE__RESOURSE;

alter table user_has_resourses
   drop constraint FK_USER__AUTH_HAS_RESOURSES;

drop index User_get_inf_FK;

drop index "inf correspond theme_FK";

drop index inf_correspond_resourse_FK;

drop table Information cascade constraints;

drop table Lection_theme cascade constraints;

drop table Resourse cascade constraints;

drop table "User" cascade constraints;

drop index user_author_of_theme_FK;

drop index theme_belongs_to_user_FK;

drop table User_has_theme cascade constraints;

drop index user_author_of_resourse_FK;

drop index resourse_belongs_to_user_FK;

drop table user_has_resourses cascade constraints;

/*==============================================================*/
/* Table: Information                                           */
/*==============================================================*/
create table Information 
(
   info_id              INTEGER              not null,
   nickname             VARCHAR2(25)         not null,
   Lection_name         VARCHAR2(150)        not null,
   resource_name        VARCHAR2(100)        not null,
   Information_link     VARCHAR2(200)        not null,
   "Date"               DATE                 not null,
   constraint PK_INFORMATION primary key (info_id)
);

/*==============================================================*/
/* Index: inf_correspond_resourse_FK                            */
/*==============================================================*/
create index inf_correspond_resourse_FK on Information (
   resource_name ASC
);

/*==============================================================*/
/* Index: "inf correspond theme_FK"                             */
/*==============================================================*/
create index "inf correspond theme_FK" on Information (
   Lection_name ASC
);

/*==============================================================*/
/* Index: User_get_inf_FK                                       */
/*==============================================================*/
create index User_get_inf_FK on Information (
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
   nickname             VARCHAR2(25)         not null,
   login                VARCHAR2(40)         not null,
   pass                 VARCHAR2(20)         not null,
   name                 VARCHAR2(20),
   surname              VARCHAR2(40),
   faculty_name         VARCHAR2(50)         not null,
   course_number        INTEGER              not null,
   constraint PK_USER primary key (nickname)
);

/*==============================================================*/
/* Table: User_has_theme                                        */
/*==============================================================*/
create table User_has_theme 
(
   user_theme_id        INTEGER              not null,
   Author_nickname      VARCHAR2(25)         not null,
   Lection_name         VARCHAR2(150)        not null,
   "Date"               DATE                 not null,
   constraint PK_USER_HAS_THEME primary key (user_theme_id)
);

/*==============================================================*/
/* Index: theme_belongs_to_user_FK                              */
/*==============================================================*/
create index theme_belongs_to_user_FK on User_has_theme (
   Lection_name ASC
);

/*==============================================================*/
/* Index: user_author_of_theme_FK                               */
/*==============================================================*/
create index user_author_of_theme_FK on User_has_theme (
   Author_nickname ASC
);

/*==============================================================*/
/* Table: user_has_resourses                                    */
/*==============================================================*/
create table user_has_resourses 
(
   user_resourse_id     INTEGER              not null,
   author_nickname      VARCHAR2(25)         not null,
   resource_name        VARCHAR2(100)        not null,
   "Date"               DATE                 not null,
   constraint PK_USER_HAS_RESOURSES primary key (user_resourse_id)
);

/*==============================================================*/
/* Index: resourse_belongs_to_user_FK                           */
/*==============================================================*/
create index resourse_belongs_to_user_FK on user_has_resourses (
   resource_name ASC
);

/*==============================================================*/
/* Index: user_author_of_resourse_FK                            */
/*==============================================================*/
create index user_author_of_resourse_FK on user_has_resourses (
   author_nickname ASC
);

alter table Information
   add constraint FK_INFORMAT_USER_GET__USER foreign key (nickname)
      references "User" (nickname);

alter table Information
   add constraint FK_INFORMAT_INF_CORRE_RESOURSE foreign key (resource_name)
      references Resourse (resource_name);

alter table Information
   add constraint FK_INFORMAT_INFORMATI_LECTION_ foreign key (Lection_name)
      references Lection_theme (Lection_name);

alter table User_has_theme
   add constraint FK_USER_HAS_THEME_BEL_LECTION_ foreign key (Lection_name)
      references Lection_theme (Lection_name);

alter table User_has_theme
   add constraint FK_USER_AUTH_HAS_THEME foreign key (Author_nickname)
      references "User" (nickname);

alter table user_has_resourses
   add constraint FK_USER_HAS_RESOURSE__RESOURSE foreign key (resource_name)
      references Resourse (resource_name);

alter table user_has_resourses
   add constraint FK_USER__AUTH_HAS_RESOURSES foreign key (author_nickname)
      references "User" (nickname);
      
alter table Lection_theme
    add CONSTRAINT Theme_check CHECK (REGEXP_LIKE(Lection_name,'^[A-Z][A-Za-z]*\s([A-Za-z]*\s?)+'));
    
alter table RESOURSE
    add CONSTRAINT Resourse_name_check CHECK (REGEXP_LIKE(resource_name,'^www\.[a-z]*\.[0-9a-z\.\/\-]+'));

alter table "User"
    add CONSTRAINT User_pass_check CHECK (REGEXP_LIKE(PASS,'[A-Za-z0-9]{6,16}'));
alter table "User"
    add CONSTRAINT User_name_check CHECK (REGEXP_LIKE(name,'^[A-Z]{1}[A-Za-z]+'));
alter table "User"
    add CONSTRAINT User_surname_check CHECK (REGEXP_LIKE(SURNAME,'^[A-Z]{1}[A-Za-z]+'));
alter table "User"
    add CONSTRAINT User_nickname_check CHECK (REGEXP_LIKE(NICKNAME,'^[A-Za-z].*'));
alter table "User"
    add CONSTRAINT faculty_name_check CHECK (REGEXP_LIKE(FACULTY_NAME,'^[A-Z]{1}[A-Za-z]+(\s[A-Za-z]*)*'));
alter table "User"
    add CONSTRAINT course_number_check CHECK (course_number <= 6 and course_number > 0);
    
alter table INFORMATION
    add CONSTRAINT INFORMATION_LINK_check CHECK (REGEXP_LIKE(INFORMATION_LINK,'^https:\/\/telegra\.ph\/[A-Za-z\-]+'));
alter table INFORMATION
   add constraint INFORMATION_nickname_check CHECK (REGEXP_LIKE(nickname,'^[A-Za-z].*'));
alter table INFORMATION
   add constraint INFORMATION_theme_check CHECK (REGEXP_LIKE(Lection_name,'^[A-Z][A-Za-z]*\s([A-Za-z]*\s?)+'));
alter table INFORMATION
   add constraint INFORMATION_resorse_check CHECK (REGEXP_LIKE(resource_name,'^www\.[a-z]*\.[0-9a-z\.\/\-]+'));
alter table INFORMATION
   add constraint INFORMATION_unique UNIQUE (nickname, Lection_name, resource_name);

alter table User_has_theme
   add constraint UhT_author_nickname_check CHECK (REGEXP_LIKE(Author_nickname,'^[A-Za-z].*'));
alter table User_has_theme
   add constraint User_has_theme_unique UNIQUE (Author_nickname, LECTION_NAME);
   
alter table User_has_resourses
   add constraint UhR_author_check CHECK (REGEXP_LIKE(Author_nickname,'^[A-Za-z].*'));
alter table User_has_resourses
   add constraint User_has_resourses_unique UNIQUE (Author_nickname, RESOURCE_NAME);



