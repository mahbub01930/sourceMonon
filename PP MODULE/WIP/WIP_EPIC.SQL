--Feature: WIP Process Finish

--WIP PRODUCT LIST-LEFT PANEL-LANDING MODE---1ST API

API TYPE : GET
API NAME : api/pp/get-wip-product-list

Response Fields :  BATCH_ID, BATCH_NO, PROD_ID, PROD_NAME, BATCH_SIZE, SIZE_UOM, SIZE_UOM_NAME, BATCH_START_DATE, PROD_LOCATION_ID, 
                   PROD_LOCATION_NAME, PROD_LINE_ID, PLANT_ID, PLANT_NAME, PRODUCTION_LINE_ID, PRODUCTION_LINE_NAME
                     
	  
Operational Fields: BATCH_ID, BATCH_NO, PROD_ID, PROD_NAME, BATCH_SIZE, SIZE_UOM, SIZE_UOM_NAME, BATCH_START_DATE, PROD_LOCATION_ID, 
                    PROD_LOCATION_NAME, PROD_LINE_ID, PLANT_ID, PLANT_NAME, PRODUCTION_LINE_ID, PRODUCTION_LINE_NAME        
                     
         
PARAMETER  :        pSBU_ID

Table Name:   	    JERP_PP_UTIL.FD_GET_WIP_PRODUCT_LIST (pSBU_ID NUMBER)

			  
Relation : 	  	
                
			  
Filter by:  

QUERY : 

SELECT JERP_PP_UTIL.FD_GET_WIP_PRODUCT_LIST(:pSBU_ID) FROM DUAL

FD_GET_WIP_PRODUCT_LIST
-------------------------------------------------

-------BATCH-PRODUCT WISE PROCESS-SUB-PROCESS LIST- SEQUENCE WISE-----2ND API

API TYPE : GET
API NAME : api/pp/get-wip-process-sub-process-list/{pPROD_ID}/{pBATCH_ID}

Response Fields :  BATCH_ID, BATCH_NO, PROD_ID, PROD_NAME, PROCESS_ID, PROCESS_NAME, SUB_PROCESS_ID, SUB_PROCESS_NAME, PROCESS_SEQUENCE, PROCESS_STATUS, IS_COMPLETED, IS_SKIPPED
                     
	  
Operational Fields: ID AS BATCH_ID, BATCH_NO, PROD_ID, PROD_NAME, PROCESS_ID, PROCESS_NAME, SUB_PROCESS_ID, SUB_PROCESS_NAME, PROCESS_SEQUENCE, PROCESS_STATUS, IS_COMPLETED, IS_SKIPPED        
                     
         
PARAMETER  :        pPROD_ID  (COME FROM 1ST API)
                    pBATCH_ID (COME FROM 1ST API)

Table Name:   	    JERP_PP_UTIL.FD_GET_WIP_PROCESS_SUB_PROCESS_LIST  (pPROD_ID NUMBER, pBATCH_ID NUMBER) 

Relation : 	  	
                
Filter by:  

QUERY : 

SELECT JERP_PP_UTIL.FD_GET_WIP_PROCESS_SUB_PROCESS_LIST(183, 11678) PROCESS_DT FROM DUAL;

SELECT FD_GET_WIP_PROCESS_SUB_PROCESS_LIST(183, 11678) PROCESS_DT FROM DUAL;


-------------------------------------------------------------------

--------3RD API--------

API TYPE : GET
API NAME : api/pp/get-wip-opt-and-machine-list/{pBATCH_ID}/{pPROCESS_ID}/{pSUB_PROCESS_ID}

