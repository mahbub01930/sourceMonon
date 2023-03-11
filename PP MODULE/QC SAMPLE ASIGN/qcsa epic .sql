Feature Name : QC - Sample Advice

Description : QC Sample Details data will be enter here

Design Link : 

From : WEB 

Users : 

Constraint:

User must be logged in

User info available

Check auth token for every request

Check SBU_ID

Tables/Data Source:

PP_QC_SAMPLE_ASSIGN, PP_QC_SAMPLING

------------------------------------------------------------------------------

--LEFT PANEL LIST (LANDING MODE)-1ST API
API TYPE : GET
API NAME : api/pp/get-trn-type-list

Response Fields :  
                    ELEMENT_NAME
	  
Operational Fields: 
                ID,ELEMENT_NAME
         
PARAMETER  : 

Table Name:   	ADM_CODE_ELEMENTS


Relation : 	  	
    
Filter by:  WHERE CODE_KEY='QC_TRAN_TYPE' and STATUS = 1 

QUERY : 

SELECT ID,ELEMENT_NAME FROM ADM_CODE_ELEMENTS
WHERE CODE_KEY='QC_TRAN_TYPE';


------------------------------------------------------------------------------

--LEFT PANEL LIST (LANDING MODE)-2ND API (QC STAGE LIST)

API TYPE : GET
API NAME : api/pp/qc-stage-list

Response Fields :  
                    ELEMENT_NAME
	  
Operational Fields: 
                    ID,ELEMENT_NAME
         
PARAMETER  :        

Table Name:   	    ADM_CODE_ELEMENTS

			  
Relation : 	  	
                    MCS.MAT_PROD_ID =P.ID
			  
Filter by:  WHERE CODE_KEY='QC_STAGE' AND  STATUS = 1 ;

QUERY : 

SELECT ID,ELEMENT_NAME,DISPLAY_VALUE FROM ADM_CODE_ELEMENTS A
WHERE CODE_KEY='QC_STAGE';


------------------------------------------------------------------------------

--LEFT PANEL LIST (LANDING MODE)(GRN LIST) 3RD API

API TYPE : GET
API NAME : api/pp/get-grn-list

Response Fields :  
                    GRN_NO,GRN_DATE,GD.PROD_ID,P.PROD_NAME 
	  
Operational Fields: 
                    G.ID,GRN_NO,GRN_DATE,GD.PROD_ID,P.PROD_NAME 
         
PARAMETER  :        QC_PASS_STATUS  = :pQC_STAGE (COME FROM 2ND API (qc-stage-list))

Table Name:   	    ADM_GRN         = G
                    ADM_GRN_DETAIL  = GD
                    ADM_PRODUCTS    = P

			  
Relation : 	  	
                    G.ID        = GD.GRN_ID
                    GD.PROD_ID  = P.ID
			  
Filter by:  WHERE STATUS = 1 AND QC_REQUIRED='Y'

QUERY : 

SELECT G.ID GRN_ID,GRN_NO,TRUNC(GRN_DATE) GRN_DATE,GD.PROD_ID,P.PROD_NAME 
FROM ADM_GRN G
JOIN ADM_GRN_DETAIL GD ON G.ID=GD.GRN_ID
LEFT JOIN ADM_PRODUCTS P ON GD.PROD_ID=P.ID
WHERE  QC_REQUIRED='Y' 
AND QC_PASS_STATUS =:pQC_STAGE;


------------------------------------------------------------------------------

----RIGHT PANEL DATA (LANDING MODE)-AFTER CLICK THE LEFT PANEL 3RD API) -4TH API 

API TYPE : GET
API NAME : api/pp/get-prod-loat-data

Response Fields :  
                    GD.ID,GD.GRN_ID,GRN_NO,GRN_DATE,GD.PROD_ID,P.PROD_NAME,BATCH_LOT_NO,COUNT(GC.GRNDTL_ID) AS TOT_CONT_NO
	  
Operational Fields: 
                    GD.ID,GD.GRN_ID,GRN_NO,GRN_DATE,GD.PROD_ID,P.PROD_NAME,BATCH_LOT_NO,COUNT(GC.GRNDTL_ID) AS TOT_CONT_NO
         
