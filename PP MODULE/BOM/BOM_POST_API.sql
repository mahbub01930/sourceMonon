
DB Procedure : 
8. CREATE-UPDATE, DRAFT, SUBMIT - BOM & Sub-BOM
API NAME : http://203.188.245.58:8889/api/pp/create-update-pp-bom
API TYPE : GET

 Procedure call for - BOM, Sub-BOM Create, Update, Draft & Submit

JERP_PP_UTIL.PP_BOM

(   
    pBOM_MST          IN CLOB, 
    pBOM_BMR          IN CLOB, 
    pBOM_BPR          IN CLOB,
    pBOM_SUB          IN CLOB, 
    pBMR_MST          IN CLOB,
    pUSER_ID          IN NUMBER, 
    pIS_SUBMITTED     IN NUMBER, 
    pBOM_ID           IN OUT NUMBER, 
    pSTATUS           OUT CLOB) 

Parameters :

A. pBOM_MST (JSON Array)

Header = pp_bom_mst

Object

bom_type              number not null,
sbu_id               number not null,
blk_prod_id            number not null,
sfg_prod_id            number,
mat_prod_id            number,
batch_size            number,
batch_uom            number,
batch_weight            number,
batch_weight_uom            number,
theo_batch_output            number,
theo_batch_uom            number,
std_batch_output            number,
std_batch_uom            number,
api_filler_prod_id            number,
api_filler_weight            number,
api_filler_uom            number,

unit_volume               number,
volume_uom               number,
unit_weight               number,
weight_uom               number,

apply_from_date         varchar2 format dd-mm-yyyy not null,
is_active             varchar2,
is_std_bom             varchar2,
tran_status             varchar2


B. pBOM_BMR (JSON Array)

Header = bom_bmr

Object

id                        number,
mat_prod_id               number not null,
batch_qty                 number not null,
uom                       number not null,
is_mandatory              varchar2 ,
is_must_for_qualify       varchar2 ,
is_sub_bom                varchar2 ,
fg_prod_id                 number,
std_potency               number,
overage_percent            number,


C. pBOM_BPR (JSON Array)

Header = bom_bpr

Object

id                          number,
mat_prod_id                 number not null,
batch_qty                   number not null,
uom                         number not null,
is_mandatory                varchar2,
is_must_for_qualify         varchar2,
is_sub_bom                  varchar2
fg_prod_id                 number,
std_potency               number,
overage_percent            number,

D. pBOM_SUB (JSON Array)

Header = bom_sub

Object

id                          number,
bom_id                 number not null,
bom_dtl_id                   number not null


E. pBMR_MST (JSON Array)

Header = bmr_mst

Object

id                          number,
effective_date         varchar2,
core_weight            number,
core_uom               number,
coated_weight          number,
coated_uom             number,
change_history         varchar2,
revision_no            varchar2,
fill_weight            number,
fill_weight_uom        number,
fill_volume            number,
fill_vol_uom           number,
description            varchar2,
other_info             varchar2,
label_claim            varchar2,
size_shape             varchar2

F .pUSER_ID (Number)

pUSER_ID number not null auth.user_id

G. pIS_SUBMITTED (Number)

pIS_SUBMITTED number not null (0 for draft, 1 for submit)I

H. pBOM_ID (Number)

pBOM_ID number (in-out parameter)

I. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.

---------------------CALL-------------

DECLARE 
    vSTATUS     CLOB;
    vMst number:=0; 
    --vSBU_ID number:=2; 
    vBOM_MST CLOB :=  
                    '{
                       "pp_bom_mst":[
                          {
                             "bom_type":502,
                             "sbu_id":2,
                             "blk_prod_id":5044,
                             "sfg_prod_id":4044,
                             "mat_prod_id":179,
                             "batch_size":500000,
                             "batch_uom":532,
                             "apply_from_date":"28-NOV-2022",
                             "batch_weight":30,
                             "batch_weight_uom":530,
                             "std_batch_output":500000,
                             "std_batch_uom":532,
                             "api_filler_prod_id":1002,
                             "api_filler_weight":10,
                             "api_filler_uom":532,
                             "is_active":"Y",
                             "is_std_bom":"Y",
                             "unit_volume":10,
                             "volume_uom":532,
                             "unit_weight":12,
                             "weight_uom":534
                          }
                       ]
                    }';

vBOM_BMR CLOB := 
                '{
                   "bom_bmr":[
                      {
                         "id":null,
                         "mat_prod_id":1006,
                         "batch_qty":12.34,
                         "uom":532,
                         "is_mandatory":"Y",
                         "is_must_for_qualify":"Y",
                         "is_sub_bom":"N",
                         "fg_prod_id": null,
                         "std_potency": 100,
                         "overage_percent": 2
                      }
                   ]
                }';

vBOM_BPR CLOB :=
                '{
                   "bom_bpr":[
                      {
                         "id":null,
                         "mat_prod_id":1010,
                         "batch_qty":4356,
                         "uom":532,
                         "is_mandatory":"Y",
                         "is_must_for_qualify":"N",
                         "is_sub_bom":"N",
                         "fg_prod_id": "",
                         "std_potency": 100,
                         "overage_percent": 2
                      }
                   ]
                }';

vBOM_SUB CLOB :=
                '{
                   "bom_sub":[
                      {
                         "id":null,
                         "bom_id":1230,
                         "bom_dtl_id":1010
                      }
                   ]
                }';

vBBMR_MST CLOB :=  '{
                           "bmr_mst":[
                              {
                                 "id" : null,
                                 "effective_date":"20-NOV-2022",
                                 "core_weight":2,
                                 "core_uom":532,
                                 "coated_weight":3,
                                 "coated_uom":532,
                                 "change_history":"hist",
                                 "revision_no":"rev no",
                                 "fill_weight":4,
                                 "fill_weight_uom":532,
                                 "fill_volume":5,
                                 "fill_vol_uom":532,
                                 "description":"desc",
                                 "other_info":"oi",
                                 "label_claim":"lc",
                                 "size_shape":"ss"
                              }
                           ]
                        }';
BEGIN
      JERP_PP_UTIL.PP_BOM    (pBOM_MST => vBOM_MST, 
               pBOM_BMR => vBOM_BMR,
               pBOM_BPR => vBOM_BPR,
               pBOM_SUB => vBOM_SUB,
               pBMR_MST => vBBMR_MST,
               pUSER_ID => 9,
               pIS_SUBMITTED =>0,
               pAS_FLAG =>0,  
               pBOM_ID =>vMst,
               pSTATUS=>vSTATUS);
               
    dbms_output.put_line('vSTATUS > '||vSTATUS);
exception when others then
    dbms_output.put_line(sqlerrm);    
END;