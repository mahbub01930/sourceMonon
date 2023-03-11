http://api.jerpbd.com:8889/api/pp/get-fg-prod-list-ptn/101/2

Feature Name : Production Transfer Note Entry Process

Description : Production Transfer Note data will be enter here

Design Link : https://www.figma.com/proto/XEZs348djTWYjp8idW7Y9k/Production-Transfer-Note?node-id=19%3A1139&scaling=min-zoom&page-id=0%3A1&starting-point-node-id=19%3A1139

From : WEB 

Users : 

Constraint:

User must be logged in

User info available

Check auth token for every request

Check SBU_ID

Tables/Data Source:

PP_TRANS_NOTE_MST, PP_TRANS_NOTE_DTL

------------------------------------------------------------------------------

--LEFT PANEL LIST (AFTER CREATE LANDING MODE)-1ST API
API TYPE : GET
API NAME : api/pp/get-prod-transfer-list

Response Fields :  
                    PB.PROD_ID,P.PROD_NAME,P.PROD_CODE,PB.BATCH_NO,PB.MFG_DATE,PB.EXP_DATE
	  
Operational Fields: 
                PB.ID BATCH_ID,PB.PROD_ID,P.PROD_NAME,P.PROD_CODE,PB.BATCH_NO,PB.MFG_DATE,PB.EXP_DATE
         
PARAMETER  : 

Table Name:   	PP_PRODUCT_BATCH = PB
                ADM_PRODUCTS     = P
                PP_BATCH_RECON_MST


Relation : 	  	PB.PROD_ID = P.ID
    
Filter by:  WHERE PB.IS_TRANSFERED='N' and PB.IS_CLOSED='N' and STATUS = 1

QUERY : 

SELECT PB.ID BATCH_ID,PB.PROD_ID,P.PROD_NAME,P.PROD_CODE,PB.BATCH_NO,PB.MFG_DATE,PB.EXP_DATE
FROM PP_PRODUCT_BATCH PB
JOIN ADM_PRODUCTS P ON PB.PROD_ID=P.ID
AND PB.IS_TRANSFERED='N'
AND PB.IS_CLOSED='N'
AND PB.ID IN (SELECT BATCH_ID FROM PP_BATCH_RECON_MST);

------------------------------------------------------------------------------

--RIGHT PANEL DATA (LANDING MODE)-AFTER CLICK THE LEFT PANEL 1ST API)--2ND API 

API TYPE : GET
API NAME : api/pp/mst-prod-info-data/{pBATCH_ID}

Response Fields :  
                    PB.PROD_ID,P.PROD_NAME,P.PROD_CODE,PB.BATCH_NO,PB.MFG_DATE,PB.EXP_DATE,p.BATCH_SIZE,SIZE_UOM,STD_QTY,STD_OUTPUT_UOM 
	  
Operational Fields: 
                    PB.ID BATCH_ID,PB.PROD_ID,P.PROD_NAME,P.PROD_CODE,PB.BATCH_NO,PB.MFG_DATE,PB.EXP_DATE,p.BATCH_SIZE,SIZE_UOM,STD_QTY,STD_OUTPUT_UOM
         
PARAMETER  :        PB.ID=:pBATCH_ID  (COME FROM 1ST API-->ID)

Table Name:   	    PP_PRODUCT_BATCH        = PB 
                    ADM_PRODUCTS            = P

			  
Relation : 	  	PB.PROD_ID=P.ID
   
Filter by:  WHERE PB.IS_TRANSFERED='N' AND PB.IS_CLOSED='N' AND STATUS = 1 ;

QUERY : 

SELECT PB.ID BATCH_ID,PB.PROD_ID,P.PROD_NAME,P.PROD_CODE,PB.BATCH_NO,PB.MFG_DATE,PB.EXP_DATE,p.BATCH_SIZE,SIZE_UOM,STD_QTY,STD_OUTPUT_UOM
FROM PP_PRODUCT_BATCH PB
JOIN ADM_PRODUCTS P ON PB.PROD_ID=P.ID
--WHERE P.ID=:pMst_PROD_ID--107
--and PB.BATCH_NO=:pBATCH_NO--'04522'
WHERE PB.ID=:pBATCH_ID
AND PB.IS_TRANSFERED='N'
AND PB.IS_CLOSED='N';


