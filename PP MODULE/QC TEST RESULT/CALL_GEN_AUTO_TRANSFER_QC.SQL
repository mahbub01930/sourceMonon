DECLARE
pQCTM_ID       NUMBER := 10117;
vPASSED_QTY         NUMBER :=199.8;
pUSER_ID            NUMBER := 1;
vTRANSFER_ID             NUMBER;
vSTATUS             NUMBER;
BEGIN
JERP_PP_UTIL.GEN_AUTO_TRANSFER_QC (pTSET_ID      => pQCTM_ID,
                                                        pQTY          => vPASSED_QTY,
                                                        pUSER_ID      => pUSER_ID,
                                                        pTRANSFER_ID  => vTRANSFER_ID,
                                                        pSTATUS       => vSTATUS
                                                        );
       DBMS_OUTPUT.PUT_LINE('Output : '||vSTATUS);
EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM); 
END;