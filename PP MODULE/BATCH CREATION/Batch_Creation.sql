Feature Name : BATCH CREATION

Description : Create-update new batch no geenration based on the production requirements. BMR document-BPR document generation aalso will be done from this screen

Design Link : https://www.figma.com/proto/r53Vu6QgsTIUsJ1KromjH7/Batch-Creation---Approval-BMR---BPR---Generation?node-id=8%3A1078&scaling=min-zoom&page-id=0%3A1&starting-point-node-id=7%3A2


From : WEB 

Users : Quality Compliance Users will generate batch no and batch document (BMR-BPR), based on the submitted batch document requisition from production

Constraint:

User must be logged in

User info available

Check auth token for every request

Check SBU_ID


Tables/Data Source:

PP_PRODUCT_BATCH-BMR(INSERT)-BPR(N/A)
PP_PROD_BATCH_MAP-BMR(INSERT)-BPR(INSERT)

UPDATE SOURCE(PP_BATCH_DOC_DTL)- BMR-BPR-(UPDATE)






-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
API list


LEFT PANEL  - BATCH CREATION LIST (LANDING MODE)- 1st API
API TYPE : GET
API NAME : api/pp/get-batch-list

Response Fields :  
	 PB.BATCH_NO, PB.BATCH_CREATE_DATE, PB.PROD_ID, AP.PROD_NAME, PB.BATCH_SIZE, PB.BATCH_STATUS
Operational Fields: 
	PB.ID, PB.BATCH_NO, PB.BATCH_CREATE_DATE, PB.PROD_ID, AP.PROD_NAME, PB.BATCH_SIZE, PB.BATCH_STATUS

PARAMETER : NONE
Table Name: PP_PRODUCT_BATCH = PB  
			(SELECT ID PROD_ID, PROD_NAME FROM ADM_PRODUCTS WHERE PROD_TYPE = 506) = AP (sub-query)

Relation :  PB.PROD_ID = AP.PROD_ID (one to one)

Filter by: WHERE PB.SBU_ID = :pSBU_ID 
                  
QUERY :  

SELECT PB.ID, PB.BATCH_NO, PB.BATCH_CREATE_DATE, PB.PROD_ID, AP.PROD_NAME, PB.BATCH_SIZE, PB.BATCH_STATUS
FROM PP_PRODUCT_BATCH PB 
JOIN (SELECT ID PROD_ID, PROD_NAME FROM ADM_PRODUCTS WHERE PROD_TYPE=506) AP ON PB.PROD_ID=AP.PROD_ID
 WHERE PB.SBU_ID = :pSBU_ID


--------------------------------------------------

AFTER CLICK CREATE NEW DROPDOWN LIST- BATCH DOC REQUISITION - 2nd API
API TYPE : GET
API NAME : api/pp/get-batch-doc-req-list

Response Fields :  
	 DISPLAY_CODE, REQ_DATE 
Operational Fields: 
	ID, DISPLAY_CODE, REQ_DATE 

PARAMETER : NONE
Table Name: PP_BATCH_DOC_MST  

Relation :   

Filter by:  WHERE SBU_ID = :pSBU_ID 
                  
QUERY :  
 
SELECT ID,DISPLAY_CODE, REQ_DATE 
FROM PP_BATCH_DOC_MST 
WHERE TRAN_STATUS= 10049  
AND SBU_ID =:pSBU_ID



--------------------------------------------------

LIST OF PRODUCT-BATCH (AFTER CLICK OF BATCH DOC REQUISITION  )  - 3rd API
API TYPE : GET
API NAME : api/pp/get-product-batch-list

Response Fields :  
	  BDD.PROD_ID, AP.PROD_NAME, BDD.REQUIRED_NO_OF_BATCH, (BDD.REQUIRED_NO_OF_BATCH - NVL(COUNT_BATCH_NO,0))= AVAILABLE_BATCH,
	   BDD.DOC_TYPE, AC.ELEMENT_NAME = DOC_TYPE_NAME, BDD.REMARKS, BDD.GEN_DOC_CODES 
