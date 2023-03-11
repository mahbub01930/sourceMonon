


-------------PRODUCT_PROCESS_MODIFICATION-----------------------------------


--TOTAL HOUR + ICON -1st API
API TYPE : GET
API NAME : api/pp/get-process-time-attribute

Response Fields :  
                    AT.ATTRIBUTE_NAME, AT.DATA_TYPE, ATT.DISPLAY_NAME
	  
Operational Fields: 
                AT.ID, AT.ATTRIBUTE_NAME, AT.DATA_TYPE, AC.ELEMENT_NAME, ATT.TABLE_NAME, ATT.DISPLAY_NAME, ATT.ID 				ATTRIBUTE_ID, ATT.SORT_ORDER
         
PARAMETER  : 

Table Name:   	ADM_ATTRIBUTES 	   =AT
                ADM_CODE_ELEMENTS  =AC
                ADM_ATTRIBUTES_TAB =ATT


Relation : 	  	AT.DATA_TYPE=AC.ID
			AT.ID=ATT.ATTRIBUTE_ID
    
Filter by:  WHERE ATT.TABLE_NAME='PP_PROC_TYPE_PROCESS'


QUERY : 

SELECT AT.ID, AT.ATTRIBUTE_NAME, AT.DATA_TYPE, AC.ELEMENT_NAME, ATT.TABLE_NAME, ATT.DISPLAY_NAME, ATT.ID ATTRIBUTE_ID, ATT.SORT_ORDER
FROM ADM_ATTRIBUTES AT JOIN ADM_CODE_ELEMENTS AC ON AT.DATA_TYPE=AC.ID 
JOIN ADM_ATTRIBUTES_TAB ATT ON AT.ID=ATT.ATTRIBUTE_ID
WHERE ATT.TABLE_NAME='PP_PROC_TYPE_PROCESS'

==================================================


--AFTER SELECTING MACHINE DATA FROM MODAL -2nd API
API TYPE : GET
API NAME : api/pp/get-machine-time-attribute

Response Fields :  
                    AT.ATTRIBUTE_NAME, AT.DATA_TYPE, ATT.DISPLAY_NAME
	  
Operational Fields: 
                AT.ID, AT.ATTRIBUTE_NAME, AT.DATA_TYPE, AC.ELEMENT_NAME, ATT.TABLE_NAME, ATT.DISPLAY_NAME, ATT.ID 				ATTRIBUTE_ID, ATT.SORT_ORDER
         
PARAMETER  : 

Table Name:   	ADM_ATTRIBUTES 	   =AT
                ADM_CODE_ELEMENTS  =AC
                ADM_ATTRIBUTES_TAB =ATT


Relation : 	  	AT.DATA_TYPE=AC.ID
			AT.ID=ATT.ATTRIBUTE_ID
    
Filter by:  WHERE ATT.TABLE_NAME='PP_PROCESS_MACHINE'


QUERY : 

SELECT AT.ID, AT.ATTRIBUTE_NAME, AT.DATA_TYPE, AC.ELEMENT_NAME, ATT.TABLE_NAME, ATT.DISPLAY_NAME, ATT.ID ATTRIBUTE_ID, ATT.SORT_ORDER
FROM ADM_ATTRIBUTES AT JOIN ADM_CODE_ELEMENTS AC ON AT.DATA_TYPE=AC.ID 
JOIN ADM_ATTRIBUTES_TAB ATT ON AT.ID=ATT.ATTRIBUTE_ID
WHERE ATT.TABLE_NAME='PP_PROCESS_MACHINE'


=======================================================================


--VIEW PROCESS TIME TOOL TIP -3rd API
API TYPE : GET
API NAME : api/pp/get-process-time-value/{pDATA_ROW_ID}

Response Fields :  
                    ATT.ID ATTRIBUTE_ID, AT.ATTRIBUTE_NAME, ATT.DISPLAY_NAME, ATD.DATA_VALUE, ATD.ID
	  
Operational Fields: 
                ATT.ID ATTRIBUTE_ID, AT.ATTRIBUTE_NAME, ATT.DISPLAY_NAME, ATD.DATA_VALUE, ATD.ID
         
PARAMETER  : 	ATD.DATA_ROW_ID  = :pDATA_ROW_ID  (COME FROM 1ST API-->ATD.DATA_ROW_ID)  --10149

