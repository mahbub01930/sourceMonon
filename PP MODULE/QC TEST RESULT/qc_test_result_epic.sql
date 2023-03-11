Feature Name : QC Test Result Entry

Description : QC Test Results data will be enter here

Design Link : https://www.figma.com/proto/DuQAkS40oxGMp363JdDUBT/QC-Test-Result-Entry?node-id=1%3A2&starting-point-node-id=1%3A2

From : WEB 

Users : 

Constraint:

User must be logged in

User info available

Check auth token for every request

Check SBU_ID

Tables/Data Source:

PP_QC_TEST_MST, PP_QC_TEST_DTL

------------------------------------------------------------------------------

--LEFT PANEL LIST (LANDING MODE)-1ST API
API TYPE : GET
API NAME : api/pp/get-trn-type-list

Response Fields :  
                    ELEMENT_NAME
	  
Operational Fields: 
                ID,ELEMENT_NAME
         
PARAMETER  : 

Table Name:   	ADM_CODE_ELEMENTS,PP_QC_SAMPLE_ASSIGN


Relation : 	  	
    
Filter by:  WHERE CODE_KEY='QC_TRAN_TYPE' and STATUS = 1 

QUERY : 

SELECT ID,ELEMENT_NAME FROM ADM_CODE_ELEMENTS
WHERE CODE_KEY='QC_TRAN_TYPE'
AND ID IN (SELECT TRANSACTION_TYPE FROM PP_QC_SAMPLE_ASSIGN);


------------------------------------------------------------------------------

--LEFT PANEL LIST (LANDING MODE)-2ND API (QC STAGE LIST)

API TYPE : GET
API NAME : api/pp/qc-stage-list/{pTrn_Type}

Response Fields :  
                    ELEMENT_NAME
	  
Operational Fields: 
                    ID,ELEMENT_NAME
         
PARAMETER  :        TRANSACTION_TYPE = :pTrn_Type

Table Name:   	    ADM_CODE_ELEMENTS ,PP_QC_SAMPLE_ASSIGN

			  
Relation : 	  	
                   
			  
Filter by:  WHERE  STATUS = 1 ;

QUERY : 

SELECT ID,ELEMENT_NAME FROM ADM_CODE_ELEMENTS 
WHERE ID IN (SELECT QC_STATUS FROM PP_QC_SAMPLE_ASSIGN
             --WHERE TRANSACTION_TYPE=:pTrn_Type
             );


------------------------------------------------------------------------------

--LEFT PANEL LIST (LANDING MODE)(GRN LIST) 3RD API

API TYPE : GET
API NAME : api/pp/get-grn-list/{pTrn_Type,pQC_STATUS}

Response Fields :  
                    TRANSACTION_ID GRN_ID,QSA.LAB_CONTROL_CODE,QSA.PROD_ID,P.PROD_NAME 
	  
Operational Fields: 
                    QSA.ID,TRANSACTION_ID GRN_ID,QSA.LAB_CONTROL_CODE,QSA.PROD_ID,P.PROD_NAME 
         
PARAMETER  :        QSA.TRANSACTION_TYPE = :pTrn_Type  (COME FROM 1ST API )
                    QSA.QC_STATUS        = :pQC_STATUS (COME FROM 2ND API )

Table Name:   	    PP_QC_SAMPLE_ASSIGN = QSA
                    ADM_PRODUCTS        = P

			  
Relation : 	  	
                QSA.PROD_ID=P.ID
			  
Filter by:  WHERE STATUS = 1 
QUERY : 

SELECT QSA.ID,TRANSACTION_ID GRN_ID,QSA.LAB_CONTROL_CODE,QSA.PROD_ID,P.PROD_NAME
FROM PP_QC_SAMPLE_ASSIGN QSA
LEFT JOIN ADM_PRODUCTS P ON QSA.PROD_ID=P.ID
WHERE  QSA.TRANSACTION_TYPE=:pTrn_Type
AND QSA.QC_STATUS=:pQC_STATUS;


------------------------------------------------------------------------------

----RIGHT PANEL DATA (LANDING MODE)-AFTER CLICK THE LEFT PANEL 3RD API) -4TH API 

