Feature Name : Batch Reconciliation Entry Process

Description : Batch Reconciliation data will be enter here

Design Link : https://www.figma.com/proto/Zunp8kd7PDtd9sAdGi05ig/Batch-Reconciliation?node-id=1%3A2&scaling=min-zoom&page-id=0%3A1&starting-point-node-id=5%3A509

From : WEB 

Users : 

Constraint:

User must be logged in

User info available

Check auth token for every request

Check SBU_ID

Tables/Data Source:

PP_BATCH_RECON_MST, PP_BATCH_RECON_DTL

------------------------------------------------------------------------------

--LEFT PANEL LIST (AFTER CREATE LANDING MODE)-1ST API
API TYPE : GET
API NAME : api/pp/get-batch-recon-list

Response Fields :  
                    PB.ID BATCH_ID,PB.PROD_ID,P.PROD_NAME,PB.BATCH_NO,PB.MFG_DATE,PB.EXP_DATE
	  
Operational Fields: 
                PB.ID BATCH_ID,PB.PROD_ID,P.PROD_NAME,PB.BATCH_NO,PB.MFG_DATE,PB.EXP_DATE
         
PARAMETER  : 

Table Name:   	PP_PRODUCT_BATCH = PB
                ADM_PRODUCTS     = P
                ADM_CODE_ELEMENTS


Relation : 	  	PB.PROD_ID = P.ID
    
Filter by:  WHERE PB.IS_TRANSFERED='N' and PB.IS_CLOSED='N' and STATUS = 1
            WHERE CODE_KEY ='BATCH_STATUS' AND AND ELEMENT_KEY ='BATCH_STATUSWIP-SFG'

QUERY : 

SELECT PB.ID BATCH_ID,PB.PROD_ID,P.PROD_NAME,PB.BATCH_NO,PB.MFG_DATE,PB.EXP_DATE
FROM PP_PRODUCT_BATCH PB
JOIN ADM_PRODUCTS P ON PB.PROD_ID=P.ID
AND PB.IS_TRANSFERED='N'
AND PB.IS_CLOSED='N'
AND PB.BATCH_STATUS IN (SELECT ID FROM ADM_CODE_ELEMENTS
                        WHERE CODE_KEY ='BATCH_STATUS'
                        AND ELEMENT_KEY ='BATCH_STATUSWIP-SFG'
                       );


------------------------------------------------------------------------------

--RIGHT PANEL DATA (LANDING MODE)-AFTER CLICK THE LEFT PANEL 1ST API)-2ND API 

API TYPE : GET
API NAME : api/pp/issue-data-list/{pFOR_BATCHES,pFOR_PRODUCTS}

Response Fields :  
                    IM.ID,IM.ISS_DATE,IDB.PROD_ID,P.PROD_NAME,IDB.BATCH_LOT_NUMBER GRN_ID,ISS_QTY 
	  
Operational Fields: 
                    IM.ID,IM.ISS_DATE,IDB.PROD_ID,P.PROD_NAME,IDB.BATCH_LOT_NUMBER GRN_ID,ISS_QTY 
         
PARAMETER  :        IM.FOR_BATCHES  = :pFOR_BATCHES  (COME FROM 1ST API-->BATCH_NO)
                    IM.FOR_PRODUCTS = :pFOR_PRODUCTS (COME FROM 1ST API-->PROD_ID)

Table Name:   	    MM_INT_ISS_MST          = IM 
                    MM_INT_ISS_DTL_BATCH    = IDB
                    ADM_PRODUCTS            = P

			  
Relation : 	  	IM.ID       = IDB.ISS_ID
                IDB.PROD_ID = P.ID
                   
			  
Filter by:  WHERE  STATUS = 1 ;

QUERY : 

