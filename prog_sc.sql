--1. variable declare

select 'v'||COLUMN_NAME||'         '||DATA_TYPE||decode(DATA_TYPE,'VARCHAR2','('||DATA_LENGTH||')')||';' from ALL_TAB_COLUMNS
where owner ='JERP_ADM'
and table_name='PP_WIP_PROC_YIELD'
ORDER BY COLUMN_ID;

---2
select 'v'||COLUMN_NAME||'        := '||decode(DATA_TYPE,'DATE','TO_DATE(','TIMESTAMP(6)','TO_DATE(')|| :vOBJECT_NAME||'.'||decode(DATA_TYPE,'VARCHAR2','GET_STRING','NUMBER','GET_NUMBER','DATE','GET_STRING','TIMESTAMP(6)','GET_STRING')||
'('||lower(''''||COLUMN_NAME||'''')||')'||decode(DATA_TYPE,'DATE',', ''dd-mm-rrrr'')','TIMESTAMP(6)',', ''dd-mm-rrrr hh24:mi:ss'')')||';' from ALL_TAB_COLUMNS
where owner ='JERP_ADM'
and table_name='PP_WIP_PROC_YIELD'
ORDER BY COLUMN_ID;

--TO_DATE(vAQDDTL_OBJ.GET_STRING('receive_date'),'dd-mm-rrrr');  
---3&4-----
select 'INSERT INTO '||:TAB ||'('|| LISTAGG(COLUMN_NAME||',') WITHIN GROUP(ORDER BY COLUMN_ID)||')'||CHR(10)||
'VALUES ('||LISTAGG('v'||COLUMN_NAME||',') WITHIN GROUP(ORDER BY COLUMN_ID)||');'
from ALL_TAB_COLUMNS
where owner ='JERP_ADM'
and table_name='PP_WIP_PROC_YIELD';

---3--
select LISTAGG(COLUMN_NAME||',') WITHIN GROUP(ORDER BY COLUMN_ID)
from ALL_TAB_COLUMNS
where owner ='JERP_ADM'
and table_name='PP_PROD_LINE_ALLO';


--4
select LISTAGG('v'||COLUMN_NAME||',') WITHIN GROUP(ORDER BY COLUMN_ID) from ALL_TAB_COLUMNS
where owner ='JERP_ADM'
and table_name='PP_QC_PARAM';

----5 FOR UPDATE


select COLUMN_NAME||' = '||' v'||COLUMN_NAME||',' from ALL_TAB_COLUMNS
where owner ='JERP_ADM'
and table_name='PP_QC_IPQC_TEST'
ORDER BY COLUMN_ID;


----for epic declare

select decode(DATA_TYPE,'VARCHAR2','GET_STRING','NUMBER','GET_NUMBER','DATE','GET_STRING')||
'('||lower(''''||COLUMN_NAME||'''')||')'||decode(DATA_TYPE,'DATE',', ''dd-mm-rrrr'')')||';' from ALL_TAB_COLUMNS
where owner ='JERP_ADM'
and table_name='PP_QC_SAMPLING'
ORDER BY COLUMN_ID;;