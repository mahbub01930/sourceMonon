Feature Name : CREATE GRN

Description : 

Design Link : https://www.figma.com/proto/YGEG5c3kuCc2vPOFsAro1y/Create-GRN?node-id=270%3A4214&scaling=min-zoom&page-id=0%3A1&starting-point-node-id=3%3A2


From : WEB 

Users : Warehouse User will make the Goods Receive Note, When any materail is received in Plant end.

Constraint:

1. in Master panel, all field is required.
2. At least one material is needed in GRN detail level.
3. GRN Quantity can not exceed from Receivable quantity.


User must be logged in

User info available

Check auth token for every request

Check SBU_ID


Tables/Data Source:

ADM_GRN, ADM_GRN_DTL, ADM_GRN_CONTAINER, ADM_GRN_VAT


-----------------------------------------------------------

--API LIST
------------------------------------------------------------------

--LEFT PANEL LIST(LANDING MODE AND HEADER)--1ST API
API TYPE : GET
API NAME : api/mm/get-grn-list

Response Fields :  
	 AG.GRN_NO, AG.GRN_DATE,AW.WH_NAME RECEIVE_DEPOT, AG.REF_NO,
   AG.PI_NO, AG.PI_DATE, AG.CI_NO, AG.CI_DATE, AG.CHALLAN_NO, 
   AG.CHALLAN_DATE, AG.PO_ID, AG.STORAGE_CONDITION, AG.INDICATION,
    AG.QC_PRIORITY, AP.SUPPLIER_NAME
	 
Operational Fields: 
	     AG.ID, AG.GRN_NO, AG.GRN_DATE,  AG.DESCRIPTION, AG.GRN_SOURCE,
       AG.REF_NO, AG.WAREHOUSE_ID, AG.PI_NO, AG.PI_DATE, AG.CI_NO,
       AG.CI_DATE, AG.CHALLAN_NO, AG.CHALLAN_DATE, AG.PO_ID,
       AG.STORAGE_CONDITION, AG.INDICATION, AG.QC_PRIORITY,
       AW.WH_NAME RECEIVE_DEPOT, MPOM.SUPPLIER_ID, AP.SUPPLIER_NAME

PARAMETER :  

Table Name: ADM_GRN = AG 
            ADM_WAREHOUSE = AW
            MM_PUR_ORD_MST = MPOM
            ADM_SUPPLIERS = AP

Relation : 
       AW.ID = AG.WAREHOUSE_ID
       MPOM.ID = AG.PO_ID
       AP.ID = MPOM.SUPPLIER_ID
            
Filter by:   
            AG.STATUS = 1 AND AG.GRN_SOURCE IN ('LOCAL-PURCHASE', 'IMPORT-PURCHASE')


QUERY:

SELECT AG.ID, AG.GRN_NO, AG.GRN_DATE,  AG.DESCRIPTION, AG.GRN_SOURCE,
       AG.REF_NO, AG.WAREHOUSE_ID, AG.PI_NO, AG.PI_DATE, AG.CI_NO,
       AG.CI_DATE, AG.CHALLAN_NO, AG.CHALLAN_DATE, AG.PO_ID,
       AG.STORAGE_CONDITION, AG.INDICATION, AG.QC_PRIORITY,
       AW.WH_NAME RECEIVE_DEPOT, MPOM.SUPPLIER_ID, AP.SUPPLIER_NAME
  FROM ADM_GRN AG
  LEFT JOIN ADM_WAREHOUSE AW ON AW.ID = AG.WAREHOUSE_ID
  LEFT JOIN MM_PUR_ORD_MST MPOM ON MPOM.ID = AG.PO_ID
  LEFT JOIN ADM_SUPPLIERS AP ON AP.ID = MPOM.SUPPLIER_ID
 WHERE AG.GRN_SOURCE IN ('LOCAL-PURCHASE', 'IMPORT-PURCHASE') AND AG.STATUS = 1;

---------------------------------------------------------------------

--VIEW RIGHT PANEL DETAIL PART(AFTER CLICK ON LEFT PANEL LIST DATA) --2nd API
API TYPE : GET
API NAME : api/mm/get-grn-details-data/{pGRN_ID}

Response Fields :  
	     AGD.PROD_ID ||' - '|| AP.PROD_NAME PRODUCTS, AGD.RCV_QTY, AGD.BATCH_LOT_NO,
	     AGD.POTENCY, AGD.MFG_DATE, AGD.EXP_DATE