SELECT IM.ID,IM.ISS_DATE,IDB.PROD_ID,P.PROD_NAME,IDB.BATCH_LOT_NUMBER GRN_ID,ISS_QTY 
FROM MM_INT_ISS_MST IM
JOIN MM_INT_ISS_DTL_BATCH IDB ON IM.ID=IDB.ISS_ID
LEFT JOIN ADM_PRODUCTS P ON IDB.PROD_ID=P.ID
WHERE  IM.FOR_BATCHES=:pFOR_BATCHES --'04522'
AND IM.FOR_PRODUCTS =:pFOR_PRODUCTS; --'1091'


------------------------------------------------------------------------------

--BATCH RECONCILIATION MASTER INFO DATA-VIEW MODE-3rd API

API TYPE : GET
API NAME : api/pp/get-recon-mst-data

Response Fields :     BRM.ID,RECONCILATION_DATE,BATCH_ID,BRM.PROD_ID,P.PROD_NAME,PB.MFG_DATE,PB.EXP_DATE 
	  
Operational Fields: 
                    BRM.ID,BRM.DISPLAY_CODE,RECONCILATION_DATE,BATCH_ID,BRM.PROD_ID,P.PROD_NAME,PB.MFG_DATE,PB.EXP_DATE   
         
PARAMETER  :       ID = :PQCTM_ID
                    

Table Name:   	    PP_BATCH_RECON_MST = BRM
                    ADM_PRODUCTS       = P
                    PP_PRODUCT_BATCH   = PB
			  
Relation : 	  	BRM.PROD_ID  = P.ID
                BRM.BATCH_ID = PB.ID
			  
Filter by:  WHERE STATUS = 1 


QUERY : 

SELECT BRM.ID,BRM.DISPLAY_CODE,RECONCILATION_DATE,BATCH_ID,BRM.PROD_ID,P.PROD_NAME,PB.MFG_DATE,PB.EXP_DATE 
FROM PP_BATCH_RECON_MST BRM
LEFT JOIN ADM_PRODUCTS P ON BRM.PROD_ID=P.ID
LEFT JOIN PP_PRODUCT_BATCH PB ON BRM.BATCH_ID=PB.ID;


--BATCH RECONCILIATION DETAILS INFO DATA-VIEW MODE-4TH API

API TYPE : GET
API NAME : api/pp/get-recon-dtl-data/{PQCTM_ID}

Response Fields :     BRD.ID, BRD.ISSUE_ID,IM.ISS_DATE, BRD.PROD_ID,P.PROD_NAME, BRD.GRN_ID,
                      BRD.ISSUE_QTY,RETURN_QTY,DAMAGE_QTY,REJECT_QTY, WASTAGE_QTY, EXT_REJECTION_QTY
	  
Operational Fields: 
                    BRD.ID, RECONCILATION_ID,BRD.ISSUE_ID,IM.ISS_DATE, BRD.PROD_ID,P.PROD_NAME, BRD.GRN_ID,
                    BRD.ISSUE_QTY,RETURN_QTY,DAMAGE_QTY,REJECT_QTY, WASTAGE_QTY, EXT_REJECTION_QTY   
         
PARAMETER  :       BRD.RECONCILATION_ID = :pRECON_ID
                    

Table Name:   	    PP_BATCH_RECON_DTL = BRD
                    ADM_PRODUCTS       = P
                    MM_INT_ISS_MST     = IM
			  
Relation : 	  	BRD.PROD_ID  = P.ID
                BRD.ISSUE_ID = IM.ID
			  
Filter by:  WHERE STATUS = 1 


QUERY : 

SELECT BRD.ID, RECONCILATION_ID,BRD.ISSUE_ID,IM.ISS_DATE, BRD.PROD_ID,P.PROD_NAME, BRD.GRN_ID,
BRD.ISSUE_QTY,RETURN_QTY,DAMAGE_QTY,REJECT_QTY, WASTAGE_QTY, EXT_REJECTION_QTY 
FROM PP_BATCH_RECON_DTL BRD
LEFT JOIN ADM_PRODUCTS P ON BRD.PROD_ID=P.ID
LEFT JOIN MM_INT_ISS_MST IM ON BRD.ISSUE_ID=IM.ID
WHERE BRD.RECONCILATION_ID=:pRECON_ID;


