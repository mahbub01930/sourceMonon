
API TYPE : POST
API NAME : api/pp/create-trnsfr-note-grn


JERP_ADM.PD_CREATE_TRNSFR_NOTE_GRN (pTRNS_NOTE_ID NUMBER,pUSER_ID NUMBER)


A. pTRNS_NOTE_ID (Number)  
pTRNS_NOTE_ID number not null

B. pUSER_ID (Number)
pUSER_ID number not null auth.user_id


C. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.

------------CALLING TRANSFER NOTE GRN----------

DECLARE
    vSTATUS NUMBER;

    
BEGIN
    JERP_ADM.JERP_PP_UTIL.PD_CREATE_TRNSFR_NOTE_GRN  (pTRNS_NOTE_ID       => 10088,
              pUSER_ID        =>1,
              pSTATUS         => vSTATUS
              );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;


----batch reconciliation grn--

API TYPE : POST
API NAME : api/pp/create-batch-recon-grn


JERP_ADM.JERP_PP_UTIL.PD_CREATE_BATCH_RECON_GRN (pBATCH_RECON_ID NUMBER,pUSER_ID NUMBER,pSTATUS OUT NUMBER)


A. pBATCH_RECON_ID (Number)  
pBATCH_RECON_ID number not null

B. pUSER_ID (Number)
pUSER_ID number not null auth.user_id


C. pSTATUS (Out CLOB)
pSTATUS CLOB data return DB status against input data.


------------CALLING BATCH RECONCILIATION GRN----------

DECLARE
    vSTATUS NUMBER;

    
BEGIN
    JERP_ADM.JERP_PP_UTIL.PD_CREATE_BATCH_RECON_GRN  (pBATCH_RECON_ID       => 10069,
              pUSER_ID        =>1,
              pSTATUS         => vSTATUS
              );
DBMS_OUTPUT.PUT_LINE(vSTATUS);
END;
