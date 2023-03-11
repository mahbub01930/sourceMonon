--1

SELECT ID,ELEMENT_NAME FROM ADM_CODE_ELEMENTS
WHERE CODE_KEY='QC_TRAN_TYPE';

--2,9

SELECT ID,ELEMENT_NAME FROM ADM_CODE_ELEMENTS A
WHERE CODE_KEY='QC_STAGE';

--3
SELECT G.ID GRN_ID,GRN_NO,TRUNC(GRN_DATE) GRN_DATE,GD.PROD_ID,P.PROD_NAME 
FROM ADM_GRN G
JOIN ADM_GRN_DETAIL GD ON G.ID=GD.GRN_ID
LEFT JOIN ADM_PRODUCTS P ON GD.PROD_ID=P.ID
WHERE  QC_REQUIRED='Y' 
AND QC_PASS_STATUS =:pQC_PASS_STATUS;


--4
SELECT GD.ID,GD.GRN_ID,GRN_NO,TRUNC(GRN_DATE) GRN_DATE,GD.PROD_ID,P.PROD_NAME,BATCH_LOT_NO,COUNT(GC.GRNDTL_ID) TOT_CONT_NO
FROM ADM_GRN G
JOIN ADM_GRN_DETAIL GD ON G.ID=GD.GRN_ID
LEFT JOIN ADM_PRODUCTS P ON GD.PROD_ID=P.ID
LEFT JOIN ADM_GRN_CONTAINER GC ON GD.ID=GC.GRNDTL_ID
WHERE  QC_REQUIRED='Y' 
AND GD.GRN_ID=:pGRN_ID
AND GD.PROD_ID=:pPROD_ID
GROUP BY GD.ID,GD.GRN_ID,GRN_NO,TRUNC(GRN_DATE),GD.PROD_ID,P.PROD_NAME,BATCH_LOT_NO; 

---5--MST-DATA

SELECT QSA.ID, QC_PERSON_ID1,P1.EMP_NAME PERSON1_NAME, QC_PERSON_ID2,P2.EMP_NAME PERSON2_NAME, LAB_CONTROL_CODE, SAMPLING_STAGE,QC_STATUS,CE.ELEMENT_NAME 
FROM PP_QC_SAMPLE_ASSIGN QSA
LEFT JOIN HRM_EMPLOYEE P1 ON QSA.QC_PERSON_ID1=P1.EMP_ID
LEFT JOIN HRM_EMPLOYEE P2 ON QSA.QC_PERSON_ID2=P2.EMP_ID
LEFT JOIN ADM_CODE_ELEMENTS CE ON QSA.QC_STATUS=CE.ID
WHERE TRANSACTION_TYPE =:pTRANSACTION_TYPE --1NO API
AND TRANSACTION_ID =:pTRANSACTION_ID  --4 NO API GRN_ID
AND PROD_ID = :pPROD_ID  --4 NO API PROD_ID
AND PART_LOT_NO =:pPART_LOT_NO --4 NO API PROD_ID

---6--DTL DATA
SELECT QCS.ID,QC_SAMPLE_ID,CONTAINER_NO,SAMPLING_TIME,SAMPLING_BY,HE.EMP_NAME SAMPLING_BY_NAME, SAMPLE_QTY, 
SAMPLE_UOM,JERP_ADM.FD_GET_BASE_UOM(SAMPLE_UOM) UOM, SAMPLE_FOR 
FROM PP_QC_SAMPLING QCS
LEFT JOIN HRM_EMPLOYEE HE ON QCS.SAMPLING_BY=HE.EMP_ID
WHERE QC_SAMPLE_ID=:pQC_SAMPLE_ID

--7,8

SELECT HE.EMP_ID,HE.EMP_NAME,HD.DESIG_NAME,HDE.DEPARTMENT_NAME 
FROM HRM_EMPLOYEE HE 
LEFT JOIN HRM_DESIGNATION HD ON HE.DESIGNATION_ID=HD.ID
LEFT JOIN HRM_DEPARTMENT HDE ON HE.DEPARTMENT_ID=HDE.ID
WHERE HE.DESIGNATION_ID IS NOT NULL
AND HE.DEPARTMENT_ID IS NOT NULL;


--9
SELECT ID,ELEMENT_NAME FROM ADM_CODE_ELEMENTS A
WHERE CODE_KEY='QC_STAGE';

--10
SELECT CONTAINER_NO FROM ADM_GRN_CONTAINER 
WHERE GRN_ID=:pGRN_ID
AND GRNDTL_ID=:pGRNDTL_ID

------call---


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