Response Fields :  PERSON_ID, EMP_ID, EMP_NAME, DESIG_NAME, ROOM_ID, ROOM_NAME, MACHINE_ID, MACHINE_NAME, STD_TIME, START_TIME, END_TIME
                     
	  
Operational Fields: PERSON_ID, EMP_ID, EMP_NAME, DESIG_NAME, ROOM_ID, ROOM_NAME, MACHINE_ID, MACHINE_NAME, STD_TIME, START_TIME, END_TIME        
                     
         
PARAMETER  :        pBATCH_ID           (COME FROM 2ND API)
                    pPROCESS_ID         (COME FROM 2ND API)
                    pSUB_PROCESS_ID     (COME FROM 2ND API)

Table Name:   	    JERP_PP_UTIL.FD_GET_WIP_OPERATOR_AND_MACHINE_LIST  (pBATCH_ID NUMBER,pPROCESS_ID NUMBER,pSUB_PROCESS_ID NUMBER DEFAULT NULL, pWIP_PROCESS_ID NUMBER DEFAULT NULL)

Relation : 	  	
                
Filter by:  

QUERY : 

SELECT JERP_PP_UTIL.FD_GET_WIP_OPERATOR_AND_MACHINE_LIST  (:pBATCH_ID ,:pPROCESS_ID,:pSUB_PROCESS_ID,:pWIP_PROCESS_ID ) FROM DUAL --10605--10305--10307

SELECT FD_GET_WIP_OPERATOR_AND_MACHINE_LIST  (:pBATCH_ID ,:pPROCESS_ID,:pSUB_PROCESS_ID,:pWIP_PROCESS_ID,:pWIP_PROCESS_ID ) FROM DUAL --11663--10304--,10470

--------------------BULK SFG AND FG PRODUCT LIST--------------
---------4TH API--------

API TYPE : GET
API NAME : api/pp/get-bulk-sfg-fg-prod-list/{pMST_PROD_ID}

Response Fields :  ID, PARENT, PROD_TYPE, PROD_CAT, PROD_GROUP, PROD_NAME, PROD_CODE, COM_PACK_SIZE, COM_UOM, ELEMENT_NAME, PROD_TYPE_DESC
                     
	  
Operational Fields: ID, PARENT, PROD_TYPE, PROD_CAT, PROD_GROUP, PROD_NAME, PROD_CODE, COM_PACK_SIZE, COM_UOM, ELEMENT_NAME, PROD_TYPE_DESC        
                     
         
PARAMETER  :        pSBU_ID             (user auth.)
                    pMST_PROD_ID        (COME FROM 1ST API PROD_ID)

Table Name:   	    JERP_PP_UTIL.FD_GET_BULK_SFG_FG_PRODUCT_LIST(pSBU_ID NUMBER,pMST_PROD_ID NUMBER) 

Relation : 	  	
                
Filter by:  

QUERY : 

SELECT JERP_PP_UTIL.FD_GET_BULK_SFG_FG_PRODUCT_LIST(:pSBU_ID ,:pMST_PROD_ID ) FROM DUAL

FD_GET_BULK_SFG_FG_PRODUCT_LIST

--------------------WIP_PROCESS_CONTROLLER_DATA--------------
---------5TH API--------

API TYPE : GET
API NAME : api/pp/get-wip-process-conttroller-data/{pWIP_PROCESS_ID}

Response Fields :  ID, TIMING_ACTION, TIMING_ACTION_NAME, PROCESS_DATE, START_TIME, END_TIME, TOTAL_TIME_CONS, REMARKS, CREATED_BY, CREATED_NAME
                     
	  
Operational Fields: ID, TIMING_ACTION, TIMING_ACTION_NAME, PROCESS_DATE, START_TIME, END_TIME, TOTAL_TIME_CONS, REMARKS, CREATED_BY, CREATED_NAME        
                     
         
PARAMETER  :        pWIP_PROCESS_ID        (COME FROM 2ND API WIP_PROCESS_ID )

Table Name:   	    JERP_PP_UTIL.FD_GET_WIP_PROCESS_CONTROLLER_DATA  (pWIP_PROCESS_ID  NUMBER)

Relation : 	  	
                
Filter by:  

QUERY : 