Operational Fields: 
	     AGD.ID, AGD.PROD_ID ||' - '|| AP.PROD_NAME PRODUCTS, AGD.BATCH_LOT_NO,
         AGD.MFG_DATE, AGD.EXP_DATE, 
         AGD.PROD_UOM, ACE.ELEMENT_NAME, AGD.POTENCY 

PARAMETER :  AGD.GRN_ID = :pGRN_ID (PARAMETER WILL COME FROM LEFT PANEL LIST) -- 2820

Table Name: ADM_GRN_DETAIL = AGD 
            ADM_PRODUCTS = AP
            ADM_CODE_ELEMENTS = ACE

Relation : 
       AP.ID = AGD.PROD_ID
       ACE.ID = AGD.PROD_UOM

Filter by:   
            AGD.STATUS = 1

QUERY:

SELECT AGD.ID, AGD.PROD_ID ||' - '|| ASP.DISPLAY_NAME  PRODUCTS, AGD.BATCH_LOT_NO,
    AGD.MFG_DATE, AGD.EXP_DATE, AGD.RCV_QTY, POD.APP_QTY,NVL(GD.OTHER_RECEIVE_QTY,0) OTHER_RECEIVE_QTY,
    AGD.PROD_UOM, ACE.ELEMENT_NAME, AGD.POTENCY,AGD.CHALLAN_QTY
FROM ADM_GRN_DETAIL AGD
LEFT JOIN ADM_SBU_PRODUCTS ASP  ON ASP.PROD_ID = AGD.PROD_ID
LEFT JOIN ADM_CODE_ELEMENTS ACE ON ACE.ID = AGD.PROD_UOM
LEFT JOIN ADM_GRN AG ON AGD.GRN_ID=AG.ID AND ASP.SBU_ID = AG.SBU_ID
LEFT JOIN MM_PUR_ORD_DTL POD ON AG.PO_ID=POD.PO_ID AND AGD.PROD_ID=POD.PROD_ID
LEFT JOIN (
    SELECT AG.PO_ID, GD.PROD_ID, SUM(RCV_QTY) OTHER_RECEIVE_QTY
    FROM ADM_GRN AG JOIN ADM_GRN_DETAIL GD ON AG.ID=GD.GRN_ID WHERE AG.ID<>:pGRN_ID
    GROUP BY AG.PO_ID, GD.PROD_ID
    ) GD ON AG.PO_ID=GD.PO_ID AND GD.PROD_ID=AGD.PROD_ID
WHERE AGD.STATUS = 1
AND AGD.GRN_ID = :pGRN_ID; --3501

----old code
/*
	SELECT AGD.ID, AGD.PROD_ID ||' - '|| AP.PROD_NAME products, AGD.BATCH_LOT_NO,
		AGD.MFG_DATE, AGD.EXP_DATE, AGD.RCV_QTY,
		AGD.PROD_UOM, ACE.ELEMENT_NAME, AGD.POTENCY 
	FROM ADM_GRN_DETAIL AGD
	LEFT JOIN ADM_PRODUCTS AP  ON AP.ID = AGD.PROD_ID
	LEFT JOIN ADM_CODE_ELEMENTS ACE ON ACE.ID = AGD.PROD_UOM
		WHERE AGD.STATUS = 1
		AND AGD.GRN_ID = :pGRN_ID;-- 2820
		*/

----------------------------------------------------------------------------------------------------------

--CLICK VAT CHALLAN ON VIEW ICON --3rd API

API TYPE : GET
API NAME : api/mm/get-grn-vat-challan-details/{pGRN_ID}

Response Fields :  
	     VAT_CHALLAN_NO, CHALLAN_DATE, CHALLAN_AMT

Operational Fields: 
	     ID, VAT_CHALLAN_NO, CHALLAN_DATE, CHALLAN_AMT

PARAMETER :  GRN_ID = :pGRN_ID;   -- 2820 

Table Name:  ADM_GRN_VAT

Relation : 
       AP.ID = AGD.PROD_ID
       ACE.ID = AGD.PROD_UOM

Filter by:   
           STATUS = 1
           
QUERY:

