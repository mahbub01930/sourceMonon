--CREATE OR REPLACE PROCEDURE TEST_procedure
--AS
DECLARE 

    pGRN_ID         NUMBER := null;
    vSTATUS         CLOB;
    pGRN_MST CLOB :=  '{ "grn_mst":[
                                  {"sbu_id" :2,
                                   "grn_value" :null ,
                                   "grn_date"  :"30-08-2022",
                                   "office_id" :17,
                                   "warehouse_id" : 218,
                                   "pi_no" :"123" ,
                                   "pi_date" : "30-08-2022",
                                   "ci_no" : 123,
                                   "ci_date" : "30-08-2022",
                                   "challan_no" : "112233",
                                   "challan_date" : "30-08-2022",
                                   "po_id" : 1002,
                                   "storage_condition" : "Good",
                                   "indication" : "1" ,
                                   "qc_priority" : "Y",
                                   "description" : "Y",
                                   "grn_source" : "LOCAL-PURCHASE",
                                   "product_id" : 7265
                                  }
                                ]
                                }';
                                
      pGRN_DTL CLOB :=  '{ "grn_dtl":[
                                {"id"    :null ,
                                 "prod_id" :7265,
                                 "batch_lot_no" : "07752",
                                 "mfg_date" : "30-08-2021",
                                 "exp_date" :"30-08-2024" ,
                                 "whss_id" :null  ,
                                 "whssb_id" : null,
                                 "wh_type" :null  ,
                                 "prod_uom" :534,
                                 "rcv_qty" : 40,
                                 "potency" : 10,
                                 "challan_qty" : 4
                                },
                                 {"id"    :null ,
                                 "prod_id" :7266,
                                 "batch_lot_no" : "07752",
                                 "mfg_date" : "30-08-2021",
                                 "exp_date" :"30-08-2024" ,
                                 "whss_id" :null  ,
                                 "whssb_id" : null,
                                 "wh_type" :null  ,
                                 "prod_uom" :534,
                                 "rcv_qty" : 50,
                                 "potency" : 10,
                                 "challan_qty" : 4
                                }
                                ]
                                }';

      pGRN_VAT CLOB :=  '{ "grn_vat":[
                                {  "vat_id" :null,
                                   "grn_id"     :null ,
                                   "vat_challan_no" : "025789",
                                   "challan_date" :"30-08-2024",
                                   "challan_amt"   :20000 ,
                                   "description" :"Y" 
                                },
                                {  "vat_id" :null,
                                   "grn_id"     :null ,
                                   "vat_challan_no" : "025790",
                                   "challan_date" :"30-08-2024",
                                   "challan_amt"   :15000 ,
                                   "description" :"Y" 
                                }
                                ]
                                }';

      pGRN_CONTAINER CLOB :=  '{ "grn_container":[
                                ]
                                }';
                                
BEGIN
    PD_CREATE_GRN( pGRN_MST, pGRN_DTL, pGRN_VAT, pGRN_CONTAINER, pGRN_ID, 1,  vSTATUS);
    DBMS_OUTPUT.PUT_LINE('vSTATUS > '||VSTATUS);
EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);    
END;

----call receive grn
/*
DECLARE
    vSTATUS         NUMBER;
    vGRN NUMBER := 3409;
    vUSER NUMBER :=1;
BEGIN

    RECEIVE_GRN_BY_ID( vGRN, vUSER, vSTATUS);
    DBMS_OUTPUT.PUT_LINE('vSTATUS > '||VSTATUS);

END;
*/