Operational Fields: 
	 BDD.DOC_REQ_ID, BDD.PROD_ID, AP.PROD_NAME, BDD.REQUIRED_NO_OF_BATCH,(BDD.REQUIRED_NO_OF_BATCH - NVL(COUNT_BATCH_NO,0)) AVAILABLE_BATCH, 
     BDD.DOC_TYPE, AC.ELEMENT_NAME AS DOC_TYPE_NAME, BDD.REMARKS, BDD.GEN_DOC_CODES 

PARAMETER : WHERE BDD.DOC_REQ_ID =:pDOC_REQ_ID ( ID OF 2nd API)

Table Name: PP_BATCH_DOC_DTL = BDD 
            ADM_PRODUCTS = AP 
            ADM_CODE_ELEMENTS = AC
            ( SELECT BATCH_DOC_REQ_ID,PROD_ID, COUNT(BATCH_NO) AS COUNT_BATCH_NO FROM PP_PRODUCT_BATCH GROUP BY BATCH_DOC_REQ_ID, PROD_ID ) =  PB (sub-query)
			
Relation : 
         BDD.PROD_ID=AP.ID
         BDD.DOC_TYPE=AC.ID
         BDD.PROD_ID=PB.PROD_ID


Filter by:  
         
                  
QUERY :  

     --3rd api- 
    SELECT BDD.DOC_REQ_ID,PBDM.DISPLAY_CODE AS DOC_REQ_NO, BDD.PROD_ID, AP.PROD_NAME, BDD.REQUIRED_NO_OF_BATCH,(BDD.REQUIRED_NO_OF_BATCH - NVL(COUNT_BATCH_NO,0)) AVAILABLE_BATCH, 
    BDD.DOC_TYPE, AC.ELEMENT_NAME AS DOC_TYPE_NAME, BDD.REMARKS, BDD.GEN_DOC_CODES 
    FROM PP_BATCH_DOC_DTL BDD 
    LEFT JOIN PP_BATCH_DOC_MST PBDM ON PBDM.ID = BDD.DOC_REQ_ID
    LEFT JOIN ADM_PRODUCTS AP ON BDD.PROD_ID=AP.ID
    left JOIN ADM_CODE_ELEMENTS AC ON BDD.DOC_TYPE=AC.ID
    LEFT JOIN( SELECT BATCH_DOC_REQ_ID,PROD_ID, COUNT(BATCH_NO) AS COUNT_BATCH_NO FROM PP_PRODUCT_BATCH GROUP BY BATCH_DOC_REQ_ID,PROD_ID
             ) PB ON BDD.DOC_REQ_ID=PB.BATCH_DOC_REQ_ID AND BDD.PROD_ID=PB.PROD_ID
    WHERE BDD.DOC_REQ_ID =:pDOC_REQ_ID --10282

--194 REPLACE TO 179 FOR TEST
--------------------------------------------------

DROPDOWN LIST RIGHT PANEL BODY - BATCH TYPE-   4th API
API TYPE : GET
API NAME : api/pp/get-batch-type-list

Response Fields :  
	 ELEMENT_NAME = BATCH TYPE
Operational Fields: 
	ID, ELEMENT_NAME

PARAMETER :  

Table Name: ADM_CODE_ELEMENTS

Relation : 
			 
			
Filter by:   
        WHERE CODE_ID = 701

SPECIAL CONDITION:  
        BATCH TYPE ID - 7001(Manufacture) WILL BE BY DEFAULT VALUE
                 
QUERY :   
     SELECT ID, ELEMENT_NAME
     FROM ADM_CODE_ELEMENTS
      WHERE CODE_ID = 701


--------------------------------------------------

DROPDOWN LIST RIGHT PANEL BODY - BATCH CATEGORY 5th API
API TYPE : GET
API NAME : api/pp/get-batch-category-list

Response Fields :  
	 ELEMENT_NAME = BATCH CATEGORY
Operational Fields: 
	ID, ELEMENT_NAME

PARAMETER :  

Table Name: ADM_CODE_ELEMENTS

Relation : 
			 
			
Filter by:   
        WHERE CODE_ID = 703

SPECIAL CONDITION:  
        BATCH CATEGORY- ID:7023(Commercial) WILL BE BY DAFAULT VALUE
                 
