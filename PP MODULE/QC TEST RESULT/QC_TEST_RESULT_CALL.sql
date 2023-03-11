DECLARE
    vSTATUS CLOB;
    vMst number:=10075; 
    vQCTR_MST CLOB := '{ "qctr_mst":[
                                  {
                                     "test_status":7032,
                                     "passed_qty":20,
                                     "hold_qty":12,
                                     "reject_qty":0,
                                     "verified_by":292,
                                     "verify_comments":"done",
                                     "re_test_date":null,
                                     "expiry_date":null,
                                     "potency":20
                                     
                                  }
                                ]
                                }';
                                
    vQCTR_DTL CLOB :=  '{ "qctr_dtl":[
                                  {
                                     "id":10258,
                                     "test_id":10075,
                                     "test_result_value":"PASS",
                                     "remarks":"remarks-1"
                                  },
                                  {
                                     "id":10259,
                                     "test_id":10075,
                                     "test_result_value":"PASS",
                                     "remarks":"rmk"
                                  }
                                ] 
                                }';  
BEGIN
    PD_QC_TEST_RESULT(pQCTR_MST       =>vQCTR_MST,
                      pQCTR_DTL       =>vQCTR_DTL,
                      pQCTM_ID        =>vMst,
                      pUSER_ID        =>1,
                      pGRN_ID         =>3435,
                      pLAB_CODE       =>'LAB-00029/22',
                      pPROD_ID        =>7603,
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