------------------------------------------------------------------------------

--LEFT PANEL ADD PRODUCT POP-UP  -3rd API

API TYPE : GET
API NAME : api/pp/get-fg-prod-list/{pPROD_ID}

Response Fields :     PROD_ID, PROD_NAME,PROD_TYPE_DESC, 

Operational Fields: 
                     PROD_ID, PROD_NAME, DISPLAY_CODE, BASE_UOM, PROD_UOM, COM_PACK_SIZE, IS_PROMO_PROD, PROD_TYPE_DESC, 
                     PROD_TYPE, PARENT_PROD_ID, PARENT_PROD_NAME, PARENT_DISPLAY_CODE, OLD_CODE   
         
PARAMETER  :       pPROD_ID


Table Name:   	    

Relation : 	  	

Filter by:  


QUERY : 

SELECT JERP_PP_UTIL.GET_FG_PROD_LIST (:pPROD_ID)  FROM DUAL


--RIGHT PANEL DATA (LANDING MODE)-AFTER CLICK THE LEFT PANEL 3RD API)-4TH API

API TYPE : GET
API NAME : api/pp/get-fg-prod-info-data/{pPROD_ID}

Response Fields :     ID, PROD_NAME, PROD_CODE, COM_PACK_SIZE, COM_UOM,PROD_CAT, CAT_NAME
	  
Operational Fields: 
                    ID, PROD_NAME, PROD_CODE, COM_PACK_SIZE, COM_UOM, EXP_PACK_SIZE, EXP_UOM, PROD_CAT, CAT_NAME, PROD_TYPE, ELEMENT_NAME
         
PARAMETER  :       P.ID=:pPROD_ID

Table Name:   	    
                ADM_PRODUCTS        = P
                ADM_PROD_CATEGORY   = PC
                ADM_CODE_ELEMENTS   = CE
			  
Relation : 	  	P.PROD_CAT=PC.ID
                P.PROD_TYPE=CE.ID
			  
Filter by:  WHERE STATUS = 1 


QUERY : 

SELECT P.ID,P.PROD_NAME,P.PROD_CODE,COM_PACK_SIZE,COM_UOM,EXP_PACK_SIZE,EXP_UOM,P.PROD_CAT,PC.CAT_NAME,P.PROD_TYPE,CE.ELEMENT_NAME
FROM ADM_PRODUCTS P,ADM_PROD_CATEGORY PC,ADM_CODE_ELEMENTS CE
WHERE P.PROD_CAT=PC.ID
AND P.PROD_TYPE=CE.ID
AND P.ID=:pPROD_ID;--1008 (COME FROM 3RD API PROD_ID);

--------------------------------------------------------------------------

--PRODUCTION TRANSFER NOTE MASTER INFO DATA -5TH API

API TYPE : GET
API NAME : api/pp/get-ptn-mst-data

Response Fields :     ID, DISPLAY_CODE, TRANSFER_DATE, BATCH_ID, BATCH_NO, MST_PROD_ID, PROD_NAME, TRAN_STATUS, ELEMENT_NAME, PROD_CODE, 
                      MFG_DATE, EXP_DATE, BATCH_SIZE, SIZE_UOM, STD_QTY, STD_OUTPUT_UOM, IS_PART_TRANSFER, IS_COMPLETE_TRANSFER, REMARKS
	  
Operational Fields: 
                    ID, DISPLAY_CODE, TRANSFER_DATE, BATCH_ID, BATCH_NO, MST_PROD_ID, PROD_NAME, TRAN_STATUS, ELEMENT_NAME, PROD_CODE, 
                    MFG_DATE, EXP_DATE, BATCH_SIZE, SIZE_UOM, STD_QTY, STD_OUTPUT_UOM, IS_PART_TRANSFER, IS_COMPLETE_TRANSFER, REMARKS
         
PARAMETER  :      

Table Name:   	    
                PP_TRANS_NOTE_MST   = TNM
                ADM_PRODUCTS        = P
                PP_PRODUCT_BATCH    = PB
                ADM_CODE_ELEMENTS   = CE
			  
