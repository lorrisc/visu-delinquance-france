/*==============================================================*/
/* Nom de SGBD :  MySQL 5.0                                     */
/* Date de création :  20/05/2023 16:46:52                      */
/*==============================================================*/


drop table if exists CENSUS;

drop table if exists CLASS;

drop table if exists DEPARTMENT;

drop table if exists YEAR;

/*==============================================================*/
/* Table : CENSUS                                               */
/*==============================================================*/
create table CENSUS
(
   YR_ID                int not null,
   CL_ID                int not null,
   DP_ID                int not null,
   CE_TOT               int not null,
   CE_RATE              numeric(5,1) not null,
   primary key (YR_ID, CL_ID, DP_ID)
);

/*==============================================================*/
/* Table : CLASS                                                */
/*==============================================================*/
create table CLASS
(
   CL_ID                int not null auto_increment,
   CL_LIB               longtext not null,
   primary key (CL_ID)
);

/*==============================================================*/
/* Table : DEPARTMENT                                           */
/*==============================================================*/
create table DEPARTMENT
(
   DP_ID                int not null auto_increment,
   DP_CODE              varchar(3) not null,
   primary key (DP_ID)
);

/*==============================================================*/
/* Table : YEAR                                                 */
/*==============================================================*/
create table YEAR
(
   YR_ID                int not null auto_increment,
   YR_LIB               char(4) not null,
   primary key (YR_ID)
);

alter table CENSUS add constraint FK_CENSUS foreign key (YR_ID)
      references YEAR (YR_ID) on delete restrict on update restrict;

alter table CENSUS add constraint FK_CENSUS2 foreign key (CL_ID)
      references CLASS (CL_ID) on delete restrict on update restrict;

alter table CENSUS add constraint FK_CENSUS3 foreign key (DP_ID)
      references DEPARTMENT (DP_ID) on delete restrict on update restrict;

