DECLARE
    vSTATUS CLOB;
    vMst number:=null; 
    vQC_PARAM CLOB := '{ "basic_info":
                                  {
                                     "prod_id":2,
                                     "primary_info":{
                                                        "spec_ref_no" : "AA",
                                                        "effective_date" : "30-NOV-2022",
                                                        "supersedes" : "AA",
                                                        "cas_no" : "AA",
                                                        "synonyms" : "AA",
                                                        "molecular_formula" : "AA",                                                       
                                                        "molecular_weight" : "AA",
                                                        "description" : "SS",
                                                        "safety_pre_caution" : "SS",
                                                        "shelf_life" : "SS",
                                                        "dar_no" : "SS",
                                                        "shape_size" : "SS",
                                                        "reference_no" : "SS",
                                                        "color_smell" : "SS"
                                                    },
                                    "packaging_info":{
                                                        "pack_size" : "SS",
                                                        "packing_mode" : "SS",
                                                        "storage_condition" : "SS",
                                                        "container" : "SS",
                                                        "doc_com_supp" : "SS",
                                                        "doc_new_source" : "SS"
                                                    },
                                    "revesion_info":{
                                                        "version_no" : "V1",
                                                        "review_date" : "29-NOV-2022",
                                                        "issue_date" : "29-NOV-2022",
                                                        "cause_for_version" : "V2"
                                                    }                
                                  }
                                }';
           vLABEL_INFO     CLOB := '{"label_info": [
                                            {
                                                "manufacturer" : "JMI"
                                            },
                                            {
                                                "batch_no" : "23"
                                            },
                                            {
                                                "gross_weight" : 28
                                            },
                                            {
                                                "net_weight" : 28
                                            },
                                            {
                                                "manufacture_date" : "28-DEC-2022"
                                            },

                                            {
                                                "exp_date" : "28-DEC-2022"
                                            },
                                            {
                                                "storage_condition" : "12"
                                            }
                                        ]
                                }';  
         vRAW_QC_SPEC     CLOB := null;/*'{"raw_qc_spec": [
                                        {
                                            "id": null,
                                            "test_id": 123,
                                            "reference": "raw-ref",
                                            "test_type": "raw_qc_spec",
                                            "specification": "raw_qc_spec spec",
                                            "version_no": "v1",
                                            "test_serial_no":1,
                                            "attb_data": [
                                                {
                                                    id: null,
                                                    "atab_id": 22,
                                                    "data_value": "16.6"
                                                }
                                            ]
                                        }
                                    ]
                                }'; */
         vWIP_QC_SPEC     CLOB := '{"wip_qc_process": [
                                        {
                                            "id": null,
                                            "wip_stage_id": 111,
                                            "process_id": 111,
                                            "sub_process_id": 111,
                                            "wip_qc_spec": [
                                                {
                                                    "id": null,
                                                    "test_id": 123,
                                                    "reference": "wip_qc_process",
                                                    "test_type": "wip_qc_process tt",
                                                    "specification": "wip_qc_process spec",
                                                    "version_no": "v1",
                                                    "test_serial_no":1,
                                                    "attb_data": [
                                                        {
                                                            "id" : null,
                                                            "atab_id": 22,
                                                            "data_value": "26.6"
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                }'; 
        vWIP_IPQC_SPEC     CLOB := '{"ipqc_process": [
                                        {
                                            "id": null,
                                            "wip_stage_id": 222,
                                            "process_id": 222,
                                            "sub_process_id": 222,
                                            "wip_ipqc_spec": [
                                                {
                                                    "id": null,
                                                    "test_id": 123,
                                                    "reference": "wip_ipqc_spec ref",
                                                    "test_type": "wip_ipqc_spec tt",
                                                    "specification": "wip_ipqc_spec spec",
                                                    "version_no": "v1",
                                                    "test_serial_no":1,
                                                    "ipqc_attb_data": [
                                                        {
                                                            "id" : null,
                                                            "atab_id": 22,
                                                            "data_value": "36.6"
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                }';               
BEGIN
    JERP_ADM.PD_QC_PARAMETER_SETUP(pQC_PARAM_ID    =>vMst,
                                       pQC_PARAM       =>vQC_PARAM ,
                                       pLABEL_INFO       =>vLABEL_INFO,
                                       pRAW_QC_SPEC       =>vRAW_QC_SPEC,
                                       pWIP_QC_SPEC   =>vWIP_QC_SPEC,
                                       pWIP_IPQC_SPEC   =>vWIP_IPQC_SPEC,
                                       pSBU_ID      =>2,
                                       pUSER_ID        =>1,
                                       pIS_SUBMITTED        =>0,
                                       pSTATUS         => vSTATUS
                                    );
DBMS_OUTPUT.PUT_LINE(vSTATUS);

END;

/*
-----------UPDATE

DECLARE
    vSTATUS CLOB;
    vMst number:=10145; 
    vQC_PARAM CLOB := '{ "basic_info":
                                  {
                                     "prod_id":2,
                                     "primary_info":{
                                                        "spec_ref_no" : "AA",
                                                        "effective_date" : "30-NOV-2022",
                                                        "supersedes" : "AA",
                                                        "cas_no" : "AA",
                                                        "synonyms" : "AA",
                                                        "molecular_formula" : "AA",                                                       
                                                        "molecular_weight" : "AA",
                                                        "description" : "SS",
                                                        "safety_pre_caution" : "SS",
                                                        "shelf_life" : "SS",
                                                        "dar_no" : "SS",
                                                        "shape_size" : "SS",
                                                        "reference_no" : "SS",
                                                        "color_smell" : "SS"
                                                    },
                                    "packaging_info":{
                                                        "pack_size" : "SS",
                                                        "packing_mode" : "SS",
                                                        "storage_condition" : "SS",
                                                        "container" : "SS",
                                                        "doc_com_supp" : "SS",
                                                        "doc_new_source" : "SS"
                                                    },
                                    "revesion_info":{
                                                        "version_no" : "V1",
                                                        "review_date" : "29-NOV-2022",
                                                        "issue_date" : "29-NOV-2022",
                                                        "cause_for_version" : "V2"
                                                    }                
                                  }
                                }';
           vLABEL_INFO     CLOB := '{"label_info": [
                                            {
                                                "manufacturer" : "JMI"
                                            },
                                            {
                                                "batch_no" : "23"
                                            },
                                            {
                                                "gross_weight" : 29
                                            },
                                            {
                                                "net_weight" : 29
                                            },
                                            {
                                                "manufacture_date" : "28-DEC-2022"
                                            },

                                            {
                                                "exp_date" : "28-DEC-2022"
                                            },
                                            {
                                                "storage_condition" : "12"
                                            }
                                        ]
                                }';  
         vRAW_QC_SPEC     CLOB := null;/*'{"raw_qc_spec": [
                                        {
                                            "id": null,
                                            "test_id": 123,
                                            "reference": "raw-ref",
                                            "test_type": "raw_qc_spec",
                                            "specification": "raw_qc_spec spec",
                                            "version_no": "v1",
                                            "attb_data": [
                                                {
                                                    id: null,
                                                    "atab_id": 22,
                                                    "data_value": "16.6"
                                                }
                                            ]
                                        }
                                    ]
                                }'; */
         vWIP_QC_SPEC     CLOB := '{"wip_qc_process": [
                                        {
                                            "id": 10167,
                                            "wip_stage_id": 1113,
                                            "process_id": 1113,
                                            "sub_process_id": 1113,
                                            "wip_qc_spec": [
                                                {
                                                    "id": 10317,
                                                    "test_id": 123,
                                                    "reference": "wip_qc_process U",
                                                    "test_type": "wip_qc_process tt U",
                                                    "specification": "wip_qc_process spec",
                                                    "version_no": "v1",
                                                    "attb_data": [
                                                        {
                                                            "id" : 1423,
                                                            "atab_id": 23,
                                                            "data_value": "26.6"
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                }'; 
        vWIP_IPQC_SPEC     CLOB := '{"ipqc_process": [
                                        {
                                            "id": 10168,
                                            "wip_stage_id": 2224,
                                            "process_id": 2224,
                                            "sub_process_id": 2224,
                                            "wip_ipqc_spec": [
                                                {
                                                    "id": 10318,
                                                    "test_id": 123,
                                                    "reference": "wip_ipqc_spec ref U",
                                                    "test_type": "wip_ipqc_spec tt U",
                                                    "specification": "wip_ipqc_spec spec U",
                                                    "version_no": "v1",
                                                    "ipqc_attb_data": [
                                                        {
                                                            "id" : 1424,
                                                            "atab_id": 22,
                                                            "data_value": "36.6"
                                                        }
                                                    ]
                                                }
                                            ]
                                        }
                                    ]
                                }';               
BEGIN
    JERP_ADM.PD_QC_PARAMETER_SETUP(pQC_PARAM_ID    =>vMst,
                                       pQC_PARAM       =>vQC_PARAM ,
                                       pLABEL_INFO       =>vLABEL_INFO,
                                       pRAW_QC_SPEC       =>vRAW_QC_SPEC,
                                       pWIP_QC_SPEC   =>vWIP_QC_SPEC,
                                       pWIP_IPQC_SPEC   =>vWIP_IPQC_SPEC,
                                       pSBU_ID      =>2,
                                       pUSER_ID        =>1,
                                       pIS_SUBMITTED        =>1,
                                       pSTATUS         => vSTATUS
                                    );
DBMS_OUTPUT.PUT_LINE(vSTATUS);

END;
*/

