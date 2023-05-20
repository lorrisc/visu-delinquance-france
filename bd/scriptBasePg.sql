/*==============================================================*/
/* Nom de SGBD :  PostgreSQL 8                                  */
/* Date de création :  20/05/2023 16:43:51                      */
/*==============================================================*/


drop index CENSUS3_FK;

drop index CENSUS2_FK;

drop index CENSUS_FK;

drop index CENSUS_PK;

drop table CENSUS;

drop index CLASS_PK;

drop table CLASS;

drop index DEPARTMENT_PK;

drop table DEPARTMENT;

drop index YEAR_PK;

drop table YEAR;

/*==============================================================*/
/* Table : CENSUS                                               */
/*==============================================================*/
create table CENSUS (
   YR_ID                INT4                 not null,
   CL_ID                INT4                 not null,
   DP_ID                INT4                 not null,
   CE_TOT               INT4                 not null,
   CE_RATE              NUMERIC(5,1)         not null,
   constraint PK_CENSUS primary key (YR_ID, CL_ID, DP_ID)
);

/*==============================================================*/
/* Index : CENSUS_PK                                            */
/*==============================================================*/
create unique index CENSUS_PK on CENSUS (
YR_ID,
CL_ID,
DP_ID
);

/*==============================================================*/
/* Index : CENSUS_FK                                            */
/*==============================================================*/
create  index CENSUS_FK on CENSUS (
YR_ID
);

/*==============================================================*/
/* Index : CENSUS2_FK                                           */
/*==============================================================*/
create  index CENSUS2_FK on CENSUS (
CL_ID
);

/*==============================================================*/
/* Index : CENSUS3_FK                                           */
/*==============================================================*/
create  index CENSUS3_FK on CENSUS (
DP_ID
);

/*==============================================================*/
/* Table : CLASS                                                */
/*==============================================================*/
create table CLASS (
   CL_ID                SERIAL               not null,
   CL_LIB               VARCHAR(150)         not null,
   constraint PK_CLASS primary key (CL_ID)
);

/*==============================================================*/
/* Index : CLASS_PK                                             */
/*==============================================================*/
create unique index CLASS_PK on CLASS (
CL_ID
);

/*==============================================================*/
/* Table : DEPARTMENT                                           */
/*==============================================================*/
create table DEPARTMENT (
   DP_ID                SERIAL               not null,
   DP_CODE              VARCHAR(3)           not null,
   constraint PK_DEPARTMENT primary key (DP_ID)
);

/*==============================================================*/
/* Index : DEPARTMENT_PK                                        */
/*==============================================================*/
create unique index DEPARTMENT_PK on DEPARTMENT (
DP_ID
);

/*==============================================================*/
/* Table : YEAR                                                 */
/*==============================================================*/
create table YEAR (
   YR_ID                SERIAL               not null,
   YR_LIB               CHAR(4)              not null,
   constraint PK_YEAR primary key (YR_ID)
);

/*==============================================================*/
/* Index : YEAR_PK                                              */
/*==============================================================*/
create unique index YEAR_PK on YEAR (
YR_ID
);

alter table CENSUS
   add constraint FK_CENSUS_CENSUS_YEAR foreign key (YR_ID)
      references YEAR (YR_ID)
      on delete restrict on update restrict;

alter table CENSUS
   add constraint FK_CENSUS_CENSUS2_CLASS foreign key (CL_ID)
      references CLASS (CL_ID)
      on delete restrict on update restrict;

alter table CENSUS
   add constraint FK_CENSUS_CENSUS3_DEPARTME foreign key (DP_ID)
      references DEPARTMENT (DP_ID)
      on delete restrict on update restrict;

