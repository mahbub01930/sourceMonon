Feature Name : PRODUCTION LINE-MACHINE-MAN RELATION

Description : Incoming material check sheet data will be enter here

Design Link : https://www.figma.com/proto/biP0rDz9bOPDVT7u5LjMbN/Production-Line---Machine-Relation?node-id=36%3A166&scaling=min-zoom&page-id=0%3A1&starting-point-node-id=2%3A2


From : WEB 

Users : PRODUCTION Personnal will setup- the production room, location with man, machine and mold

Constraint:

1. Each room will be assigned with multiple men, machine and mold.
2. 

User must be logged in

User info available

Check auth token for every request

Check SBU_ID


Tables/Data Source:

ADM_PLANT, PP_PROD_ROOM_MAN, PP_PROD_ROOM_MACHINE, PP_PROD_ROOM_MOLD

---------------------------------------
ALL API LIST

--LEFT PANEL HIREARCHY-PARENT-CHILD-1st API
API TYPE : GET
API NAME : api/pp/get-plant-prod-line-room data


JERP_ADM.PD_ADM_PLANT_DATA PROCEDURE

JERP_ADM.PD_ADM_PLANT_DATA(			  pID       IN NUMBER,
                                      pPDR_DATA      OUT CLOB)

A. pID    IN  NUMBER   -- (183)

E. pPDR_DATA (OUT CLOB)
                    pPDR_DATA (JSON OBJECT)
                    Header = prod_list

                    OBJECT
                    
                    GET_NUMBER  ('PLANT_CODE') 
                    GET_STRING  ('PLANT_NAME')
					GET_STRING  ('level')

QUERY :

SELECT ID, PLANT_CODE, PLANT_NAME, PARENT, LVL 
FROM ADM_PLANT WHERE PLANT_TYPE=183 
CONNECT BY PRIOR ID=PARENT START WITH PARENT IS NULL

---------------------------------------------------------------------

--CREATE MODE--RIGHT PANEL- PERSON LIST-2nd API
API TYPE : GET
API NAME : api/pp/get-person-data

Response Fields :  
		HE.EMP_NAME, HD.DESIG_NAME, HDE.DEPARTMENT_NAME
	  
Operational Fields: 
		HE.EMP_ID, HE.EMP_NAME, HD.DESIG_NAME, HDE.DEPARTMENT_NAME
         
PARAMETER  : 

Table Name:   	HRM_EMPLOYEE    =HE
				HRM_DESIGNATION =HD
				HRM_DEPARTMENT  =HDE
			  
Relation : 	  	HE.DESIGNATION_ID=HD.ID
				HE.DEPARTMENT_ID=HDE.ID
			  
Filter by:  

QUERY :

SELECT HE.EMP_ID, HE.EMP_NAME, HD.DESIG_NAME, HDE.DEPARTMENT_NAME 
FROM HRM_EMPLOYEE HE JOIN HRM_DESIGNATION HD ON HE.DESIGNATION_ID=HD.ID
JOIN HRM_DEPARTMENT HDE ON HE.DEPARTMENT_ID=HDE.ID

-----------------------------------------------------------
--CREATE MODE--RIGHT PANEL- MACHINE LIST-3rd API
API TYPE : GET
API NAME : api/pp/get-machine-data

Response Fields :  
		ASSET_CODE, ASSET_NAME, CAPACITY, FD_GET_BASE_UOM(CAPACITY_UOM) CAPACITY_UOM
	  
Operational Fields: 
		ID, ASSET_CODE, ASSET_NAME, CAPACITY, FD_GET_BASE_UOM(CAPACITY_UOM) CAPACITY_UOM
         
PARAMETER  : 

Table Name:   	FICO_ASSET_REGISTER 	FAR
				ADM_PLANT				AP
			  
Relation : 	  	FAR.PLANT_ID=AP.ID
			  
Filter by:  ACTIVE_FLAG='Y' AND AP.PLANT_TYPE=183

