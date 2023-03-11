DECLARE 
    vSTATUS     CLOB;
    vMst number:=0; 
    --vSBU_ID number:=2; 
    Vac_IMCS_mst CLOB :=  '{ "pr_mst":[
                                  {
                                     "prm_sbu_id": 2,
                                     "prm_prod_id":253,
                                     "prm_prod_qty":20,
                                     "prm_prod_uom":532,
                                     "prm_prod_weight":2,
                                     "prm_weight_uom": 538,
                                     "version_no": "1.2"
                                  }
                                ] 
                                }';
    Vac_IMCS_dtl CLOB :=  '{ "pr_dtl":[
                                  {
                                     "id":null,
                                     "prd_mat_prod_id":6139,
                                     "prd_required_qty":1,
                                     "prd_required_uom":538,
                                     "prd_overage":2,
                                     "prd_total_with_wastage_qty": 1,
                                     "prd_spec":1
                                     },
                                   {
                                     "id":null,
                                     "prd_mat_prod_id":6141,
                                     "prd_required_qty":1,
                                     "prd_required_uom":538,
                                     "prd_overage":3,
                                     "prd_total_with_wastage_qty": 3,
                                     "prd_spec":2
                                  }
                                ] 
                                }';
           
            
BEGIN
    PP_RECEIPE(pPR_MST => Vac_IMCS_mst, 
               pPR_DTL=> Vac_IMCS_dtl,
               pUSER_ID=>1,
               pIS_SUBMITTED=>0,
               pPR_MST_ID=>vMst,  
               pSTATUS=>vSTATUS);
               
    dbms_output.put_line('vSTATUS > '||vSTATUS);
exception when others then
    dbms_output.put_line(sqlerrm);    
END;


-----UPDATE

/*
DECLARE 
    vSTATUS     CLOB;
    vMst number:=10012; 
    --vSBU_ID number:=2; 
    Vac_IMCS_mst CLOB :=  '{ "pr_mst":[
                                  {
                                     "prm_sbu_id": 2,
                                     "prm_prod_id":253,
                                     "prm_prod_qty":20,
                                     "prm_prod_uom":532,
                                     "prm_prod_weight":2,
                                     "prm_weight_uom": 538,
                                     "version_no": "1.3"
                                  }
                                ] 
                                }';
    Vac_IMCS_dtl CLOB :=  '{ "pr_dtl":[
                                  {
                                     "id":1015,
                                     "prd_mat_prod_id":6139,
                                     "prd_required_qty":1,
                                     "prd_required_uom":538,
                                     "prd_overage":2,
                                     "prd_total_with_wastage_qty": 1,
                                     "prd_spec":2
                                     },
                                   {
                                     "id":1016,
                                     "prd_mat_prod_id":6141,
                                     "prd_required_qty":1,
                                     "prd_required_uom":538,
                                     "prd_overage":3,
                                     "prd_total_with_wastage_qty": 3,
                                     "prd_spec":5
                                  }
                                ] 
                                }';
           
            
BEGIN
    PP_RECEIPE(pPR_MST => Vac_IMCS_mst, 
               pPR_DTL=> Vac_IMCS_dtl,
               pUSER_ID=>1,
               pIS_SUBMITTED=>1,
               pPR_MST_ID=>vMst,  
               pSTATUS=>vSTATUS);
               
    dbms_output.put_line('vSTATUS > '||vSTATUS);
exception when others then
    dbms_output.put_line(sqlerrm);    
END;
*/