PARAMETER  :        GD.GRN_ID  = :pGRN_ID  (COME FROM 3RD API)
                    GD.PROD_ID = :pPROD_ID (COME FROM 3RD API)

Table Name:   	    ADM_GRN             = G
                    ADM_GRN_DETAIL      = GD
                    ADM_PRODUCTS        = P
                    ADM_GRN_CONTAINER   = GC

			  
Relation : 	  	
                    G.ID        = GD.GRN_ID
                    GD.PROD_ID  = P.ID
                    GD.ID       = GC.GRNDTL_ID
			  
Filter by:  WHERE STATUS = 1 AND QC_REQUIRED='Y' 

GROUP BY: GD.ID,GD.GRN_ID,GRN_NO,GRN_DATE,GD.PROD_ID,P.PROD_NAME,BATCH_LOT_NO

QUERY : 

SELECT GD.ID,GD.GRN_ID,GRN_NO,TO_CHAR(GRN_DATE,'DD-MON-YYYY') GRN_DATE,GD.PROD_ID,P.DISPLAY_NAME AS PROD_NAME,P.DISPLAY_CODE, BATCH_LOT_NO,GD.CONTAINER_COUNT AS TOT_CONT_NO,NVL(GD.RCV_QTY,0) AS TOTAL_QUENTITY
FROM ADM_GRN G
JOIN ADM_GRN_DETAIL GD ON G.ID=GD.GRN_ID
--LEFT JOIN ADM_PRODUCTS P ON GD.PROD_ID=P.ID
LEFT JOIN ADM_SBU_PRODUCTS P ON GD.PROD_ID=P.PROD_ID AND G.SBU_ID = P.SBU_ID
--LEFT JOIN ADM_GRN_CONTAINER GC ON GD.ID=GC.GRNDTL_ID
WHERE  QC_REQUIRED='Y' 
AND GD.GRN_ID=:pGRN_ID
AND GD.PROD_ID=:pPROD_ID

--GROUP BY GD.ID,GD.GRN_ID,GRN_NO, GRN_DATE,GD.PROD_ID,P.DISPLAY_NAME ,P.DISPLAY_CODE, BATCH_LOT_NO,GD.CONTAINER_COUNT ; 




------------------------------------------------------------------------------

----QC Sample Asign MASTER INFO DATA-5TH API 

API TYPE : GET
API NAME : api/pp/get-qcs-mst-data

Response Fields :  
                    QSA.ID, P1.EMP_NAME AS PERSON1_NAME,P2.EMP_NAME AS PERSON2_NAME, LAB_CONTROL_CODE, SAMPLING_STAGE,CE.ELEMENT_NAME 
	  
Operational Fields: 
                    QSA.ID, QC_PERSON_ID1,P1.EMP_NAME AS PERSON1_NAME, QC_PERSON_ID2,P2.EMP_NAME AS PERSON2_NAME, LAB_CONTROL_CODE, SAMPLING_STAGE,QC_STATUS,CE.ELEMENT_NAME  
         
PARAMETER  :        TRANSACTION_TYPE = :pTRANSACTION_TYPE --1NO API
                    TRANSACTION_ID   = :pTRANSACTION_ID  --4 NO API GRN_ID
                    PROD_ID          = :pPROD_ID  --4 NO API PROD_ID
                    PART_LOT_NO      = :pPART_LOT_NO --4 NO API BATCH_LOT_NO

Table Name:   	    PP_QC_SAMPLE_ASSIGN = QSA
                    HRM_EMPLOYEE        = P1
                    HRM_EMPLOYEE        = P2
                    ADM_CODE_ELEMENTS   = CE

			  
Relation : 	  	
                    QSA.QC_PERSON_ID1 = P1.EMP_ID
                    QSA.QC_PERSON_ID2 = P2.EMP_ID
                    QSA.QC_STATUS     = CE.ID
			  
Filter by:  WHERE STATUS = 1 


QUERY : 