SELECT ID, VAT_CHALLAN_NO, CHALLAN_DATE, CHALLAN_AMT
  FROM ADM_GRN_VAT
 WHERE STATUS = 1
   AND GRN_ID = :pGRN_ID;   -- 2820

---------------------------------------------------------------------------------------

---- CLICK CONTAINER ON VIEW ICON --4th API

API TYPE : GET
API NAME : api/mm/get-container-details/{pGRN_ID}/{pGRN_DTL_ROW_ID}

Response Fields :  
	     AGC.SL_NO, AGC.IMCS_NO, AGC.CONTAINER_NO, ACE.ELEMENT_NAME CON_TYPE,
       AGC.CON_VOLUMN, FD_GET_BASE_UOM(AGC.CON_VOLUMN_UOM) CON_VOL_UOM_NAME, AGC.INTACT_FLAG, AGC.REMARKS

Operational Fields: 
	     AGC.SL_NO, AGC.ID, AGC.GRNDTL_ID, AGC.IMCS_NO, AGC.CONTAINER_NO, 
       AGC.CONTAINER_TYPE, ACE.ELEMENT_NAME,
       AGC.CON_VOLUMN, AGC.CON_VOLUMN_UOM,
       FD_GET_BASE_UOM(AGC.CON_VOLUMN_UOM) CON_VOL_UOM_NAME,
       AGC.INTACT_FLAG, AGC.REMARKS

PARAMETER :  AGC.GRN_ID = :pGRN_ID AND GRNDTL_ID = :pGRN_DTL_ROW_ID;   -- 2820, 23116

Table Name:  ADM_GRN_CONTAINER = AGC
             ADM_CODE_ELEMENTS = ACE


Relation : 
       ACE.ID = AGC.CONTAINER_TYPE

            
Filter by:   
          AGC.STATUS = 1 
           
QUERY:

SELECT AGC.SL_NO, AGC.ID, AGC.GRNDTL_ID, AGC.IMCS_NO, AGC.CONTAINER_NO, 
       AGC.CONTAINER_TYPE, ACE.ELEMENT_NAME,
       AGC.CON_VOLUMN, AGC.CON_VOLUMN_UOM,
       FD_GET_BASE_UOM(AGC.CON_VOLUMN_UOM) CON_VOL_UOM_NAME,
       AGC.INTACT_FLAG, AGC.REMARKS
FROM ADM_GRN_CONTAINER AGC
LEFT JOIN ADM_CODE_ELEMENTS ACE ON ACE.ID = AGC.CONTAINER_TYPE 
WHERE AGC.STATUS = 1 
   AND AGC.GRN_ID = :pGRN_ID AND AGC.GRNDTL_ID =:pGRNDTL_ID; --2820, 23116

--------------------------------------------------
---- CLICK CREATE NEW TO GET GRN SOURCE LIST--5th API
API TYPE : GET
API NAME : api/mm/get-grn-source-list

Response Fields :  
	     SOURCE_NAME, DISPLAY_VALUE

Operational Fields: 
	     ID, SOURCE_NAME, DISPLAY_VALUE, DESCRIPTION

PARAMETER :  

Table Name:  VW_GRN_SOURCE --VIEW

Relation : 
                 
Filter by:   

QUERY:

SELECT * FROM VW_GRN_SOURCE;--VIEW

----------------------------------------------------------------------
---- INDIVISUAL SOURCE DATA WILL APPEAR IN LEFT PANEL--6th API
API TYPE : GET
API NAME : api/mm/get-po-list-header-data/{pPO_TYPE}

Response Fields :  
	     MPOM.DISPLAY_CODE PO_NO, AP.SUPPLIER_NAME

Operational Fields: 
	     MPOM.ID, MPOM.DISPLAY_CODE PO_NO, MPOM.SUPPLIER_ID, AP.SUPPLIER_NAME

PARAMETER :  MPOM.PO_TYPE = :pPO_TYPE;

Table Name:  MM_PUR_ORD_MST = MPOM
             ADM_SUPPLIERS = AP

Relation : AP.ID = MPOM.SUPPLIER_ID
     
Filter by:   
          MPOM.STATUS  = 1 

QUERY:

SELECT MPOM.ID, MPOM.DISPLAY_CODE PO_NO, MPOM.SUPPLIER_ID, AP.SUPPLIER_NAME
  FROM MM_PUR_ORD_MST MPOM
  LEFT JOIN ADM_SUPPLIERS AP ON AP.ID = MPOM.SUPPLIER_ID
 WHERE MPOM.STATUS  = 1 
   AND MPOM.PO_TYPE = :pPO_TYPE; ---- LINKED UP WITH API NO: 06


