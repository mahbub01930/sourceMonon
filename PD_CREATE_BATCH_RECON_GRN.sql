CREATE OR REPLACE PROCEDURE JERP_ADM.PD_CREATE_BATCH_RECON_GRN(pBATCH_RECON_ID NUMBER,pUSER_ID NUMBER,pSTATUS OUT NUMBER) IS

    vGRN_ID         NUMBER;
    vGRN_NO         VARCHAR(20);
    vSBU_ID         NUMBER;
    vDISPLAY_CODE   VARCHAR2(20);
    vBATCH_NO       VARCHAR2(20);
    vDEPOT_ID       NUMBER;
    vDEPOT_CODE     VARCHAR2(30);
    vOFFICE_ID      NUMBER;
    vSTORE_TYPE     VARCHAR2(20):='IN';
    vMFG_DATE       DATE;
    vEXP_DATE       DATE;
    vRET_QNTY       NUMBER;
    vER_RET_QNTY    NUMBER;
    vISSUE_ID       NUMBER;
    vPROD_ID        NUMBER;
    vPROD_TYPE      NUMBER;

    /*CURSOR C_GRN_SORC
    IS
    SELECT DISPLAY_VALUE 
    FROM ADM_CODE_ELEMENTS
    WHERE ID=5002;

    R_GRN_SORC C_GRN_SORC%ROWTYPE;*/


