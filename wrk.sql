SELECT DM.ID BATCH_DOC_ID, DM.DISPLAY_CODE, DT.PROD_ID MST_PROD_ID, AP.PROD_NAME MST_PROD_NAME, DT.REQUIRED_NO_OF_BATCH, ACE.ELEMENT_NAME DOC_TYPE, BD.MAT_PROD_ID MATERIAL_ID, APP.PROD_NAME MATERIAL_NAME, BD.BATCH_QTY, BD.UOM, FD_GET_BASE_UOM(BD.UOM) AS UOM_NAME
, BD.IS_BMR, PB.BATCH_NO, PB.ID BATCH_ID, NVL(ISD.APPROVE_QTY,0) ISSUE_QTY
FROM PP_BATCH_DOC_MST DM 
JOIN PP_BATCH_DOC_DTL DT ON DM.ID=DT.DOC_REQ_ID
LEFT JOIN ADM_PRODUCTS AP ON DT.PROD_ID=AP.ID
LEFT JOIN ADM_CODE_ELEMENTS ACE ON DT.DOC_TYPE=ACE.ID
LEFT JOIN PP_BOM_MST BM ON DT.PROD_ID=BM.MAT_PROD_ID
LEFT JOIN PP_BOM_DTL BD ON BM.ID=BD.BOM_ID
LEFT JOIN ADM_PRODUCTS APP ON BD.MAT_PROD_ID=APP.ID
LEFT JOIN (SELECT DISTINCT BATCH_DOC_REQ_ID, BATCH_ID FROM PP_PROD_BATCH_MAP) PBM ON PBM.BATCH_DOC_REQ_ID=DM.ID
LEFT JOIN PP_PRODUCT_BATCH PB ON PBM.BATCH_ID=PB.ID
LEFT JOIN MM_INT_ISS_MST IM ON PB.ID=IM.FOR_BATCHES AND PB.PROD_ID=IM.FOR_PRODUCTS
LEFT JOIN MM_INT_ISS_DTL ISD ON IM.ID=ISD.ISS_ID AND BD.MAT_PROD_ID=ISD.PROD_ID
WHERE DM.ID=10233 
--WHERE (ISD.ID IS NULL OR BD.BATCH_QTY<NVL(ISD.APPROVE_QTY,0))
AND (ISD.ID IS NULL OR BD.BATCH_QTY<NVL(ISD.APPROVE_QTY,0))
ORDER BY DT.PROD_ID, BD.MAT_PROD_ID;



SELECT DM.ID BATCH_DOC_ID, DM.DISPLAY_CODE, DT.PROD_ID MST_PROD_ID, AP.PROD_NAME MST_PROD_NAME, DT.REQUIRED_NO_OF_BATCH, ACE.ELEMENT_NAME DOC_TYPE, BD.MAT_PROD_ID MATERIAL_ID, APP.PROD_NAME MATERIAL_NAME, BD.BATCH_QTY, BD.UOM, FD_GET_BASE_UOM(BD.UOM) AS UOM_NAME
, BD.IS_BMR
FROM PP_BATCH_DOC_MST DM 
JOIN PP_BATCH_DOC_DTL DT ON DM.ID=DT.DOC_REQ_ID
LEFT JOIN ADM_PRODUCTS AP ON DT.PROD_ID=AP.ID
LEFT JOIN ADM_CODE_ELEMENTS ACE ON DT.DOC_TYPE=ACE.ID
LEFT JOIN PP_BOM_MST BM ON DT.PROD_ID=BM.MAT_PROD_ID
LEFT JOIN PP_BOM_DTL BD ON BM.ID=BD.BOM_ID
LEFT JOIN ADM_PRODUCTS APP ON BD.MAT_PROD_ID=APP.ID;

SELECT DISTINCT BATCH_DOC_REQ_ID, BATCH_ID FROM PP_PROD_BATCH_MAP;

