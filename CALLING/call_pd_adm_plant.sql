
-- CALLING:

DECLARE 
    vID    NUMBER := NULL;
    vSTATUS     CLOB;
    vPROD_CAT CLOB :='{"prod_cat":[
                        {
                          "id":null,
                          "prod_cat_id":451,
                          "is_cheeck":
                        },
                        {
                          "id":null,
                          "prod_cat_id":452,
                          "is_cheeck":
                        }
                    ]}';
BEGIN
    PD_ADD_PLANT (pSBU_ID  =>   2,     
                pID  =>         vID,   
                pPARENT =>       1004, 
                pPLANT_TYPE  =>   183,
                pPLANT_CODE  =>      'Room-0',      
                pPLANT_NAME   =>  'Room-0 - Batch1 - packing -print',
                pPLANT_ADDRESS  =>'Floor-01-Room-0',
                pUSER_ID       => 1,
                pPROD_CAT  =>  vPROD_CAT,
                pSTATUS => vSTATUS
           );
END;
