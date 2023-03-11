--------------------------------------------
--- CREATE-UPDATE, DRAFT, SUBMIT - Daily Man Machine -14TH API
URL = api/pp/crud-daily-man-machin-allo
Method = Post

PD_DAILY_MAN_MACHINE_ALLO Creation PROCEDURE

JERP_PP_UTIL.PD_DAILY_MAN_MACHINE_ALLO (pPROD_LINE_ALO_ID   IN OUT NUMBER,
                                    pPROD_LINE_ALLO     IN CLOB,
                                    pPROD_LINE_BATCH    IN CLOB,
                                    pUSER_ID            IN NUMBER,
                                    pSTATUS             OUT CLOB
                                   )

Parameters :

A. pPROD_LINE_ALO_ID          IN OUT NUMBER,
CREATE/INSERT MODE : pPROD_LINE_ALO_ID  WILL BE NULL
UPDATE MODE :  pPROD_LINE_ALO_ID WILL COME FROM FRONT-END

B. pPROD_LINE_ALLO (JSON Array)

Header = prod_line_allo

OBJECT

sbu_id                      NUMBER; 
assign_date                 STRING;
plant_id                    NUMBER; 
production_line_id          NUMBER; 



C. pPROD_LINE_BATCH (JSON Array)

Header = allocation_for

OBJECT

id                      NUMBER;
batch_id                NUMBER; 

'process_info' (new object for 'allocation_for')
process_id              NUMBER;  
sub_process_id          NUMBER;  

'prod_line_man' (new object for 'process_info')
id              NUMBER;
person_id       NUMBER; 
exp_level       NUMBER;
'prod_line_room' (new object for 'process_info')
id              NUMBER;
room_id         NUMBER;
machine_id      NUMBER;
mold_id         NUMBER;
std_time        NUMBER;

D. pUSER_ID (Number)

pUSER_ID number not null auth.user_id

E. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.


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
                                
    vPROD_LINE_BATCH CLOB :=  '{ "allocation_for":[
                           { "id" : null,
                            "batch_id" : 10084,
                            "process_info" : [
                                  {
                                      "process_id": 10305, 
                                      "sub_process_id": 10306, 

                                      "prod_line_man": [
                                          {
                                              "id": null,
                                              "person_id": 260,
                                              "exp_level": 1
                                          },
                                          {
                                              "id": null,
                                              "person_id": 261,
                                              "exp_level": 2
                                          }
                                      ],

                                      "prod_line_room": [
                                          {
                                              "id": null,
                                              "room_id": 1101,
                                              "machine_id": 1002,
                                              "mold_id": 10000,
                                              "std_time": 1
                                          },
                                          {
                                              "id": null,
                                              "room_id": 1119,
                                              "machine_id": 1103,
                                              "mold_id": 10001,
                                              "std_time": 2
                                          }
                                      ]
                                  }
  ]
}]
}';          
BEGIN
    PD_DAILY_MAN_MACHINE_ALLO(pPROD_LINE_ALO_ID    =>vMst,
                                       pPROD_LINE_ALLO       =>vPROD_LINE_ALLO,
                                       pPROD_LINE_BATCH       =>vPROD_LINE_BATCH,
                                       pUSER_ID        =>1,
                                       pIS_SUBMITTED  =>0,
                                       pSTATUS         => vSTATUS
                                    );
DBMS_OUTPUT.PUT_LINE(vSTATUS);

END;
----------------

------------update 
/*
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