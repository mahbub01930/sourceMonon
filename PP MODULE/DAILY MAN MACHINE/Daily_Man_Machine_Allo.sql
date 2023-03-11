

/*
---CALLL

DECLARE
    vSTATUS CLOB;
    vMst number:=null; 
    vPROD_LINE_ALLO CLOB := '{ "prod_line_allo":[
                                  {
                                     "sbu_id":2,
                                     "assign_date":"08-nov-2022",
                                     "plant_id":1004,
                                     "production_line_id":1122
                                  }
                                ]
                                }';
                                
    vPROD_LINE_BATCH CLOB :=  '{
                               "prod_line_batch":[
                                  {
                                     "id":null,
                                     "batch_id":10084,
                                     "process_id":10305,
                                     "sub_process_id":10306,
                                     "prod_line_man":[
                                        {
                                           "id":null,
                                           "person_id":260,
                                           "exp_level":1
                                        },
                                        {
                                           "id":null,
                                           "person_id":261,
                                           "exp_level":2
                                        }
                                     ],
                                     "prod_line_room":[
                                        {
                                           "id":null,
                                           "room_id":1101,
                                           "machine_id":1002,
                                           "mold_id":10000,
                                           "std_time":1
                                        },
                                        {
                                           "id":null,
                                           "room_id":1119,
                                           "machine_id":1103,
                                           "mold_id":10001,
                                           "std_time":2
                                        }
                                     ]
                                  }
                               ]
                            }';          
BEGIN
    JERP_ADM.PD_DAILY_MAN_MACHINE_ALLO(pPROD_LINE_ALO_ID    =>vMst,
                                       pPROD_LINE_ALLO       =>vPROD_LINE_ALLO,
                                       pPROD_LINE_BATCH       =>vPROD_LINE_BATCH,
                                       pUSER_ID        =>1,
                                       pSTATUS         => vSTATUS
                                    );
DBMS_OUTPUT.PUT_LINE(vSTATUS);

END;

------------update 

---CALLL

DECLARE
    vSTATUS CLOB;
    vMst number:=10004; 
    vPROD_LINE_ALLO CLOB := '{ "prod_line_allo":[
                                  {
                                     "sbu_id":2,
                                     "assign_date":"08-nov-2022",
                                     "plant_id":1004,
                                     "production_line_id":1100
                                  }
                                ]
                                }';
                                
    vPROD_LINE_BATCH CLOB :=  '{
                               "prod_line_batch":[
                                  {
                                     "id":10000,
                                     "batch_id":10084,
                                     "process_id":10305,
                                     "sub_process_id":10306,
                                     "prod_line_man":[
                                        {
                                           "id":10000,
                                           "person_id":260,
                                           "exp_level":1
                                        },
                                        {
                                           "id":10001,
                                           "person_id":261,
                                           "exp_level":2
                                        }
                                     ],
                                     "prod_line_room":[
                                        {
                                           "id":10000,
                                           "room_id":1101,
                                           "machine_id":1030,
                                           "mold_id":10002,
                                           "std_time":1
                                        },
                                        {
                                           "id":10001,
                                           "room_id":1119,
                                           "machine_id":1003,
                                           "mold_id":10003,
                                           "std_time":2
                                        }
                                     ]
                                  }
                               ]
                            }';          
BEGIN
    JERP_ADM.PD_DAILY_MAN_MACHINE_ALLO(pPROD_LINE_ALO_ID    =>vMst,
                                       pPROD_LINE_ALLO       =>vPROD_LINE_ALLO,
                                       pPROD_LINE_BATCH       =>vPROD_LINE_BATCH,
                                       pUSER_ID        =>1,
                                       pSTATUS         => vSTATUS
                                    );
DBMS_OUTPUT.PUT_LINE(vSTATUS);

END;
*/