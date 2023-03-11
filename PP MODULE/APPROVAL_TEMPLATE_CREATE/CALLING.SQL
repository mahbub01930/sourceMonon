
DECLARE
    vSTATUS CLOB;
    vMst number:=null; 
    vAPP_THR_MST CLOB := '{ "app_thr_mst":[
                                  {
                                     "mold_name":"AD (0.5ml) Plunger - 9",
                                     "total_cavity":40,
                                     "running_cavity":30,
                                     "cycle_time":20
                                  }
                                ]
                                }';
                                
    vAPP_THR_DTL CLOB :=  '{ "mold_dtl":[
                                  {
                                     "id":null,
                                     "event_type":7441,
                                     "event_quantity":5,
                                     "previous_quantity":6,
                                     "event_declare_by": 2088,
                                     "event_conf_date":"13-09-2022",
                                     "event_remarks":"UPDATE NEW",
                                     "responsible_person":2093,
                                     "sort_order":1
                                  }
                               
                                ] 
                                }';  
                                
    
BEGIN
    APPROVAL_TEMPLATE_CREATE  (pAPP_THR_MST       => vAPP_THR_MST,
              pAPP_THR_DTL       =>vAPP_THR_DTL,
               pAPP_THR_ID        =>vMst,
              pUSER_ID        =>1,
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