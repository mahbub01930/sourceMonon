

DECLARE
    VPOUTPUT        CLOB;
    vRETURN_CLOB        CLOB;
    vINPUT CLOB :='{"input":
                        {
                          "transaction_id":3024,
                          "prod_id":6038,
                          "container_no":"1,2",
                          "sbu_id":2
                        }
                    }';
BEGIN
 PD_STICKER_PRINT (pSTICKER_TYPE    => 7460,
                   pINPUT       => vINPUT,
                   POUTPUT        => VPOUTPUT
                 ); 
DBMS_OUTPUT.PUT_LINE(VPOUTPUT);
END;

/*
SELECT DFN_STICKER_PRINT (pSTICKER_TYPE => 7460,
                          pINPUT        =>'{"input":
                                            {
                                              "transaction_id":3024,
                                              "prod_id":6038,
                                              "container_no":"1,2",
                                              "sbu_id":2
                                            }
                                         }'
                        ) RETURN_CLOB FROM DUAL;
*/
 