API TYPE : GET
API NAME : api/pp/get-lab-prod-data/{pQSA_ID}

Response Fields :  
                    LAB_CONTROL_CODE,PROD_ID,P.PROD_NAME,ASSIGN_DATE SAMPLING_DATE,DFN_GET_QC_TEST_ANALYZED (QSA.LAB_CONTROL_CODE) ANALYZED_BY,PQTM.APP_THR_ID
	  
Operational Fields: 
                    QSA.ID,TRANSACTION_ID GRN_ID,LAB_CONTROL_CODE,PROD_ID,P.PROD_NAME,ASSIGN_DATE SAMPLING_DATE, 
                    DFN_GET_QC_TEST_ANALYZED (QSA.LAB_CONTROL_CODE) ANALYZED_BY
         
PARAMETER  :       QSA.ID = :pQSA_ID  (COME FROM 3RD API ->QSA.ID ) 

Table Name:   	   PP_QC_SAMPLE_ASSIGN = QSA
                   ADM_PRODUCTS        = P

			  
Relation : 	  	
            QSA.PROD_ID = P.ID
			  
Filter by:  WHERE STATUS = 1 

GROUP BY: 

QUERY : 

SELECT QSA.ID,TRANSACTION_ID GRN_ID,QSA.LAB_CONTROL_CODE,QSA.PROD_ID,P.DISPLAY_NAME PROD_NAME,ASSIGN_DATE SAMPLING_DATE, 
DFN_GET_QC_TEST_ANALYZED (QSA.LAB_CONTROL_CODE) ANALYZED_BY,PQTM.ID AS QC_TST_MST_ID,PQTM.APP_THR_ID,P.DISPLAY_CODE
FROM PP_QC_SAMPLE_ASSIGN QSA
--LEFT JOIN ADM_PRODUCTS P ON QSA.PROD_ID=P.ID
LEFT JOIN ADM_SBU_PRODUCTS P ON QSA.PROD_ID=P.PROD_ID
LEFT JOIN PP_QC_TEST_MST PQTM ON QSA.LAB_CONTROL_CODE = PQTM.LAB_CONTROL_CODE
WHERE QSA.ID =:PQSA_ID
AND P.SBU_ID = :pSBU_ID

/*
SELECT QSA.ID,TRANSACTION_ID GRN_ID,LAB_CONTROL_CODE,PROD_ID,P.PROD_NAME,ASSIGN_DATE SAMPLING_DATE, 
DFN_GET_QC_TEST_ANALYZED (QSA.LAB_CONTROL_CODE) ANALYZED_BY,
(select ID from PP_QC_TEST_MST where LAB_CONTROL_CODE= QSA.LAB_CONTROL_CODE) QC_TST_MST_ID
FROM PP_QC_SAMPLE_ASSIGN QSA
LEFT JOIN ADM_PRODUCTS P ON QSA.PROD_ID=P.ID
WHERE QSA.ID =:pQSA_ID;
*/


------------------------------------------------------------------------------

----RESULT SPECIFICATION INFO DATA-5TH API 

API TYPE : GET
API NAME : api/pp/get-rslt-spec-data/{pPROD_ID}

Response Fields :  
                    QPS.TEST_ID,CE.ELEMENT_NAME TEST_NAME,QPS.SPECIFICATION,QPS.REFERENCE  
	  
Operational Fields: 
                    QP.PROD_ID,QPS.ID,QPS.TEST_ID,CE.ELEMENT_NAME TEST_NAME,QPS.SPECIFICATION,QPS.REFERENCE   
         
PARAMETER  :        QP.PROD_ID        = :pPROD_ID (4TH NO API ->PROD_ID)

Table Name: PP_QC_PARAM       = QP
            PP_QC_PARAM_SPEC  = QPS
            ADM_CODE_ELEMENTS = CE
	
Relation : 	  	
                    QP.ID=QPS.QC_PARAM_ID
                    QPS.TEST_ID=CE.ID

Filter by:  WHERE STATUS = 1 

QUERY : 

