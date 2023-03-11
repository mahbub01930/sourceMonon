Feature Name : PP QC IPQC TEST 

Description : PP QC IPQC TEST data will be enter here

Design Link : 

From : WEB 

Users : 

Constraint:

User must be logged in

User info available

Check auth token for every request

Check SBU_ID

Tables/Data Source:

PP_QC_IPQC_TEST

--LEFT PANEL LIST (LANDING MODE)-1ST API

API TYPE : GET
API NAME : api/pp/get-qc-ipqc-test-list/{pSBU_ID} 

Response Fields :   PQIT.ID, PQIT.DISPLAY_CODE, PQIT.TEST_DEPARTMENT,ASD.DISPLAY_NAME AS DEPARTMENT_NAME 
	  
Operational Fields: PQIT.ID, PQIT.DISPLAY_CODE, PQIT.TEST_DEPARTMENT,ASD.DISPLAY_NAME AS DEPARTMENT_NAME 
         
PARAMETER  :        ASD.SBU_ID=:pSBU_ID

Table Name:   	    PP_QC_IPQC_TEST     = PQIT
                    ADM_SBU_DEPARTMENT  = ASD

			  
Relation : 	  	ASD.DEPARTMENT_ID = PQIT.TEST_DEPARTMENT

Filter by:  WHERE STATUS = 1 

QUERY : 

SELECT PQIT.ID, PQIT.DISPLAY_CODE, PQIT.TEST_DEPARTMENT,ASD.DISPLAY_NAME AS DEPARTMENT_NAME 
FROM PP_QC_IPQC_TEST PQIT
LEFT JOIN ADM_SBU_DEPARTMENT ASD ON ASD.DEPARTMENT_ID = PQIT.TEST_DEPARTMENT
WHERE ASD.SBU_ID=:pSBU_ID
AND PQIT.PARENT_ID IS NULL
AND PQIT.STATUS=1;


--LEFT PANEL LIST (LANDING MODE RIGHT SIDE)-2nd API

API TYPE : GET
API NAME : api/pp/get-qc-ipqc-test-data/{pSBU_ID}/{pQC_TEST_ID}

Response Fields :  TEST_ID ,DISPLAY_CODE,TEST_DEPARTMENT,DEPARTMENT_NAME,TEST_NAME,TEST_MEASURE,TEST_MEASURE_NAME    
                    TEST_TYPE, TEST_TYPE_NAME ,UOM ,UOM_NAME ,MACHINE_ID,MACHINE_NAME
                     
	  
Operational Fields: TEST_ID ,DISPLAY_CODE,TEST_DEPARTMENT,DEPARTMENT_NAME,TEST_NAME,TEST_MEASURE,TEST_MEASURE_NAME    
                    TEST_TYPE, TEST_TYPE_NAME ,UOM ,UOM_NAME ,MACHINE_ID,MACHINE_NAME        
                     
         
PARAMETER  :        

Table Name:   	    JERP_PP_UTIL.FD_GET_QC_IPQC_TEST_DATA (pSBU_ID NUMBER,pQC_TEST_ID NUMBER)

			  
Relation : 	  	
                
			  
Filter by:  

QUERY : 

SELECT JERP_PP_UTIL.FD_GET_QC_IPQC_TEST_DATA (:pQC_TEST_ID,:pSBU_ID)  FROM DUAL  --10079,2


--RIGHT PANEL  (LANDING MODE)(TEST DEPARTMENT LIST) 3rd API

API TYPE : GET
API NAME : api/pp/get-department-list/{pSBU_ID} 

Response Fields :   DEPARTMENT_NAME

Operational Fields: DEPARTMENT_ID, DISPLAY_NAME as DEPARTMENT_NAME
                    
PARAMETER  :        SBU_ID=:pSBU_ID

Table Name:   	    ADM_SBU_DEPARTMENT

			  
Relation : 	  	                
			  
Filter by:  WHERE STATUS = 1 AND DEPARTMENT_ID IN (4,5,33,34)

QUERY : 

SELECT DEPARTMENT_ID, DISPLAY_NAME  as DEPARTMENT_NAME
FROM ADM_SBU_DEPARTMENT
WHERE SBU_ID=:pSBU_ID
AND DEPARTMENT_ID IN (4,5,33,34)
ORDER BY 1;


--RIGHT PANEL  (LANDING MODE)(TEST MEASURE LIST) 3RD API

API TYPE : GET
API NAME : api/pp/get-test-measure-list

Response Fields :   ELEMENT_NAME

Operational Fields: ID,ELEMENT_NAME
                    
PARAMETER  :        