SELECT JERP_PP_UTIL.FD_GET_WIP_PROCESS_CONTROLLER_DATA  (:pWIP_PROCESS_ID  ) FROM DUAL; --10151

--------------------FWIP_SAMPLING_DATA--------------
---------6TH API--------

API TYPE : GET
API NAME : api/pp/get-wip-sampling-data/{pWIP_PROCESS_ID}

Response Fields :  ID, WIP_PROCESS_ID, SL_NO, PROD_ID, PROD_NAME, ITEM_NAME, SAMPLE_QTY, SAMPLE_UOM, SAMPLE_UOM_NAME, 
                   SAMPLING_PURPOSE, SAMPLING_PURPOSE_NAME, TESTING_DEPARTMENT, TESTING_DEPARTMENT_NAME, SAMPLING_STAGE, 
                   SAMPLING_STAGE_NAME, INSTRUCTIONS, SAMPLING_TIME, SAMPLE_BY,LAB_CONTROL_CODE,QC_STATUS_NAME
                     
	  
Operational Fields: ID, WIP_PROCESS_ID, SL_NO, PROD_ID, PROD_NAME, ITEM_NAME, SAMPLE_QTY, SAMPLE_UOM, SAMPLE_UOM_NAME, 
                   SAMPLING_PURPOSE, SAMPLING_PURPOSE_NAME, TESTING_DEPARTMENT, TESTING_DEPARTMENT_NAME, SAMPLING_STAGE, 
                   SAMPLING_STAGE_NAME, INSTRUCTIONS, SAMPLING_TIME, SAMPLE_BY, QC_TEST_MST_ID, QC_STATUS, LAB_CONTROL_ID,LAB_CONTROL_CODE,QC_STATUS_NAME        
                     
         
PARAMETER  :        pWIP_PROCESS_ID        (COME FROM 2ND API WIP_PROCESS_ID )

Table Name:   	    JERP_PP_UTIL.FD_GET_WIP_SAMPLING_DATA  (pWIP_PROCESS_ID NUMBER )

Relation : 	  	
                
Filter by:  

QUERY : 

SELECT JERP_PP_UTIL.FD_GET_WIP_SAMPLING_DATA  (:pWIP_PROCESS_ID  ) FROM DUAL; --10120

FD_GET_WIP_SAMPLING_DATA
--------------------QC_IPQC_TEST_DATA--------------
---------7TH API--------

API TYPE : GET
API NAME : api/pp/get-wip-qc-ipqc-test-data/{pWIP_PROCESS_ID}

Response Fields :  TEST_SL_NO, TEST_ID, TEST_NAME, SPECIFICATION, TEST_RESULT_VALUE, PARENT_TEST_ID, TEST_STATUS, QC_IPQC_STATUS_NAME
                     
	  
Operational Fields:  TEST_SL_NO, TEST_ID, TEST_NAME, SPECIFICATION, TEST_RESULT_VALUE, PARENT_TEST_ID, TEST_STATUS, QC_IPQC_STATUS_NAME      
                     
         
PARAMETER  :        pWIP_PROCESS_ID        (COME FROM 2ND API WIP_PROCESS_ID )

Table Name:   	    JERP_PP_UTIL.FD_GET_WIP_QC_IPQC_TEST_DATA  (pWIP_PROCESS_ID NUMBER )

Relation : 	  	

Filter by:  

QUERY : 

SELECT JERP_PP_UTIL.FD_GET_WIP_QC_IPQC_TEST_DATA (:PWIP_PROCESS_ID) FROM DUAL --10120

--------------------QC_IPQC_TEST_DATA--------------
---------8TH API--------

API TYPE : GET
API NAME : api/pp/get-wip-assign-opt-machine-list/{pWIP_PROCESS_ID}

Response Fields :  ID, EMP_ID, PERSON_ID, EMP_NAME, DESIG_NAME, PROCESS_DATE, START_TIME, END_TIME, TOTAL_TIME_CONS, REMARKS,MACHINE_ID,MACHINE_NAME
	  