QUERY :     
        SELECT ID, ELEMENT_NAME FROM ADM_CODE_ELEMENTS WHERE CODE_ID = 703

--------------------------------------------------

DROPDOWN LIST RIGHT PANEL BODY - PRODUCTION TYPE -- 6th API
API TYPE : GET
API NAME : api/pp/get-production-type-list

Response Fields :  
	 ELEMENT_NAME = PRODUCTION TYPE
Operational Fields: 
	ID, ELEMENT_NAME

PARAMETER :  

Table Name: ADM_CODE_ELEMENTS

Relation : 
			 
			
Filter by:   
        WHERE CODE_ID = 702

SPECIAL CONDITION:  
        PRODUCTION TYPE- ID:7011(Start Batch) WILL BE BY DAFAULT VALUE
                 
QUERY :     
        
        SELECT ID, ELEMENT_NAME FROM ADM_CODE_ELEMENTS WHERE CODE_ID = 702

 


--------------------------------------------------

BOM DROPDOWN LIST (AFTER SELECT THE PRODUCT- MODAL LEFT PANEL)-BY DAUFAULT ROW ONE WILL BE SELECTED - 7th API
API TYPE : GET
API NAME : api/pp/get-bom-batch-data

Response Fields :  

	 BOM_DISPLAY_CODE,  BATCH_SIZE, BATCH_UOM, PBM_UOM_NAME, STD_BATCH_OUTPUT, STD_BATCH_UOM, PBM_THEO_BATCH_UOM
	 
Operational Fields: 
		MST_ID, BOM_DISPLAY_CODE, BLK_PROD_ID, BATCH_SIZE, BATCH_UOM, PBM_UOM_NAME, STD_BATCH_OUTPUT, STD_BATCH_UOM, PBM_THEO_BATCH_UOM 

PARAMETER  : WHERE BLK_PROD_ID = :pBLK_PROD_ID

Table Name:  
			V_PP_BOM_MST_DTL (VIEW)     
			
Relation : 	 
			
Filter by:  
                  
QUERY :  

SELECT DISTINCT MST_ID, BOM_DISPLAY_CODE, BLK_PROD_ID, BATCH_SIZE, BATCH_UOM, PBM_UOM_NAME, STD_BATCH_OUTPUT, STD_BATCH_UOM, PBM_THEO_BATCH_UOM 
FROM V_PP_BOM_MST_DTL 
WHERE MAT_PROD_ID = :pBLK_PROD_ID --10041


--------------------------------------------------
 
DROPDOWN LIST RIGHT PANEL BODY -PRODUCTION LOCATION--ALL LOCATION  --8TH API
API TYPE : GET
API NAME : api/pp/get-prod-location

Response Fields :  

	 WH_NAME = LOCATION NAME
	  
Operational Fields: 
		ID, WH_NAME
PARAMETER  

Table Name:  
			ADM_WAREHOUSE    
			
Relation : 	 
			
Filter by:  WHERE SBU_ID =:pSBU_ID
                  
QUERY :  
 

SELECT ID, WH_NAME FROM ADM_WAREHOUSE WHERE SBU_ID =:pSBU_ID



--------------------------------------------------
 
PRODUCTION LOCATION-SELECTED LOCATION- AFTER SELECTING THE PRODUCT  --9TH  API
API TYPE : GET
API NAME : api/pp/get-prod-location-selected

Response Fields :  

	 AW.WH_NAME  = LOCATION NAME
	  
Operational Fields: 
		SP.PRODUCTION_LOCATION, AW.WH_NAME 
PARAMETER  

Table Name:   ADM_SBU_PRODUCTS SP 
			 ADM_WAREHOUSE   = AW  
			
Relation : 	  SP.PRODUCTION_LOCATION = AW.ID  (1 TO 1)
			
Filter by:  WHERE PROD_ID= :pPROD_ID 
                  
QUERY :   
SELECT SP.PRODUCTION_LOCATION, AW.WH_NAME 
  FROM ADM_SBU_PRODUCTS SP 
  JOIN ADM_WAREHOUSE AW ON SP.PRODUCTION_LOCATION = AW.ID 
