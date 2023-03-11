-------BATCH NO----------
API TYPE : GET
API NAME : api/pp/get-batch-no/{pSBU_ID}/{pPROD_ID}

Response Fields :  BATCH_NO

	  
Operational Fields: BATCH_NO

         
PARAMETER  :       pSBU_ID ,pPROD_ID 

Table Name:   	   FUNCTION JERP_ADM.GET_BATCH_NO_FOR_BATCH_CREATION (pSBU_ID NUMBER,pPROD_ID NUMBER)
 
Relation : 	

Filter by:   

GROUP BY: 

QUERY : 

SELECT JERP_ADM.GET_BATCH_NO_FOR_BATCH_CREATION(:pSBU_ID ,:pPROD_ID ) as batch_no from dual --for test (2,4001)


-------BPR ID----------

API TYPE : GET
API NAME : api/pp/get-bpr-id/{pSBU_ID}

Response Fields :  BPR_ID

Operational Fields: BPR_ID

PARAMETER  :       pSBU_ID  

Table Name:   	   FUNCTION JERP_ADM.GET_BPR_DOC_ID (pSBU_ID NUMBER)
 
Relation : 	

Filter by:   

GROUP BY: 

QUERY : 

SELECT JERP_ADM.GET_BPR_DOC_ID (:pSBU_ID) as BPR_ID from dual --for test (2)

------------------------FG PROD LIST------------------------------------------------------


API TYPE : GET
API NAME : api/pp/get-fg-prod-list/{pSBU_ID}/{pREQ_ID}

Response Fields :  REQ_ID, PROD_ID, PROD_NAME, REQ_NO, PAK_SIZE, REQUIRED_QTY, UOM, DOC_ID 

	  
Operational Fields: REQ_ID, PROD_ID, PROD_NAME, REQ_NO, PAK_SIZE, REQUIRED_QTY, UOM, DOC_ID 

         
PARAMETER  :    PBDM.SBU_ID = :pSBU_ID   
                PBDM.ID = :pREQ_ID

Table Name:   	   PP_BATCH_DOC_PROD = PBDP
                   PP_BATCH_DOC_DTL = PBDD
                   PP_BATCH_DOC_MST = PBDM
                   ADM_PRODUCTS = AP
                   PP_PROD_BATCH_MAP = PPBM

 
Relation : 	PBDD.ID = PBDP.BATCH_DOC_DETAIL_ID
            PBDM.ID = PBDD.DOC_REQ_ID
            AP.ID = PBDP.TRANSFER_PROD_ID
            PPBM.PROD_ID = PBDP.TRANSFER_PROD_ID
            

Filter by:  WHERE PPBM.DOC_TYPE = 10051 AND STATUS = 1 

GROUP BY: 

QUERY : 

SELECT PBDM.ID REQ_ID,PBDP.TRANSFER_PROD_ID AS PROD_ID,AP.PROD_NAME, PBDM.DISPLAY_CODE REQ_NO,NVL(AP.COM_PACK_SIZE,AP.EXP_PACK_SIZE) PAK_SIZE,
      PBDP.REQUIRED_QTY,JERP_ADM.FD_GET_BASE_UOM(PBDP.REQUIRED_UOM ) UOM,PPBM.DOC_ID
FROM PP_BATCH_DOC_PROD PBDP
LEFT JOIN PP_BATCH_DOC_DTL PBDD ON PBDD.ID = PBDP.BATCH_DOC_DETAIL_ID
LEFT JOIN PP_BATCH_DOC_MST PBDM ON PBDM.ID = PBDD.DOC_REQ_ID
LEFT JOIN ADM_PRODUCTS AP ON AP.ID = PBDP.TRANSFER_PROD_ID
LEFT JOIN PP_PRODUCT_BATCH PPB ON PPB.BATCH_DOC_REQ_ID = PBDM.ID AND PBDD.PROD_ID = PPB.PROD_ID
LEFT JOIN PP_PROD_BATCH_MAP PPBM ON PPBM.PROD_ID = PBDP.TRANSFER_PROD_ID AND PBDM.ID=PPBM.BATCH_DOC_REQ_ID AND PPB.ID = PPBM.BATCH_ID
WHERE PBDM.SBU_ID = 2
AND PBDM.ID = 10282
AND PBDD.PROD_ID = 274
AND PPB.ID = 11651
AND NVL(PPBM.DOC_TYPE,10051) = 10051