Table Name:   	ADM_ATTRIBUTES_TAB      =ATT
                ADM_ATTRIBUTES          =AT
                ADM_ATTRIBUTES_TAB_DATA =ATD


Relation : 	  	ATT.ATTRIBUTE_ID=AT.ID
			ATT.ID=ATD.ATAB_ID
    
Filter by:  WHERE ATT.TABLE_NAME='PP_PROC_TYPE_PROCESS' 


QUERY : 

SELECT ATT.ID ATTRIBUTE_ID, AT.ATTRIBUTE_NAME, ATT.DISPLAY_NAME, ATD.DATA_VALUE, ATD.ID
FROM ADM_ATTRIBUTES_TAB ATT
JOIN ADM_ATTRIBUTES AT ON ATT.ATTRIBUTE_ID=AT.ID
JOIN ADM_ATTRIBUTES_TAB_DATA ATD ON ATT.ID=ATD.ATAB_ID
WHERE ATT.TABLE_NAME='PP_PROC_TYPE_PROCESS' AND ATD.DATA_ROW_ID=:pDATA_ROW_ID  ---10149


---------------------------------------------------------
--VIEW MACHINE TIME SELECTION -4th API
API TYPE : GET
API NAME : api/pp/get-machine-time-value/{pDATA_ROW_ID}

Response Fields :  
                    ATT.ID ATTRIBUTE_ID, AT.ATTRIBUTE_NAME, ATT.DISPLAY_NAME, ATD.DATA_VALUE, ATD.ID
	  
Operational Fields: 
                ATT.ID ATTRIBUTE_ID, AT.ATTRIBUTE_NAME, ATT.DISPLAY_NAME, ATD.DATA_VALUE, ATD.ID
         
PARAMETER  : 	ATD.DATA_ROW_ID  = :pDATA_ROW_ID  (COME FROM 1ST API-->ATD.DATA_ROW_ID)  --10149

Table Name:   	ADM_ATTRIBUTES_TAB      =ATT
                ADM_ATTRIBUTES          =AT
                ADM_ATTRIBUTES_TAB_DATA =ATD


Relation : 	  	ATT.ATTRIBUTE_ID=AT.ID
			ATT.ID=ATD.ATAB_ID
    
Filter by:  WHERE ATT.TABLE_NAME='PP_PROCESS_MACHINE' 


QUERY : 


SELECT ATT.ID ATTRIBUTE_ID, AT.ATTRIBUTE_NAME, ATT.DISPLAY_NAME, ATD.DATA_VALUE, ATD.ID
FROM ADM_ATTRIBUTES_TAB ATT
JOIN ADM_ATTRIBUTES AT ON ATT.ATTRIBUTE_ID=AT.ID
JOIN ADM_ATTRIBUTES_TAB_DATA ATD ON ATT.ID=ATD.ATAB_ID
WHERE ATT.TABLE_NAME='PP_PROCESS_MACHINE' AND ATD.DATA_ROW_ID=:pDATA_ROW_ID  --10149


---------------------------------------------------------------






7. CREATE-UPDATE, DRAFT, SUBMIT - PRODUCT-PROCESS
URL = http://203.188.245.58:8889/api/pp/crud-prod-process
Method = Post

Procedure call for - Product-Process  Create, Update, Draft & Submit

 JERP_PP_UTIL.PP_PRODUCT_PROCESS(
                                pPROD_PROCE_TYPE     IN CLOB,
                                pPROCE_TYPE_PROCE    IN CLOB,
                                pPROCE_MACHINE       IN CLOB,
                                pPRO_TYP_PROC_ATB    IN CLOB,
                                pPRO_MACIN_ATB       IN CLOB,
                                pUSER_ID             IN NUMBER,
                                pIS_SUBMITTED        IN NUMBER,
                                pSTATUS              OUT CLOB
                            ) 

Parameters :

A. pPROD_PROCE_TYPE (JSON Array)

Header = pp_prod_proce_type

OBJECT

id                          NUMBER;
sbu_id                      NUMBER; (not null)
prod_id                     NUMBER; (not null)
batch_category              NUMBER; (not null)
process_type                NUMBER; (not null)
checked_mst                 NUMBER; 


B. pPROCE_TYPE_PROCE (JSON Array)

Header = pp_proce_type_proce

OBJECT