WHERE PROD_ID= :pPROD_ID --'1001'



--------------------------------------------------
 
GET SELECTED BATCH DETAIL DATA VIEW  -- 10TH  API
API TYPE : GET
API NAME : api/pp/get-prod-location-selected

Response Fields :  

	 PB.BATCH_NO, PB.PROD_ID, AP.PROD_NAME, PB.BATCH_CREATE_DATE, PB.BOM_ID, PB.BATCH_SIZE, PB.STD_QTY, PB.PROD_LOCATION_ID, PB.BATCH_TYPE, 
     PB.PRODUCTION_TYPE, PB.BATCH_CATEGORY, PB.BATCH_DOC_REQ_ID 
	  
Operational Fields: 
		PB.ID, PB.BATCH_NO, PB.PROD_ID, AP.PROD_NAME, PB.BATCH_CREATE_DATE, PB.BOM_ID, PB.BATCH_SIZE,PB.STD_QTY, PB.PROD_LOCATION_ID, PB.BATCH_TYPE, 
        PB.PRODUCTION_TYPE, PB.BATCH_CATEGORY, PB.BATCH_DOC_REQ_ID
         
PARAMETER  : WHERE PB.ID = :pPROD_BATHC_ID 

Table Name:   PP_PRODUCT_BATCH = PB
			  ADM_PRODUCTS = AP  
			
Relation : 	  AP ON PB.PROD_ID=AP.ID  (1 TO 1)
			
Filter by:  
                  
QUERY :   

--11TH API-GET SELECTED BATCH DETAIL DATA VIEW
SELECT PB.ID, PB.BATCH_NO, PB.PROD_ID, AP.PROD_NAME, PB.BATCH_CREATE_DATE, PB.BOM_ID, PB.BATCH_SIZE,PB.STD_QTY, PB.PROD_LOCATION_ID, PB.BATCH_TYPE, 
        PB.PRODUCTION_TYPE, PB.BATCH_CATEGORY, PB.BATCH_DOC_REQ_ID 
FROM PP_PRODUCT_BATCH PB JOIN ADM_PRODUCTS AP ON PB.PROD_ID=AP.ID
 WHERE PB.ID = :pPROD_BATHC_ID --320
 
 
 
-------------------------------------------------------------------------------

CREATE-UPDATE BATCH CREATION   (BY BATCH SAVE-UPDATE)-  -- 11th API
API TYPE : POST
API NAME : api/pp/create-update-batch-creation


JERP_ADM.BATCH_CREATION Creation PROCEDURE

JERP_ADM.BATCH_CREATION(
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
     GET_NUMBER  ('ppb_sort_order');   
     GET_STRING  ('ppb_status'); 
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
     GET_NUMBER  ('ppbm_sort_order');
     GET_NUMBER  ('ppbm_prod_id');
     GET_STRING  ('ppbm_status');    not null
     GET_STRING  ('ppbm_bpr_doc_id'); -- (new add)
     
     
     
 
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
    
------------

EXAMPLE (PROCEDURE CALLING): 

DECLARE 
    vSTATUS     CLOB; 
    pBATCH_ID   number :=0; ---DEFULT ZERO
    bdr_mst CLOB :=  '{ "batch_create" : 
                                    {  
                                      "batch_doc_type" : "BDFSMR",  
                                      "ppb_prod_id" : 1138,  
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
                                      "ppbm_prod_id" :1002,
                                      "ppbm_bpr_doc_id" : "BPR-22-0001"      
                                  } 
                                }';   
                              
                                                 
BEGIN
    JERP_ADM.BATCH_CREATION( bdr_mst, pBATCH_ID, 0, 0, 1522, vSTATUS); 
    dbms_output.put_line('vSTATUS > '||pBATCH_ID||'-'||vSTATUS);
exception when others then
    dbms_output.put_line(sqlerrm);    
END;


-----------------------------

VALIDATION FOR BATCH CREATION :

1. MANDATORY FIELDS VALUE FROM FRONT-END (BATCH TYPE, PRODUCTION TYPE, BATCH CATEGORY, PRODUCTION LOCATION, BOM ID)
 
