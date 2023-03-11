
------------------------------------------------------------------------------

--LEFT PANEL LIST (LANDING MODE)-1ST API
API TYPE : GET
API NAME : api/mm/get-imcs-list

Response Fields :  
		MCS.ID,IMCS_CODE,IMCS_DATE,POM.DISPLAY_CODE PO_NO,P.PROD_NAME MATERIAL_NAME
	  
Operational Fields: 
		MCS.ID,IMCS_CODE,IMCS_DATE,POM.DISPLAY_CODE PO_NO,P.PROD_NAME MATERIAL_NAME
         
PARAMETER  : ---ISSUE_ID = :pISSUE_ID (will come from LEFT PANel DATA)

Table Name:   	INC_MAT_CHECK_SHEET = MCS,
                MM_PUR_ORD_MST      = POM,
                ADM_PRODUCTS        = P

			  
Relation : 	  	
            MCS.LC_PO_NO    = POM.ID
            MCS.MAT_PROD_ID = P.ID;
			  
Filter by:  WHERE STATUS = 1 

QUERY : 

SELECT MCS.ID,IMCS_CODE,IMCS_DATE,POM.DISPLAY_CODE PO_NO,P.PROD_NAME MATERIAL_NAME 
FROM INC_MAT_CHECK_SHEET MCS,MM_PUR_ORD_MST POM,ADM_PRODUCTS P
WHERE MCS.LC_PO_NO=POM.ID
AND MCS.MAT_PROD_ID=P.ID;


------------------------------------------------------------------------------

--RIGHT PANEL LIST (LANDING MODE)-2ND API

API TYPE : GET
API NAME : api/mm/get-imcs-mst-data

Response Fields :  
                    MCS.ID, DISPLAY_CODE, IMCS_DATE, QUEST_ID, DOC_CHECK_LIST_ID, RECEIVE_DATE, RECEIVE_TIME, 
                    LC_PO_NO,MAT_PROD_ID,P.PROD_NAME, VEHICLE_NO, CONTAINER_SEAL_NO, GRN_ID, NOTES
	  
Operational Fields: 
                    MCS.ID, DISPLAY_CODE, IMCS_DATE, QUEST_ID, DOC_CHECK_LIST_ID, RECEIVE_DATE, RECEIVE_TIME, 
                    LC_PO_NO,MAT_PROD_ID,P.PROD_NAME, VEHICLE_NO, CONTAINER_SEAL_NO, GRN_ID, NOTES
         
PARAMETER  :        MCS.ID = :pID (will come from LEFT PANel DATA)

Table Name:   	    INC_MAT_CHECK_SHEET = MCS,
                    ADM_PRODUCTS        = P

			  
Relation : 	  	
                    MCS.MAT_PROD_ID =P.ID
			  
Filter by:  WHERE STATUS = 1 

QUERY : 

SELECT MCS.ID, DISPLAY_CODE, IMCS_DATE, QUEST_ID, DOC_CHECK_LIST_ID, RECEIVE_DATE, RECEIVE_TIME, 
LC_PO_NO, MAT_PROD_ID,P.PROD_NAME, VEHICLE_NO, CONTAINER_SEAL_NO, GRN_ID, NOTES
from INC_MAT_CHECK_SHEET MCS,ADM_PRODUCTS P
WHERE MCS.MAT_PROD_ID=P.ID
AND MCS.ID=:pID;


------------------------------------------------------------------------------

--Document Chk List Data-3RD API

API TYPE : GET
API NAME : api/mm/get-document-chk-list

Response Fields :  
                    AQTD.ID, AQTD.SL_NO, AQTD.QEUSTION, AQTD.ANSWER_ARRAY, AQTD.ANSWER_FIELD, 
                    VQTAT.FIELD_TYPE,AQTD.DEFAULT_ANSWER, AQTD.MANDATORY_FLAG
	  
Operational Fields: 
                    AQTD.ID, AQTD.SL_NO, AQTD.QEUSTION, AQTD.ANSWER_ARRAY, AQTD.ANSWER_FIELD, 
                    VQTAT.FIELD_TYPE,AQTD.DEFAULT_ANSWER, AQTD.MANDATORY_FLAG
         
PARAMETER  :        

Table Name:   	    ADM_QUEST_TEMP_DTL      = AQTD
                    V_QUEST_TEMP_ANS_TYPE   = VQTAT

			  
Relation : 	  	
                    VQTAT.FIELD_VALUE = AQTD.ANSWER_FIELD
			  
Filter by:  WHERE STATUS = 1 AND AQTD.QTEMP_ID = 1010

QUERY : 

SELECT AQTD.ID, AQTD.SL_NO, AQTD.QEUSTION, AQTD.ANSWER_ARRAY, AQTD.ANSWER_FIELD, VQTAT.FIELD_TYPE,
       AQTD.DEFAULT_ANSWER, AQTD.MANDATORY_FLAG
