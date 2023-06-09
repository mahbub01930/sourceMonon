
--Qry-1-left panel-

SELECT MCS.ID,MCS.DISPLAY_CODE,IMCS_DATE,POM.DISPLAY_CODE PO_NO,P.PROD_NAME MATERIAL_NAME 
FROM INC_MAT_CHECK_SHEET MCS
JOIN MM_PUR_ORD_MST POM ON MCS.LC_PO_NO=POM.ID
LEFT JOIN ADM_PRODUCTS P ON MCS.MAT_PROD_ID=P.ID;

--Qry-2-right panel-

SELECT MCS.ID, MCS.DISPLAY_CODE, IMCS_DATE, QUEST_ID, DOC_CHECK_LIST_ID, RECEIVE_DATE, RECEIVE_TIME, LC_PO_NO, MAT_PROD_ID,P.PROD_NAME, VEHICLE_NO, CONTAINER_SEAL_NO, GRN_ID, NOTES
from INC_MAT_CHECK_SHEET MCS
JOIN ADM_PRODUCTS P ON MCS.MAT_PROD_ID=P.ID
WHERE  MCS.ID=:pID;

--Qry-3 Document Chk and varification List-

SELECT AQTM.ID, AQTM.QTEMP_NAME, AQTM.DESCRIPTION, AQTM.TRN_TYPE, AC.CODE_NAME,AQTG.ID GROUP_ID,AQTG.GROUP_NAME,AQTG.DISPLAY_ORDER, 
AQTD.ID DETAIL_ID, AQTD.SL_NO, AQTD.QUESTION, AQTD.ANSWER_ARRAY, AQTD.ARRAY_SEPARATOR, AQTD.ANSWER_FIELD, AQTD.DEFAULT_ANSWER, AQTD.MANDATORY_FLAG
FROM ADM_QUEST_TEMP_DTL AQTD 
LEFT JOIN ADM_QUEST_TEMP_MST AQTM ON AQTM.ID = AQTD.QTEMP_ID
LEFT JOIN ADM_QUEST_TEMP_GROUP AQTG ON AQTG.ID = AQTD.QUEST_GROUP_ID
LEFT JOIN ADM_CODES AC ON AC.ID = AQTM.TRN_TYPE
WHERE  AQTM.ID=1010 AND AQTD.STATUS=1

/*
SELECT AQTD.ID, AQTD.SL_NO, AQTD.QEUSTION, AQTD.ANSWER_ARRAY, AQTD.ANSWER_FIELD, VQTAT.FIELD_TYPE,
       AQTD.DEFAULT_ANSWER, AQTD.MANDATORY_FLAG
FROM ADM_QUEST_TEMP_DTL AQTD
LEFT JOIN V_QUEST_TEMP_ANS_TYPE VQTAT ON VQTAT.FIELD_VALUE = AQTD.ANSWER_FIELD
WHERE AQTD.STATUS = 1
AND AQTD.QTEMP_ID = 1010;

--Qry-4 Document varification List-

SELECT AQTD.ID, AQTD.SL_NO, AQTD.QEUSTION, AQTD.ANSWER_ARRAY, AQTD.ANSWER_FIELD, VQTAT.FIELD_TYPE,
       AQTD.DEFAULT_ANSWER, AQTD.MANDATORY_FLAG
FROM ADM_QUEST_TEMP_DTL AQTD
LEFT JOIN V_QUEST_TEMP_ANS_TYPE VQTAT ON VQTAT.FIELD_VALUE = AQTD.ANSWER_FIELD
WHERE AQTD.STATUS = 1
AND AQTD.QTEMP_ID = 1011;
*/;
--Qry-5 container dtl data-

SELECT MC.ID, IMCS_ID, SL_NO, CONTAINER_NO, CONTAINER_TYPE,CE.ELEMENT_NAME, VOLUME,JERP_ADM.FD_GET_BASE_UOM(CONTAINER_UOM) UOM , IS_INTACT, REMARKS 
FROM INC_MAT_CONTAINER MC
JOIN ADM_CODE_ELEMENTS CE ON MC.CONTAINER_TYPE=CE.ID
WHERE  MC.IMCS_ID=:P_IMCS_ID;

--Qry-6 container type list-

SELECT ID,ELEMENT_NAME FROM ADM_CODE_ELEMENTS 
WHERE   CODE_KEY='CONTAINER_TYPE'
ORDER BY 1;

--Qry-7 lc_po_no list-

SELECT POM.ID,'Order No: '|| DISPLAY_CODE||', Order Date: '||PO_DATE||', Dep:'||SD.DISPLAY_NAME||',Supplier: '||S.SUPPLIER_NAME DISPLAY_VALUE
FROM MM_PUR_ORD_MST POM
JOIN ADM_SBU_DEPARTMENT SD ON POM.DEPARTMENT_ID = SD.ID
LEFT JOIN ADM_SUPPLIERS S ON POM.SUPPLIER_ID=S.ID;

--Qry-8 material list-

SELECT OD.ID,'Product: '||p.PROD_NAME||', Quentity:'|| PO_QTY||', Total Cost: '||ITEM_TOTAL_COST DISPLAY_VALUE
FROM MM_PUR_ORD_DTL OD
JOIN ADM_PRODUCTS P ON OD.PROD_ID=P.ID
WHERE  PO_ID=:P_PO_ID
