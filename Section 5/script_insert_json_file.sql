-- 1/ Création de la table TB_TYPE_FOURNISSEUR_JSON
-- DROP TABLE IF EXISTS TB_TYPE_FOURNISSEUR_JSON;
CREATE TABLE TB_TYPE_FOURNISSEUR_JSON
(
	TYPE_FRS VARIANT
);


-- 2/ Création du format des fichiers : JSON_FILE_FORMAT
CREATE FILE FORMAT JSON_FILE_FORMAT 
TYPE = 'JSON' 
STRIP_OUTER_ARRAY = TRUE; 



 -- 3/ Création d'un stage 
 CREATE STAGE COPY_TEMP_DATA_JSON
      FILE_FORMAT = (FORMAT_NAME=JSON_FILE_FORMAT);



-- 4/ Ajout du fichier TB_TYPE_FOURNISSEUR.json dans la zone de préparation interne (stage) : à exécuter dans snowsql
PUT 'file://C:/Script SQL - Formation Snowflake/Section 5/TB_TYPE_FOURNISSEUR.json' @COPY_TEMP_DATA_JSON AUTO_COMPRESS = FALSE;



-- 5/ Insertion des données dans la table TB_TYPE_FOURNISSEUR_JSON    
COPY INTO TB_TYPE_FOURNISSEUR_JSON
from @COPY_TEMP_DATA_JSON
files = ('TB_TYPE_FOURNISSEUR.json');

SELECT * from TB_TYPE_FOURNISSEUR_JSON

-- 6/ Selection des données présentes dans la table TB_TYPE_FOURNISSEUR_JSON
SELECT TYPE_FRS:CD_TYPE_FRS::STRING  CD_TYPE_FRS,
       TYPE_FRS:LB_TYPE_FRS::STRING  LB_TYPE_FRS
FROM TB_TYPE_FOURNISSEUR_JSON;



-- 7/ Création et insertion des données dans la table structuée
CREATE TABLE TB_TYPE_FOURNISSEUR AS 
SELECT DISTINCT 
       TYPE_FRS:CD_TYPE_FRS::STRING  CD_TYPE_FRS,
       TYPE_FRS:LB_TYPE_FRS::STRING  LB_TYPE_FRS
FROM TB_TYPE_FOURNISSEUR_JSON;