Relation : 	  	TNM.MST_PROD_ID = P.ID
                TNM.BATCH_ID    = PB.ID
                TNM.TRAN_STATUS = CE.ID
			  
Filter by:  WHERE STATUS = 1 


QUERY : 

SELECT TNM.ID, DISPLAY_CODE, TRANSFER_DATE, BATCH_ID,PB.BATCH_NO, MST_PROD_ID,P.PROD_NAME,TNM.TRAN_STATUS,CE.ELEMENT_NAME
,P.PROD_CODE,PB.MFG_DATE,PB.EXP_DATE,p.BATCH_SIZE,SIZE_UOM,STD_QTY,STD_OUTPUT_UOM,IS_PART_TRANSFER,IS_COMPLETE_TRANSFER,TNM.REMARKS
FROM PP_TRANS_NOTE_MST TNM
LEFT JOIN ADM_PRODUCTS P ON TNM.MST_PROD_ID=P.ID
LEFT JOIN PP_PRODUCT_BATCH PB ON TNM.BATCH_ID=PB.ID
LEFT JOIN ADM_CODE_ELEMENTS CE ON TNM.TRAN_STATUS=CE.ID;
--

SELECT TND.ID,TND.TRANSFER_NOTE_ID,TND.PROD_ID,P.PROD_NAME,P.COM_PACK_SIZE,P.COM_UOM,
P.EXP_PACK_SIZE,P.EXP_UOM,TND.TOTAL_TRANSFER_QTY, TND.MASTER_CARTOON_QTY, TND.LOOSE_QTY,ASP.IS_PROMO_PROD,
CASE WHEN ASP.IS_PROMO_PROD = 'N' THEN 'COMMERCIAL' 
             WHEN ASP.IS_PROMO_PROD = 'Y' THEN 'SAMPLE'
             WHEN ASP.IS_PROMO_PROD = 'E' THEN SSA.AREA_NAME END CAT_NAME
FROM PP_TRANS_NOTE_DTL TND
LEFT JOIN ADM_PRODUCTS P ON TND.PROD_ID=P.ID
LEFT JOIN ADM_PROD_CATEGORY PC ON P.PROD_CAT=PC.ID
LEFT JOIN ADM_SBU_PRODUCTS ASP ON TND.PROD_ID=ASP.PROD_ID
LEFT JOIN SD_SALES_AREA SSA ON SSA.ID = ASP.EXPORT_TERRITORY
WHERE TND.TRANSFER_NOTE_ID=10001

------------------------------------------------------------------------------

--------------------------------------------------------------------------

--PRODUCTION TRANSFER NOTE DETAILS INFO DATA -6TH API

API TYPE : GET
API NAME : api/pp/get-ptn-dtl-data

Response Fields :    ID,PROD_ID,PROD_NAME,COM_PACK_SIZE,COM_UOM,PROD_CAT,CAT_NAME,TOTAL_TRANSFER_QTY,MASTER_CARTOON_QTY,LOOSE_QTY
	  
Operational Fields: 
                    ID, TRANSFER_NOTE_ID, PROD_ID, PROD_NAME, COM_PACK_SIZE, COM_UOM, EXP_PACK_SIZE, 
                    EXP_UOM, PROD_CAT, CAT_NAME, TOTAL_TRANSFER_QTY, MASTER_CARTOON_QTY, LOOSE_QTY
         
PARAMETER  :      

Table Name:   	    
                PP_TRANS_NOTE_MST   = TNM
                ADM_PRODUCTS        = P
                PP_PRODUCT_BATCH    = PB
                ADM_CODE_ELEMENTS   = CE
			  
Relation : 	  	TNM.MST_PROD_ID = P.ID
                TNM.BATCH_ID    = PB.ID
                TNM.TRAN_STATUS = CE.ID
			  
Filter by:  WHERE STATUS = 1 


QUERY : 