Operational Fields:  ID, EMP_ID, PERSON_ID, EMP_NAME, DESIG_NAME, PROCESS_DATE, START_TIME, END_TIME, TOTAL_TIME_CONS, REMARKS,MACHINE_ID,MACHINE_NAME
         
PARAMETER  :        pWIP_PROCESS_ID        (COME FROM 2ND API WIP_PROCESS_ID )

Table Name:   	    JERP_PP_UTIL.FD_GET_WIP_ASSIGEND_OPERATOR_MACHINE_LIST  (pWIP_PROCESS_ID NUMBER )

Relation : 	  	

Filter by:  

QUERY : 

SELECT JERP_PP_UTIL.FD_GET_WIP_ASSIGEND_OPERATOR_MACHINE_LIST (:PWIP_PROCESS_ID) FROM DUAL --10113

Feature: WIP Process Finish


SELECT FD_GET_WIP_ASSIGEND_OPERATOR_MACHINE_LIST  (:pWIP_PROCESS_ID ) FROM DUAL --10113

--------------------YIELD RECONCILIATION--------------
---------9TH API--------

API TYPE : GET
API NAME : api/pp/get-wip-yield-recon-data/{pPROD_ID}/{pPROCESS_ID}/{pWIP_PROCESS_ID}

Response Fields :    SL_NO, PARAM_PREFIX, PARAM_NAME, PARAM_VALUE,  ELEMENT_NAME
	  
Operational Fields:  MAT_PROD_ID, PROCESS_ID, SUB_PROCESS_ID, SL_NO, PARAM_PREFIX, PARAM_NAME, PARAM_VALUE, PARAM_UOM, ELEMENT_NAME
         
PARAMETER  :        pPROD_ID        (COME FROM 2ND API PROD_ID  )
                    pPROCESS_ID     (COME 2ND API PROCESS_ID)
                    pSUB_PROCESS_ID     (COME 2ND API PROCESS_ID)
                    pWIP_PROCESS_ID (COME 2ND API PROCESS_ID)
                    pSBU_ID         (user auth.)
                    

Table Name:   	    JERP_PP_UTIL.FD_GET_WIP_YIELD_RECONCILIATION_DATA  (pPROD_ID NUMBER,pPROCESS_ID NUMBER,pSUB_PROCESS_ID NUMBER,pSBU_ID NUMBER,pWIP_PROCESS_ID NUMBER)

Relation : 	  	

Filter by:  

QUERY : 

SELECT JERP_PP_UTIL.FD_GET_WIP_YIELD_RECONCILIATION_DATA (:pPROD_ID,:pPROCESS_ID,:pSUB_PROCESS_ID,:pSBU_ID,:pWIP_PROCESS_ID) FROM DUAL --183,10305,10309,2,10636

Feature: WIP Process Finish


SELECT FD_GET_WIP_YIELD_RECONCILIATION_DATA (:pPROD_ID,:pPROCESS_ID,:pSUB_PROCESS_ID,:pSBU_ID,:pWIP_PROCESS_ID) FROM DUAL --183,10305,10309,2,10636

--------------------VIEW PROCESS INPUT DATA --------------
---------10TH API--------

API TYPE : GET
API NAME : api/pp/get-wip-process-input-data/{pWIP_PROCESS_ID}

Response Fields :  SL_NO, PROD_ID, ITEM, QTY, UOM, UOM_NAME
	  
Operational Fields:  SL_NO, PROD_ID, ITEM, QTY, UOM, UOM_NAME
         
PARAMETER  :        pWIP_PROCESS_ID        (COME FROM 2ND API WIP_PROCESS_ID )

Table Name:   	    JERP_PP_UTIL.FD_GET_WIP_PROCESS_INPUT_DATA  (pWIP_PROCESS_ID NUMBER)

Relation : 	  	