SELECT QP.PROD_ID,QPS.ID,QPS.TEST_ID,PQIT.TEST_NAME,QPS.SPECIFICATION,QPS.REFERENCE,QPS.PARENT_TEST_ID
FROM PP_QC_PARAM QP
LEFT JOIN PP_QC_PARAM_SPEC QPS ON QP.ID=QPS.QC_PARAM_ID
LEFT JOIN PP_QC_IPQC_TEST PQIT ON QPS.TEST_ID=PQIT.ID
WHERE  QP.PROD_ID=:pPROD_ID;

--OLD
/*
SELECT QP.PROD_ID,QPS.ID,QPS.TEST_ID,CE.ELEMENT_NAME TEST_NAME,QPS.SPECIFICATION,QPS.REFERENCE 
FROM PP_QC_PARAM QP
LEFT JOIN PP_QC_PARAM_SPEC QPS ON QP.ID=QPS.QC_PARAM_ID
LEFT JOIN ADM_CODE_ELEMENTS CE ON QPS.TEST_ID=CE.ID
WHERE  QP.PROD_ID=:pPROD_ID;
*/

------------------------------------------------------------------------------

--QC RESULT TEST DETAILS INFO DATA-VIEW MODE-6TH API

API TYPE : GET
API NAME : api/pp/get-qct-dtl-data/{PQCTM_ID}

Response Fields :     TEST_ID, TEST_NAME, SPECIFICATION, REFERENCE, TEST_RESULT_VALUE, REMARKS 
	  
Operational Fields:  ID, TEST_RESULT_ID, TEST_ID, TEST_NAME, SPECIFICATION, REFERENCE, TEST_RESULT_VALUE, REMARKS   

PARAMETER  :       TEST_RESULT_ID =:PQCTM_ID 


Table Name:   	    PP_QC_TEST_DTL

Relation : 	  	

   
Filter by:  WHERE STATUS = 1 


QUERY : 

SELECT ID, TEST_RESULT_ID, TEST_ID, TEST_NAME, SPECIFICATION, REFERENCE, TEST_RESULT_VALUE, REMARKS ,PARENT_TEST_ID,TEST_SL_NO
FROM PP_QC_TEST_DTL
WHERE TEST_RESULT_ID=:PQCTM_ID


------------------------------------------------------------------------------

--QC RESULT TEST MASTER INFO DATA-VIEW MODE-7TH API

API TYPE : GET
API NAME : api/pp/get-qct-mst-data/{PQCTM_ID}

Response Fields :     TEST_STATUS,PASSED_QTY, HOLD_QTY, REJECT_QTY,RE_TEST_DATE, EXPIRY_DATE,POTENCY,VERIFY_COMMENTS
	  
Operational Fields: 
                    ID,TEST_STATUS,PASSED_QTY, HOLD_QTY, REJECT_QTY,RE_TEST_DATE, EXPIRY_DATE,POTENCY,VERIFY_COMMENTS   
         
PARAMETER  :       ID = :PQCTM_ID
                    

Table Name:   	    PP_QC_TEST_MST
			  
Relation : 	  	
			  
Filter by:  WHERE STATUS = 1 


QUERY : 

SELECT PQTM.ID, PQTM.TEST_STATUS, PQTM.PASSED_QTY, PQTM.HOLD_QTY, PQTM.REJECT_QTY, PQTM.RE_TEST_DATE, PQTM.EXPIRY_DATE, PQTM.POTENCY, PQTM.VERIFY_COMMENTS,
       PQTM.VERIFIED_BY, PQTM.VERIFY_DATE, AGD.POTENCY SUPPLIED_POTENCY
FROM PP_QC_TEST_MST PQTM
LEFT JOIN PP_QC_SAMPLE_ASSIGN PQSA ON PQSA.LAB_CONTROL_CODE = PQTM.LAB_CONTROL_CODE
LEFT JOIN ADM_GRN_DETAIL AGD ON AGD.GRN_ID = PQSA.TRANSACTION_ID AND AGD.PROD_ID = PQSA.PROD_ID
WHERE PQTM.ID=:PQCTM_ID

------------------------------------------------------------------------------

--TEST STATUS LIST --8TH API

API TYPE : GET
API NAME : api/pp/get-tst-status-list

Response Fields :   ELEMENT_NAME

