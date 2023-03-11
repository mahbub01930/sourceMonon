--- PD_DISPENSE_REQUISITION

DECLARE 
    vSTATUS               CLOB;
    pREQ_ID               NUMBER := 1228;
    pDES_REQ_MST CLOB :=  '{
                           "des_req_mst": [
                              {
                                 "sbu_id": 2,
                                 "req_from_wh": 218,
                                 "req_to_wh": 201,
                                 "is_urgent": "Y",
                                 "req_cat_type":10069 ,
                                 "req_prod_types": "251,252,260",
                                 "req_purpose": "URGENT",
                                 "req_comments": "THIS IS DISPENSABLE REQ",
                                 "is_extra_req": "N",
                                 "for_products": "132",
                                 "for_batches": "10568"
                              }
                           ]
                        }';
                                
    pDES_REQ_DTL CLOB :=  '{
                           "des_req_dtl": [
                              {
                                 "id": 1509,
                                 "prod_id": 6202,
                                 "uom": 532,
                                 "req_qty": 10,
                                 "batch_lot_number": "00256"
                              },
                              {
                                 "id": 1510,
                                 "prod_id": 6141,
                                 "uom": 532,
                                 "req_qty": 7,
                                 "batch_lot_number": "00256"
                              },
                              {
                                 "id": 1567,
                                 "prod_id": 6174,
                                 "uom": 531,
                                 "req_qty": 300,
                                 "batch_lot_number": "00256"
                              },
                             {
                                 "id": 1568,
                                 "prod_id": 6204,
                                 "uom": 531,
                                 "req_qty": 300,
                                 "batch_lot_number": "00256"
                              }
                             
                           ]
                        }';
    pDES_REQ_ATT CLOB :=  null;                 
                                
                          
BEGIN
    PD_DISPENSE_REQUISITION( pDES_REQ_MST,pDES_REQ_DTL,pDES_REQ_ATT, 2415,1,0,pREQ_ID, vSTATUS);
    DBMS_OUTPUT.PUT_LINE('vSTATUS > '||VSTATUS);
EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);    
END;