SELECT QSA.ID, QC_PERSON_ID1,P1.EMP_NAME AS PERSON1_NAME, QC_PERSON_ID2,P2.EMP_NAME AS PERSON2_NAME, LAB_CONTROL_CODE, SAMPLING_STAGE,QC_STATUS,CE.ELEMENT_NAME 
FROM PP_QC_SAMPLE_ASSIGN QSA
LEFT JOIN HRM_EMPLOYEE P1 ON QSA.QC_PERSON_ID1=P1.ID
LEFT JOIN HRM_EMPLOYEE P2 ON QSA.QC_PERSON_ID2=P2.ID
LEFT JOIN ADM_CODE_ELEMENTS CE ON QSA.QC_STATUS=CE.ID
WHERE TRANSACTION_TYPE =:pTRANSACTION_TYPE 
AND TRANSACTION_ID =:pTRANSACTION_ID  
AND PROD_ID = :pPROD_ID;


------------------------------------------------------------------------------

--QC SAMPLE ASIGN DETAILS INFO DATA -6TH API


API TYPE : GET
API NAME : api/pp/get-qcs-dtl-data

Response Fields :   CONTAINER_NO,SAMPLING_TIME,HE.EMP_NAME AS SAMPLING_BY_NAME, SAMPLE_QTY, 
                    JERP_ADM.FD_GET_BASE_UOM(SAMPLE_UOM) AS UOM, SAMPLE_FOR 
	  
Operational Fields: 
                    QCS.ID,QC_SAMPLE_ID,CONTAINER_NO,SAMPLING_TIME,SAMPLING_BY,HE.EMP_NAME AS SAMPLING_BY_NAME, SAMPLE_QTY, 
                    SAMPLE_UOM,JERP_ADM.FD_GET_BASE_UOM(SAMPLE_UOM) AS UOM, SAMPLE_FOR  
         
PARAMETER  :       QC_SAMPLE_ID = :pQC_SAMPLE_ID (5NO API (ID COLUMN))
                    

Table Name:   	    PP_QC_SAMPLING  = QCS
                    HRM_EMPLOYEE    = HE
			  
Relation : 	  	
                    QCS.SAMPLING_BY = HE.EMP_ID
              
			  
Filter by:  WHERE STATUS = 1 


QUERY : 

SELECT QCS.ID,QC_SAMPLE_ID,CONTAINER_ID,AGC.CONTAINER_NO, SAMPLING_TIME,SAMPLING_BY,HE.EMP_NAME AS SAMPLING_BY_NAME, 
SAMPLE_QTY, 
SAMPLE_UOM,JERP_ADM.FD_GET_BASE_UOM(SAMPLE_UOM) AS UOM, SAMPLE_FOR 
FROM PP_QC_SAMPLING QCS
LEFT JOIN HRM_EMPLOYEE HE ON QCS.SAMPLING_BY=HE.ID
LEFT JOIN ADM_GRN_CONTAINER AGC ON AGC.ID = QCS.CONTAINER_ID
WHERE QC_SAMPLE_ID=:pQC_SAMPLE_ID;

------------------------------------------------------------------------------

--PERSON 1 AND 2 List 7TH  & 8TH API

API TYPE : GET
API NAME : api/pp/get-person-list

Response Fields :  
                    HE.EMP_ID,HE.EMP_NAME,HD.DESIG_NAME,HDE.DEPARTMENT_NAME 
	  
Operational Fields: 
                    HE.EMP_ID,HE.EMP_NAME,HD.DESIG_NAME,HDE.DEPARTMENT_NAME 
         
PARAMETER  :        

Table Name:   	HRM_EMPLOYEE      = HE
                HRM_DESIGNATION   = HD,
                HRM_DEPARTMENT    = HDE
          
Relation : 	  	HE.DESIGNATION_ID = HD.ID
                HE.DEPARTMENT_ID  = HDE.ID

Filter by:  WHERE STATUS = 1  AND HE.DESIGNATION_ID IS NOT NULL AND HE.DEPARTMENT_ID IS NOT NULL

QUERY : 

