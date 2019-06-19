--------------------------------------------------------
--  File created - Wednesday-June-19-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure ENABLE_INDEXES_CONSTRAINTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE ENABLE_INDEXES_CONSTRAINTS(schema_name_in IN varchar2,table_name_in IN varchar2)
IS
BEGIN

for i in ( select owner,table_name, constraint_name
               from all_constraints
               where table_name = UPPER(table_name_in)
               and owner = UPPER(schema_name_in) )
    loop
        dbms_output.put_line('alter table '|| i.owner ||'.'|| i.table_name ||' enable constraint '|| i.constraint_name);
        execute immediate 'alter table '|| i.owner || '.' || i.table_name ||' enable constraint '|| i.constraint_name;
    end loop;


declare create_idx_q varchar(200) := 'CREATE';
BEGIN
for i in ( select *
               from dropped_indexes_bulk_load
               where table_name = UPPER(table_name_in)
               and owner = UPPER(schema_name_in))
    loop
        dbms_output.put_line('create index '|| i.owner || '.' || i.index_name);
        
        IF i.uniqueness = 'UNIQUE'
          THEN create_idx_q := create_idx_q ||' UNIQUE';
        END IF;
          
          create_idx_q := create_idx_q || ' INDEX ' || i.index_name || ' ON ' || i.table_name || '(' || i.column_name || ')';
        dbms_output.put_line(create_idx_q);
        execute immediate create_idx_q ;
        
        dbms_output.put_line('Delete from dropped_indexes_bulk_load where OWNER = ' || '''' || i.owner || '''' || ' AND ' || 'TABLE_NAME = ' || '''' || i.TABLE_NAME || '''');
        execute immediate 'Delete from dropped_indexes_bulk_load where OWNER = ' || '''' || i.owner || '''' || ' AND ' || 'TABLE_NAME = ' || '''' || i.TABLE_NAME || '''';

    end loop;
END;
    
END;

/
