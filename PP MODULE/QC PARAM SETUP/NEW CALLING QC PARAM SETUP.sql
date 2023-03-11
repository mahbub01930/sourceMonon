--create or replace procedure qcpm as
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
         vRAW_QC_SPEC     CLOB := NULL;/*'{"raw_qc_spec": [
                                            {
                                                "id": 10408,
                                                "test_id": 10294,
                                                "reference": "raw-ref U",
                                                "test_type": null,
                                                "specification": "raw_qc_spec spec UP",
                                                "version_no": "v1",
                                                "test_serial_no":1,
                                                "sub_test": [
                                                            {
                                                                "id": 10409,
                                                                "parent_id": null,
                                                                "sub_test_id": 10295,
                                                                "sub_reference": "raw-ref U",
                                                                "sub_specification": "raw_qc_spec spec U",
                                                                "sub_test_serial_no":2
                                                            },
                                                            {
                                                                "id": 10410,
                                                                "parent_id": null,
                                                                "sub_test_id": 10296,
                                                                "sub_reference": "raw-ref U",
                                                                "sub_specification": "raw_qc_spec spec U",
                                                                "sub_test_serial_no":3
                                                            }
                                                ],
                                                "attb_data": [
                                                            {
                                                            "id" : null,
                                                            "atab_id": 22,
                                                            "data_value": "26.6"
                                                        }
                                                ]
                                            }
                                            ]
                                        }'; */
         vWIP_QC_SPEC     CLOB := '{"wip_qc_process": [
                                        {
                                            "id": null,
                                            "wip_stage_id": 7611,
                                            "process_id": 10384,
                                            "sub_process_id": 10385,
                                            "wip_qc_spec": [
                                                {
                                                    "id": null,
                                                    "test_id": 10294,
                                                    "reference": "wip_qc_process",
                                                    "test_type": null,
                                                    "specification": "wip_qc_process spec",
                                                    "version_no": "v1",
                                                    "test_serial_no":1,
                                                    "sub_test":[
                                                                {
                                                                    "id": null,
                                                                    "parent_id": null,
                                                                    "sub_test_id": 10295,
                                                                    "sub_reference": "raw-ref",
                                                                    "sub_specification": "raw_qc_spec spec",
                                                                    "sub_test_serial_no":2,
                                                                    "sub_attb_data": [
                                                                                    {
                                                                                    "id" : null,
                                                                                    "sub_atab_id": 22,
                                                                                    "sub_data_value": "1.25"
                                                                                    }
                                                                                 ]
                                                                },
                                                                {
                                                                    "id": null,
                                                                    "parent_id": null,
                                                                    "sub_test_id": 10296,
                                                                    "sub_reference": "raw-ref",
                                                                    "sub_specification": "raw_qc_spec spec",
                                                                    "sub_test_serial_no":3,
                                                                    "sub_attb_data": [
                                                                                    {
                                                                                    "id" : null,
                                                                                    "sub_atab_id": 23,
                                                                                    "sub_data_value": "2.1"
                                                                                    }
                                                                                 ]
                                                                }
                                                               ],
                                                    "attb_data": []
                                                }
                                            ]
                                        }
                                    ]
                                }'; 
        vWIP_IPQC_SPEC     CLOB := '{"ipqc_process": [
                                        {
                                            "id": null,
                                            "wip_stage_id": 7611,
                                            "process_id": 10336,
                                            "sub_process_id": 10338,
                                            "wip_ipqc_spec": [
                                                {
                                                    "id": null,
                                                    "test_id": 10297,
                                                    "reference": "wip_ipqc_spec ref",
                                                    "test_type": null,
                                                    "specification": "wip_ipqc_spec spec",
                                                    "version_no": "v1",
                                                    "test_serial_no":1,
                                                    "sub_test":[
                                                                {
                                                                    "id": null,
                                                                    "parent_id": null,
                                                                    "sub_test_id": 10298,
                                                                    "sub_reference": "raw-ref",
                                                                    "sub_specification": "raw_qc_spec spec",
                                                                    "sub_test_serial_no":2,
                                                                    "sub_attb_data": [ 
                                                                                    {
                                                                                    "id" : null,
                                                                                    "sub_atab_id": 24,
                                                                                    "sub_data_value": "3"
                                                                                    }
                                                                                 ]
                                                                },
                                                                {
                                                                    "id": null,
                                                                    "parent_id": null,
                                                                    "sub_test_id": 10299,
                                                                    "sub_reference": "raw-ref",
                                                                    "sub_specification": "raw_qc_spec spec",
                                                                    "sub_test_serial_no":3,
                                                                    "sub_attb_data": [
                                                                                    {
                                                                                    "id" : null,
                                                                                    "sub_atab_id": 25,
                                                                                    "sub_data_value": "2.45"
                                                                                    }
                                                                                 ]
                                                                }
                                                               ],
                                                    "ipqc_attb_data": []
                                                }
                                            ]
                                        }
                                    ]
                                }';             
