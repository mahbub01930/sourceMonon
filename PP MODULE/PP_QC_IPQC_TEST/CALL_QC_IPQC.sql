
DECLARE
    vSTATUS CLOB;
    vMst number:=null;
    vQC_IPQC_TEST CLOB := '{ "qc_ipqc_test":
                                  {
                                     "test_department":34,
                                     "test_name":"TEST@2 mst",
                                     "test_measure":7751,
                                     "test_type":7152,
                                     "uom":null,
                                     "description" : "Desc",
                                     "machine_id" : "1031,1051",
                                     "qc_ipqc_sub_test" : [
                                                        {
                                                         "sub_test_id" : null,
                                                         "parent_id" : 10751,
                                                         "sub_test_name":"Sub Test-1",
                                                         "sub_test_measure":7752,
                                                         "sub_uom" : 534,
                                                         "prod_id" : "7280,7281"
                                                        },
                                                        {
                                                          "sub_test_id" : null,
                                                          "parent_id" : 10751,
                                                          "sub_test_name":"Sub Test-2",
                                                          "sub_test_measure":7752,
                                                          "sub_uom" : 534,
                                                          "prod_id" : "7282,7283"
                                                        }
                                                    ]
                                  }
                                }';

BEGIN
  PP_QC_IPQC_TEST_DATA(pQC_IPQC_TEST         =>vQC_IPQC_TEST,
                          pQC_IPQC_TEST_ID      =>vMst ,
                          pSBU_ID                =>2,
                          pUSER_ID               =>1,
                          pSTATUS              =>vSTATUS
                      );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;


--update--

DECLARE
    vSTATUS CLOB;
    vMst number:=10751;
    vQC_IPQC_TEST CLOB := '{ "qc_ipqc_test":
                                  {
                                     "test_department":34,
                                     "test_name":"TEST@2 mst",
                                     "test_measure":7751,
                                     "test_type":7152,
                                     "uom":null,
                                     "description" : "Desc",
                                     "machine_id" : "1031,1051",
                                     "qc_ipqc_sub_test" : [
                                                        {
                                                         "id" : null,
                                                         "parent_id" : 10751,
                                                         "sub_test_name":"Sub Test-1",
                                                         "sub_test_measure":7752,
                                                         "sub_uom" : 534,
                                                         "prod_id" : "7280,7281"
                                                        },
                                                        {
                                                          "id" : null,
                                                          "parent_id" : 10751,
                                                          "sub_test_name":"Sub Test-2",
                                                          "sub_test_measure":7752,
                                                          "sub_uom" : 534,
                                                          "prod_id" : "7282,7283"
                                                        }
                                                    ]
                                  }
                                }';

BEGIN
  PP_QC_IPQC_TEST_DATA(pQC_IPQC_TEST         =>vQC_IPQC_TEST,
                          pQC_IPQC_TEST_ID      =>vMst ,
                          pSBU_ID                =>2,
                          pUSER_ID               =>1,
                          pSTATUS              =>vSTATUS
                      );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;












-------------old--------INSERT----------------------

DECLARE
    vSTATUS CLOB;
    vMst number:=null;
    vQC_IPQC_TEST CLOB := '{ "qc_ipqc_test":
                                  {
                                     "test_department":34,
                                     "test_name":"Type of 3",
                                     "test_measure":7752,
                                     "test_type":7153,
                                     "uom":538,
                                     "description" : "ASDF",
                                     "machine_id" : "1,2,3",
                                     "qc_ipqc_sub_test" : [
                                        {
                                          "prod_id" : "1,2,3",
                                          "sub_test" : [
                                                        {
                                                         "id" : null,
                                                         "parent_id" : null,
                                                         "sub_test_name":"Sub Test-1",
                                                         "sub_test_measure":7752,
                                                         "sub_uom" : 532
                                                        },
                                                        {
                                                          "id" : null,
                                                          "parent_id" : null,
                                                          "sub_test_name":"Sub Test-2",
                                                          "sub_test_measure":7752,
                                                          "sub_uom" : 532
                                                        }
                                                    ]
                                        }
                                     ]
                                  }
                                }';

BEGIN
  PP_QC_IPQC_TEST_DATA(pQC_IPQC_TEST         =>vQC_IPQC_TEST,
                          pQC_IPQC_TEST_ID      =>vMst ,
                          pSBU_ID                =>2,
                          pUSER_ID               =>1,
                          pSTATUS              =>vSTATUS
                      );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;

---------------------UPDATE----------------------
DECLARE
    vSTATUS CLOB;
    vMst number:=10768;
    vQC_IPQC_TEST CLOB := '{ "qc_ipqc_test":
                                  {
                                     "test_department":34,
                                     "test_name":"Type of 3",
                                     "test_measure":7752,
                                     "test_type":7153,
                                     "uom":538,
                                     "description" : "aa",
                                     "machine_id" : "1,2,3",
                                     "qc_ipqc_sub_test" : [
                                        {
                                          "prod_id" : "1,2,3",
                                          "sub_test" : [
                                                        {
                                                         "id" : 10769,
                                                         "parent_id" : 10768,
                                                         "sub_test_name":"Sub Test-1 u",
                                                         "sub_test_measure":7752,
                                                         "sub_uom" : 532
                                                        },
                                                        {
                                                          "id" : 10770,
                                                          "parent_id" : 10768,
                                                          "sub_test_name":"Sub Test-2 u",
                                                          "sub_test_measure":7752,
                                                          "sub_uom" : 531
                                                        },
                                                        {
                                                          "id" : null,
                                                          "parent_id" : 10768,
                                                          "sub_test_name":"Sub Test-3",
                                                          "sub_test_measure":7752,
                                                          "sub_uom" : 531
                                                        }
                                                    ]
                                        }
                                     ]
                                  }
                                }';

BEGIN
  PP_QC_IPQC_TEST_DATA(pQC_IPQC_TEST         =>vQC_IPQC_TEST,
                          pQC_IPQC_TEST_ID      =>vMst ,
                          pSBU_ID                =>2,
                          pUSER_ID               =>1,
                          pSTATUS              =>vSTATUS
                      );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;