QUERY : 

SELECT FAR.ID, ASSET_CODE, ASSET_NAME, CAPACITY, FD_GET_BASE_UOM(CAPACITY_UOM) CAPACITY_UOM 
FROM FICO_ASSET_REGISTER FAR JOIN ADM_PLANT AP ON FAR.PLANT_ID=AP.ID WHERE ACTIVE_FLAG='Y' AND AP.PLANT_TYPE=183


--------------------------------------------------------------

--CREATE MODE--RIGHT PANEL-MOLD LIST-4th API
API TYPE : GET
API NAME : api/pp/get-mold-data

Response Fields :  
		DISPLAY_CODE, MOLD_NAME, TOTAL_CAVITY, RUNNING_CAVITY, CYCLE_TIME
	  
Operational Fields: 
		ID, DISPLAY_CODE, MOLD_NAME, TOTAL_CAVITY, RUNNING_CAVITY, CYCLE_TIME 
         
PARAMETER  : 

Table Name:   	PP_MOLD_MST
			  
Relation : 	  	
			  
Filter by:  

QUERY :  

SELECT ID, DISPLAY_CODE, MOLD_NAME, TOTAL_CAVITY, RUNNING_CAVITY, CYCLE_TIME 
FROM PP_MOLD_MST

--END OF CREATE MODE

-------------------------------------------------------------------------------------

--VIEW MODE DATA--PERSON DATA VIEW LIST-AFTER SELECTING THE PLANT-ROOM ID-5th API
API TYPE : GET
API NAME : api/pp/get-room-person-data/{pPLANT_ID, pROOM_ID}

Response Fields :  
		PM.EMP_ID, HE.EMP_NAME
	  
Operational Fields: 
		PM.ID, PM.EMP_ID, HE.EMP_NAME
         
PARAMETER  :  WHERE PM.PLANT_ID =:pPLANT_ID AND PM.ROOM_ID =:pROOM_ID

Table Name:   	PP_PROD_ROOM_MAN =PM
				HRM_EMPLOYEE     =HE
			  
Relation : 	  	PM.EMP_ID=HE.ID
			  
Filter by:  

QUERY :  

SELECT PM.ID, PM.EMP_ID, HE.EMP_NAME
FROM PP_PROD_ROOM_MAN PM JOIN HRM_EMPLOYEE HE ON PM.EMP_ID=HE.ID
WHERE PM.PLANT_ID =:pPLANT_ID AND PM.ROOM_ID =:pROOM_ID

----------------------------------------------------------------------------------------

--VIEW MODE DATA--MACHINE DATA VIEW LIST-AFTER SELECTING THE PLANT-ROOM ID-6th API
API TYPE : GET
API NAME : api/pp/get-room-machine-data/{pPLANT_ID, pROOM_ID}

Response Fields :  
		PM.MACHINE_ID, FR.ASSET_NAME, PM.CAPACITY 
	  
Operational Fields: 
		PM.ID, PM.MACHINE_ID, FR.ASSET_NAME, PM.CAPACITY 
         
PARAMETER  :  WHERE PM.PLANT_ID =:pPLANT_ID AND PM.ROOM_ID =:pROOM_ID

Table Name:   	PP_PROD_ROOM_MACHINE =PM
				FICO_ASSET_REGISTER  =FR
			  
Relation : 	  	PM.MACHINE_ID=FR.ID
			  
Filter by:  

QUERY :  

SELECT PM.ID, PM.MACHINE_ID, FR.ASSET_NAME, PM.CAPACITY 
FROM PP_PROD_ROOM_MACHINE PM JOIN FICO_ASSET_REGISTER FR ON PM.MACHINE_ID=FR.ID
WHERE PM.PLANT_ID =:pPLANT_ID AND PM.ROOM_ID =:pROOM_ID

-----------------------------------------------------------------------------------------