--------------------------------------------------------------------------------------------

---- CLICK ON ADD PRODUCT GET PRODUCT LIST AFTER SELECTION OF THE PO ID--7th API
API TYPE : GET
API NAME : api/mm/get-po-product-details/{pPO_ID}

Response Fields :  
	     MPOD.PROD_ID, AP.PROD_NAME, ACE.ELEMENT_NAME, MPOD.APP_QTY, ALREADY_RECEIVE_QTY

Operational Fields: 
	     MPOD.ID, MPOD.PROD_ID, AP.PROD_NAME, MPOD.UOM, ACE.ELEMENT_NAME, MPOD.APP_QTY, NVL(GD.ALREADY_RECEIVE_QTY,0) ALREADY_RECEIVE_QTY

PARAMETER :  MPOD.PO_ID = :pPO_ID -- 1002

Table Name:  MM_PUR_ORD_DTL = MPOD
             ADM_PRODUCTS = AP
             ADM_CODE_ELEMENTS = ACE

Relation : AP.ID = MPOD.PROD_ID
           ACE.ID = MPOD.UOM
           
Filter by:   
          MPOD.STATUS = 1
QUERY:

 SELECT MPOD.ID, MPOD.PROD_ID, AP.PROD_NAME, MPOD.UOM, ACE.ELEMENT_NAME, MPOD.APP_QTY, NVL(GD.ALREADY_RECEIVE_QTY,0) ALREADY_RECEIVE_QTY
FROM MM_PUR_ORD_DTL MPOD
LEFT JOIN ADM_PRODUCTS AP ON AP.ID = MPOD.PROD_ID 
LEFT JOIN ADM_CODE_ELEMENTS ACE ON ACE.ID = MPOD.UOM
LEFT JOIN(
    SELECT AG.REF_NO, AG.PO_ID, GD.PROD_ID, SUM(RCV_QTY) ALREADY_RECEIVE_QTY
    FROM ADM_GRN AG JOIN ADM_GRN_DETAIL GD ON AG.ID=GD.GRN_ID
    GROUP BY AG.REF_NO, AG.PO_ID, GD.PROD_ID
) GD ON MPOD.PO_ID=GD.PO_ID AND MPOD.PROD_ID=GD.PROD_ID
WHERE MPOD.STATUS = 1
AND MPOD.PO_ID = :pPO_ID -- 1002

-----------------------------------------------------------------------------------------------
---- CLICK CREATE NEW TO GET UOM LISTT--8th API
API- NAME: (GET UOM LIST)
QUERY:

ITS ALREADY DEVELOPED

-----------------------------------------------------------------------------------------------------------
----IMCS DROPDOWN LIST BOX FROM MODAL(AFTER CLICK THE ICON OF DETAIL ROW)--9th API
API TYPE : GET
API NAME : api/mm/get-imcs-list/{pLC_PO_NO}/{pMAT_PROD_ID}

Response Fields :  
	     DISPLAY_CODE IMCS_NO, RECEIVE_DATE, VEHICLE_NO

Operational Fields: 
	     ID, DISPLAY_CODE IMCS_NO, RECEIVE_DATE, VEHICLE_NO

PARAMETER :  LC_PO_NO= :pLC_PO_NO  --1002
             MAT_PROD_ID = :pMAT_PROD_ID ;-- 1003

Table Name:  INC_MAT_CHECK_SHEET

Relation : 

Filter by:   
          STATUS = 1;
           
QUERY:

SELECT ID, DISPLAY_CODE IMCS_NO
FROM INC_MAT_CHECK_SHEET
WHERE STATUS = 1
  AND LC_PO_NO= :pLC_PO_NO  --1002
  AND MAT_PROD_ID = :pMAT_PROD_ID ;-- 1003
  
  --NEW
