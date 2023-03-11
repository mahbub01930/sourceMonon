DECLARE 
    vSTATUS     CLOB;
    vMst number:=0; 
    vSBU_ID number:=2; 
    Vac_mst CLOB :=  '{ "aqd_mst":[
                                  {
                                     "id":null,
                                     "sbu_id": "2",
                                     "ref_id":"1015",
                                     "ref_id1":"4",
                                     "trn_type":"8",
                                     "qtemp_id":"7"
                                  },
                                     {
                                     "id":null,
                                     "sbu_id": "2",
                                     "ref_id":"1020",
                                     "ref_id1":"7",
                                     "trn_type":"9",
                                     "qtemp_id":"8"
                                     }
                                      
                                ] 
                                }'; 
        Vace_dtl CLOB :=  '{ "adq_dtl":[
                                     {   "id" :null, 
                                         "qmst_id": null,
                                         "array_answer":"a",
                                         "answer_text":"answer_text", 
                                         "comments":"comments", 
                                         "sort_order":"1",
                                         "sl_no":"1" ,
                                         "question":"question 1" ,
                                         "answer_array":"answer_array1" ,
                                         "array_separator":"as 2" ,
                                         "answer_field" : "2"
                                      },
                                      {  "id" :null, 
                                         "qmst_id": null,
                                         "array_answer":"a",
                                         "answer_text":"answer_text", 
                                         "comments":"comments", 
                                         "sort_order":"1",
                                         "sl_no":"1" ,
                                         "question":"question 1" ,
                                         "answer_array":"answer_array2" ,
                                         "array_separator":"as 3" ,
                                         "answer_field" : "4"
                                      }  
                                    ]
                                    }';  
      Vac_IMCS_mst CLOB :=  '{ "imcs_mst":[
                                  {
                                     "id":null,
                                     "imcs_code": null,
                                     "imcs_date":"25-08-2022",
                                     "quest_id":25,
                                     "doc_check_list_id":26,
                                     "receive_date":"25-08-2022",
                                     "receive_time": "25-08-2022",
                                     "lc_po_no":1002,
                                     "mat_prod_id":1003,
                                     "vehicle_no":"s12",
                                     "container_seal_no":"3",
                                     "grn_id":1,
                                     "notes":"Good"
                                  }
                                ] 
                                }';
  Vac_IMCS_dtl CLOB :=  '{ "imcs_dtl":[
                                  {
                                     "id":null,
                                     "imcs_id":null,
                                     "sl_no":1,
                                     "container_no":1,
                                     "container_type":10541,
                                     "volume": 40,
                                     "container_uom":534,
                                     "is_intact":"n",
                                     "remarks":"rmks1"
                                  },
                                   {
                                     "id":null,
                                     "imcs_id":null,
                                     "sl_no":2,
                                     "container_no":2,
                                     "container_type":10542,
                                     "volume": 40,
                                     "container_uom":534,
                                     "is_intact":"n",
                                     "remarks":"rmks2"
                                  }
                                ] 
                                }';
           
            
BEGIN
    PD_IMCS( Vac_mst,  Vace_dtl,Vac_IMCS_mst,Vac_IMCS_dtl,  111,vSBU_ID,vMst,  vSTATUS);
--    dbms_output.put_line('Vpp_prod_proce_type > '||Vpp_prod_proce_type);
--    dbms_output.put_line('Vpp_proce_type_proce > '||Vpp_proce_type_proce);
--    dbms_output.put_line('Vpp_proce_mechine > '||Vpp_proce_mechine);
    dbms_output.put_line('vSTATUS > '||vSTATUS);
exception when others then
    dbms_output.put_line(sqlerrm);    
END;


---update

/*                  
DECLARE 
    vSTATUS     CLOB;
    vMst number:=0; 
    Vac_mst CLOB :=  '{ "aqd_mst":[
                                  {
                                     "id":77,
                                     "sbu_id": "2",
                                     "ref_id":"3",
                                     "ref_id1":"4",
                                     "trn_type":"8",
                                     "qtemp_id":"7"
                                  },
                                     {
                                     "id":78,
                                     "sbu_id": "2",
                                     "ref_id":"5",
                                     "ref_id1":"7",
                                     "trn_type":"9",
                                     "qtemp_id":"8"
                                     }
                                      
                                ] 
                                }'; 
        Vace_dtl CLOB :=  '{ "adq_dtl":[
                                     {   "id" :141, 
                                         "qmst_id": "77",
                                         "array_answer":"a",
                                         "answer_text":"answer_text", 
                                         "comments":"comments", 
                                         "sort_order":"1",
                                         "sl_no":"1" ,
                                         "question":"question 1" ,
                                         "answer_array":"answer_array1" ,
                                         "array_separator":"as 2" ,
                                         "answer_field" : "2"
                                      },
                                      {  "id" :143, 
                                         "qmst_id": "78",
                                         "array_answer":"a",
                                         "answer_text":"answer_text", 
                                         "comments":"comments", 
                                         "sort_order":"1",
                                         "sl_no":"1" ,
                                         "question":"question 1" ,
                                         "answer_array":"answer_array2" ,
                                         "array_separator":"as 3" ,
                                         "answer_field" : "4"
                                      }  
                                    ]
                                    }';  
      Vac_IMCS_mst CLOB :=  '{ "imcs_mst":[
                                  {
                                     "id":51,
                                     "imcs_code": "1",
                                     "imcs_date":"25-08-2022",
                                     "quest_id":25,
                                     "doc_check_list_id":26,
                                     "receive_date":"25-08-2022",
                                     "receive_time": "25-08-2022",
                                     "lc_po_no":1,
                                     "mat_prod_id":1,
                                     "vehicle_no":"s12",
                                     "container_seal_no":"3",
                                     "grn_id":1,
                                     "notes":"Good"
                                  }
                                ] 
                                }';
  Vac_IMCS_dtl CLOB :=  '{ "imcs_dtl":[
                                  {
                                     "id":7,
                                     "imcs_id":51,
                                     "sl_no":1,
                                     "container_no":1,
                                     "container_type":2,
                                     "volume": 40,
                                     "container_uom":1,
                                     "is_intact":"n",
                                     "remarks":"rmks1"
                                  },
                                   {
                                     "id":8,
                                     "imcs_id":51,
                                     "sl_no":2,
                                     "container_no":2,
                                     "container_type":2,
                                     "volume": 40,
                                     "container_uom":1,
                                     "is_intact":"n",
                                     "remarks":"rmks2"
                                  },
                                    {
                                     "id":12,
                                     "imcs_id":null,
                                     "sl_no":3,
                                     "container_no":3,
                                     "container_type":2,
                                     "volume": 40,
                                     "container_uom":1,
                                     "is_intact":"n",
                                     "remarks":"rmks3"
                                  }
                                ] 
                                }';
           
            
BEGIN
    PD_IMCS( Vac_mst,  Vace_dtl,Vac_IMCS_mst,Vac_IMCS_dtl,  111,vMst,  vSTATUS);
--    dbms_output.put_line('Vpp_prod_proce_type > '||Vpp_prod_proce_type);
--    dbms_output.put_line('Vpp_proce_type_proce > '||Vpp_proce_type_proce);
--    dbms_output.put_line('Vpp_proce_mechine > '||Vpp_proce_mechine);
    dbms_output.put_line('vSTATUS > '||vSTATUS);
exception when others then
    dbms_output.put_line(sqlerrm);    
END;
*/