FROM ADM_QUEST_TEMP_DTL AQTD
LEFT JOIN V_QUEST_TEMP_ANS_TYPE VQTAT ON VQTAT.FIELD_VALUE = AQTD.ANSWER_FIELD
WHERE AQTD.STATUS = 1
AND AQTD.QTEMP_ID = 1010;


------------------------------------------------------------------------------

--Document varification List Data-4TH API

API TYPE : GET
API NAME : api/mm/get-document-varifi-list

Response Fields :  
                    AQTD.ID, AQTD.SL_NO, AQTD.QEUSTION, AQTD.ANSWER_ARRAY, AQTD.ANSWER_FIELD, 
                    VQTAT.FIELD_TYPE,AQTD.DEFAULT_ANSWER, AQTD.MANDATORY_FLAG
	  
Operational Fields: 
                    AQTD.ID, AQTD.SL_NO, AQTD.QEUSTION, AQTD.ANSWER_ARRAY, AQTD.ANSWER_FIELD, 
                    VQTAT.FIELD_TYPE,AQTD.DEFAULT_ANSWER, AQTD.MANDATORY_FLAG
         
PARAMETER  :        

Table Name:   	    ADM_QUEST_TEMP_DTL      = AQTD
                    V_QUEST_TEMP_ANS_TYPE   = VQTAT

			  
Relation : 	  	
                    VQTAT.FIELD_VALUE = AQTD.ANSWER_FIELD
			  
Filter by:  WHERE STATUS = 1 AND AQTD.QTEMP_ID = 1011

QUERY : 

SELECT AQTD.ID, AQTD.SL_NO, AQTD.QEUSTION, AQTD.ANSWER_ARRAY, AQTD.ANSWER_FIELD, VQTAT.FIELD_TYPE,
       AQTD.DEFAULT_ANSWER, AQTD.MANDATORY_FLAG
FROM ADM_QUEST_TEMP_DTL AQTD
LEFT JOIN V_QUEST_TEMP_ANS_TYPE VQTAT ON VQTAT.FIELD_VALUE = AQTD.ANSWER_FIELD
WHERE AQTD.STATUS = 1
AND AQTD.QTEMP_ID = 1011;


------------------------------------------------------------------------------

--Container Dtl Data -5TH API

API TYPE : GET
API NAME : api/mm/get-container-dtl-data

Response Fields :  
                    MC.ID, IMCS_ID, SL_NO, CONTAINER_NO, CONTAINER_TYPE,CE.ELEMENT_NAME, VOLUME, UOM , IS_INTACT, REMARKS
	  
Operational Fields: 
                    MC.ID, IMCS_ID, SL_NO, CONTAINER_NO, CONTAINER_TYPE,CE.ELEMENT_NAME, VOLUME, UOM , IS_INTACT, REMARKS
         
PARAMETER  :        MC.IMCS_ID = :pIMCS_ID (will come from RIGHT PANel BODY)

Table Name:   	    INC_MAT_CONTAINER = MC,
                    ADM_CODE_ELEMENTS = CE
			  
Relation : 	  	
                    MC.CONTAINER_TYPE = CE.ID
			  
Filter by:  WHERE STATUS = 1 

QUERY : 

SELECT MC.ID, IMCS_ID, SL_NO, CONTAINER_NO, CONTAINER_TYPE,CE.ELEMENT_NAME, VOLUME,JERP_ADM.FD_GET_BASE_UOM(CONTAINER_UOM) UOM , IS_INTACT, REMARKS 
FROM INC_MAT_CONTAINER MC,ADM_CODE_ELEMENTS CE
WHERE MC.CONTAINER_TYPE=CE.ID
AND MC.IMCS_ID=:P_IMCS_ID;


------------------------------------------------------------------------------

--Container Type List -6TH API

API TYPE : GET
API NAME : api/mm/get-container-type-list

Response Fields :  
                    ID,ELEMENT_NAME
	  
Operational Fields: 
                    ID,ELEMENT_NAME
         
PARAMETER  :        

Table Name:   	    INC_MAT_CONTAINER = MC,
                    ADM_CODE_ELEMENTS = CE
			  
Relation : 	  	

Filter by:  WHERE STATUS = 1 AND CODE_KEY='CONTAINER_TYPE'

QUERY : 

SELECT ID,ELEMENT_NAME FROM ADM_CODE_ELEMENTS 
WHERE   CODE_KEY='CONTAINER_TYPE'
ORDER BY 1;


------------------------------------------------------------------------------

--LC/PO NO List -7TH API

API TYPE : GET
API NAME : api/mm/get-lc_po-list

Response Fields :  
                    ID, DISPLAY_VALUE
	  
Operational Fields: 
                    ID, DISPLAY_VALUE
         
PARAMETER  :        

