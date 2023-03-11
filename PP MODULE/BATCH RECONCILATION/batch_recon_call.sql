
DECLARE
    vSTATUS CLOB;
    vMst number:=null; 
    vRECON_MST CLOB := '{ "recon_mst":[
                                  {
                                     "batch_id":10230,
                                     "prod_id":1091
                                     
                                  }
                                ]
                                }';
                                
    vRECON_DTL CLOB :=  '{ "recon_dtl":[
                                  {
                                     "id":null,
                                     "issue_id":1013,
                                     "prod_id":1001,
                                     "grn_id":00222,
                                     "issue_qty":1,
                                     "damage_qty":0,
                                     "wastage_qty":0,
                                     "reject_qty":0,
                                     "ext_rejection_qty":0,
                                     "return_qty":0
                                  },
                                  {
                                     "id":null,
                                     "issue_id":1013,
                                     "prod_id":1001,
                                     "grn_id":00322,
                                     "issue_qty":2,
                                     "damage_qty":0,
                                     "wastage_qty":0,
                                     "reject_qty":0,
                                     "ext_rejection_qty":0,
                                     "return_qty":2
                                  },
                                  {
                                     "id":null,
                                     "issue_id":1013,
                                     "prod_id":1001,
                                     "grn_id":12345,
                                     "issue_qty":2,
                                     "damage_qty":0,
                                     "wastage_qty":1,
                                     "reject_qty":0,
                                     "ext_rejection_qty":0,
                                     "return_qty":0
                                  }
                                ] 
                                }';  
BEGIN
    PD_BATCH_RECONCILATION(pRECON_MST       =>vRECON_MST,
                          pRECON_DTL       =>vRECON_DTL,
                          pRECON_ID        =>vMst,
                          pUSER_ID        =>1,
                          pIS_SUBMITTED         =>0,
                          pAS_FLAG       =>0,
                          pSBU_ID         =>2,
                          pSTATUS         => vSTATUS
                      );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;


/*
DECLARE
    vSTATUS CLOB;
    vMst number:=null; 
    vQCTR_MST CLOB := '{ "qctr_mst":[
                                  {
                                     "lab_control_code":"Lab-01",
                                     "test_status":11,
                                     "passed_qty":3,
                                     "hold_qty":null,
                                     "reject_qty":null,
                                     "verified_by":292,
                                     "verify_comments":"DONE",
                                     "re_test_date":"29-09-2022",
                                     "expiry_date":"01-01-2023"
                                     
                                  }
                                ]
                                }';
                                
    vQCTR_DTL CLOB :=  '{ "qctr_dtl":[
                                  {
                                     "id":null,
                                     "prod_id":10013,
                                     "test_id":10107,
                                     "test_result_value":"PASS",
                                     "remarks":"remarks-1"
                                  },
                                  {
                                     "id":null,
                                     "prod_id":10013,
                                     "test_id":10108,
                                     "test_result_value":null,
                                     "remarks":null
                                  }
                                ] 
                                }';  
BEGIN
    PD_QC_TEST_RESULT(pQCTR_MST       =>vQCTR_MST,
                      pQCTR_DTL       =>vQCTR_DTL,
                      pQCTM_ID        =>vMst,
                      pUSER_ID        =>326,
                      pSTATUS         => vSTATUS
                      );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;
*/