Filter by:  

QUERY : 

SELECT JERP_PP_UTIL.FD_GET_WIP_PROCESS_INPUT_DATA (:PWIP_PROCESS_ID) FROM DUAL --10113

Feature: WIP Process Finish


SELECT FD_GET_WIP_PROCESS_INPUT_DATA  (:pWIP_PROCESS_ID ) FROM DUAL --10113

--------------------VIEW PROCESS OUTPUT DATA --------------
---------11TH API--------

API TYPE : GET
API NAME : api/pp/get-wip-process-output-data/{pWIP_PROCESS_ID}

Response Fields :   SL_NO, PROD_ID, ITEM_NAME, OUTPUT_QTY, OUTPUT_UOM,OUTPUT_UOM_NAME
	  
Operational Fields:  ID, WIP_PROCESS_ID, SL_NO, PROD_ID, ITEM_NAME, OUTPUT_QTY, OUTPUT_UOM,OUTPUT_UOM_NAME
         
PARAMETER  :        pWIP_PROCESS_ID        (COME FROM 2ND API WIP_PROCESS_ID )

Table Name:   	    JERP_PP_UTIL.FD_GET_WIP_PROCESS_OUTPUT_DATA  (pWIP_PROCESS_ID NUMBER)

Relation : 	  	

Filter by:  

QUERY : 

SELECT JERP_PP_UTIL.FD_GET_WIP_PROCESS_OUTPUT_DATA (:PWIP_PROCESS_ID) FROM DUAL --10106

Feature: WIP Process Finish


SELECT FD_GET_WIP_PROCESS_OUTPUT_DATA  (:pWIP_PROCESS_ID ) FROM DUAL --10106

--------------------VIEW YIELD RECONCILIATION DATA --------------
---------11TH API--------

API TYPE : GET
API NAME : api/pp/get-wip-view-yield-recon-data/{pWIP_PROCESS_ID}

Response Fields :   ID, WIP_PROCESS_ID, SL_NO, PREFIX, RECORD_PARAM, RECORD_FORMULA, YIELD_VALUE, YIELD_UOM, ELEMENT_NAME
	  
Operational Fields:  ID, WIP_PROCESS_ID, SL_NO, PREFIX, RECORD_PARAM, RECORD_FORMULA, YIELD_VALUE, YIELD_UOM, ELEMENT_NAME
         
PARAMETER  :        pWIP_PROCESS_ID        (COME FROM 2ND API WIP_PROCESS_ID )

Table Name:   	    JERP_PP_UTIL.FD_GET_WIP_VIEW_YIELD_RECON_DATA  (pWIP_PROCESS_ID NUMBER)

Relation : 	  	

Filter by:  

QUERY : 

SELECT JERP_PP_UTIL.FD_GET_WIP_VIEW_YIELD_RECON_DATA (:PWIP_PROCESS_ID) FROM DUAL --10114

Feature: WIP Process Finish


SELECT FD_GET_WIP_VIEW_YIELD_RECON_DATA  (:pWIP_PROCESS_ID ) FROM DUAL --10114

-----------------sample id generate-----------------------------------

API TYPE : GET
API NAME : api/pp/get-wip-sample_id

Response Fields :  SAMPLE_ID
                     
	  
Operational Fields: SAMPLE_ID        

PARAMETER  :        pSBU_ID             (user auth.)
                    

Table Name:   	    JERP_PP_UTIL.FD_GET_SAMPLE_ID_GENERATE(pSBU_ID NUMBER) 

Relation : 	  	
                
Filter by:  

QUERY : 
   
SELECT JERP_PP_UTIL.FD_GET_SAMPLE_ID_GENERATE(:pSBU_ID) SAMPLE_ID FROM DUAL --2

SELECT FD_GET_SAMPLE_ID_GENERATE(:pSBU_ID) SAMPLE_ID FROM DUAL --2

-------------------POST API-------------------------