SELECT DISTINCT IMCS.ID, DISPLAY_CODE||' ('||AP.PROD_NAME||')' IMCS_NO
  FROM INC_MAT_CHECK_SHEET IMCS
  LEFT JOIN INC_MAT_CONTAINER IMC ON IMC.IMCS_ID=IMCS.ID
  LEFT JOIN ADM_PRODUCTS AP ON AP.ID = IMCS.MAT_PROD_ID
 WHERE IMCS.STATUS = 1
   AND LC_PO_NO= :pLC_PO_NO  --1013
   AND MAT_PROD_ID = :pMAT_PROD_ID -- 6006
   AND (IMC.IMCS_ID,IMC.ID) NOT IN (SELECT IMCS_NO,SL_NO FROM ADM_GRN_CONTAINER WHERE IMCS_NO IS NOT NULL AND SL_NO IS NOT NULL);

------------------------------------------------------------------------------------------

---- IMCS DETAIL DATA AFTER SELECTING THE IMCS ID--10th API
API TYPE : GET
API NAME : api/mm/get-imcs-details/{pIMCS_NO}

Response Fields :  
		IMC.SL_NO,  IMC.CONTAINER_NO, ACE.ELEMENT_NAME CONT_TYPE,
		IMC.VOLUME, IMC.IS_INTACT, IMC.REMARKS

Operational Fields: 
		IMC.SL_NO, IMC.ID, IMC.CONTAINER_NO,
		IMC.CONTAINER_TYPE, ACE.ELEMENT_NAME CONT_TYPE,
		IMC.VOLUME, IMC.IS_INTACT, IMC.REMARKS

PARAMETER :  IMC.IMCS_ID = :pIMCS_NO; -- -- 10000

Table Name:  INC_MAT_CONTAINER = IMC
             ADM_CODE_ELEMENTS = ACE

Relation : ACE.ID = IMC.CONTAINER_TYPE

Filter by:   
          IMC.STATUS = 1 
           
QUERY:

SELECT IMC.SL_NO, IMC.ID, IMC.CONTAINER_NO,
       IMC.CONTAINER_TYPE, ACE.ELEMENT_NAME CONT_TYPE,
       IMC.VOLUME, IMC.IS_INTACT, IMC.REMARKS
  FROM INC_MAT_CONTAINER IMC
  LEFT JOIN ADM_CODE_ELEMENTS ACE ON ACE.ID = IMC.CONTAINER_TYPE
 WHERE IMC.STATUS = 1 
   AND IMC.IMCS_ID = :pIMCS_NO;   -- 10118

---NEW
SELECT IMC.SL_NO, IMC.ID, IMC.CONTAINER_NO,
       IMC.CONTAINER_TYPE, ACE.ELEMENT_NAME CONT_TYPE,
       IMC.VOLUME, IMC.IS_INTACT, IMC.REMARKS
  FROM INC_MAT_CONTAINER IMC
  LEFT JOIN ADM_CODE_ELEMENTS ACE ON ACE.ID = IMC.CONTAINER_TYPE
 WHERE IMC.STATUS = 1 
   AND IMC.IMCS_ID = :pIMCS_NO
   AND (IMC.IMCS_ID,IMC.ID) NOT IN (SELECT IMCS_NO,SL_NO FROM ADM_GRN_CONTAINER); 


-------------------------------------------------------------------------------------------
---- CONTAINER TYPE DROPDOWN LIST--11th API
API TYPE : GET
API NAME : api/mm/get-container-type

Response Fields :  
	     ID, ELEMENT_NAME CONTAINER_TYPE

Operational Fields: 
	    ID, ELEMENT_NAME CONTAINER_TYPE

PARAMETER :  

Table Name:  ADM_CODE_ELEMENTS

Relation : ACE.ID = IMC.CONTAINER_TYPE
     
Filter by:   
        STATUS  = 1 AND CODE_ID = 1087
           
QUERY:

SELECT ID, ELEMENT_NAME CONTAINER_TYPE
FROM ADM_CODE_ELEMENTS 
WHERE STATUS  = 1
 AND CODE_ID = 1087;

----------------------------------FOR GRN REPORT--------------------------------------------------

SELECT DISTINCT AG.ID GRN_ID,GRN_NO||' ('||ASP.DISPLAY_NAME||'-'||ASP.DISPLAY_CODE||')' AS GRN_NO
FROM ADM_GRN AG
JOIN ADM_GRN_DETAIL AGD ON AG.ID=AGD.GRN_ID
JOIN ADM_SBU_PRODUCTS ASP ON AGD.PROD_ID = ASP.PROD_ID AND ASP.SBU_ID = AG.SBU_ID
WHERE AG.STATUS = 1
AND AG.SBU_ID= :pSBU_ID
ORDER BY AG.ID DESC;

