7. CREATE-UPDATE, DRAFT, SUBMIT - PRODUCT-PROCESS
URL = http://203.188.245.58:8889/api/pp/crud-prod-process
Method = Post

Procedure call for - Product-Process  Create, Update, Draft & Submit

 JERP_ADM.PP_PRODUCT_PROCESS(
                                pPROD_PROCE_TYPE     IN CLOB,
                                pPROCE_TYPE_PROCE    IN CLOB,
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
'pro_typ_proc_atb' (new object for 'pp_proce_type_proce')
id              NUMBER;
atab_id         NUMBER; 
data_value      NUMBER;
'pp_proce_machine' (new object for 'pp_proce_type_proce')
id              NUMBER;
machine_id      NUMBER;
process_id      NUMBER;
checked_mch     NUMBER;
'pro_macin_atb' (new object for 'pp_proce_machine')
id              NUMBER;
atab_id         NUMBER; 
data_value      NUMBER;


C. pUSER_ID (Number)

pUSER_ID number not null auth.user_id

D. pIS_SUBMITTED (Number)

pIS_SUBMITTED number not null (0 for draft, 1 for submit) 

E. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.


---CALLL

DECLARE
    vSTATUS CLOB;
    --vMst number:=null; 
    vPROD_PRO_TYP CLOB := '{ "pp_prod_proce_type":[
                                  {
                                     "id":null,
                                     "sbu_id":2,
                                     "prod_id":1041,
                                     "batch_category":7023,
                                     "process_type":7172,
                                     "checked_mst":1
                                  }
                                ]
                                }';
                                
    vPRO_TYP_PROC CLOB :=  '{ "pp_proce_type_proce":[
                                  {
                                     "id":null,
                                     "process_id":10165,
                                     "sub_process_id":10168,
                                     "process_sequence":3,
                                     "is_machine_group":"Y",
                                     "process_type":7172,
                                     "checked_dtl":1,
                                     "wip_stage_id":7611,
                                     "ipqc_required":"Y",
                                     "qc_required":"Y",
                                     "reconciliation_required":"Y",
                                     "doc_id":2,
                                     "pro_typ_proc_atb":[
                                                         {
                                                            "id":null,
                                                            "atab_id":48,
                                                            "data_value":12
                                                         },
                                                         {
                                                             "id":null,
                                                             "atab_id":49,
                                                             "data_value":10
                                                         }
                                                        ],
                                    "pp_proce_machine":[
                                                        {
                                                         "id":null,
                                                         "machine_id":1003,
                                                         "process_id":10165,
                                                         "checked_mch":1,
                                                         "pro_macin_atb":[
                                                                           {
                                                                             "id":null,
                                                                             "atab_id":52,
                                                                             "data_value":10
                                                                          },
                                                                          {
                                                                             "id":null,
                                                                             "atab_id":53,
                                                                             "data_value":12
                                                                          },
                                                                           {
                                                                             "id":null,
                                                                             "atab_id":54,
                                                                             "data_value":12
                                                                          }
                                                                         ]
                                                        },
                                                        {
                                                         "id":null,
                                                         "machine_id":1004,
                                                         "process_id":10165,
                                                         "checked_mch":1,
                                                         "pro_macin_atb":[
                                                                           {
                                                                             "id":null,
                                                                             "atab_id":52,
                                                                             "data_value":10
                                                                          },
                                                                          {
                                                                             "id":null,
                                                                             "atab_id":53,
                                                                             "data_value":12
                                                                          }
                                                                         ]
                                                        }
                                                       ]                    
                                  }
                                ] 
                                }';          
BEGIN
    JERP_ADM.PP_PRODUCT_PROCESS(pPROD_PROCE_TYPE       =>vPROD_PRO_TYP,
                                   pPROCE_TYPE_PROCE       =>vPRO_TYP_PROC,
                                   pUSER_ID        =>1,
                                   pIS_SUBMITTED   =>0,
                                   pSTATUS         => vSTATUS
                                );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;