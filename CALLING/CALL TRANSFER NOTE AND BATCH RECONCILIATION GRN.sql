------------TRANSFER NOTE GRN----------

DECLARE
    vSTATUS NUMBER;

    
BEGIN
    JERP_ADM.JERP_PP_UTIL.PD_CREATE_TRNSFR_NOTE_GRN  (pTRNS_NOTE_ID       => 10088,
              pUSER_ID        =>1,
              pSTATUS         => vSTATUS
              );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;


------------BATCH RECONCILIATION GRN----------

DECLARE
    vSTATUS NUMBER;

    
BEGIN
    JERP_ADM.JERP_PP_UTIL.PD_CREATE_BATCH_RECON_GRN  (pBATCH_RECON_ID       => 10069,
              pUSER_ID        =>1,
              pSTATUS         => vSTATUS
              );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;
