WITH AP AS (
SELECT * FROM ADM_PLANT
)
select json_arrayagg(
        json_object(
                   'id' value l1.id,
                   'plant_code' value l1.PLANT_CODE,
                   'plant_name' value l1.PLANT_NAME,
                   'level'||l1.lvl value( 
                                         select json_arrayagg(
                                            json_object(
                                                        'id' value l2.id,
                                                        'plant_code' value l2.PLANT_CODE,
                                                        'plant_name' value l2.PLANT_NAME,
                                                        'level'||l2.lvl value(
                                                                               select json_arrayagg(
                                                                                       json_object(
                                                                                                   'id' value l3.id,
                                                                                                   'plant_code' value l3.PLANT_CODE,
                                                                                                   'plant_name' value l3.PLANT_NAME,
                                                                                                   'level'||l3.lvl value(
                                                                                                                          select json_arrayagg(
                                                                                                                                 json_object(
                                                                                                                                             'id' value l4.id,
                                                                                                                                             'plant_code' value l4.PLANT_CODE,
                                                                                                                                             'plant_name' value l4.PLANT_NAME,
                                                                                                                                             'level'||l4.lvl value(
                                                                                                                                                                   select json_arrayagg(
                                                                                                                                                                          json_object(
                                                                                                                                                                                      'id' value l5.id,
                                                                                                                                                                                      'plant_code' value l5.PLANT_CODE,
                                                                                                                                                                                      'plant_name' value l5.PLANT_NAME,
                                                                                                                                                                                      'level'||l5.lvl value null
                                                                                                                                                                                     )returning clob
                                                                                                                                                                                )qry from (select * from AP where PARENT=l4.id) l5
                                                                                                                                                                  ) 
                                                                                                                                            )returning clob
                                                                                                                                        ) qry from (select * from AP where PARENT=l3.id) l4
                                                                                                                        )
                                                                                                   )
                                                                                                ) qry from (select * from AP where PARENT=l2.id) l3
                                                                             )
                                                        ) returning clob
                                                    ) qry from (select * from AP where PARENT=l1.id) l2
                                        )
       )returning clob
    ) qry 
from (SELECT * FROM AP WHERE PLANT_TYPE=NVL(:pType,PLANT_TYPE)) l1