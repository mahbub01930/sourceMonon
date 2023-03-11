SELECT json_arrayagg (
            json_object (
                         'pono'             VALUE       REF_NO,
                         'grnno'            VALUE       GRN_NO,
                         'grndate'          VALUE       TO_CHAR (GRN_DATE, :vDATE_FORMAT),
                         'challanno'        VALUE       NVL (CHALLAN_NO,' '),
                         'challandate'      VALUE       TO_CHAR (CHALLAN_DATE, :vDATE_FORMAT),
                         'supplier'         VALUE       SUPPLIER_NAME,
                         'lcno'             VALUE       ' ',
                         'coorgn'           VALUE       ' ',
                         'itemdtls'         VALUE
                                                (
                                                SELECT json_arrayagg (
                                                            json_object (
                                                                         'itemname'     VALUE   AP.PROD_NAME,
                                                                         'batchno'      VALUE   AGD.BATCH_LOT_NO,
                                                                         'mfgdate'      VALUE   TO_CHAR(AGD.MFG_DATE, :vDATE_FORMAT),
                                                                         'expdate'      VALUE   TO_CHAR(AGD.EXP_DATE, :vDATE_FORMAT),
                                                                         'grnqty'       VALUE   AGD.GRN_QTY,
                                                                         'rcvqty'       VALUE   AGD.RCV_QTY,
                                                                         'rcvuom'       VALUE   ACE.ELEMENT_NAME,
                                                                         'contcount'    VALUE   AGD.CONTAINER_COUNT
                                                                        ) ORDER BY UPPER (AP.PROD_NAME) RETURNING CLOB
                                                                      )
                                                  FROM ADM_GRN AG
                                                  LEFT JOIN ADM_GRN_DETAIL AGD ON AGD.GRN_ID = AG.ID
                                                  LEFT JOIN ADM_PRODUCTS AP ON AGD.PROD_ID = AP.ID
                                                  LEFT JOIN ADM_CODE_ELEMENTS ACE ON ACE.ID = AGD.PROD_UOM
                                                 WHERE AG.ID = GRN.ID
                                                ),
                        'footerinfo'        VALUE 
                                                (
                                                SELECT json_arrayagg (
                                                            json_object (
                                                                         'cratedby'         VALUE   HE.EMP_NAME,
                                                                         'createdat'        VALUE   TO_CHAR(AG.CREATED_AT, :vDATE_FORMAT),
                                                                         'receivedby'       VALUE   HE1.EMP_NAME,
                                                                         'receivedate'      VALUE   TO_CHAR(AG.RECEIVED_DATE, :vDATE_FORMAT)
                                                                        ) RETURNING CLOB
                                                                      )
                                                  FROM ADM_GRN AG
                                                  LEFT JOIN HRM_EMPLOYEE HE ON AG.CREATED_BY = HE.ID
                                                  LEFT JOIN HRM_EMPLOYEE HE1 ON AG.RECEIVED_BY = HE1.ID
                                                 WHERE AG.ID = GRN.ID
                                                ) RETURNING CLOB
                        ) RETURNING CLOB
                     ) QRY_OUTPUT
  FROM
    (
    SELECT AG.*, AP.PLANT_NAME OFFICE_NAME, AW.WH_NAME, SUP.SUPPLIER_NAME
      FROM ADM_GRN AG
      LEFT JOIN ADM_PLANT AP ON AG.OFFICE_ID=AP.ID
      LEFT JOIN ADM_WAREHOUSE AW ON AG.WAREHOUSE_ID=AW.ID
      LEFT JOIN MM_PUR_ORD_MST MPOM ON MPOM.ID = AG.PO_ID 
      --MPOM.DISPLAY_CODE = AG.REF_NO
      LEFT JOIN ADM_SUPPLIERS SUP ON SUP.ID = MPOM.SUPPLIER_ID
     WHERE AG.ID = NVL (:pGRN_ID,AG.ID)
    ) GRN