-MOLD VIEW LIST-AFTER CLICK THE MACHINE LIST OF A PARTICULAR ROOM (PARAMETER: ID FROM PP_PROD_ROOM_MACHINE TABLE)-7th API
API TYPE : GET
API NAME : api/pp/get-room-machine-mold-data/{pROOM_MACHINE_ID}

Response Fields :  
		PM.MOLD_ID, MM.MOLD_NAME, PM.TOTAL_CAVITY, PM.RUNNING_CAVITY
	  
Operational Fields: 
		PM.ID, PM.MOLD_ID, MM.MOLD_NAME, PM.TOTAL_CAVITY, PM.RUNNING_CAVITY
         
PARAMETER  :  WHERE PM.ROOM_MACHINE_ID =:pROOM_MACHINE_ID

Table Name:   	PP_PROD_ROOM_MOLD =PM
				PP_MOLD_MST       =MM
			  
Relation : 	  	PM.MOLD_ID=MM.ID
			  
Filter by:  

QUERY :  

SELECT PM.ID, PM.MOLD_ID, MM.MOLD_NAME, PM.TOTAL_CAVITY, PM.RUNNING_CAVITY
FROM PP_PROD_ROOM_MOLD PM JOIN PP_MOLD_MST MM ON PM.MOLD_ID=MM.ID
WHERE PM.ROOM_MACHINE_ID =:pROOM_MACHINE_ID



--CREATE MODE--RIGHT PANEL- CATEGORY LIST---8TH API
API TYPE : GET
API NAME : api/pp/get-category-list

Response Fields :  
                 CAT_NAME
	  
Operational Fields: 
                ID,CAT_NAME
         
PARAMETER  : 

Table Name:   	ADM_PROD_CATEGORY

Relation : 	  	

Filter by:  PROD_TYPE=506 AND LVL=3 

QUERY : 

SELECT ID,CAT_NAME FROM ADM_PROD_CATEGORY 
WHERE PROD_TYPE=506 AND LVL=3 
ORDER BY ID;

-------------------------------------------

--MOLD VIEW LIST-AFTER CLICK THE PRODUCTION FLOOR VIEW (PARAMETER: pPROD_LINE_ID FROM SELECTED PRODUCTION FLORR ID) -8th API
API TYPE : GET
API NAME : api/pp/get-view-category-data/{pPROD_LINE_ID}

Response Fields : APC.CAT_NAME
	  
Operational Fields: PPLC.ID,PPLC.PROD_CAT_ID,APC.CAT_NAME 
         
PARAMETER  :  PROD_LINE_ID = :pPROD_LINE_ID

Table Name:   	PP_PROD_LINE_CATEGORY = PPLC
				ADM_PROD_CATEGORY     = APC
			  
Relation : 	  	APC.ID = PPLC.PROD_CAT_ID
			  
Filter by:  

QUERY :  

SELECT PPLC.ID,PPLC.PROD_CAT_ID,APC.CAT_NAME 
FROM PP_PROD_LINE_CATEGORY PPLC
LEFT JOIN ADM_PROD_CATEGORY APC ON APC.ID = PPLC.PROD_CAT_ID
WHERE PROD_LINE_ID = :pPROD_LINE_ID

--END OF VIEW MODE

--CREATE MODE--RIGHT PANEL- CATEGORY LIST---8TH API
API TYPE : GET
API NAME : api/pp/get-category-list

Response Fields :  
                 CAT_NAME
	  
Operational Fields: 
                ID,CAT_NAME
         
PARAMETER  : 

Table Name:   	ADM_PROD_CATEGORY

Relation : 	  	

Filter by:  PROD_TYPE=506 AND LVL=3 

QUERY : 

SELECT ID,CAT_NAME FROM ADM_PROD_CATEGORY 
WHERE PROD_TYPE=506 AND LVL=3 
ORDER BY ID;


--END OF VIEW MODE

---------------------------------------------------------------------------------