Table Name:   	MM_PUR_ORD_MST      = POM
                ADM_SBU_DEPARTMENT  = SD,
                ADM_SUPPLIERS       = S
          
Relation : 	  	POM.DEPARTMENT_ID   = SD.ID
                POM.SUPPLIER_ID     = S.ID

Filter by:  WHERE STATUS = 1 

QUERY : 

SELECT POM.ID,'Order No: '|| DISPLAY_CODE||', Order Date: '||PO_DATE||', Dep:'||SD.DISPLAY_NAME||',Supplier: '||S.SUPPLIER_NAME DISPLAY_VALUE
FROM MM_PUR_ORD_MST POM,ADM_SBU_DEPARTMENT SD,ADM_SUPPLIERS S
WHERE POM.DEPARTMENT_ID = SD.ID
AND POM.SUPPLIER_ID=S.ID;


--Material List -8TH API

API TYPE : GET
API NAME : api/mm/get-material-list

Response Fields :  
                    ID, DISPLAY_VALUE
	  
Operational Fields: 
                    ID, DISPLAY_VALUE
         
PARAMETER  :        PO_ID   = :pPO_ID  (will come from lo_po list)

Table Name:   	MM_PUR_ORD_DTL = OD,
                ADM_PRODUCTS   = P
          
Relation : 	  	OD.PROD_ID = P.ID 
                

Filter by:  WHERE STATUS = 1 

QUERY : 

SELECT OD.ID,'Product: '||p.PROD_NAME||', Quentity:'|| PO_QTY||', Total Cost: '||ITEM_TOTAL_COST DISPLAY_VALUE
FROM MM_PUR_ORD_DTL OD,ADM_PRODUCTS P
WHERE OD.PROD_ID=P.ID 
AND PO_ID=:P_PO_ID

--------------------------------------------------------------------------------


--SAVE-UPDATE INCOMING MATERIAL CHECK SHEET (INC_MAT_CHECK_SHEET) DATA -9TH API
API TYPE : POST
API NAME : api/pp/insert-update-imcs-data

JERP_ADM.PD_IMCS Creation PROCEDURE

JERP_ADM.PD_IMCS  (pIMCS_MST       IN CLOB,
                   pIMCS_DTL       IN CLOB,
                   pAQD_MSS      IN CLOB,
                   pAQD_DTL      IN CLOB, 
                   pUSER_ID       IN  NUMBER,
                   pSBU_ID       IN  NUMBER,
                   pIMCS_ID     in  out  NUMBER,
                   pSTATUS        OUT CLOB
                  )


A. pIMCS_MST (JSON OBJECT)
Header = imcs_mst

OBJECT
 
GET_NUMBER('id');
GET_STRING('imcs_code');
GET_STRING('imcs_date'),'dd-mm-rrrr');
GET_NUMBER('quest_id');
GET_NUMBER('doc_check_list_id');
GET_STRING('receive_date'),'dd-mm-rrrr'); 
GET_STRING('receive_time'),'dd-mm-rrrr'); 
GET_NUMBER('lc_po_no') (not null);
GET_NUMBER('mat_prod_id') (not null);
GET_STRING('vehicle_no');
GET_STRING('container_seal_no');
GET_NUMBER('grn_id');
GET_STRING('notes');   
 
B. pIMCS_DTL (JSON ARRAY)
Header = imcs_dtl

OBJECT
 
GET_NUMBER('id');
GET_STRING('imcs_id');
GET_NUMBER('sl_no');
GET_NUMBER('container_no');
GET_NUMBER('container_type');
GET_NUMBER('volume');
GET_NUMBER('container_uom');
GET_STRING('is_intact');
GET_STRING('remarks');

C. pAQD_MSS (JSON ARRAY)
Header = aqd_mst

OBJECT
 
GET_NUMBER('id');
GET_NUMBER('sbu_id');
GET_NUMBER('ref_id');
GET_NUMBER('ref_id1');
GET_NUMBER('trn_type');
GET_NUMBER('qtemp_id');

D. pAQD_DTL (JSON ARRAY)  
Header = adq_dtl

OBJECT

GET_NUMBER('id');
GET_NUMBER('qmst_id');
GET_STRING('array_answer');
GET_STRING('answer_text');
GET_STRING('comments');
GET_NUMBER('sort_order');
GET_NUMBER('sl_no');
GET_STRING('question');
GET_STRING('answer_array');
GET_STRING('array_separator');
GET_NUMBER('answer_field');


E. pUSER_ID (Number)
 pUSER_ID number not null auth.user_id


F. pSBU_ID (Number)

     pSBU_ID number not null ()


G. pIMCS_ID    IN OUT NUMBER,
    CREATE/INSERT MODE : pIMCS_ID  WILL BE NULL
    UPDATE MODE :  pIMCS_ID WILL COME FROM FRONT-END


H. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.

-------------------------------------------------------------