id                                   NUMBER;
process_id                           NUMBER;  (not null)
sub_process_id                       NUMBER;  (not null)
process_sequence                     NUMBER;  (not null) 
is_machine_group                     NUMBER;   
process_type                         NUMBER; 
checked_dtl                          NUMBER; 
wip_stage_id                         NUMBER; 
ipqc_required                        VARCHAR2 (1 Byte);  -  'Y'  or   'N' 
qc_required                          VARCHAR2 (1 Byte);  -  'Y'  or   'N'
reconciliation_required              VARCHAR2 (1 Byte);   - 'Y'  or   'N'
doc_id                               NUMBER;



C. pPROCE_MACHINE (JSON Array)

Header = pp_proce_machine

OBJECT
 
id                                     NUMBER;  
machine_id                             NUMBER; (not null)
process_id                             NUMBER;
checked_mch                            NUMBER;        
 
D. pPRO_TYP_PROC_ATB (JSON Array)

Header = pro_typ_proc_atb

OBJECT
 
id                                     NUMBER;  
atab_id                                NUMBER; 
data_row_id                            NUMBER; (not null) (PP_PROC_TYPE_PROCESS.ID)
data_value                             NUMBER;

E. pPRO_MACIN_ATB (JSON Array)

Header = pro_macin_atb

OBJECT
 
id                                     NUMBER;  
atab_id                                NUMBER; 
data_row_id                            NUMBER; (not null) (PP_PROCESS_MACHINE.ID)
data_value    

F. pUSER_ID (Number)

pUSER_ID number not null auth.user_id

G. pIS_SUBMITTED (Number)

pIS_SUBMITTED number not null (0 for draft, 1 for submit) 

H. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.

---------------------

calling---

---CALLL

DECLARE
    vSTATUS CLOB;
    --vMst number:=null; 
    vPROD_PRO_TYP CLOB := '{ "pp_prod_proce_type":[
                                  {
                                     "id":null,
                                     "sbu_id":2,
                                     "prod_id":1214,
                                     "batch_category":2,
                                     "process_type":999,
                                     "checked_mst":1
                                  }
                                ]
                                }';
                                
    vPRO_TYP_PROC CLOB :=  '{ "pp_proce_type_proce":[
                                  {
                                     "id":null,
                                     "process_id":888,
                                     "sub_process_id":777,
                                     "process_sequence":11,
                                     "is_machine_group":1,
                                     "process_type":999,
                                     "checked_dtl":1,
                                     "wip_stage_id":11,
                                     "ipqc_required":"Y",
                                     "qc_required":"Y",
                                     "reconciliation_required":"Y",
                                     "doc_id":2
                                  }
                                ] 
                                }';  
        vPROC_MACHIN CLOB := '{ "pp_proce_machine":[
                              {
                                 "id":null,
                                 "machine_id":666,
                                 "process_id":888,
                                 "checked_mch":1
                              }
                            ]
                            }';
                            
        vPRO_TYP_ATB CLOB := '{ "pro_typ_proc_atb":[
                              {
                                 "id":null,
                                 "atab_id":1,
                                 "data_row_id":1,
                                 "data_value":12
                              },
                                    {
                                 "id":null,
                                 "atab_id":2,
                                 "data_row_id":1,
                                 "data_value":10
                              },
                                    {
                                 "id":null,
                                 "atab_id":3,
                                 "data_row_id":1,
                                 "data_value":5
                              }
                            ]
                            }';
                            
        vMACHIN_ATB CLOB := '{ "pro_macin_atb":[
                              {
                                 "id":null,
                                 "atab_id":7,
                                 "data_row_id":2,
                                 "data_value":10
                              },
                                {
                                 "id":null,
                                 "atab_id":8,
                                 "data_row_id":2,
                                 "data_value":12
                              }
                            ]
                            }';
BEGIN
    JERP_PP_UTIL.PP_PRODUCT_PROCESS_MODIFI(pPROD_PROCE_TYPE       =>vPROD_PRO_TYP,
                                   pPROCE_TYPE_PROCE       =>vPRO_TYP_PROC,
                                   pPROCE_MACHINE     =>vPROC_MACHIN,
                                   pPRO_TYP_PROC_ATB  =>vPRO_TYP_ATB,
                                   pPRO_MACIN_ATB  =>vMACHIN_ATB,
                                   pUSER_ID        =>1,
                                   pIS_SUBMITTED   =>0,
                                   pSTATUS         => vSTATUS
                                );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;

------------------