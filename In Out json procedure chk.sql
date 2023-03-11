

DECLARE
    vSTATUS CLOB;
    vMst number:=10012; 
    vIMCS_MST CLOB := '{ "imcs_mst":[
                                  {
                                     
                                     "receive_date":"01-09-2022",
                                     "receive_time":"01-09-2022 10:30:00 AM",
                                     "lc_po_no":"1002",
                                     "mat_prod_id":1003,
                                     "vehicle_no":"VD213243",
                                     "container_seal_no":"CN1234",
                                     "grn_id":1001,
                                     "notes":"Test" 
                                  }
                                ]
                                }';
                                
    vIMCS_DTL CLOB :=  '{ "imcs_dtl":[
                                  {
                                     "id":10024,
                                     "sl_no":1,
                                     "container_no":1,
                                     "container_type":10541,
                                     "volume": 40,
                                     "container_uom":534,
                                     "is_intact":"N",
                                     "remarks":"rmks UP"
                                  },
                                   {
                                     "id":10025,
                                     "sl_no":2,
                                     "container_no":2,
                                     "container_type":10542,
                                     "volume": 40,
                                     "container_uom":534,
                                     "is_intact":"N",
                                     "remarks":"rmks2 UPDATE"
                                  }
                                ] 
                                }';  
                                
    vADMQ_MST CLOB :=  '{ "aqd_mst":[
                              {
                                 "id":1024,
                                 "sbu_id": "2",
                                 "ref_id1":"4",
                                 "trn_type":"8",
                                 "qtemp_id":"1010"
                              }
                                  
                            ] 
                            }';                                              
    
    vADMQ_DTL CLOB :=  '{ "adq_dtl":[
                             {   "id" :1048, 
                                 "qmst_id": null,
                                 "array_answer":"a",
                                 "answer_text":"answer_text", 
                                 "comments":"comments", 
                                 "sort_order":"1"
                           
                              },
                              {  "id" :1049, 
                                 "qmst_id": null,
                                 "array_answer":"a",
                                 "answer_text":"answer_text", 
                                 "comments":"comments", 
                                 "sort_order":"2"
                        
                              }  
                            ]
                            }';
    
BEGIN
    PD_IMCS  (pIMCS_MST       => vIMCS_MST,
              pIMCS_DTL       =>vIMCS_DTL,
              pADMQ_MST        =>vADMQ_MST,
              pADMQ_DTL        =>vADMQ_DTL, 
              pUSER_ID        =>1,
              pSBU_ID         =>2,
              pIS_SUBMITTED   =>0, --0 not submitted, 1 submitted
               --pAS_FLAG       IN NUMBER  DEFAULT 0, --0 before submitted, 1 after submitted
              pIMCS_ID        =>vMst,
              pSTATUS         => vSTATUS
              );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;


/*DECLARE
    VPOUTPUT CLOB;
BEGIN
PD_APP_THR_DATA (PAPP_THR_ID    => 1064,
                 PUSER_ID       => 1,
                 POUTPUT        => VPOUTPUT);
DBMS_OUTPUT.PUT_LINE(VPOUTPUT);
END;
*/