----- CREATE AND UPDATE-LEFT PANEL DATA INSERTION-9th API
API TYPE : POST
API NAME : api/pp/adm-plant-create-update

PROCEDERE JERP_ADM.PD_ADD_PLANT Creation PROCEDURE

  JERP_ADM.PD_ADD_PLANT (
                         pSBU_ID         IN      NUMBER, 
                         pID             IN OUT  NUMBER,
                         pPARENT         IN      NUMBER,
                         pPLANT_TYPE     IN      NUMBER,
                         pPLANT_CODE     IN      VARCHAR2,          
                         pPLANT_NAME     IN      VARCHAR2,
                         pPLANT_ADDRESS  IN      VARCHAR2,
                         pUSER_ID        IN      NUMBER,
                         pPROD_CAT       IN      CLOB
                         )


----------------------------------------------------------------

-- CALLING:

DECLARE 
    vID    NUMBER := NULL;
    vSTATUS     CLOB;
    vPROD_CAT CLOB :='{"prod_cat":[
                        {
                          "id":null,
                          "prod_cat_id":451
                        },
                        {
                          "id":null,
                          "prod_cat_id":452
                        }
                    ]}';
BEGIN
    PD_ADD_PLANT (pSBU_ID  =>   2,     
                pID  =>         vID,   
                pPARENT =>       1008, 
                pPLANT_TYPE  =>   183,
                pPLANT_CODE  =>      'Room-9',      
                pPLANT_NAME   =>  'Room-9 - Batch - packing -print',
                pPLANT_ADDRESS  =>'Floor-01-Room-09',
                pUSER_ID       => 1,
                pPROD_CAT  =>  vPROD_CAT,
                pSTATUS => vSTATUS
           );
END;

------------------------------------------------------------------------------------
----- CREATE AND UPDATE-ROOM-MAN-MACHINE-MOLD DATA-10th API
API TYPE : POST
API NAME : api/pp/prod-line-machine-relation-create-update


JERP_ADM.PD_PROD_LINE_MACHINE_RELATION Creation PROCEDURE

JERP_ADM.PD_PROD_LINE_MACHINE_RELATION(pROOM_MAN         IN CLOB,
                                       pROOM_MACHINE     IN CLOB,
                                       pROOM_MOLD        IN CLOB,
                                       pROOM_MAN_ID      IN OUT NUMBER,
                                       pUSER_ID          IN NUMBER,
                                       pSTATUS           OUT CLOB  
                                       )

A. pROOM_MAN (JSON OBJECT)
Header = room_man

OBJECT
 
GET_NUMBER('sbu_id');       (NOT NULL)
GET_NUMBER('plant_id');     (NOT NULL)
GET_NUMBER('room_id');      (NOT NULL)
GET_NUMBER('emp_id');       (NOT NULL)


B. pROOM_MACHINE (JSON OBJECT)
Header = room_machine

OBJECT
 
GET_NUMBER('id');
GET_NUMBER('sbu_id');       (NOT NULL)
GET_NUMBER('plant_id');     (NOT NULL)
GET_NUMBER('room_id');      (NOT NULL)
GET_NUMBER('machine_id');   (NOT NULL)
GET_NUMBER('output');


C. pROOM_MOLD (JSON OBJECT)
Header = room_mold

OBJECT
 
GET_NUMBER('id');
GET_NUMBER('room_machine_id');  (NOT NULL)
GET_NUMBER('mold_id');          (NOT NULL)


D. pROOM_MAN_ID IN OUT NUMBER,
    CREATE/INSERT MODE : pROOM_MAN_ID  WILL BE NULL
    UPDATE MODE :  pROOM_MAN_ID WILL COME FROM FRONT-END

E. pUSER_ID (Number)
 pUSER_ID number not null auth.user_id

F. pSTATUS (Out CLOB)

pSTATUS CLOB data return DB status against input data.

---------------------------------------------------------