SELECT MIRM.ID REQ_MST_ID--PBDD.DOC_REQ_ID,PBM.BATCH_ID,MIRM.ID REQ_MST_ID
FROM PP_BATCH_DOC_DTL PBDD
LEFT JOIN (SELECT DISTINCT BATCH_DOC_REQ_ID, BATCH_ID FROM PP_PROD_BATCH_MAP) PBM ON PBM.BATCH_DOC_REQ_ID=PBDD.DOC_REQ_ID
--LEFT JOIN PP_PRODUCT_BATCH PPB ON PPB.BATCH_DOC_REQ_ID = PBDD.DOC_REQ_ID
LEFT JOIN MM_INT_REQ_MST MIRM ON MIRM.FOR_BATCHES = PBM.BATCH_ID
WHERE PBDD.PROD_ID=200
GROUP BY MIRM.ID;

SELECT REQ_ID,PROD_ID,SUM(ISSUED_QTY) FROM MM_INT_REQ_DTL
--WHERE REQ_ID =1261
GROUP BY REQ_ID,PROD_ID;


SELECT PROD_ID,SUM(ISSUED_QTY) FROM MM_INT_REQ_DTL
WHERE REQ_ID IN (1261,1290,1293,1295,1262)
GROUP BY PROD_ID;

----BOOKING QUENTITY

SELECT B.PROD_ID,SUM(B.ISSUED_QTY) BOOK_QTY FROM (
SELECT MIRM.ID REQ_MST_ID--PBDD.DOC_REQ_ID,PBM.BATCH_ID,MIRM.ID REQ_MST_ID
FROM PP_BATCH_DOC_DTL PBDD
LEFT JOIN (SELECT DISTINCT BATCH_DOC_REQ_ID, BATCH_ID FROM PP_PROD_BATCH_MAP) PBM ON PBM.BATCH_DOC_REQ_ID=PBDD.DOC_REQ_ID
--LEFT JOIN PP_PRODUCT_BATCH PPB ON PPB.BATCH_DOC_REQ_ID = PBDD.DOC_REQ_ID
LEFT JOIN MM_INT_REQ_MST MIRM ON MIRM.FOR_BATCHES = PBM.BATCH_ID
WHERE PBDD.PROD_ID=200
GROUP BY MIRM.ID)A,(
SELECT REQ_ID,PROD_ID,SUM(ISSUED_QTY) ISSUED_QTY FROM MM_INT_REQ_DTL
--WHERE REQ_ID =1261
GROUP BY REQ_ID,PROD_ID)B
WHERE A.REQ_MST_ID=B.REQ_ID
GROUP BY B.PROD_ID;

-----------------

SELECT * FROM (
SELECT PBD.MAT_PROD_ID,ASP.DISPLAY_NAME, NVL(BATCH_QTY,0) BATCH_QTY, UOM,NVL(BATCH_QTY,0)*NVL(:pNO_OF_BATCH,1) REQUIRED_QTY,
JERP_INVENTORY_UTIL.AVAILABLE_QUANTITY(JERP_INVENTORY_UTIL.GET_STORE(DECODE (JERP_PP_UTIL.FD_GET_MATERIAL_CODE(PBD.MAT_PROD_ID), 'RM', 205, 'PM', 206),'OUT'), PBD.MAT_PROD_ID) AVAILABLE_QTY,
ACE.ELEMENT_NAME
FROM PP_BOM_DTL PBD
LEFT JOIN PP_BOM_MST PBM ON PBM.ID = PBD.BOM_ID
LEFT JOIN ADM_SBU_PRODUCTS ASP ON ASP.PROD_ID = PBD.MAT_PROD_ID
LEFT JOIN ADM_CODE_ELEMENTS ACE ON  ACE.ID=PBD.UOM
WHERE PBM.MAT_PROD_ID=:pPROD_ID
AND ( (:pDOC_TYPE = '10050' AND IS_BMR ='Y')
OR (:pDOC_TYPE = '10051' AND IS_BMR ='N')
OR (:pDOC_TYPE = '10052' AND IS_BMR IN ('Y','N'))
)
) RAVQ
LEFT JOIN (
SELECT B.PROD_ID,SUM(B.ISSUED_QTY) BOOK_QTY FROM (
SELECT MIRM.ID REQ_MST_ID--PBDD.DOC_REQ_ID,PBM.BATCH_ID,MIRM.ID REQ_MST_ID
FROM PP_BATCH_DOC_DTL PBDD
LEFT JOIN (SELECT DISTINCT BATCH_DOC_REQ_ID, BATCH_ID FROM PP_PROD_BATCH_MAP) PBM ON PBM.BATCH_DOC_REQ_ID=PBDD.DOC_REQ_ID
LEFT JOIN MM_INT_REQ_MST MIRM ON MIRM.FOR_BATCHES = PBM.BATCH_ID
WHERE PBDD.PROD_ID=:pPROD_ID
GROUP BY MIRM.ID)A,(
SELECT REQ_ID,PROD_ID,SUM(ISSUED_QTY) ISSUED_QTY FROM MM_INT_REQ_DTL
--WHERE REQ_ID =1261
GROUP BY REQ_ID,PROD_ID)B
WHERE A.REQ_MST_ID=B.REQ_ID
GROUP BY B.PROD_ID
) BQ ON RAVQ.MAT_PROD_ID = BQ.PROD_ID