--------------------------FOR BATCH CREATION-----------------------------------------------------

CREATE-UPDATE BATCH CREATION   (BY BATCH SAVE-UPDATE)-  -- 11th API
API TYPE : POST
API NAME : api/pp/create-update-batch-creation


JERP_ADM.BATCH_CREATION Creation PROCEDURE

JERP_ADM.JERP_PP_UTIL.BATCH_CREATION(
                            pBATCH_CREATE           IN CLOB, 
                            pBATCH_ID               IN OUT NUMBER,    
                            pIS_SUBMITTED           IN NUMBER, --0 not submitted, 1 submitted
                            pAS_FLAG                IN NUMBER  DEFAULT 0, --0 before submitted, 1 after submitted
                            pUSER_ID                IN NUMBER,
                            pSTATUS                 OUT CLOB
                         )


A. pBATCH_CREATE (JSON OBJECT)
Header = batch_create

OBJECT 
     GET_STRING  ('batch_doc_type');  ------ BMR OR BPR OR BOTH
     GET_NUMBER  ('ppb_id');       not null
     GET_NUMBER  ('ppb_prod_id');    not null
     --GET_NUMBER  ('ppb_sort_order');   
     --GET_STRING  ('ppb_status'); 
     GET_NUMBER  ('ppb_sbu_id');       not null
     GET_STRING  ('ppb_batch_create_date')  format => 'dd-mm-rrrr' ; 
     GET_NUMBER  ('ppb_batch_status');  
     GET_NUMBER  ('ppb_bom_id');  
     GET_NUMBER  ('ppb_batch_size');  
     GET_NUMBER  ('ppb_std_qty');   
     GET_NUMBER  ('ppb_std_uom');  
     GET_NUMBER  ('ppb_prod_location_id');  
     GET_NUMBER  ('ppb_bmr_id');  
     GET_NUMBER  ('ppb_bpr_id');   
     GET_NUMBER  ('ppb_batch_type');  
     GET_NUMBER  ('ppb_production_type');  
     GET_NUMBER  ('ppb_batch_category');    
     GET_NUMBER  ('ppb_batch_doc_req_id');   
     GET_STRING  ('ppb_batch_no'); -- (new add)
                 
    -----------  -- ---PP_PROD_BATCH_MAP	 PPBM  VARIABLE DECLARE,  When Updated this object is no need. 
                 
     GET_NUMBER  ('ppbm_id');     not null
     GET_NUMBER  ('ppbm_doc_type');  
     --GET_NUMBER  ('ppbm_sort_order');
     GET_NUMBER  ('ppbm_prod_id');
     --GET_STRING  ('ppbm_status');    
     
     
     
 
B. pBATCH_ID    IN OUT NUMBER,
    CREATE/INSERT MODE : pBATCH_ID  WILL BE NULL
    UPDATE MODE :  pBATCH_ID WILL COME FROM FRONT-END


C. pIS_SUBMITTED (Number)

     pIS_SUBMITTED number not null (0 for draft, 1 for submit)

D. pAS_FLAG   IN NUMBER  DEFAULT 0, 
    0 before submitted, 1 after submitted

E. pUSER_ID (Number)
 pUSER_ID number not null auth.user_id
 
F. pSTATUS (Out CLOB)

  pSTATUS CLOB data return DB status against input data.


-------------------------------FOR BPR GENERATE------------------------------------------------

CREATE BPR   (BY BATCH SAVE-UPDATE)-  
API TYPE : POST
API NAME : api/pp/generate-bpr


JERP_ADM.JERP_PP_UTIL.GENERATE_BPR_FOR_BATCH_CREATION Creation PROCEDURE