SELECT TND.ID,TND.TRANSFER_NOTE_ID,TND.PROD_ID,P.PROD_NAME,
P.COM_PACK_SIZE,P.COM_UOM,P.EXP_PACK_SIZE,P.EXP_UOM,P.PROD_CAT,PC.CAT_NAME,
TND.TOTAL_TRANSFER_QTY, TND.MASTER_CARTOON_QTY, TND.LOOSE_QTY,P.PROD_CODE
FROM PP_TRANS_NOTE_DTL TND
LEFT JOIN ADM_PRODUCTS P ON TND.PROD_ID=P.ID
LEFT JOIN ADM_PROD_CATEGORY PC ON P.PROD_CAT=PC.ID
WHERE TND.TRANSFER_NOTE_ID=:pTRANSFER_NOTE_ID;--10001;

------------------------------------------------------------------------------


--SAVE-UPDATE PRODUCTION TRANSFER NOTE DATA 7TH API

API TYPE : POST
API NAME : api/pp/insert-update-prod-trns-note-data

JERP_ADM.PD_PROD_TRANSFER_NOTE Creation PROCEDURE

JERP_ADM.PD_PROD_TRANSFER_NOTE (pTRNS_MST       IN CLOB,
                                pTRNS_DTL       IN CLOB,
                                pTRN_NOT_ID     IN OUT NUMBER,
                                pUSER_ID        IN NUMBER,
                                pIS_SUBMITTED   IN NUMBER, --0 not submitted, 1 submitted
                                pAS_FLAG        IN NUMBER  DEFAULT 0, --0 before submitted, 1 after submitted
                                pSBU_ID         IN NUMBER,
                                pSTATUS         OUT CLOB
                                )


A. pTRNS_MST (JSON OBJECT)
Header = trns_mst

OBJECT

GET_NUMBER('batch_id');
GET_NUMBER('mst_prod_id');
GET_NUMBER('transfer_to');
GET_STRING('is_part_transfer');
GET_STRING('is_complete_transfer');
GET_STRING('remarks');



 
 
B. pTRNS_DTL (JSON ARRAY)
Header = trns_dtl

OBJECT

GET_NUMBER('id');
GET_NUMBER('prod_type');
GET_NUMBER('prod_id');
GET_NUMBER('total_transfer_qty');
GET_NUMBER('master_cartoon_qty');
GET_NUMBER('loose_qty');





C. pTRN_NOT_ID    IN OUT NUMBER,
    CREATE/INSERT MODE : pTRN_NOT_ID  WILL BE NULL
    UPDATE MODE :  pTRN_NOT_ID WILL COME FROM FRONT-END

D. pUSER_ID (Number)
 pUSER_ID number not null auth.user_id


E. pIS_SUBMITTED (NUMBER) --0 not submitted, 1 submitted

    pIS_SUBMITTED number not null ()

F. pAS_FLAG (NUMBER)    DEFAULT 0, --0 before submitted, 1 after submitted  

G. pSBU_ID (Number)

    pSBU_ID number not null ()

H. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.;

-------------------------------------------------------------


---CALLL

DECLARE
    vSTATUS CLOB;
    vMst number:=null; 
    vRECON_MST CLOB := '{ "trns_mst":[
                                  {
                                     "batch_id":10230,
                                     "mst_prod_id":107,
                                     "transfer_to":null,
                                     "is_part_transfer":"Y",
                                     "is_complete_transfer":null,
                                     "remarks":"rmk"
                                  }
                                ]
                                }';
                                
    vRECON_DTL CLOB :=  '{ "trns_dtl":[
                                  {
                                     "id":null,
                                     "prod_type":null,
                                     "prod_id":1008,
                                     "total_transfer_qty":100,
                                     "master_cartoon_qty":50,
                                     "loose_qty":20
                                  },
                                  {
                                     "id":null,
                                     "prod_type":null,
                                     "prod_id":3054,
                                     "total_transfer_qty":200,
                                     "master_cartoon_qty":100,
                                     "loose_qty":50
                                  }
                                ] 
                                }';  
BEGIN
    JERP_ADM.PD_PROD_TRANSFER_NOTE(pTRNS_MST       =>vRECON_MST,
                                   pTRNS_DTL       =>vRECON_DTL,
                                   pTRN_NOT_ID     =>vMst,
                                   pUSER_ID        =>1,
                                   pIS_SUBMITTED   =>0,
                                   pAS_FLAG        =>0,
                                   pSBU_ID         =>2,
                                   pSTATUS         => vSTATUS
                                );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;