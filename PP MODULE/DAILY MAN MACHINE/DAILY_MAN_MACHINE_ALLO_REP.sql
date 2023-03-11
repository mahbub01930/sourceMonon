
WITH Q AS (
SELECT LA.ID ALLOCATION_ID, LA.ASSIGN_DATE, LA.PLANT_ID, AP.PLANT_NAME, LA.PRODUCTION_LINE_ID, APP.PLANT_NAME PRODUCTION_LINE_NAME,
 LB.BATCH_ID, PB.BATCH_NO, LB.PROCESS_ID, PC.PROCESS_NAME, LB.SUB_PROCESS_ID, PCC.PROCESS_NAME SUB_PROCESS_NAME,
LM.ID LINE_MAN_ID, LM.PERSON_ID, HE.EMP_ID, HE.EMP_NAME, HD.DESIG_NAME,
LM.ID LINE_ROOM_ID, LM.ROOM_ID, AP1.PLANT_NAME ROOM_NAME, LM.MACHINE_ID, FAR.ASSET_NAME MACHINE_NAME, FAR.CAPACITY, FAR.CAPACITY_UOM, 
LM.STD_TIME,TO_CHAR(LM.START_TIME,'HH12:MM AM') START_TIME,TO_CHAR(LM.END_TIME,'HH12:MM AM') END_TIME 
FROM PP_PROD_LINE_ALLO LA
LEFT JOIN ADM_PLANT AP ON LA.PLANT_ID=AP.ID
LEFT JOIN ADM_PLANT APP ON LA.PRODUCTION_LINE_ID=APP.ID
LEFT JOIN PP_PROD_LINE_BATCH LB ON LA.ID=LB.PROD_LINE_ID
LEFT JOIN PP_PRODUCT_BATCH PB ON LB.BATCH_ID=PB.ID
LEFT JOIN PP_PROCESS_CONFIG PC ON LB.PROCESS_ID=PC.ID
LEFT JOIN PP_PROCESS_CONFIG PCC ON LB.SUB_PROCESS_ID=PCC.ID
LEFT JOIN PP_PROD_LINE_MAN LM ON LB.ID=LM.LINE_BATCH_ID
LEFT JOIN HRM_EMPLOYEE HE ON LM.PERSON_ID=HE.ID
LEFT JOIN HRM_DESIGNATION HD ON HE.DESIGNATION_ID=HD.ID
LEFT JOIN PP_PROD_LINE_ROOM LM ON LB.ID=LM.LINE_BATCH_ID
LEFT JOIN ADM_PLANT AP1 ON LM.ROOM_ID=AP1.ID
LEFT JOIN FICO_ASSET_REGISTER FAR ON LM.MACHINE_ID=FAR.ID
WHERE LA.ASSIGN_DATE = '25-JAN-2023'
AND LA.SBU_ID=2
)
SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                        'general_building'  VALUE PLANT_NAME,
                        'production_line'   VALUE PRODUCTION_LINE_NAME,
                        'batch_list'        VALUE (
                                                   SELECT JSON_ARRAYAGG(
                                                                JSON_OBJECT(
                                                                            'batch_id'      VALUE BATCH_ID,
                                                                            'batch_no'      VALUE BATCH_NO,
                                                                            'product'       VALUE DISPLAY_NAME,
                                                                            'batch_size'    VALUE BATCH_SIZE,
                                                                            'process_list'  VALUE(
                                                                                                  SELECT JSON_ARRAYAGG(
                                                                                                              JSON_OBJECT(
                                                                                                                          'process_id'       VALUE C.PROCESS_ID,
                                                                                                                          'process_name'     VALUE C.PROCESS_NAME, 
                                                                                                                          'std_time'         VALUE C.STD_TIME,
                                                                                                                          'start_time'       VALUE NVL(C.START_TIME,' '),
                                                                                                                          'end_time'         VALUE NVL(C.END_TIME,' '),
                                                                                                                          'sub_process_list' VALUE(
                                                                                                                                                   SELECT JSON_ARRAYAGG(
                                                                                                                                                                JSON_OBJECT(
                                                                                                                                                                            'process_id'           VALUE C.PROCESS_ID,
                                                                                                                                                                            'sub_process_id'       VALUE D.SUB_PROCESS_ID,
                                                                                                                                                                            'sub_process_name'     VALUE D.SUB_PROCESS_NAME,
                                                                                                                                                                            'employee_list'        VALUE(
                                                                                                                                                                                                         SELECT JSON_ARRAYAGG(
                                                                                                                                                                                                                     JSON_OBJECT(
                                                                                                                                                                                                                                 'employee_id'          VALUE E.EMP_ID,
                                                                                                                                                                                                                                 'employee_name'        VALUE E.EMP_NAME,
                                                                                                                                                                                                                                 'desig_name'           VALUE E.DESIG_NAME
                                                                                                                                                                                                                                )RETURNING CLOB
                                                                                                                                                                                                                             ) FROM (SELECT * FROM Q WHERE PROCESS_ID=C.PROCESS_ID AND SUB_PROCESS_ID=D.SUB_PROCESS_ID)E
                                                                                                                                                                                                        ),
                                                                                                                                                                            'room_list'        VALUE(
                                                                                                                                                                                                         SELECT JSON_ARRAYAGG(
                                                                                                                                                                                                                     JSON_OBJECT(
                                                                                                                                                                                                                                 'room_id'              VALUE F.ROOM_ID,
                                                                                                                                                                                                                                 'room_name'            VALUE F.ROOM_NAME,
                                                                                                                                                                                                                                 'machine_list'         VALUE(
                                                                                                                                                                                                                                                              SELECT JSON_ARRAYAGG(
                                                                                                                                                                                                                                                                          JSON_OBJECT(
                                                                                                                                                                                                                                                                                      'machine_id'      VALUE G.MACHINE_ID,
                                                                                                                                                                                                                                                                                      'machine_name'    VALUE G.MACHINE_NAME,
                                                                                                                                                                                                                                                                                      'capacity'        VALUE G.CAPACITY
                                                                                                                                                                                                                                                                                     )RETURNING CLOB
                                                                                                                                                                                                                                                                                  )FROM (SELECT DISTINCT MACHINE_ID,MACHINE_NAME,X.CAPACITY||' '||ACE.ELEMENT_NAME CAPACITY
                                                                                                                                                                                                                                                                                         FROM Q X
                                                                                                                                                                                                                                                                                         LEFT JOIN ADM_CODE_ELEMENTS ACE ON X.CAPACITY_UOM = ACE.ID
                                                                                                                                                                                                                                                                                         WHERE ROOM_ID=F.ROOM_ID)G
                                                                                                                                                                                                                                                             )
                                                                                                                                                                                                                                )RETURNING CLOB
                                                                                                                                                                                                                             ) FROM (SELECT DISTINCT ROOM_ID,ROOM_NAME FROM Q WHERE PROCESS_ID=C.PROCESS_ID AND SUB_PROCESS_ID=D.SUB_PROCESS_ID)F
                                                                                                                                                                                                        )                            
                                                                                                                                                                           )RETURNING CLOB
                                                                                                                                                                       )FROM (SELECT DISTINCT SUB_PROCESS_ID,SUB_PROCESS_NAME FROM Q WHERE PROCESS_ID=C.PROCESS_ID)D
                                                                                                                                                  )
                                                                                                                         )RETURNING CLOB
                                                                                                  )FROM (SELECT DISTINCT PROCESS_ID,PROCESS_NAME,STD_TIME,START_TIME,END_TIME
                                                                                                         FROM Q WHERE BATCH_ID=B.BATCH_ID) C 
                                                                                                 )
                                                                           ) RETURNING CLOB
                                                                       )FROM (SELECT  X.BATCH_ID,X.BATCH_NO,PB.PROD_ID,SP.DISPLAY_NAME,PB.BATCH_SIZE
                                                                                FROM Q X
                                                                                LEFT JOIN PP_PRODUCT_BATCH PB ON  X.BATCH_ID=PB.ID
                                                                                LEFT JOIN ADM_SBU_PRODUCTS SP ON PB.PROD_ID=SP.PROD_ID
                                                                                WHERE PLANT_ID=A.PLANT_ID AND PRODUCTION_LINE_ID=A.PRODUCTION_LINE_ID
                                                                                GROUP BY X.BATCH_ID,X.BATCH_NO,PB.PROD_ID,SP.DISPLAY_NAME,PB.BATCH_SIZE) B
                                                  )
                       )RETURNING CLOB
                    ) QRY
                    FROM 
                    (SELECT PLANT_ID, PLANT_NAME, PRODUCTION_LINE_ID, PRODUCTION_LINE_NAME FROM Q
                     GROUP BY PLANT_ID, PLANT_NAME, PRODUCTION_LINE_ID, PRODUCTION_LINE_NAME
                    )A