Table Name:   	    ADM_CODE_ELEMENTS

			  
Relation : 	  	                
			  
Filter by:  WHERE STATUS = 1 AND CODE_ID = 737

QUERY : 

SELECT ID,ELEMENT_NAME FROM ADM_CODE_ELEMENTS
WHERE CODE_ID= 737;


--RIGHT PANEL  (LANDING MODE)(TEST TYPE LIST) 4TH API

API TYPE : GET
API NAME : api/pp/get-test-type-list

Response Fields :   ELEMENT_NAME

Operational Fields: ID,ELEMENT_NAME
                    
PARAMETER  :        

Table Name:   	    ADM_CODE_ELEMENTS

			  
Relation : 	  	                
			  
Filter by:  WHERE STATUS = 1 AND CODE_ID = 706

QUERY : 

SELECT ID,ELEMENT_NAME FROM ADM_CODE_ELEMENTS
WHERE CODE_ID= 706;

--RIGHT PANEL  (LANDING MODE)(UOM LIST) 5TH API

--RIGHT PANEL  (LANDING MODE)(TEST DEPARTMENT LIST) 6TH API

API TYPE : GET
API NAME : api/pp/get-prod-list/{pSBU_ID} 

Response Fields :   PRODUCT_NAME

Operational Fields: PROD_ID, DISPLAY_NAME AS PRODUCT_NAME 
                    
PARAMETER  :        SBU_ID=:pSBU_ID

Table Name:   	    ADM_SBU_PRODUCTS

			  
Relation : 	  	                
			  
Filter by:  WHERE STATUS = 1 

QUERY : 

SELECT PROD_ID, DISPLAY_NAME AS PRODUCT_NAME 
FROM ADM_SBU_PRODUCTS
WHERE SBU_ID= :pSBU_ID
and prod_type in (502,503,506)
AND STATUS=1

-----------------

--------------test sub test data-------------------

API TYPE : GET
API NAME : api/pp/get-test-sub-test-data/{pPROD_ID}/{pSBU_ID}

Response Fields :  ID, DISPLAY_CODE, TEST_DEPARTMENT, DEPARTMENT_NAME, TEST_NAME, TEST_MEASURE, TEST_MEASURE_NAME, TEST_TYPE, TEST_TYPE_NAME, PARENT_ID, PROD_ID
                     
	  
Operational Fields: ID, DISPLAY_CODE, TEST_DEPARTMENT, DEPARTMENT_NAME, TEST_NAME, TEST_MEASURE, TEST_MEASURE_NAME, TEST_TYPE, TEST_TYPE_NAME, PARENT_ID, PROD_ID
         
PARAMETER  :        

Table Name:   	    FD_GET_QC_IPQC_TEST_SUB_TEST (pPROD_ID NUMBER,pSBU_ID NUMBER)

			  
Relation : 	  	
                
			  
Filter by:  

QUERY : 

SELECT  FD_GET_QC_IPQC_TEST_SUB_TEST (:pPROD_ID,:pSBU_ID ) FROM DUAL   --7594,2

--------------------------------------------------------

API TYPE : POST
API NAME : api/pp/crud-qc-ipqc-test-data

JERP_PP_UTIL.PP_QC_IPQC_TEST_DATA Creation PROCEDURE

JERP_PP_UTIL.PP_QC_IPQC_TEST_DATA(pQC_IPQC_TEST         =>vQC_IPQC_TEST,
                          pQC_IPQC_TEST_ID      =>vMst ,
                          pSBU_ID                =>2,
                          pUSER_ID               =>1,
                          pSTATUS              =>vSTATUS
                      );


A. pQC_IPQC_TEST (JSON OBJECT)
Header = qc_ipqc_test

OBJECT

GET_NUMBER('test_department');
GET_STRING('test_name');
GET_NUMBER('test_measure');
GET_NUMBER('test_type');
GET_NUMBER('uom');
GET_STRING('description');
GET_STRING('machine_id');

Header = qc_ipqc_sub_test

GET_NUMBER('sub_test_id');
GET_NUMBER('parent_id');
GET_STRING('sub_test_nam');
GET_NUMBER('sub_test_measure');
GET_NUMBER('sub_uom');
GET_STRING('description');
GET_STRING('prod_id');

                                            

B. pQC_IPQC_TEST_ID    IN OUT NUMBER,
    CREATE/INSERT MODE : pQCTM_ID  WILL BE NULL
    UPDATE MODE :  pQCTM_ID WILL COME FROM FRONT-END

C. pSBU_ID (Number)

D. pUSER_ID (Number)
 pUSER_ID number not null auth.user_id


E. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.

-------------------------------------------------------------

----call

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