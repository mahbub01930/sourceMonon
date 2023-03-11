--- CREATE-UPDATE, DRAFT, SUBMIT - PD QC PARAMETER SETUP 
URL = api/pp/crud-qc-param-setup
Method = Post

JERP_PP_UTIL.PD_QC_PARAMETER_SETUP Creation PROCEDURE

JERP_PP_UTIL.PD_QC_PARAMETER_SETUP (pQC_PARAM_ID        IN  OUT NUMBER,
                                    pQC_PARAM           IN  CLOB,
                                    pLABEL_INFO         IN  CLOB,
                                    pRAW_QC_SPEC        IN  CLOB,
                                    pWIP_QC_SPEC        IN  CLOB,
                                    pWIP_IPQC_SPEC      IN  CLOB,
                                    pSBU_ID             IN  NUMBER,
                                    pUSER_ID            IN  NUMBER,
                                    pIS_SUBMITTED       IN NUMBER, --0 not submitted, 1 submitted
                                    pAS_FLAG            IN NUMBER DEFAULT 0,
                                    pSTATUS             OUT CLOB
                                   )

Parameters :

A. pQC_PARAM_ID          IN OUT NUMBER,
CREATE/INSERT MODE : pQC_PARAM_ID  WILL BE NULL
UPDATE MODE :  pQC_PARAM_ID WILL COME FROM FRONT-END

B. pLABEL_INFO (JSON Array)

C.pQC_PARAM (JSON Array)

Header = basic_info

OBJECT

prod_id          NUMBER; 

Header = primary_info

OBJECT

spec_ref_no         VARCHAR2;
effective_date      VARCHAR2; ('dd-mm-rrrr')
supersedes          VARCHAR2;
method_ref_no       VARCHAR2;
cas_no              VARCHAR2;
synonyms            VARCHAR2;
molecular_formula   VARCHAR2;
molecular_weight    VARCHAR2;
description         VARCHAR2;
safety_pre_caution  VARCHAR2;
shelf_life          VARCHAR2;
dar_no              VARCHAR2;
shape_size          VARCHAR2;
reference_no        VARCHAR2;
color_smell         VARCHAR2;

Header = packaging_info

OBJECT

pack_size           VARCHAR2;
packing_mode        VARCHAR2;
storage_condition   VARCHAR2;
container           VARCHAR2;
doc_com_supp        VARCHAR2;
doc_new_source      VARCHAR2;

Header = revesion_info

OBJECT

version_no         VARCHAR2;
review_date        VARCHAR2;  ('dd-mm-rrrr')
issue_date         VARCHAR2;  ('dd-mm-rrrr')
cause_for_version  VARCHAR2;

D. pRAW_QC_SPEC (JSON Array)

Header = raw_qc_spec

OBJECT

id                     NUMBER;
test_id                NUMBER;
reference              VARCHAR2;
test_type              VARCHAR2;
specification          VARCHAR2;
version_no             VARCHAR2;
test_serial_no         NUMBER; 

'attb_data' (new object for 'raw_qc_spec')

OBJECT

id              NUMBER;
atab_id              NUMBER;  
data_value           VARCHAR2; 


E. pWIP_QC_SPEC (JSON Array)

Header = wip_qc_process

OBJECT

id                      NUMBER;
wip_stage_id            NUMBER; 
process_id              NUMBER;
sub_process_id          NUMBER; 

Header = wip_qc_spec

OBJECT

id                     NUMBER;
test_id                NUMBER;
reference              VARCHAR2;
test_type              VARCHAR2;
specification          VARCHAR2;
version_no             VARCHAR2;
test_serial_no         NUMBER;

Header = attb_data

'attb_data' (new object for 'ipqc_process')
id              NUMBER;
atab_id              NUMBER;  
data_value           VARCHAR2; 

F.pWIP_IPQC_SPEC (JSON Array)

Header = ipqc_process

OBJECT

id                      NUMBER;
wip_stage_id            NUMBER; 
process_id              NUMBER;
sub_process_id          NUMBER; 

Header = wip_ipqc_spec

OBJECT

id                     NUMBER;
test_id                NUMBER;
reference              VARCHAR2;
test_type              VARCHAR2;
specification          VARCHAR2;
version_no             VARCHAR2;
test_serial_no         NUMBER;

Header = attb_data

Header 'ipqc_attb_data' 

id              NUMBER;
atab_id              NUMBER;  
data_value           VARCHAR2; 

G.pSBU_ID (Number)

pSBU_ID number not null auth.user_id

H. pUSER_ID (Number)

pUSER_ID number not null auth.user_id

I. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.


-----------CALL

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
                                       pAS_FLAG     =>0,
                                       pSTATUS         => vSTATUS
                                    );
DBMS_OUTPUT.PUT_LINE(vSTATUS);

END;