BEGIN
    JERP_PP_UTIL.PD_QC_PARAMETER_SETUP(pQC_PARAM_ID    =>vMst,
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

-----------UPDATE
/*

DECLARE
    vSTATUS CLOB;
    vMst number:=10185; 
    vQC_PARAM CLOB := '{ "basic_info":
                                  {
                                     "prod_id":2,
                                     "primary_info":{
                                                        "spec_ref_no" : "a2",
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
                                                        "pack_size" : "s2",
                                                        "packing_mode" : "SS",
                                                        "storage_condition" : "SS",
                                                        "container" : "SS",
                                                        "doc_com_supp" : "SS",
                                                        "doc_new_source" : "SS"
                                                    },
                                    "revesion_info":{
                                                        "version_no" : "v2",
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
         vRAW_QC_SPEC     CLOB := NULL;/*'{"raw_qc_spec": [
                                            {
                                                "id": 10408,
                                                "test_id": 10294,
                                                "reference": "raw-ref U",
                                                "test_type": null,
                                                "specification": "raw_qc_spec spec UP",
                                                "version_no": "v1",
                                                "test_serial_no":1,
                                                "sub_test": [
                                                            {
                                                                "id": 10409,
                                                                "parent_id": null,
                                                                "sub_test_id": 10295,
                                                                "sub_reference": "raw-ref U",
                                                                "sub_specification": "raw_qc_spec spec U",
                                                                "sub_test_serial_no":2
                                                            },
                                                            {
                                                                "id": 10410,
                                                                "parent_id": null,
                                                                "sub_test_id": 10296,
                                                                "sub_reference": "raw-ref U",
                                                                "sub_specification": "raw_qc_spec spec U",
                                                                "sub_test_serial_no":3
                                                            }
                                                ],
                                                "attb_data": [
                                                            {
                                                            "id" : null,
                                                            "atab_id": 22,
                                                            "data_value": "26.6"
                                                        }
                                                ]
                                            }
                                            ]
                                        }'; */
         vWIP_QC_SPEC     CLOB := '{"wip_qc_process": [
                                        {
                                            "id": 10206,
                                            "wip_stage_id": 7611,
                                            "process_id": 10384,
                                            "sub_process_id": 10385,
                                            "wip_qc_spec": [
                                                {
                                                    "id": 10444,
                                                    "test_id": 10294,
                                                    "reference": "wip_qc_process u",
                                                    "test_type": null,
                                                    "specification": "wip_qc_process spec",
                                                    "version_no": "v1",
                                                    "test_serial_no":1,
                                                    "sub_test":[
                                                                {
                                                                    "id": 10445,
                                                                    "parent_id": null,
                                                                    "sub_test_id": 10295,
                                                                    "sub_reference": "raw-ref u",
                                                                    "sub_specification": "raw_qc_spec spec u",
                                                                    "sub_test_serial_no":2,
                                                                    "sub_attb_data": [
                                                                                    {
                                                                                    "id" : 1629,
                                                                                    "sub_atab_id": 22,
                                                                                    "sub_data_value": "1.3"
                                                                                    }
                                                                                 ]
                                                                },
                                                                {
                                                                    "id": 10446,
                                                                    "parent_id": null,
                                                                    "sub_test_id": 10296,
                                                                    "sub_reference": "raw-ref u",
                                                                    "sub_specification": "raw_qc_spec spec u",
                                                                    "sub_test_serial_no":3,
                                                                    "sub_attb_data": [
                                                                                    {
                                                                                    "id" : 1630,
                                                                                    "sub_atab_id": 23,
                                                                                    "sub_data_value": "2.2"
                                                                                    }
                                                                                 ]
                                                                }
                                                               ],
                                                    "attb_data": []
                                                }
                                            ]
                                        }
                                    ]
                                }'; 
        vWIP_IPQC_SPEC     CLOB := '{"ipqc_process": [
                                        {
                                            "id": 10207,
                                            "wip_stage_id": 7611,
                                            "process_id": 10336,
                                            "sub_process_id": 10338,
                                            "wip_ipqc_spec": [
                                                {
                                                    "id": 10447,
                                                    "test_id": 10297,
                                                    "reference": "wip_ipqc_spec ref u",
                                                    "test_type": null,
                                                    "specification": "wip_ipqc_spec spec u",
                                                    "version_no": "v1",
                                                    "test_serial_no":1,
                                                    "sub_test":[
                                                                {
                                                                    "id": 10448,
                                                                    "parent_id": null,
                                                                    "sub_test_id": 10298,
                                                                    "sub_reference": "raw-ref",
                                                                    "sub_specification": "raw_qc_spec spec",
                                                                    "sub_test_serial_no":2,
                                                                    "sub_attb_data": [ 
                                                                                    {
                                                                                    "id" : 1631,
                                                                                    "sub_atab_id": 24,
                                                                                    "sub_data_value": "3.3"
                                                                                    }
                                                                                 ]
                                                                },
                                                                {
                                                                    "id": 10449,
                                                                    "parent_id": null,
                                                                    "sub_test_id": 10299,
                                                                    "sub_reference": "raw-ref u",
                                                                    "sub_specification": "raw_qc_spec spec u",
                                                                    "sub_test_serial_no":3,
                                                                    "sub_attb_data": [
                                                                                    {
                                                                                    "id" : 1632,
                                                                                    "sub_atab_id": 25,
                                                                                    "sub_data_value": "3.45"
                                                                                    }
                                                                                 ]
                                                                }
                                                               ],
                                                    "ipqc_attb_data": []
                                                }
                                            ]
                                        }
                                    ]
                                }';             
BEGIN
    PD_QC_PARAMETER_SETUP(pQC_PARAM_ID    =>vMst,
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