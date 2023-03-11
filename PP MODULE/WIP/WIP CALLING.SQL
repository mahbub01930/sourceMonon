DECLARE
    vSTATUS CLOB;
    vMst number:=null; 
    vCONTAINER_NO   CLOB:=null;
    vWIP_MST CLOB := '{ "wip_mst":
                                  {
                                     "batch_id":11663,
                                     "prod_id":183,
                                     "total_process_no":22
                                  }
                                }';
                                
    vWIP_PROCESS CLOB :=  '{ "wip_process":[
                                             {
                                             "id":null,
                                             "wip_stage_id":7611,
                                             "process_id":10305,
                                             "sub_process_id":10310,
                                             "is_completed":"N",
                                             "is_skipped":"N",
                                             "prod_line_id":1007,
                                             "wip_proc_time":[
                                                         {
                                                            "id":null,
                                                            "timing_action":7831,
                                                            "process_date":"2023-02-06",
                                                            "start_time":"06-02-2023 13:57:36",
                                                            "end_time":null,
                                                            "total_time_cons":"0:0:0",
                                                            "remarks":null
                                                         }
                                             ],
                                             "wip_sample":[
                                                
                                             ],
                                             "wip_person_eng":[
                                                         {
                                                            "id":null,
                                                            "person_id":123,
                                                            "process_date":"2023-02-08",
                                                            "start_time":"06-02-2023 13:57:36",
                                                            "end_time":null,
                                                            "total_time_cons":"0:0:0",
                                                            "remarks":null
                                                         }
                                             ],
                                             "wip_machine_eng":[
                                                         {
                                                            "id":null,
                                                            "asset_id":123,
                                                            "process_date":"2023-02-08",
                                                            "start_time":"06-02-2023 13:57:36",
                                                            "end_time":null,
                                                            "total_time_cons":"0:0:0",
                                                            "remarks":null
                                                         }
                                             ],
                                             "recon_pro_output":[
                                                                {
                                                                  "id":null,
                                                                  "sl_no":123,
                                                                  "prod_id":11,
                                                                  "item_name":"AAAA",
                                                                  "output_qty":2,
                                                                  "output_uom":532
                                                                }
                                                
                                             ],
                                             "yield_recon":[
                                                            {
                                                              "id":null,
                                                              "sl_no":3,
                                                              "prefix":"C",
                                                              "record_param":"TOTAL WEIGHT",
                                                              "record_formula":"A+B",
                                                              "yield_value":10,
                                                              "yield_uom": 532
                                                            },
                                                            {
                                                              "id":null,
                                                              "sl_no":4,
                                                              "prefix":"D",
                                                              "record_param":"ACTUAL WEIGHT GRANULES (TOTAL NET WEIGHT)",
                                                              "record_formula":null,
                                                              "yield_value":5,
                                                              "yield_uom": 532
                                                            }
                                                
                                             ]
                                          }
                                        ]
                                }';          
BEGIN
    JERP_ADM.PD_WIP_PROCESS_FINISHING(pWIP_MST_ID    =>vMst,
                                       pWIP_MST       =>vWIP_MST,
                                       pWIP_PROCESS       =>vWIP_PROCESS,
                                       pSBU_ID  =>2,
                                       pUSER_ID        =>1,
                                       pCONTAINER_NO    =>vCONTAINER_NO,
                                       pSTATUS         => vSTATUS
                                    );
DBMS_OUTPUT.PUT_LINE(vSTATUS);

END;