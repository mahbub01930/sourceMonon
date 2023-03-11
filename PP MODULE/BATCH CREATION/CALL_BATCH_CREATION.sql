
DECLARE 
    vSTATUS     CLOB; 
    vBpr_mst CLOB :=  '{"generate_bpr":[{ 
                                          "id":1,
                                          "ppbm_doc_type":3,
                                          "ppbm_prod_id":7393,
                                          "ppbm_bpr_doc_id":"BPR-22-0001"     
                                        },
                                        {  
                                          "id" : null,      
                                          "ppbm_doc_type" : 4,  
                                          "ppbm_prod_id" :7053,  
                                          "ppbm_bpr_doc_id" :"BPR-22-0002"     
                                        } 
                                        ]
                      }';   
BEGIN
    JERP_ADM.GENERATE_BPR_FOR_BATCH_CREATION ( pGENERATE_BPR => vBpr_mst,  
                                               pBATCH_DOC_REQ_ID =>10528,  
                                               pBATCH_NO =>'10002M1122',  
                                               pUSER_ID =>1, 
                                               pSTATUS =>vSTATUS
                                               ); 
    dbms_output.put_line('vSTATUS > '||vSTATUS);
exception when others then
    dbms_output.put_line(sqlerrm);    
END;






/*
DECLARE 
    vSTATUS     CLOB; 
    pBATCH_ID   number :=0; ---DEFULT ZERO
    bdr_mst CLOB :=  '{ "batch_create" : 
                                    {  
                                      "batch_doc_type" : "BDFSMR",  
                                      "ppb_id" : null,      
                                      "ppb_prod_id" : 1016524,  
                                      "ppb_sbu_id" :2,   
                                      "ppb_batch_create_date" :"02-06-2022",
                                      "ppb_batch_status" :1,
                                      "ppb_bom_id" : 102,   
                                      "ppb_batch_size" : 252 ,    
                                      "ppb_std_qty" : 21,   
                                      "ppb_std_uom" : 534,
                                      "ppb_prod_location_id" :646,   
                                      "ppb_bmr_id" :1,  
                                      "ppb_bpr_id" :12, 
                                      "ppb_batch_type" :2,  
                                      "ppb_production_type" :218,  
                                      "ppb_batch_category" :  52, 
                                      "ppb_batch_doc_req_id" :1 ,
                                      "ppb_batch_no" : "10002M1122", 
                                      "prod_batch_map" : [
                                        {
                                          "ppbm_id": null,    
                                          "ppbm_doc_type" :2,   
                                          "ppbm_prod_id" :1002,
                                          "ppbm_bpr_doc_id" : "BPR-22-0001" 
                                        }
                                      ] 
                                  } 
                                }';   
                              
                                                 
BEGIN
    JERP_ADM.BATCH_CREATION( bdr_mst, pBATCH_ID, 0, 0, 1522, vSTATUS); 
    dbms_output.put_line('vSTATUS > '||pBATCH_ID||'-'||vSTATUS);
exception when others then
    dbms_output.put_line(sqlerrm);    
END;
*/