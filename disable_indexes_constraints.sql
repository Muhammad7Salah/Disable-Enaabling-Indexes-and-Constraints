--------------------------------------------------------
--  File created - Wednesday-June-19-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure DISABLE_INDEXES_CONSTRAINTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE DISABLE_INDEXES_CONSTRAINTS(schema_name_in IN varchar2,table_name_in IN varchar2)
IS
BEGIN

for i in ( select con.owner,con.table_name, con.constraint_name, idx.INDEX_NAME
               from all_constraints con,all_indexes idx
               where con.owner = idx.owner
               and con.TABLE_NAME = idx.TABLE_NAME
               and con.table_name = UPPER(table_name_in)
               and con.owner = UPPER(schema_name_in))
    loop
        dbms_output.put_line('alter table '|| i.owner ||'.'|| i.table_name ||' disable constraint '|| i.constraint_name);
        execute immediate 'alter table '|| i.owner || '.' || i.table_name ||' disable constraint '|| i.constraint_name;
    end loop;
    
/*declare c int;
begin
  select count(*) into c from all_tables where table_name = upper('table_name');
  select
   if c = 0 then
    execute immediate  'C
end if;
end;*/


for i in ( select idx.owner, idx.INDEX_NAME, idx.INDEX_TYPE,idx.TABLE_OWNER, idx.TABLE_NAME, idx.uniqueness, col.COLUMN_NAME
               from ALL_IND_COLUMNS col,all_indexes idx
               where col.table_owner = idx.table_owner
               and col.TABLE_NAME = idx.TABLE_NAME
               and col.INDEX_NAME = idx.INDEX_NAME
               and col.table_name = UPPER(table_name_in)
               and col.table_owner = UPPER(schema_name_in))
    loop
        dbms_output.put_line('insert into dropped_indexes_bulk_load values ('''||i.owner||''','''||i.INDEX_NAME||''','''||i.INDEX_TYPE||''','''||i.TABLE_OWNER||''','''||i.TABLE_NAME||''','''||i.UNIQUENESS||''','''||i.COLUMN_NAME||''')');
        execute immediate 'insert into dropped_indexes_bulk_load values ('''||i.owner||''','''||i.INDEX_NAME||''','''||i.INDEX_TYPE||''','''||i.TABLE_OWNER||''','''||i.TABLE_NAME||''','''||i.UNIQUENESS||''','''||i.COLUMN_NAME||''')';
        dbms_output.put_line('drop index '|| i.owner || '.' || i.index_name);
        execute immediate 'drop index '|| i.owner || '.' || i.index_name ;
    end loop;

END;

/