BEGIN
   
    SELECT NVL ((SELECT ID
                   FROM ADM_GRN
                  WHERE REF_NO IN (SELECT DISPLAY_CODE
                                     FROM PP_BATCH_RECON_MST
                                    WHERE ID = pBATCH_RECON_ID)),
                0)
      INTO vGRN_ID
      FROM DUAL;
      
    SELECT PB.SBU_ID,DISPLAY_CODE,PB.BATCH_NO,PB.MFG_DATE,PB.EXP_DATE
      INTO vSBU_ID,vDISPLAY_CODE,vBATCH_NO,vMFG_DATE,vEXP_DATE
      FROM PP_BATCH_RECON_MST BRM,PP_PRODUCT_BATCH PB
     WHERE BRM.BATCH_ID=PB.ID
       AND BRM.ID=pBATCH_RECON_ID;
    
    /* FIND WARE-HOUSE ID FROM ISSUE MASTERE TABLE (ISS_FROM_WH) and prod_id for prod_type */
    
    SELECT ISSUE_ID,PROD_ID
      INTO vISSUE_ID,vPROD_ID
      FROM PP_BATCH_RECON_DTL
     WHERE RECONCILATION_ID IN (SELECT ID 
                                  FROM PP_BATCH_RECON_MST
                                 WHERE ID = :pBATCH_RECON_ID)
    FETCH FIRST ROW ONLY;
    
    SELECT ISS_FROM_WH
      INTO vDEPOT_ID
      FROM MM_INT_ISS_MST
     WHERE ID = vISSUE_ID;
     
    SELECT PROD_TYPE 
      INTO vPROD_TYPE
      FROM ADM_PRODUCTS
     WHERE ID = vPROD_ID; 
    
    SELECT WH_CODE, PLANT_ID 
      INTO vDEPOT_CODE, vOFFICE_ID
      FROM ADM_WAREHOUSE
     WHERE ID = vDEPOT_ID;
    
    /*vSTORE_TYPE := CASE WHEN SUBSTR(vDISPLAY_CODE,1,2) = 'TN' THEN 'IN' 
                        WHEN SUBSTR(vDISPLAY_CODE,1,2) = 'BR' THEN 'OUT' END; */
                    
    /* Return and Extarnerl Rejection Quentity Check */
    
    SELECT SUM (DECODE (NVL (RETURN_QTY,0),0,0,1)),
       SUM (DECODE (NVL (EXT_REJECTION_QTY,0),0,0,1))
      INTO vRET_QNTY,vER_RET_QNTY
      FROM PP_BATCH_RECON_DTL
     WHERE RECONCILATION_ID IN (SELECT ID
                            FROM PP_BATCH_RECON_MST
                            WHERE ID =pBATCH_RECON_ID);
       
        IF vRET_QNTY>0 THEN
        
            IF vGRN_ID = 0 THEN --INSERT
        
            BEGIN
            
                vGRN_ID  := SEQ_ADM_GRN.NEXTVAL;
                vGRN_NO  := 'GRN/'||vDEPOT_CODE||'/'||TO_CHAR(vGRN_ID);
                
                --OPEN C_GRN_SORC; FETCH C_GRN_SORC INTO R_GRN_SORC; CLOSE C_GRN_SORC;
                
                INSERT INTO ADM_GRN (ID,SBU_ID,OFFICE_ID,GATE_ENTRY_NO,GATE_ENTRY_BY,ENTRY_DESCRIPTION,ENTRY_REF_DOCUMENT,GRN_NO,
                                     GRN_DATE,GRN_VALUE,DESCRIPTION,GRN_SOURCE,REF_NO,PROD_TYPE,WAREHOUSE_ID,QC_REQUIRED,QC_PASS_STATUS,CREATED_BY)
                             VALUES (vGRN_ID, vSBU_ID, vOFFICE_ID, NULL, NULL, 'N/A', NULL,vGRN_NO, 
                                     SYSDATE, NULL, NULL,'PRODUCTION_RETURN',vDISPLAY_CODE, vPROD_TYPE, vDEPOT_ID, 'Y',1,pUSER_ID);
            
            EXCEPTION 
                WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
                pSTATUS := 400;
                ROLLBACK;
                RETURN;
            
            END;
        
        ELSE ---- DELETING EXISTING GRN DETAIL
        
            DELETE FROM ADM_GRN_DETAIL WHERE GRN_ID = vGRN_ID;
        
        END IF;
        
        -- ADDING GRN DETAIL DATA AND ADD STORE  
        DECLARE
        
            CURSOR C_BR_DTL IS
            SELECT BRD.PROD_ID,RETURN_QTY,BATCH_ID,BRM.ID RECONCILATION_ID
              FROM PP_BATCH_RECON_DTL BRD,PP_BATCH_RECON_MST BRM
             WHERE BRD.RECONCILATION_ID=BRM.ID
               AND BRD.RECONCILATION_ID=:pTRNS_NOTE_ID
            GROUP BY BRD.PROD_ID,RETURN_QTY,BATCH_ID,BRM.ID;

            vWHSSB_ID   NUMBER(10);
            vWHSS_ID    NUMBER(10);
            vSTORE_ID   NUMBER(10);
            lTEMP       NUMBER(10);
            
        BEGIN
        
            FOR B IN C_BR_DTL LOOP

                vSTORE_ID := (JERP_INVENTORY_UTIL.GET_STORE(vDEPOT_ID,vSTORE_TYPE));

                SELECT COUNT(*) 
                  INTO lTEMP
                  FROM SD_WH_STORE_STOCK
                 WHERE STORE_ID = vSTORE_ID AND PROD_ID = B.PROD_ID;

                IF(lTEMP > 0) THEN

                    SELECT ID INTO vWHSS_ID
                      FROM SD_WH_STORE_STOCK
                     WHERE STORE_ID = vSTORE_ID AND PROD_ID = B.PROD_ID;

                ELSE
                    vWHSS_ID := SEQ_SD_WH_STORE_STOCK.NEXTVAL;

                    INSERT INTO SD_WH_STORE_STOCK (ID, STORE_ID, PROD_ID, CURRENT_STOCK, CREATED_BY)
                                           VALUES (vWHSS_ID, vSTORE_ID, B.PROD_ID, 0, pUSER_ID);

                END IF;

                SELECT COUNT(*) INTO lTEMP
                  FROM SD_WHSS_BATCH_LOT
                 WHERE WHSS_ID = vWHSS_ID AND BATCH_LOT_NO = vBATCH_NO;

                IF(lTEMP > 0) THEN
                    SELECT ID 
                      INTO vWHSSB_ID
                      FROM SD_WHSS_BATCH_LOT
                     WHERE WHSS_ID = vWHSS_ID AND BATCH_LOT_NO = vBATCH_NO;
                ELSE
                    vWHSSB_ID := SEQ_SD_WHSS_BATCH_LOT.NEXTVAL;

                    INSERT INTO SD_WHSS_BATCH_LOT (ID, WHSS_ID, IS_BATCH, BATCH_ID, BATCH_LOT_NO, MFG_DATE, EXP_DATE, CURRENT_STOCK, CREATED_BY)
                                           VALUES (vWHSSB_ID, vWHSS_ID, 'Y', B.BATCH_ID, vBATCH_NO, vMFG_DATE, vEXP_DATE, 0, pUSER_ID);
                END IF;

                INSERT INTO ADM_GRN_DETAIL (GRN_ID, PROD_ID, BATCH_LOT_NO, WHSSB_ID, GRN_QTY, RCV_QTY, PROD_UOM, CREATED_BY)
                                    VALUES (vGRN_ID, B.PROD_ID, vBATCH_NO, vWHSSB_ID, B.RETURN_QTY, B.RETURN_QTY, NULL, pUSER_ID);
                
                /*INSERT INTO PP_PRODUCT_BATCH_DETAIL (ID,BATCH_ID,TRANSFER_ID,TRANSFER_FG_QTY,CREATED_BY,CREATED_AT,PROD_ID)
                                             VALUES  (SEQ_PP_PRODUCT_BATCH_DETAIL.NEXTVAL,B.BATCH_ID,B.TRANSFER_ID,B.TOTAL_TRANSFER_QTY,pUSER_ID,SYSDATE,B.PROD_ID);*/

            END LOOP;
            
            
        EXCEPTION
            WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            pSTATUS := 400;
            ROLLBACK;
        END;
    
    ELSIF vER_RET_QNTY>0 THEN 
        
        /*Extarnerl Rejection Block */
        NULL;
    
    END IF;                      
    
    pSTATUS := 200;
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    pSTATUS := 400;
    ROLLBACK;

END;
/
