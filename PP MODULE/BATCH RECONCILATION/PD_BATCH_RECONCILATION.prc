CREATE OR REPLACE PROCEDURE JERP_ADM.PD_BATCH_RECONCILATION (pRECON_MST       IN CLOB,
                                                             pRECON_DTL       IN CLOB,
                                                             pRECON_ID        IN OUT NUMBER,
                                                             pUSER_ID         IN NUMBER,
                                                             pIS_SUBMITTED    IN NUMBER, --0 not submitted, 1 submitted
                                                             pAS_FLAG         IN NUMBER  DEFAULT 0, --0 before submitted, 1 after submitted
                                                             pSBU_ID          IN NUMBER,
                                                             pSTATUS          OUT CLOB
                                                            ) IS

vINPUT_OBJ      JSON_OBJECT_T := NEW JSON_OBJECT_T;
vINPUT_ARR      JSON_ARRAY_T;
vOUTPUT_OBJ     JSON_OBJECT_T := NEW JSON_OBJECT_T;

vMESSAGE        VARCHAR2(4000);
vDISPLAY_CODE   VARCHAR2(30);
vSORT_ORDER     NUMBER;
 
BEGIN

    IF NVL(pRECON_ID,0) = 0 THEN
    
        vINPUT_OBJ := JSON_OBJECT_T.PARSE(pRECON_MST);
        vINPUT_ARR := vINPUT_OBJ.GET_ARRAY('recon_mst');
        
        FOR I IN 0..vINPUT_ARR.GET_SIZE-1 LOOP
        
            DECLARE

                vRECONMST_OBJ        JSON_OBJECT_T;
                
                vBATCH_ID         NUMBER;
                vPROD_ID          NUMBER;

                
            BEGIN
                
                vBATCH_ID        := vRECONMST_OBJ.GET_NUMBER('batch_id');
                vPROD_ID         := vRECONMST_OBJ.GET_NUMBER('prod_id');
                
                pRECON_ID        := SEQ_PP_BATCH_RECON_MST.NEXTVAL;
                vDISPLAY_CODE    :=JERP_UTIL.FD_DOC_NUMBER(pDOC_CODE => 'BR', pSBU_ID =>pSBU_ID);
                vSORT_ORDER      :=JERP_ADM.DFN_FOR_SORT_ORDER_SERIAL ('PP_BATCH_RECON_MST');

                INSERT INTO PP_BATCH_RECON_MST (ID,DISPLAY_CODE,RECONCILATION_DATE,BATCH_ID,PROD_ID,
                                                TRAN_STATUS,SORT_ORDER,CREATED_BY,CREATED_AT)
                                        VALUES (pRECON_ID, vDISPLAY_CODE, TRUNC(SYSDATE), vBATCH_ID,vPROD_ID,
                                                7511, vSORT_ORDER,pUSER_ID, SYSDATE);
                
                
                /* DETAILS DATA SAVE*/
                
                vINPUT_OBJ := JSON_OBJECT_T.PARSE(pRECON_DTL);
                vINPUT_ARR := vINPUT_OBJ.GET_ARRAY('recon_dtl');
        
                FOR I IN 0..vINPUT_ARR.GET_SIZE-1 LOOP
                    
                    DECLARE
                        
                        vRECONDTL_OBJ         JSON_OBJECT_T;
                        
                        vID         NUMBER;
                        vISSUE_ID         NUMBER;
                        vPROD_ID         NUMBER;
                        vGRN_ID         NUMBER;
                        vREQ_QTY         NUMBER;
                        vISSUE_QTY         NUMBER;
                        vDAMAGE_QTY         NUMBER;
                        vWASTAGE_QTY         NUMBER;
                        vREJECT_QTY         NUMBER;
                        vEXT_REJECTION_QTY         NUMBER;
                        vRETURN_QTY         NUMBER;
                        vUSED_QTY         NUMBER;
                        vSTORE_RECEIVE_QTY         NUMBER;
                        vSTORE_RECEIVE_ID         NUMBER;
                        
                    BEGIN
                        
                       /* vISSDTL_OBJ     := JSON_OBJECT_T (vINPUT_ARR.GET(I));
                        vDTL_ID         := vISSDTL_OBJ.GET_NUMBER('id');
                        vPROD_ID        := vISSDTL_OBJ.GET_NUMBER('prod_id');
                        vUOM            := vISSDTL_OBJ.GET_NUMBER('uom');
                        vISS_QTY        := vISSDTL_OBJ.GET_NUMBER('iss_qty');
                        
                        OPEN C_PROD (vPROD_ID); FETCH C_PROD INTO R_C_PROD; CLOSE C_PROD;
                        vCURRENT_STOCK  := JERP_INVENTORY_UTIL.AVAILABLE_QUANTITY (JERP_INVENTORY_UTIL.GET_STORE (vISS_FROM_WH, 'OUT'), vPROD_ID);
                        vSAFTY_STOCK    := JERP_MM_UTIL.GET_SAFTY_STOCK (vPROD_ID, vSBU_ID, vISS_FROM_WH);
                        
                        INSERT INTO MM_INT_ISS_DTL (ISS_ID, PROD_ID, UOM, ORIGINAL_ISS_QTY, 
                                                    ISS_QTY, APPROVE_QTY, COG, TP, 
                                                    VAT, CURRENT_STOCK, SAFTY_STOCK, BATCH_LOT_NUMBER, 
                                                    CREATED_BY, CREATED_AT)
                        VALUES (pISS_ID, vPROD_ID, vUOM, vISS_QTY, 
                                vISS_QTY, vISS_QTY, R_C_PROD.BASE_COG, R_C_PROD.BASE_TP, 
                                R_C_PROD.BASE_VAT, vCURRENT_STOCK, vSAFTY_STOCK, vBATCH_LOT_NUMBER,
                                pUSER_ID, SYSDATE); */
                                NULL;
                                
                    EXCEPTION WHEN OTHERS THEN
                        vOUTPUT_OBJ.PUT('response_code',400);
                        vMESSAGE := 'Error Code : '|| SQLCODE || ' Error Text : ' || SQLERRM;
                        vOUTPUT_OBJ.PUT('message', vMESSAGE);
                        pSTATUS := vOUTPUT_OBJ.TO_CLOB;
                        ROLLBACK;
                        RETURN;
                    END;
                    
                END LOOP;

            EXCEPTION WHEN OTHERS THEN
                vOUTPUT_OBJ.PUT('response_code',400);
                vMESSAGE := 'Error Code : '|| SQLCODE || ' Error Text0 : ' || SQLERRM;
                vOUTPUT_OBJ.PUT('message', vMESSAGE);
                pSTATUS := vOUTPUT_OBJ.TO_CLOB;
                ROLLBACK;
                RETURN;
            END;
            
        END LOOP;
    
    ELSE --ALREDY EXISTING
    
        NULL;
    
    END IF;

EXCEPTION
    WHEN OTHERS THEN
    
    vOUTPUT_OBJ.PUT('response_code',400);
    vMESSAGE := 'Error Code : '|| SQLCODE || ' Error Text : ' || SQLERRM;
    vOUTPUT_OBJ.PUT('message', vMESSAGE);
    pSTATUS := vOUTPUT_OBJ.TO_CLOB;
    ROLLBACK;
    RETURN;
    
END;                                                           