Operational Fields: ID,ELEMENT_NAME
   
PARAMETER  :       

Table Name:   	    ADM_CODE_ELEMENTS

Relation : 	  	 QCS.SAMPLING_BY = HE.EMP_ID

Filter by:  WHERE CODE_KEY = 'QC_TEST_STATUS' and STATUS = 1 


QUERY : 

SELECT ID,ELEMENT_NAME FROM ADM_CODE_ELEMENTS
WHERE CODE_KEY = 'QC_TEST_STATUS';

------------------------------------------------------------------------------

--GRN AND SAMPLE QUENTITY List--9TH API

API TYPE : GET
API NAME : api/pp/get-grn-samp-qty

Response Fields :  
                    A.GRN_QTY,A.GRN_UOM,B.SAMPLE_QTY,B.SMPL_UOM,NVL(A.GRN_QTY,0)-NVL(B.SAMPLE_QTY,0) NET_GRN_QTY
	  
Operational Fields: 
                    A.GRN_QTY,A.GRN_UOM,B.SAMPLE_QTY,B.SMPL_UOM,NVL(A.GRN_QTY,0)-NVL(B.SAMPLE_QTY,0) NET_GRN_QTY 
         
PARAMETER  :      ADM_GRN.ID = :pGRN_ID  
                  ADM_GRN_DETAIL.PROD_ID =:pPROD_ID
                  PP_QC_SAMPLE_ASSIGN.TRANSACTION_ID =:pGRN_ID 
                  PP_QC_SAMPLE_ASSIGN.PROD_ID =:pPROD_ID

Table Name:   	ADM_GRN,
                ADM_GRN_DETAIL,
                PP_QC_SAMPLING,
                PP_QC_SAMPLE_ASSIGN

Relation : 	  	

Filter by:  WHERE STATUS = 1  

QUERY : 

SELECT A.GRN_QTY,A.GRN_UOM,B.SAMPLE_QTY,B.SMPL_UOM,NVL(A.GRN_QTY,0)-NVL(B.SAMPLE_QTY,0) NET_GRN_QTY FROM (
SELECT SUM(NVL(RCV_QTY,0)) GRN_QTY,JERP_ADM.FD_GET_BASE_UOM(PROD_UOM) GRN_UOM FROM ADM_GRN_DETAIL
WHERE GRN_ID IN (
SELECT ID FROM ADM_GRN
WHERE ID=:pGRN_ID --2838
)
AND PROD_ID=:pPROD_ID --10013
GROUP BY PROD_UOM)A,(
SELECT  SUM(NVL(SAMPLE_QTY,0)) SAMPLE_QTY,JERP_ADM.FD_GET_BASE_UOM(SAMPLE_UOM) SMPL_UOM FROM  PP_QC_SAMPLING
WHERE QC_SAMPLE_ID IN (
SELECT ID FROM PP_QC_SAMPLE_ASSIGN
WHERE TRANSACTION_ID=:pGRN_ID --2838
AND PROD_ID=:pPROD_ID --10013
)
GROUP BY SAMPLE_UOM)B;


-----------------------------------NEW API ADD-----get-container-wise-data--------------------------------------

API TYPE : GET
API NAME : api/pp/get-container-wise-data/{pLAB_CONTROL_CODE}

Response Fields :  
                    AGC.ID CONTAINER_ID,AGC.CONTAINER_NO,AGC.CON_VOLUMN,AGC.CON_VOLUMN_UOM,ACE1.ELEMENT_NAME AS CON_UOM_NAME,
                    PQS.SAMPLE_QTY,PQS.SAMPLE_UOM,ACE.ELEMENT_NAME AS SAMPLE_UOM_NAME
	  
Operational Fields: 
                    AGC.ID CONTAINER_ID,AGC.CONTAINER_NO,AGC.CON_VOLUMN,AGC.CON_VOLUMN_UOM,ACE1.ELEMENT_NAME AS CON_UOM_NAME,
                    PQS.SAMPLE_QTY,PQS.SAMPLE_UOM,ACE.ELEMENT_NAME AS SAMPLE_UOM_NAME
         