---

WITH Q1 AS (
SELECT COUNT(*) CNT
FROM PP_PRODUCT_BATCH PB
JOIN ADM_PRODUCTS P ON PB.PROD_ID=P.ID
AND PB.IS_TRANSFERED='N'
AND PB.IS_CLOSED='N'
AND PB.ID IN (SELECT BATCH_ID FROM PP_BATCH_RECON_MST)
), Q2 AS (
SELECT PB.ID BATCH_ID,PB.PROD_ID,P.PROD_NAME,P.PROD_CODE,PB.BATCH_NO,PB.MFG_DATE,PB.EXP_DATE
FROM PP_PRODUCT_BATCH PB
JOIN ADM_PRODUCTS P ON PB.PROD_ID=P.ID
AND PB.IS_TRANSFERED='N'
AND PB.IS_CLOSED='N'
AND PB.ID IN (SELECT BATCH_ID FROM PP_BATCH_RECON_MST)
)
SELECT JSON_ARRAYAGG(
      JSON_OBJECT(
                'success' VALUE 'true',
                'response_code' VALUE 200,
                'message' VALUE 'Success.',
                'count_data' VALUE A.CNT,
                'prod_batch_list' VALUE (
                        SELECT JSON_ARRAYAGG(
               JSON_OBJECT(
               'batch_id' VALUE B.BATCH_ID,
               'prod_id' VALUE B.PROD_ID,
               'batch_no' VALUE B.BATCH_NO,
               'mfg_date' VALUE B.MFG_DATE,
               'exp_date' VALUE B.EXP_DATE,
               'get_adm_products' VALUE (
                                        SELECT JSON_ARRAYAGG(
                                               JSON_OBJECT(
                                                           'id' VALUE C.PROD_ID,
                                                           'prod_name' VALUE C.PROD_NAME,
                                                           'prod_code' VALUE C.PROD_CODE
                                               )--OB3
                                        ) FROM (SELECT * FROM Q2 WHERE PROD_ID=B.PROD_ID) C
                                        )
               )-- OB2
        ) FROM (SELECT * FROM Q2) B
                )
      ) --RETURN CLOB OB1
) FROM (SELECT * FROM Q1) A


---
SELECT A.WH_NAME,A.SALES CASH_SALES, A.COLLECTION CASH_COLLECTION,A.DUE CASH_DUE,a.RETURN_TOTAL CASH_RETURN,
B.SALES CREDIT_SALES,B.COLLECTION CREDIT_COLLECTION,B.DUE CREDIT_DUE,b.RETURN_TOTAL CREDIT_RETURN,
(A.SALES+B.SALES) tot_sal,(A.COLLECTION+B.COLLECTION) tot_collec,(A.DUE+B.DUE) tot_due,(A.RETURN_TOTAL+B.RETURN_TOTAL) tot_return
 FROM (
SELECT AW.WH_CODE,AW.WH_NAME,SSI.IS_CREDIT,SUM(NVL(SSI.NET_TOTAL,0))SALES,SUM(NVL(SSI.PAID_AMT,0))COLLECTION,SUM(NVL(SSI.DUE_AMT,0)) DUE,
sum(nvl(RETURN_TOTAL,0)) RETURN_TOTAL
FROM SD_SALES_INVOICE SSI
LEFT JOIN ADM_WAREHOUSE_STORE AWS ON AWS.ID = SSI.STORE_ID
LEFT JOIN ADM_WAREHOUSE AW ON AW.ID = AWS.WAREHOUSE_ID
WHERE SSI.IS_CREDIT = 0
GROUP BY AW.WH_CODE,AW.WH_NAME,SSI.IS_CREDIT) A,
(SELECT AW.WH_CODE,AW.WH_NAME,SSI.IS_CREDIT,SUM(NVL(SSI.NET_TOTAL,0))SALES,SUM(NVL(SSI.PAID_AMT,0))COLLECTION,SUM(NVL(SSI.DUE_AMT,0)) DUE,
sum(nvl(RETURN_TOTAL,0)) RETURN_TOTAL
FROM SD_SALES_INVOICE SSI
LEFT JOIN ADM_WAREHOUSE_STORE AWS ON AWS.ID = SSI.STORE_ID
LEFT JOIN ADM_WAREHOUSE AW ON AW.ID = AWS.WAREHOUSE_ID
WHERE SSI.IS_CREDIT = 1
GROUP BY AW.WH_CODE,AW.WH_NAME,SSI.IS_CREDIT) B
WHERE A.WH_CODE = B.WH_CODE



