
DECLARE
    vSTATUS CLOB;
    vMst number:=null; 
    vMOLD_MST CLOB := '{ "mold_mst":[
                                  {
                                     "mold_name":"AD (0.5ml) Plunger - 9",
                                     "total_cavity":40,
                                     "running_cavity":30,
                                     "cycle_time":20
                                  }
                                ]
                                }';
                                
    vMOLD_DTL CLOB :=  '{ "mold_dtl":[
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
    PD_MOLD  (pMOLD_MST       => vMOLD_MST,
              pMOLD_DTL       =>vMOLD_DTL,
              pUSER_ID        =>1,
              pMOLD_ID        =>vMst,
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