PARAMETER  :       PQSA.LAB_CONTROL_CODE = :pLAB_CONTROL_CODE  (COME FROM 3RD API ->LAB_CONTROL_CODE ) 

Table Name:   	   
                   PP_QC_SAMPLE_ASSIGN  = PQSA
                   PP_QC_SAMPLING       = PQS
                   ADM_CODE_ELEMENTS    = ACE
                   ADM_GRN_CONTAINER    = AGC
                   ADM_CODE_ELEMENTS    = ACE1

			  
Relation : 	  	
            
            PQS.QC_SAMPLE_ID       = PQSA.ID
            PQS.SAMPLE_UOM         = ACE.ID
            AGC.ID                 = PQS.CONTAINER_ID
            AGC.CON_VOLUMN_UOM     = ACE1.ID
			  
Filter by:  WHERE STATUS = 1 

GROUP BY: 

QUERY : 

SELECT AGC.ID CONTAINER_ID,AGC.CONTAINER_NO,NVL(AGC.CON_VOLUMN,0)AS RECEIVE_QTY,AGC.CON_VOLUMN_UOM,ACE1.ELEMENT_NAME AS CON_UOM_NAME,
NVL(PQS.SAMPLE_QTY,0)SAMPLE_QTY,PQS.SAMPLE_UOM,ACE.ELEMENT_NAME AS SAMPLE_UOM_NAME
FROM ADM_GRN_CONTAINER AGC
LEFT JOIN PP_QC_SAMPLE_ASSIGN PQSA ON PQSA.TRANSACTION_ID = AGC.GRN_ID
LEFT JOIN PP_QC_TEST_MST PQTM ON PQTM.LAB_CONTROL_CODE = PQSA.LAB_CONTROL_CODE
LEFT JOIN PP_QC_SAMPLING PQS ON PQS.QC_SAMPLE_ID = PQSA.ID AND PQS.CONTAINER_ID = AGC.ID
LEFT JOIN ADM_CODE_ELEMENTS ACE ON PQS.SAMPLE_UOM = ACE.ID
LEFT JOIN ADM_CODE_ELEMENTS ACE1 ON AGC.CON_VOLUMN_UOM = ACE1.ID
WHERE PQSA.LAB_CONTROL_CODE = :pLAB_CONTROL_CODE --'LAB-00092/22'
ORDER BY 1;


-----------------------get-qct-container-dtl----------------------------

API TYPE : GET
API NAME : api/pp/get-qct-container-dtl-data/{pQC_MST_ID}

Response Fields :  
                    RECEIVE_QTY,RECEIVE_UOM_NAME, 
                    SAMPLE_QTY, SAMPLE_UOM_NAME, PASSED_QTY, PASSED_UOM_NAME, 
                    REJECTED_QTY, REJECTED_UOM_NAME
	  
Operational Fields: 
                    PQTC.ID, QC_MST_ID, CONTAINER_ID,AGC.CONTAINER_NO, RECEIVE_QTY,RECEIVE_UOM_NAME, 
                    SAMPLE_QTY, SAMPLE_UOM_NAME, PASSED_QTY, PASSED_UOM_NAME, 
                    REJECTED_QTY, REJECTED_UOM_NAME
         
PARAMETER  :       PQTC.pQC_MST_ID = :pLAB_CONTROL_CODE  (COME FROM 3RD API ->LAB_CONTROL_CODE ) 

Table Name:   	   
                   PP_QC_TEST_CONTAINER PQTC
                   ADM_GRN_CONTAINER    = AGC

			  
Relation : 	  	
            
            AGC.ID = PQTC.CONTAINER_ID
			  
Filter by:  WHERE STATUS = 1 

GROUP BY: 

QUERY : 