SELECT HE.EMP_ID,HE.EMP_NAME,HD.DESIG_NAME,HDE.DEPARTMENT_NAME
FROM HRM_EMPLOYEE HE 
LEFT JOIN HRM_DESIGNATION HD ON HE.DESIGNATION_ID=HD.ID
LEFT JOIN HRM_DEPARTMENT HDE ON HE.DEPARTMENT_ID=HDE.ID
WHERE HE.DESIGNATION_ID IS NOT NULL
AND HE.DEPARTMENT_ID IS NOT NULL;


------------------------------------------------------------------------------

--9TH API (2ND API)

------------------------------------------------------------------------------

--CONTAINER LIST 10TH API

API TYPE : GET
API NAME : api/pp/get-container-list

Response Fields :  
                    CONTAINER_NO
	  
Operational Fields: 
                    ID,CONTAINER_NO 
         
PARAMETER  :      GRN_ID    = :pGRN_ID --4NO API GRN_ID COLUMN
                  GRNDTL_ID = :pGRNDTL_ID;--  4NO API ID COLUMN

Table Name:   	 ADM_GRN_CONTAINER
          
Relation : 	  	
               

Filter by:  WHERE STATUS = 1  

QUERY : 

SELECT AGC.ID,CONTAINER_NO,CON_VOLUMN,CON_VOLUMN_UOM,ACE.ELEMENT_NAME AS CON_VOLUMN_UOM_NAME
FROM ADM_GRN_CONTAINER AGC
LEFT JOIN ADM_CODE_ELEMENTS ACE ON AGC.CON_VOLUMN_UOM = ACE.ID
WHERE GRN_ID=:pGRN_ID 
AND GRNDTL_ID=:pGRNDTL_ID
ORDER BY CONTAINER_NO ASC

--11TH API (PERSON 1 AND 2 List 7TH  & 8TH API)

--12--new for sticker/lable


API TYPE : GET
API NAME : api/pp/get-sticker-type-list/{pTRAN_TYPE}

Response Fields :  ELEMENT_NAME

	  
Operational Fields: ID 

         
PARAMETER  :       pTRAN_TYPE (COME FROM 1ST API ->(get-trn-type-list) ) 

Table Name:   	   FUNCTION JERP_PP_UTIL.DFN_QC_STICKER_TYPE_LIST (pTRAN_TYPE NUMBER)

 
Relation : 	
            

Filter by:   

GROUP BY: 

QUERY : 

SELECT JERP_PP_UTIL.DFN_QC_STICKER_TYPE_LIST (7161) FROM DUAL 

------------------------------------------------------------------------------
--13- NO API-new for sticker/lable

API TYPE : GET
API NAME : api/pp/get-container-list-sticker/{pGRN_ID}

Response Fields :  
                    CONTAINER_DESC
	  
Operational Fields: 
                    CONTAINER_NO 
         
PARAMETER  :      GRN_ID    = :pGRN_ID --4NO API GRN_ID COLUMN (get-prod-loat-data)

Table Name:   	 ADM_GRN_CONTAINER
          
Relation : 	  	

Filter by:  WHERE STATUS = 1  

QUERY : 

SELECT CONTAINER_NO,'Container No - '||CONTAINER_NO  CONTAINER_DESC 
FROM ADM_GRN_CONTAINER
WHERE GRN_ID = :pGRN_ID --3419;

-----14
API TYPE : GET
API NAME : api/pp/get-sticker-print-data/{pSTICKER_TYPE}/{pINPUT}


JERP_PP_UTIL.DFN_STICKER_PRINT Creation PROCEDURE

 
JERP_PP_UTIL.PD_STICKER_PRINT  (pSTICKER_TYPE IN NUMBER,pINPUT IN CLOB,pOUTPUT OUT CLOB)


A. pSTICKER_TYPE (Number)

B.pINPUT (JSON OBJECT)
Header = input

OBJECT
 
GET_NUMBER('transaction_id'); --3024
GET_NUMBER('prod_id'); --6038
GET_STRING('container_no'); --"1,2"
GET_NUMBER('sbu_id'); --2

C. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.


--DECLARE
    VPOUTPUT        CLOB;
    vINPUT CLOB :='{"input":
                        {
                          "transaction_id":3024,
                          "prod_id":6038,
                          "container_no":"1,2",
                          "sbu_id":2
                        }
                    }';