------------------------------------------------------------------------------


--SAVE-UPDATE BATCH RECONCILIATION DATA 5TH API

API TYPE : POST
API NAME : api/pp/insert-update-batch-recon-data

JERP_ADM.PD_BATCH_RECONCILATION Creation PROCEDURE

JERP_ADM.PD_BATCH_RECONCILATION (pRECON_MST       IN CLOB,
                                 pRECON_DTL       IN CLOB,
                                 pRECON_ID        IN OUT NUMBER,
                                 pUSER_ID         IN NUMBER,
                                 pIS_SUBMITTED    IN NUMBER, --0 not submitted, 1 submitted
                                 pAS_FLAG         IN NUMBER  DEFAULT 0, --0 before submitted, 1 after submitted
                                 pSBU_ID          IN NUMBER,
                                 pSTATUS          OUT CLOB
                                )


A. pRECON_MST (JSON OBJECT)
Header = recon_mst

OBJECT

GET_NUMBER('batch_id');
GET_NUMBER('prod_id');

 
 
B. pRECON_DTL (JSON ARRAY)
Header = recon_dtl

OBJECT

GET_NUMBER('id');
GET_NUMBER('issue_id');
GET_NUMBER('prod_id');
GET_NUMBER('grn_id');
GET_NUMBER('damage_qty');
GET_NUMBER('wastage_qty');
GET_NUMBER('reject_qty');
GET_NUMBER('ext_rejection_qty');
GET_NUMBER('return_qty');



C. pRECON_ID    IN OUT NUMBER,
    CREATE/INSERT MODE : pQCTM_ID  WILL BE NULL
    UPDATE MODE :  pQCTM_ID WILL COME FROM FRONT-END

D. pUSER_ID (Number)
 pUSER_ID number not null auth.user_id


E. pIS_SUBMITTED (NUMBER) --0 not submitted, 1 submitted

    pIS_SUBMITTED number not null ()

F. pAS_FLAG (NUMBER)    DEFAULT 0, --0 before submitted, 1 after submitted  

G. pSBU_ID (Number)

    pSBU_ID number not null ()

H. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.

-------------------------------------------------------------


---CALLL

DECLARE
    vSTATUS CLOB;
    vMst number:=null; 
    vRECON_MST CLOB := '{ "recon_mst":[
                                  {
                                     "batch_id":10230,
                                     "prod_id":1091
                                     
                                  }
                                ]
                                }';
                                
    vRECON_DTL CLOB :=  '{ "recon_dtl":[
                                  {
                                     "id":null,
                                     "issue_id":1013,
                                     "prod_id":1001,
                                     "grn_id":00222,
                                     "issue_qty":1,
                                     "damage_qty":0,
                                     "wastage_qty":0,
                                     "reject_qty":0,
                                     "ext_rejection_qty":0,
                                     "return_qty":0
                                  },
                                  {
                                     "id":null,
                                     "issue_id":1013,
                                     "prod_id":1001,
                                     "grn_id":00322,
                                     "issue_qty":2,
                                     "damage_qty":0,
                                     "wastage_qty":0,
                                     "reject_qty":0,
                                     "ext_rejection_qty":0,
                                     "return_qty":2
                                  },
                                  {
                                     "id":null,
                                     "issue_id":1013,
                                     "prod_id":1001,
                                     "grn_id":12345,
                                     "issue_qty":2,
                                     "damage_qty":0,
                                     "wastage_qty":1,
                                     "reject_qty":0,
                                     "ext_rejection_qty":0,
                                     "return_qty":0
                                  }
                                ] 
                                }';  
BEGIN
    PD_BATCH_RECONCILATION(pRECON_MST       =>vRECON_MST,
                          pRECON_DTL       =>vRECON_DTL,
                          pRECON_ID        =>vMst,
                          pUSER_ID        =>1,
                          pIS_SUBMITTED         =>0,
                          pAS_FLAG       =>0,
                          pSBU_ID         =>2,
                          pSTATUS         => vSTATUS
                      );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;