SELECT PQTC.ID, QC_MST_ID, CONTAINER_ID,AGC.CONTAINER_NO, RECEIVE_QTY,FD_GET_BASE_UOM(PQTC.RECEIVE_UOM)RECEIVE_UOM_NAME, 
SAMPLE_QTY,FD_GET_BASE_UOM(PQTC.SAMPLE_UOM) SAMPLE_UOM_NAME, NVL(PASSED_QTY,0) PASSED_QTY,FD_GET_BASE_UOM(PQTC.PASSED_UOM) PASSED_UOM_NAME, 
NVL(REJECTED_QTY,0)REJECTED_QTY,FD_GET_BASE_UOM(PQTC.REJECTED_UOM) REJECTED_UOM_NAME
FROM PP_QC_TEST_CONTAINER PQTC
LEFT JOIN ADM_GRN_CONTAINER AGC ON AGC.ID = PQTC.CONTAINER_ID
WHERE PQTC.QC_MST_ID = :pQC_MST_ID --10077

----------------------------
--SAVE-UPDATE QC TEST RESULT DATA 10TH API

API TYPE : POST
API NAME : api/pp/insert-update-qct-data

JERP_PP_UTIL.PD_QC_TEST_RESULT Creation PROCEDURE

JERP_PP_UTIL.PD_QC_TEST_RESULT(pQCTR_MST       =>vQCTR_MST,
                      pQCTR_DTL       =>vQCTR_DTL,
                      pQCTR_CON       =>vQCTR_CON,
                      pQCTM_ID        =>vMst,
                      pUSER_ID        =>1,
                      pGRN_ID         =>3442,
                      pLAB_CODE       =>'LAB-00092/22',
                      pPROD_ID        =>6078,
                      pSBU_ID         =>2,
                      pIS_SUBMITTED   =>1,
                      pAS_FLAG        =>0, --  DEFAULT 0
                      pSTATUS         => vSTATUS
                      );


A. pQCTR_MST (JSON OBJECT)
Header = qctr_mst

OBJECT

GET_NUMBER('test_status');
GET_NUMBER('passed_qty');
GET_NUMBER('hold_qty');
GET_NUMBER('reject_qty');
GET_NUMBER('verified_by');
GET_STRING('verify_comments');
GET_STRING('re_test_date'), 'dd-mm-rrrr');
GET_STRING('expiry_date'), 'dd-mm-rrrr');
GET_NUMBER('potency')

 
 pQCTR_CON
B. pQCTR_DTL (JSON ARRAY)
Header = qctr_dtl

OBJECT

GET_NUMBER('id');
GET_STRING('test_result_value');
GET_STRING('remarks');

 
C. pQCTR_CON (JSON ARRAY)
Header = qctr_con

OBJECT

GET_NUMBER('id');
GET_NUMBER('container_id');
GET_NUMBER('receive_qty');
GET_NUMBER('receive_uom');
GET_NUMBER('sample_qty');
GET_NUMBER('sample_uom');
GET_NUMBER('passed_qty_con');
GET_NUMBER('passed_uom');
GET_NUMBER('rejected_qty');
GET_NUMBER('rejected_uom');

D. pQCTM_ID    IN OUT NUMBER,
    CREATE/INSERT MODE : pQCTM_ID  WILL BE NULL
    UPDATE MODE :  pQCTM_ID WILL COME FROM FRONT-END

E. pUSER_ID (Number)
 pUSER_ID number not null auth.user_id


F. pGRN_ID (Number)         (COME FROM 4TH API)

G. pLAB_CODE (VARCHAR2)     (COME FROM 4TH API)

H. pPROD_ID (Number)        (COME FROM 4TH API)

I. pSBU_ID (Number)

J. pIS_SUBMITTED (Number)

pIS_SUBMITTED number not null (0 for draft, 1 for submit)

K. pAS_FLAG (Number)

pAS_FLAG number default 0

L. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.

-------------------------------------------------------------


---CALLL

