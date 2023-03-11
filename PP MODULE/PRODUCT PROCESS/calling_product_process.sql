---CALLL

DECLARE
    vSTATUS CLOB;
    --vMst number:=null; 
    vPROD_PRO_TYP CLOB := '{
                           "pp_prod_proce_type":[
                              {
                                 "id":null,
                                 "sbu_id":"2",
                                 "prod_id":"194",
                                 "batch_category":7023,
                                 "process_type":"7171",
                                 "checked_mst":0,
                                 "bom_display_code":"NJPL-BOM-22-316"
                              },
                              {
                                 "id":10192,
                                 "sbu_id":"2",
                                 "prod_id":"194",
                                 "batch_category":7023,
                                 "process_type":"7172",
                                 "checked_mst":1,
                                 "bom_display_code":"NJPL-BOM-22-316"
                              }
                           ]
                        }';
                                
    vPRO_TYP_PROC CLOB :=  '{
   "pp_proce_type_proce":[
      {
         "id":"10287",
         "process_id":"10304",
         "sub_process_id":null,
         "process_sequence":1,
         "is_machine_group":"N",
         "process_type":"7172",
         "checked_dtl":1,
         "wip_stage_id":"7611",
         "ipqc_required":"N",
         "qc_required":"N",
         "reconciliation_required":"N",
         "doc_id":null,
         "pro_typ_proc_atb":[
            
         ],
         "pp_proce_machine":[
            
         ]
      },
      {
         "id":"10288",
         "process_id":"10305",
         "sub_process_id":"10307",
         "process_sequence":2,
         "is_machine_group":"N",
         "process_type":"7172",
         "checked_dtl":1,
         "wip_stage_id":"7611",
         "ipqc_required":"N",
         "qc_required":"N",
         "reconciliation_required":"N",
         "doc_id":null,
         "pro_typ_proc_atb":[
            
         ],
         "pp_proce_machine":[
            
         ]
      },
      {
         "id":"10289",
         "process_id":"10305",
         "sub_process_id":"10310",
         "process_sequence":3,
         "is_machine_group":"N",
         "process_type":"7172",
         "checked_dtl":1,
         "wip_stage_id":"7611",
         "ipqc_required":"N",
         "qc_required":"N",
         "reconciliation_required":"N",
         "doc_id":null,
         "pro_typ_proc_atb":[
            
         ],
         "pp_proce_machine":[
            
         ]
      },
      {
         "id":"10290",
         "process_id":"10305",
         "sub_process_id":"10308",
         "process_sequence":4,
         "is_machine_group":"N",
         "process_type":"7172",
         "checked_dtl":1,
         "wip_stage_id":"7611",
         "ipqc_required":"N",
         "qc_required":"N",
         "reconciliation_required":"N",
         "doc_id":null,
         "pro_typ_proc_atb":[
            
         ],
         "pp_proce_machine":[
            
         ]
      },
      {
         "id":"10291",
         "process_id":"10305",
         "sub_process_id":"10309",
         "process_sequence":5,
         "is_machine_group":"N",
         "process_type":"7172",
         "checked_dtl":1,
         "wip_stage_id":"7611",
         "ipqc_required":"Y",
         "qc_required":"N",
         "reconciliation_required":"N",
         "doc_id":null,
         "pro_typ_proc_atb":[
            
         ],
         "pp_proce_machine":[
            
         ]
      },
      {
         "id":"10292",
         "process_id":"10311",
         "sub_process_id":"10312",
         "process_sequence":6,
         "is_machine_group":"N",
         "process_type":"7172",
         "checked_dtl":1,
         "wip_stage_id":"7611",
         "ipqc_required":"N",
         "qc_required":"N",
         "reconciliation_required":"N",
         "doc_id":null,
         "pro_typ_proc_atb":[
            
         ],
         "pp_proce_machine":[
            
         ]
      },
      {
         "id":"10293",
         "process_id":"10311",
         "sub_process_id":"10395",
         "process_sequence":7,
         "is_machine_group":"N",
         "process_type":"7172",
         "checked_dtl":1,
         "wip_stage_id":"7611",
         "ipqc_required":"Y",
         "qc_required":"Y",
         "reconciliation_required":"N",
         "doc_id":null,
         "pro_typ_proc_atb":[
            
         ],
         "pp_proce_machine":[
            
         ]
      },
      {
         "id":"10294",
         "process_id":"10314",
         "sub_process_id":"10315",
         "process_sequence":8,
         "is_machine_group":"N",
         "process_type":"7172",
         "checked_dtl":1,
         "wip_stage_id":"7611",
         "ipqc_required":"Y",
         "qc_required":"N",
         "reconciliation_required":"N",
         "doc_id":null,
         "pro_typ_proc_atb":[
            
         ],
         "pp_proce_machine":[
            
         ]
      },
      {
         "id":"10295",
         "process_id":"10314",
         "sub_process_id":"10316",
         "process_sequence":9,
         "is_machine_group":"N",
         "process_type":"7172",
         "checked_dtl":1,
         "wip_stage_id":"7611",
         "ipqc_required":"Y",
         "qc_required":"Y",
         "reconciliation_required":"Y",
         "doc_id":null,
         "pro_typ_proc_atb":[
            
         ],
         "pp_proce_machine":[
            
         ]
      },
      {
         "id":"10296",
         "process_id":"10318",
         "sub_process_id":"10371",
         "process_sequence":10,
         "is_machine_group":"N",
         "process_type":"7172",
         "checked_dtl":1,
         "wip_stage_id":null,
         "ipqc_required":"N",
         "qc_required":"N",
         "reconciliation_required":"Y",
         "doc_id":null,
         "pro_typ_proc_atb":[
            
         ],
         "pp_proce_machine":[
            
         ]
      },
      {
         "id":"10297",
         "process_id":"10319",
         "sub_process_id":"10347",
         "process_sequence":11,
         "is_machine_group":"N",
         "process_type":"7172",
         "checked_dtl":1,
         "wip_stage_id":"7612",
         "ipqc_required":"Y",
         "qc_required":"N",
         "reconciliation_required":"N",
         "doc_id":null,
         "pro_typ_proc_atb":[
            
         ],
         "pp_proce_machine":[
            
         ]
      },
      {
         "id":"10298",
         "process_id":"10321",
         "sub_process_id":null,
         "process_sequence":12,
         "is_machine_group":"N",
         "process_type":"7172",
         "checked_dtl":1,
         "wip_stage_id":"7612",
         "ipqc_required":"Y",
         "qc_required":"N",
         "reconciliation_required":"N",
         "doc_id":null,
         "pro_typ_proc_atb":[
            
         ],
         "pp_proce_machine":[
            
         ]
      }
   ]
}';          
BEGIN
    JERP_PP_UTIL.PP_PRODUCT_PROCESS(pPROD_PROCE_TYPE       =>vPROD_PRO_TYP,
                                   pPROCE_TYPE_PROCE       =>vPRO_TYP_PROC,
                                   pUSER_ID        =>1,
                                   pIS_SUBMITTED   =>0,
                                   pSTATUS         => vSTATUS
                                );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;