----

select json_array(
                json_object(
                            'wh_name' value x.WH_NAME,
                            'cash' value (
                            json_array(
                            json_object(
                            'cash_sales' value x.CASH_SALES,
                            'cash_collection' value x.CASH_COLLECTION,
                            'cash_due' value x.CASH_DUE
                            )
                            )
                            ),
                            'credit' value (
                            json_array(
                            json_object(
                            'cash_sales' value x.CREDIT_SALES,
                            'cash_collection' value x.CREDIT_COLLECTION,
                            'cash_due' value x.CREDIT_DUE
                            )
                            )
                            ),
                            'total' value (
                                                        json_array(
                            json_object(
                            'cash_sales' value x.tot_sal,
                            'cash_collection' value x.tot_collec,
                            'cash_due' value x.tot_due,
                            'tot_return' value x.tot_return
                            )
                            )
                            )
                ))
from (
SELECT A.WH_NAME,A.SALES CASH_SALES, A.COLLECTION CASH_COLLECTION,A.DUE CASH_DUE,a.RETURN_TOTAL CASH_RETURN,
B.SALES CREDIT_SALES,B.COLLECTION CREDIT_COLLECTION,B.DUE CREDIT_DUE,b.RETURN_TOTAL CREDIT_RETURN,
(A.SALES+B.SALES) tot_sal,(A.COLLECTION+B.COLLECTION) tot_collec,(A.DUE+B.DUE) tot_due,(A.RETURN_TOTAL+B.RETURN_TOTAL) tot_return
 FROM (
SELECT AW.WH_CODE,AW.WH_NAME,SSI.IS_CREDIT,SUM(NVL(SSI.NET_TOTAL,0))SALES,SUM(NVL(SSI.PAID_AMT,0))COLLECTION,SUM(NVL(SSI.DUE_AMT,0)) DUE,
sum(nvl(RETURN_TOTAL,0)) RETURN_TOTAL
FROM SD_SALES_INVOICE SSI
LEFT JOIN ADM_WAREHOUSE_STORE AWS ON AWS.ID = SSI.STORE_ID
LEFT JOIN ADM_WAREHOUSE AW ON AW.ID = AWS.WAREHOUSE_ID
WHERE SSI.IS_CREDIT = 0
GROUP BY AW.WH_CODE,AW.WH_NAME,SSI.IS_CREDIT) A,
(SELECT AW.WH_CODE,AW.WH_NAME,SSI.IS_CREDIT,SUM(NVL(SSI.NET_TOTAL,0))SALES,SUM(NVL(SSI.PAID_AMT,0))COLLECTION,SUM(NVL(SSI.DUE_AMT,0)) DUE,
sum(nvl(RETURN_TOTAL,0)) RETURN_TOTAL
FROM SD_SALES_INVOICE SSI
LEFT JOIN ADM_WAREHOUSE_STORE AWS ON AWS.ID = SSI.STORE_ID
LEFT JOIN ADM_WAREHOUSE AW ON AW.ID = AWS.WAREHOUSE_ID
WHERE SSI.IS_CREDIT = 1
GROUP BY AW.WH_CODE,AW.WH_NAME,SSI.IS_CREDIT) B
WHERE A.WH_CODE = B.WH_CODE)x