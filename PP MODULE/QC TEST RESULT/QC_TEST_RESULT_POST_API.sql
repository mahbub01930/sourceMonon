API TYPE : POST
API NAME : api/pp/insert-update-qct-data

JERP_PP_UTIL.PD_QC_TEST_RESULT Creation PROCEDURE

JERP_PP_UTIL.PD_QC_TEST_RESULT(pQCTR_MST       =>vQCTR_MST,
                      pQCTR_DTL       =>vQCTR_DTL,
                      pQCTR_CON       =>vQCTR_CON,
                      pQCTM_ID        =>vMst,
                      pUSER_ID        =>1,
                      pGRN_ID         =>3442,
                      pLAB_CODE       =>'LAB-00092/22',
                      pPROD_ID        =>6078,
                      pSBU_ID         =>2,
                      pIS_SUBMITTED   =>1,
                      pAS_FLAG        =>0, --  DEFAULT 0
                      pSTATUS         => vSTATUS
                      );


A. pQCTR_MST (JSON OBJECT)
Header = qctr_mst

OBJECT

GET_NUMBER('test_status');
GET_NUMBER('passed_qty');
GET_NUMBER('hold_qty');
GET_NUMBER('reject_qty');
GET_NUMBER('verified_by');
GET_STRING('verify_comments');
GET_STRING('re_test_date'), 'dd-mm-rrrr');
GET_STRING('expiry_date'), 'dd-mm-rrrr');
GET_NUMBER('potency')

 
 pQCTR_CON
B. pQCTR_DTL (JSON ARRAY)
Header = qctr_dtl

OBJECT

GET_NUMBER('id');
GET_STRING('test_result_value');
GET_STRING('remarks');

 
C. pQCTR_CON (JSON ARRAY)
Header = qctr_con

OBJECT

GET_NUMBER('id');
GET_NUMBER('container_id');
GET_NUMBER('receive_qty');
GET_NUMBER('receive_uom');
GET_NUMBER('sample_qty');
GET_NUMBER('sample_uom');
GET_NUMBER('passed_qty_con');
GET_NUMBER('passed_uom');
GET_NUMBER('rejected_qty');
GET_NUMBER('rejected_uom');

D. pQCTM_ID    IN OUT NUMBER,
    CREATE/INSERT MODE : pQCTM_ID  WILL BE NULL
    UPDATE MODE :  pQCTM_ID WILL COME FROM FRONT-END

E. pUSER_ID (Number)
 pUSER_ID number not null auth.user_id


F. pGRN_ID (Number)         (COME FROM 4TH API)

G. pLAB_CODE (VARCHAR2)     (COME FROM 4TH API)

H. pPROD_ID (Number)        (COME FROM 4TH API)

I. pSBU_ID (Number)

J. pIS_SUBMITTED (Number)

pIS_SUBMITTED number not null (0 for draft, 1 for submit)

K. pAS_FLAG (Number)

pAS_FLAG number default 0

L. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.

-------------------------------------------------------------


---CALLL

DECLARE
    vSTATUS CLOB;
    vMst number:=10077; 
    vQCTR_MST CLOB := '{ "qctr_mst":[
                                  {
                                     "test_status":7031,
                                     "passed_qty":70,
                                     "hold_qty":0,
                                     "reject_qty":70,
                                     "verified_by":1,
                                     "verify_comments":null,
                                     "re_test_date":null,
                                     "expiry_date":null,
                                     "potency":50
                                  }
                                ]
                                }';
                                
    vQCTR_DTL CLOB :=  '{ "qctr_dtl":[
                                  {
                                     "id":10261,
                                     "test_id":10345,
                                     "test_result_value":"PASS",
                                     "remarks":"remarks-2"
                                  },
                                  {
                                     "id":10262,
                                     "test_id":10346,
                                     "test_result_value":"fail",
                                     "remarks":"rejected"
                                  }
                                ] 
                                }'; 
        vQCTR_CON CLOB := '{ "qctr_con": [
                                  {
                                      "id": 10002,
                                      "container_id": 10584,
                                      "receive_qty": 80,
                                      "receive_uom": 538,
                                      "sample_qty": 10,
                                      "sample_uom": 539,
                                      "passed_qty_con": 0,
                                      "passed_uom": 538,
                                      "rejected_qty": 70,
                                      "rejected_uom": 538
                                  },
                                  {
                                      "id": 10003,
                                      "container_id": 10585,
                                      "receive_qty": 80,
                                      "receive_uom": 538,
                                      "sample_qty": 10,
                                      "sample_uom": 539,
                                      "passed_qty_con": 70,
                                      "passed_uom": 538,
                                      "rejected_qty": 0,
                                      "rejected_uom": 538
                                  }
                                ]
                          }';                      
                                 
BEGIN
    PD_QC_TEST_RESULT(pQCTR_MST       =>vQCTR_MST,
                      pQCTR_DTL       =>vQCTR_DTL,
                      pQCTR_CON       =>vQCTR_CON,
                      pQCTM_ID        =>vMst,
                      pUSER_ID        =>1,
                      pGRN_ID         =>3442,
                      pLAB_CODE       =>'LAB-00092/22',
                      pPROD_ID        =>6078,
                      pSBU_ID         =>2,
                      pIS_SUBMITTED   =>1,
                      pSTATUS         => vSTATUS
                      );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;