API TYPE : POST
API NAME : api/pp/create-wip-process-finishing

JERP_PP_UTIL.PD_WIP_PROCESS_FINISHING Creation PROCEDURE

JERP_PP_UTIL.PD_WIP_PROCESS_FINISHING (pWIP_MST_ID    IN  OUT  NUMBER,
                                      pWIP_MST       IN  CLOB,
                                      pWIP_PROCESS   IN  CLOB,
                                      pSBU_ID        IN  NUMBER,
                                      pUSER_ID       IN  NUMBER,
                                      pCONTAINER_NO  IN  CLOB,
                                      pSTATUS        OUT CLOB
                                           )

Parameters :

A. pWIP_MST_ID          IN OUT NUMBER,
CREATE/INSERT MODE : pWIP_MST_ID  WILL BE NULL
UPDATE MODE :  pWIP_MST_ID WILL COME FROM FRONT-END

B. pWIP_MST (JSON OBJECT)

Header = wip_mst

OBJECT

batch_id                NUMBER; 
prod_id                 NUMBER;
total_process_no        NUMBER; 


C. pWIP_PROCESS (JSON Array)

Header = wip_process

OBJECT

id                      NUMBER;
wip_stage_id            NUMBER; 
process_id              NUMBER;
sub_process_id          NUMBER; 
is_completed            STRING;
is_skipped              STRING; 
prod_line_id            NUMBER;

OBJECT
'wip_proc_time' 

id                  NUMBER;  
timing_action       NUMBER;  
process_date        STRING;
start_time          STRING;
end_time            STRING;
total_time_cons     STRING;
remarks             STRING;


D. pSBU_ID

pSBU_ID number not null auth.user_id

E. pUSER_ID (Number)

pUSER_ID number not null auth.user_id

F. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.


------------CALLING------------

DECLARE
    vSTATUS CLOB;
    vMst number:=null; 
    vWIP_MST CLOB := '{ "wip_mst":
                                  {
                                     "batch_id":11665,
                                     "prod_id":183,
                                     "total_process_no":15
                                  }
                                }';
                                
    vWIP_PROCESS CLOB :=  '{ "wip_process":[
                                       {
                                        "id" : null,
                                        "wip_stage_id" : 7611,
                                        "process_id": 10305, 
                                        "sub_process_id": 10307, 
                                        "is_completed": "N", 
                                        "is_skipped": "N",
                                        "prod_line_id": 10185,
                                        "wip_proc_time": [
                                                          /*{
                                                              "id": null,
                                                              "timing_action": 1212,
                                                              "process_date": "28-JAN-2023",
                                                              "start_time": "28-JAN-2023 8:26:12 PM",
                                                              "end_time": null,
                                                              "total_time_cons": "6.02H",
                                                              "remarks": "remarks"
                                                          }*/
                                                        ],
                                        "wip_sample" : [
                                                        {
                                                          "id" : null,
                                                          "sl_no" : 10001,
                                                          "prod_id" : 5148,
                                                          "item_name" : null,
                                                          "sample_qty" : 2,
                                                          "sample_uom" : 532,
                                                          "sampling_purpose" : 7852,
                                                          "testing_department" : 783,
                                                          "sampling_stage" : 7891,
                                                          "instructions" : "test",
                                                          "sampling_time" : "02-FEB-2023 10:18:12",
                                                          "sample_by" : 1
                                                        }
                                                       ]                
                                        }
                                        ]
                                }';          
BEGIN
    JERP_PP_UTIL.PD_WIP_PROCESS_FINISHING(pWIP_MST_ID    =>vMst,
                                       pWIP_MST       =>vWIP_MST,
                                       pWIP_PROCESS       =>vWIP_PROCESS,
                                       pSBU_ID  =>2,
                                       pUSER_ID        =>1,
                                       pSTATUS         => vSTATUS
                                    );
DBMS_OUTPUT.PUT_LINE(vSTATUS);

END;