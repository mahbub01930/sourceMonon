
SELECT BATCH_QTY 
  FROM PP_BOM_DTL
 WHERE BOM_ID=1248
   AND IS_MUST_FOR_QUALIFY = 'Y'

-------------------------------------
SELECT * FROM SD_WHSSB_CONTAINER;

SELECT * FROM ADM_GRN

SELECT * FROM ADM_GRN_DETAIL
WHERE GRN_ID=3320

SELECT * FROM SD_WHSS_BATCH_LOT

SELECT * FROM ADM_GRN_CONTAINER
WHERE GRN_ID=3320

--ADM_PRODUCT_LOT-->ID-->BATCH_LOT_ID
--SD_WHSSB_CONTAINER

ID, WHSSB_ID, PROD_ID, STORE_ID, BATCH_LOT_NO, BATCH_LOT_ID, 
CONTAINER_NO, CURRENT_STOCK, BLOCK_STOCK, MFG_DATE, EXP_DATE, GRN_CONT_ID


SELECT AGD.WHSSB_ID,AGD.PROD_ID,AGD.BATCH_LOT_NO
  FROM ADM_GRN_CONTAINER AGC,ADM_GRN_DETAIL AGD
  WHERE AGD.ID = AGC.GRNDTL_ID
  AND AGC.GRN_ID=3320


SELECT *
  FROM ADM_GRN_CONTAINER AGC,ADM_GRN_DETAIL AGD
  WHERE AGD.ID = AGC.GRNDTL_ID
  AND AGC.GRN_ID=2862
SELECT * FROM ADM_GRN_DETAIL
WHERE GRN_ID=2862

SELECT * FROM ADM_GRN_CONTAINER
WHERE GRN_ID=2862