JERP_ADM.JERP_PP_UTIL.GENERATE_BPR_FOR_BATCH_CREATION(
                                        pGENERATE_BPR           IN CLOB,
                                        pBATCH_DOC_REQ_ID      IN NUMBER ,
                                        pBATCH_NO              IN VARCHAR2, 
                                        pUSER_ID               IN NUMBER,
                                        pSBU_ID                IN NUMBER,
                                        pSTATUS                OUT CLOB
                         )


A. pGENERATE_BPR (JSON OBJECT)
Header = generate_bpr

OBJECT 
       GET_NUMBER('id');    
       GET_NUMBER('ppbm_doc_type');  
       GET_NUMBER('ppbm_prod_id');
       GET_STRING('ppbm_bpr_doc_id');
     
B. pBATCH_DOC_REQ_ID    IN  NUMBER,

C. pBATCH_NO (STRING)
   
D.  pUSER_ID (Number)
 pUSER_ID number not null auth.user_id
 
E. pUSER_ID (Number)

pUSER_ID number not null auth.user_idpSTATUS (Out CLOB)

F. pSTATUS CLOB data return DB status against input data.


    
------------CALL BATCH CREATE---

EXAMPLE (PROCEDURE CALLING): 

DECLARE 
    vSTATUS     CLOB; 
    pBATCH_ID   number :=0; ---DEFULT ZERO
    bdr_mst CLOB :=  '{ "batch_create" : 
                                    {  
                                      "batch_doc_type" : "BDFSMR",  
                                      "ppb_id" : null,      
                                      "ppb_prod_id" : 1016524,  
                                      "ppb_sort_order" :1,  
                                      "ppb_status" :1, 
                                      "ppb_sbu_id" :2,   
                                      "ppb_batch_create_date" :"02-06-2022",
                                      "ppb_batch_status" :1,
                                      "ppb_bom_id" : 102,   
                                      "ppb_batch_size" : 252 ,    
                                      "ppb_std_qty" : 21,   
                                      "ppb_std_uom" : 534,
                                      "ppb_prod_location_id" :646,   
                                      "ppb_bmr_id" :1,  
                                      "ppb_bpr_id" :12, 
                                      "ppb_batch_type" :2,  
                                      "ppb_production_type" :218,  
                                      "ppb_batch_category" :  52, 
                                      "ppb_batch_doc_req_id" :1 ,
                                      "ppb_batch_no" : "10002M1122",  
                                      "ppbm_id": null,    
                                      "ppbm_doc_type" :2,   
                                      "ppbm_sort_order" :1,
                                      "ppbm_prod_id" :1002,
                                      "ppbm_status" :1,
                                      "ppbm_bpr_doc_id" : "BPR-22-0001"      
                                  } 
                                }';   
                              
                                                 
BEGIN
    JERP_ADM.BATCH_CREATION( bdr_mst, pBATCH_ID, 0, 0, 1522, vSTATUS); 
    dbms_output.put_line('vSTATUS > '||pBATCH_ID||'-'||vSTATUS);
exception when others then
    dbms_output.put_line(sqlerrm);    
END;

--------------CALL BPR-----

DECLARE 
    vSTATUS     CLOB; 
    vBpr_mst CLOB :=  '{"generate_bpr":[{ 
                                          "id":1,
                                          "ppbm_doc_type":3,
                                          "ppbm_prod_id":7393,
                                          "ppbm_bpr_doc_id":"BPR-22-0001"     
                                        },
                                        {  
                                          "id" : null,      
                                          "ppbm_doc_type" : 4,  
                                          "ppbm_prod_id" :7053,  
                                          "ppbm_bpr_doc_id" :"BPR-22-0002"     
                                        } 
                                        ]
                      }';   
BEGIN
    JERP_ADM.GENERATE_BPR_FOR_BATCH_CREATION ( pGENERATE_BPR => vBpr_mst,  
                                               pBATCH_DOC_REQ_ID =>10528,  
                                               pBATCH_NO =>'10002M1122',  
                                               pUSER_ID =>1, 
                                               pSTATUS =>vSTATUS
                                               ); 
    dbms_output.put_line('vSTATUS > '||vSTATUS);
exception when others then
    dbms_output.put_line(sqlerrm);    
END;