BEGIN
 PD_STICKER_PRINT (pSTICKER_TYPE    => 7460,
                   pINPUT       => vINPUT,
                   POUTPUT        => VPOUTPUT
                 ); 
DBMS_OUTPUT.PUT_LINE(VPOUTPUT);
END;

------------------------------------------------------------------------------


--SAVE-UPDATE QC Sample Asign () DATA -12TH API

API TYPE : POST
API NAME : api/pp/insert-update-qcs-data

JERP_ADM.PD_QC_SAMPLE Creation PROCEDURE

JERP_ADM.PD_IMCS  (pQCS_MST   IN  CLOB,
                   pQCS_DTL   IN  CLOB,
                   pUSER_ID   IN  NUMBER,
                   pQCS_ID    IN  OUT  NUMBER,
                   pSBU_ID    IN  NUMBER,
                   pSTATUS    OUT CLOB
                  )


A. pQCS_MST (JSON OBJECT)
Header = qcs_mst

OBJECT
 
GET_NUMBER('transaction_type');
GET_NUMBER('transaction_id');
GET_STRING('lab_control_code');
GET_NUMBER('prod_id');
GET_STRING('part_lot_no');
GET_STRING('total_container_no');
GET_NUMBER('qc_person_id1');
GET_NUMBER('qc_person_id2');
GET_STRING('sampling_stage');
GET_NUMBER('qc_status');
GET_NUMBER('sort_order');

 
 
B. pQCS_DTL (JSON ARRAY)
Header = qcs_dtl

OBJECT
 

GET_NUMBER('id');
GET_NUMBER('container_no');
GET_STRING('sampling_time'), 'dd-mm-rrrr hh12:mi:ss am');
GET_NUMBER('sampling_by');
GET_NUMBER('sample_qty');
GET_NUMBER('sample_uom');
GET_STRING('sample_for');
GET_NUMBER('sort_order');



C. pUSER_ID (Number)
 pUSER_ID number not null auth.user_id


D. pQCS_ID    IN OUT NUMBER,
    CREATE/INSERT MODE : pQCS_ID  WILL BE NULL
    UPDATE MODE :  pQCS_ID WILL COME FROM FRONT-END


E. pSBU_ID (Number)

    pSBU_ID number not null ()

F. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.

-------------------------------------------------------------
--delete api-

API NAME : api/pp/delete-qcs-dtl-data/{pSAMPL_DTL_ID}

DELETE FROM PP_QC_SAMPLING
WHERE ID = :pSAMPL_DTL_ID --10033

--------------------------------------------------------------

---CALLL

DECLARE
    vSTATUS CLOB;
    vMst number:=null; 
    vQCS_MST CLOB := '{ "qcs_mst":[
                                  {
                                     "transaction_type":7161,
                                     "transaction_id":2838,
                                     "lab_control_code":"Lab-01",
                                     "prod_id":1001,
                                     "part_lot_no":"07752",
                                     "total_container_no":"2",
                                     "qc_person_id1":01502,
                                     "qc_person_id2":02573,
                                     "sampling_stage":"ss1",
                                     "qc_status":7427,
                                     "sort_order":1
                                  }
                                ]
                                }';
                                
    vQCS_DTL CLOB :=  '{ "qcs_dtl":[
                                  {
                                     "id":null,
                                     "container_no":1,
                                     "sampling_time":"18-09-2022 11:12:00 AM",
                                     "sampling_by":01798,
                                     "sample_qty": 1,
                                     "sample_uom":534,
                                     "sample_for":"NJML",
                                     "sort_order":1
                                  },
                                    {
                                     "id":null,
                                     "container_no":2,
                                     "sampling_time":"18-09-2022 11:12:00 AM",
                                     "sampling_by":01798,
                                     "sample_qty": 2,
                                     "sample_uom":534,
                                     "sample_for":"NJML",
                                     "sort_order":2
                                  }
                                ] 
                                }';  
                                
BEGIN
    PD_QC_SAMPLE  (pQCS_MST       => vQCS_MST,
              pQCS_DTL       =>vQCS_DTL,
              pUSER_ID        =>1,
              pQCS_ID        =>vMst,
              pSTATUS         => vSTATUS
              );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;