------------------------------------------------------------------------------------

----- CREATE AND UPDATE 
API TYPE : POST
API NAME : api/mm/create-grn-create-update


JERP_ADM.PD_QUESTION_CHECKLIST_TEMP Creation PROCEDURE

PROCEDURE JERP_ADM.PD_CREATE_GRN ( pGRN_MST        IN CLOB,
                                   pGRN_DTL        IN CLOB,
                                   pGRN_VAT        IN CLOB,
                                   pGRN_CONTAINER  IN CLOB,
                                   pGRN_ID         IN OUT NUMBER,
                                   pUSER_ID        IN NUMBER,
                                   pSTATUS         OUT CLOB
                                  )

A. pGRN_MST (JSON OBJECT)
Header = grn_mst

OBJECT
 
GET_NUMBER  ('sbu_id')        (not null) 
GET_NUMBER  ('grn_value')    
GET_STRING  ('grn_date')      'dd-mm-rrrr'
GET_NUMBER  ('office_id')     (not null) 
GET_NUMBER  ('warehouse_id')
GET_STRING  ('pi_no')
GET_STRING  ('pi_date')  'dd-mm-rrrr'
GET_STRING  ('ci_no')
GET_STRING  ('ci_date'),'dd-mm-rrrr'
GET_STRING  ('challan_no')
GET_STRING  ('challan_date'), 'dd-mm-rrrr'
GET_NUMBER  ('po_id')
GET_STRING  ('storage_condition')
GET_STRING  ('indication')
GET_STRING  ('qc_priority')
GET_STRING  ('description')
GET_STRING  ('grn_source')


B. pGRN_DTL (JSON OBJECT)
Header = grn_dtl

OBJECT
 
GET_NUMBER ('id')
GET_NUMBER ('prod_id')               (not null) 
GET_STRING ('batch_lot_no')
GET_STRING ('mfg_date') 'dd-mm-rrrr'
GET_STRING ('exp_date'),'dd-mm-rrrr'
GET_NUMBER ('whss_id');
GET_NUMBER ('whssb_id');
GET_NUMBER ('wh_type');
GET_NUMBER ('prod_uom');
GET_NUMBER ('rcv_qty');
GET_NUMBER ('potency');
GET_NUMBER ('challan_qty');

C. pGRN_VAT (JSON OBJECT)
Header = grn_vat

OBJECT
 
GET_NUMBER ('vat_id');
GET_NUMBER ('grn_id');       (not null) 
GET_STRING ('vat_challan_no');
GET_STRING ('challan_date'), 'dd-mm-rrrr'
GET_NUMBER ('challan_amt');
GET_STRING ('description');

D. pGRN_CONTAINER (JSON OBJECT)
Header = grn_container

OBJECT
 
GET_NUMBER ('grn_con_id');
GET_NUMBER ('grn_id');      (not null) 
GET_NUMBER ('grndtl_id');   (not null) 
GET_NUMBER ('imcs_no');  
GET_NUMBER ('sl_no');
GET_STRING ('container_no');
GET_NUMBER ('container_type');
GET_NUMBER ('con_volumn');
GET_NUMBER ('con_volumn_uom');
GET_STRING ('intact_flag');
GET_STRING ('remarks');
GET_NUMBER ('product_id');


E. pGRN_ID IN OUT NUMBER,
    CREATE/INSERT MODE : pGRN_ID  WILL BE NULL
    UPDATE MODE :  pGRN_ID WILL COME FROM FRONT-END

F. pUSER_ID (Number)
 pUSER_ID number not null auth.user_id

G. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.


----------------------------------------------------------------

API TYPE : POST
API NAME : api/pp/grn-add-stock


JERP_ADM.JERP_INVENTORY_UTIL.RECEIVE_GRN_BY_ID (pGRN_ID NUMBER, 
                                                pUSER_ID NUMBER, 
                                                pGE_NO VARCHAR2 DEFAULT NULL, 
                                                pGE_BY VARCHAR2 DEFAULT NULL, 
                                                pSTATUS IN OUT NUMBER)


A. pGRN_ID (Number)  
pGRN_ID number not null

B. pSBU_ID (Number)
pUSER_ID number not null auth.user_id

C. pGE_NO NULL

D.pGE_BY NULL

I. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.