declare
    vSTATUS CLOB;
    vMst number:=10102; 
    vQCTR_MST CLOB := '{ "qctr_mst":[
                                  {
                                     "test_status":7031,
                                     "passed_qty":0,
                                     "hold_qty":0,
                                     "reject_qty":0,
                                     "verified_by":null,
                                     "verify_comments":null,
                                     "re_test_date":null,
                                     "expiry_date":null,
                                     "potency":50
                                  }
                                ]
                                }';
                                
    vQCTR_DTL CLOB :=  '{ "qctr_dtl":[
                                  {
                                     "id":10333,
                                     "test_id":10515,
                                     "test_name" : "Leak test",
                                     "specification": "specification 1",
                                     "reference": "reference1",
                                     "test_result_value":"PASS",
                                     "remarks":"rm1"
                                  },
                                  {
                                     "id":10334,
                                     "test_id":10551,
                                     "test_name" : "TEST PARENT",
                                     "specification": "specification 2",
                                     "reference": "reference2",
                                     "test_result_value":null,
                                     "remarks":null,
                                     "sub_test_dtl" : [
                                                     {
                                                     "id":10335,
                                                     "test_id":10552,
                                                     "test_name" : "CHILDE TEST 1",
                                                     "specification": "specification 3",
                                                     "reference": "reference3",
                                                     "test_result_value":"pass",
                                                     "remarks":"rmrk"
                                                     },
                                                     {
                                                     "id":10336,
                                                     "test_id":10553,
                                                     "test_name" : "CHILDE TEST 2",
                                                     "specification": "specification 4",
                                                     "reference": "reference4",
                                                     "test_result_value":null,
                                                     "remarks":null
                                                     }
                                                    ]
                                  }
                                ] 
                                }'; 
        vQCTR_CON CLOB := '{ "qctr_con": []
                          }';                      
                                 
BEGIN
    PD_QC_TEST_RESULT(pQCTR_MST       =>vQCTR_MST,
                      pQCTR_DTL       =>vQCTR_DTL,
                      pQCTR_CON       =>vQCTR_CON,
                      pQCTM_ID        =>vMst,
                      pUSER_ID        =>1,
                      pGRN_ID         =>3490,
                      pLAB_CODE       =>'LAB-00005/23',
                      pPROD_ID        =>6010,
                      pSBU_ID         =>2,
                      pIS_SUBMITTED   =>1,
                      pSTATUS         => vSTATUS
                      );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;

/*
DECLARE
    vSTATUS CLOB;
    vMst number:=10077; 
    vQCTR_MST CLOB := '{ "qctr_mst":[
                                  {
                                     "test_status":7031,
                                     "passed_qty":70,
                                     "hold_qty":0,
                                     "reject_qty":70,
                                     "verified_by":1,
                                     "verify_comments":null,
                                     "re_test_date":null,
                                     "expiry_date":null,
                                     "potency":50
                                  }
                                ]
                                }';
                                
    vQCTR_DTL CLOB :=  '{ "qctr_dtl":[
                                  {
                                     "id":10261,
                                     "test_id":10345,
                                     "test_result_value":"PASS",
                                     "remarks":"remarks-2"
                                  },
                                  {
                                     "id":10262,
                                     "test_id":10346,
                                     "test_result_value":"fail",
                                     "remarks":"rejected"
                                  }
                                ] 
                                }'; 
        vQCTR_CON CLOB := '{ "qctr_con": [
                                  {
                                      "id": 10002,
                                      "container_id": 10584,
                                      "receive_qty": 80,
                                      "receive_uom": 538,
                                      "sample_qty": 10,
                                      "sample_uom": 539,
                                      "passed_qty_con": 0,
                                      "passed_uom": 538,
                                      "rejected_qty": 70,
                                      "rejected_uom": 538
                                  },
                                  {
                                      "id": 10003,
                                      "container_id": 10585,
                                      "receive_qty": 80,
                                      "receive_uom": 538,
                                      "sample_qty": 10,
                                      "sample_uom": 539,
                                      "passed_qty_con": 70,
                                      "passed_uom": 538,
                                      "rejected_qty": 0,
                                      "rejected_uom": 538
                                  }
                                ]
                          }';                      
                                 
BEGIN
    PD_QC_TEST_RESULT(pQCTR_MST       =>vQCTR_MST,
                      pQCTR_DTL       =>vQCTR_DTL,
                      pQCTR_CON       =>vQCTR_CON,
                      pQCTM_ID        =>vMst,
                      pUSER_ID        =>1,
                      pGRN_ID         =>3442,
                      pLAB_CODE       =>'LAB-00092/22',
                      pPROD_ID        =>6078,
                      pSBU_ID         =>2,
                      pIS_SUBMITTED   =>1,
                      pSTATUS         => vSTATUS
                      );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;