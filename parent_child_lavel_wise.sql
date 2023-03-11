WITH AP AS
    (SELECT * FROM ADM_PLANT)
     SELECT json_arrayagg (
                json_object (
                             'pcode' VALUE A.PLANT_CODE,
                             'pname' VALUE A.PLANT_NAME,
                             'Lavel-1' value (
                                                     SELECT json_arrayagg (
                                                            json_object (
                                                                         'pcode' VALUE b.PLANT_CODE,
                                                                         'pname' VALUE b.PLANT_NAME,
                                                                         'Lavel-2' value (
                                                                                                 SELECT json_arrayagg (
                                                                                                        json_object (
                                                                                                                     'pcode' VALUE c.PLANT_CODE,
                                                                                                                     'pname' VALUE c.PLANT_NAME,
                                                                                                                     'Lavel-3' value (
                                                                                                                                         SELECT json_arrayagg (
                                                                                                                                                json_object (
                                                                                                                                                             'pcode' VALUE d.PLANT_CODE,
                                                                                                                                                             'pname' VALUE d.PLANT_NAME,
                                                                                                                                                             'Lavel-4' value (
                                                                                                                                                                                 SELECT json_arrayagg (
                                                                                                                                                                                        json_object (
                                                                                                                                                                                                     'pcode' VALUE e.PLANT_CODE,
                                                                                                                                                                                                     'pname' VALUE e.PLANT_NAME,
                                                                                                                                                                                                     'Lavel-5' value (
                                                                                                                                                                                                                         SELECT json_arrayagg (
                                                                                                                                                                                                                                json_object (
                                                                                                                                                                                                                                             'pcode' VALUE f.PLANT_CODE,
                                                                                                                                                                                                                                             'pname' VALUE f.PLANT_NAME
                                                                                                                                                                                                                                            ) RETURNING CLOB
                                                                                                                                                                                                                                          ) QRY
                                                                                                                                                                                                        FROM (SELECT * FROM AP WHERE parent = e.id) f
                                                                                                                                                                                                    )
                                                                                                                                                                                                    ) RETURNING CLOB
                                                                                                                                                                                                  ) QRY
                                                                                                                                                                                FROM (SELECT * FROM AP WHERE parent = d.id) e
                                                                                                                                                                            )
                                                                                                                                                            ) RETURNING CLOB
                                                                                                                                                          ) QRY
                                                                                                                                     FROM (SELECT * FROM AP WHERE parent = c.id) d
                                                                                                                                    )
                                                                                                                    ) RETURNING CLOB
                                                                                                                  ) QRY
                                                                                             FROM (SELECT * FROM AP WHERE parent = b.id) c
                                                                                            )
                                                                        ) RETURNING CLOB
                                                                      ) QRY
                                                 FROM (SELECT * FROM AP WHERE parent = a.id) b
                                                )
                            ) RETURNING CLOB
                          ) QRY
     FROM (SELECT * FROM AP WHERE ID = NVL (:pID,ID)) A;