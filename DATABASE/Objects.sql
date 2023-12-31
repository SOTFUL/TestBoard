-- drop objects ------------------------------------------------------------------------
drop table tb_issue cascade constraints;
drop table tb_issue_screenshot cascade constraints;
drop table tb_issue_comment cascade constraints;
drop table tb_test cascade constraints;
drop table tb_lookup cascade constraints;

drop table tb_status cascade constraints;
drop table tb_work cascade constraints;
drop table tb_work_status cascade constraints;
drop table tb_test_status cascade constraints;


-- create tables ------------------------------------------------------------------------
create table tb_issue (
    id                             number generated by default on null as identity 
                                   constraint tb_issue_id_pk primary key,
    application_id                 number,
    page_id                        number,
    type                           varchar2(4000 char),
    title                          varchar2(4000 char),
    status_id                      number,
    error_message                  varchar2(4000 char),
    description                    varchar2(4000 char),
    reported_date                  date,
    reported_by                    varchar2(4000 char),
    assigned_to                    varchar2(4000 char),
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

create table tb_issue_screenshot (
    id                             number generated by default on null as identity 
                                   constraint tb_issue_screensho_id_pk primary key,
    issue_id                       number
                                   constraint tb_issue_screenshot_issue_id_fk
                                   references tb_issue on delete cascade,
    screenshot                     blob,
    screenshot_filename            varchar2(512 char),
    screenshot_mimetype            varchar2(512 char),
    screenshot_charset             varchar2(512 char),
    screenshot_lastupd             date,
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

create table tb_issue_comment (
    id                             number generated by default on null as identity 
                                   constraint tb_issue_comment_id_pk primary key,
    issue_id                       number
                                   constraint tb_issue_comment_issue_id_fk
                                   references tb_issue on delete cascade,
    comment_text                   varchar2(4000 char),
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

create table tb_test (
    id                             number generated by default on null as identity 
                                   constraint tb_test_id_pk primary key,
    issue_id                       number
                                   constraint tb_test_issue_id_fk
                                   references tb_issue on delete cascade,
    test_date                      date,
    test_by                        varchar2(4000 char),
    test_status                    NUMBER,
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

create table tb_lookup 
(
    id                              number generated by default on null as identity 
                                    constraint tb_lookup_id_pk primary key,
    code                            varchar2(4000 char),
    display                         varchar2(4000 char),
    sort                            varchar2(4000 char),
    lov_name                        varchar2(255 char),
    created                         date not null enable,
    created_by                      varchar2(255 char) not null enable,
    updated                         date not null enable,
    updated_by                      varchar2(255 char) not null enable
)
;


-- table index ------------------------------------------------------------------------
create index tb_issue_comment_i1 on tb_issue_comment (issue_id);
create index tb_test_i1 on tb_test (issue_id);


-- triggers ------------------------------------------------------------------------
create or replace trigger tb_issue_biu
    before insert or update 
    on tb_issue
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end tb_issue_biu;
/

create or replace trigger tb_issue_screenshot_biu
    before insert or update 
    on tb_issue_screenshot
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end tb_issue_screenshot_biu;
/

create or replace trigger tb_issue_comment_biu
    before insert or update 
    on tb_issue_comment
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end tb_issue_comment_biu;
/

create or replace trigger tb_test_biu
    before insert or update 
    on tb_test
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;
    :new.updated := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end tb_test_biu;
/

create or replace trigger tb_lookup_biu
  before insert or update 
  on tb_lookup
  for each row
begin 
    if inserting then 
        :new.created := sysdate; 
        :new.created_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
    end if; 
    :new.updated := sysdate; 
    :new.updated_by := coalesce(sys_context('APEX$SESSION','APP_USER'),user); 
end tb_lookup_biu;
/
