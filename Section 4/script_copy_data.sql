-- Définir la base de données à utiliser 
USE DATABASE ICOMMERCE;

-- Définir le schéma à utiliser 
USE SCHEMA I_OPE;



-- Création du format des fichiers : PIPE_CSV_ONEHEADER
CREATE FILE FORMAT PIPE_CSV_ONEHEADER
    TYPE = 'CSV'
    FIELD_DELIMITER = '|'
    SKIP_HEADER = 1;

 -- Création d'un stage 
 CREATE STAGE COPY_TEMP_DATA
      FILE_FORMAT = (FORMAT_NAME=PIPE_CSV_ONEHEADER);
 
 -- Commande à exécuter sur snowsql
 PUT 'file://C:/Script SQL - Formation Snowflake/Section 4/TB_TYPE_CLIENT.csv' @COPY_TEMP_DATA AUTO_COMPRESS = FALSE;
 PUT 'file://C:/Script SQL - Formation Snowflake/Section 4/TB_CLIENT.csv' @COPY_TEMP_DATA AUTO_COMPRESS = FALSE;
 PUT 'file://C:/Script SQL - Formation Snowflake/Section 4/TB_CATEGORIE.csv' @COPY_TEMP_DATA AUTO_COMPRESS = FALSE;
 PUT 'file://C:/Script SQL - Formation Snowflake/Section 4/TB_SOUS_CATEGORIE.csv' @COPY_TEMP_DATA AUTO_COMPRESS = FALSE;
 PUT 'file://C:/Script SQL - Formation Snowflake/Section 4/TB_PRODUIT.csv' @COPY_TEMP_DATA AUTO_COMPRESS = FALSE;
 PUT 'file://C:/Script SQL - Formation Snowflake/Section 4/TB_VENTE.csv' @COPY_TEMP_DATA AUTO_COMPRESS = FALSE;
 PUT 'file://C:/Script SQL - Formation Snowflake/Section 4/TB_DETAIL_VENTE.csv' @COPY_TEMP_DATA AUTO_COMPRESS = FALSE;
 


LIST @COPY_TEMP_DATA;


-- Insertion des données dans la table TB_TYPE_CLIENT    
COPY INTO TB_TYPE_CLIENT
from @COPY_TEMP_DATA
files = ('TB_TYPE_CLIENT.csv')
FORCE = TRUE
; 
 

-- Insertion des données dans la table TB_CLIENT
COPY INTO TB_CLIENT
from @COPY_TEMP_DATA
files = ('TB_CLIENT.csv');  


-- Insertion des données dans la table TB_CATEGORIE
COPY INTO TB_CATEGORIE
FROM @COPY_TEMP_DATA
files = ('TB_CATEGORIE.csv');


-- Insertion des données dans la table TB_SOUS_CATEGORIE
COPY INTO TB_SOUS_CATEGORIE
FROM @COPY_TEMP_DATA
files = ('TB_SOUS_CATEGORIE.csv');


-- Insertion des données dans la table TB_PRODUIT
COPY INTO TB_PRODUIT
FROM @COPY_TEMP_DATA
files = ('TB_PRODUIT.csv');


-- Insertion des données dans la table TB_VENTE
COPY INTO TB_VENTE
FROM @COPY_TEMP_DATA
files = ('TB_VENTE.csv');


-- Insertion des données dans la table TB_DETAIL_VENTE
COPY INTO TB_DETAIL_VENTE
FROM @COPY_TEMP_DATA
files = ('TB_DETAIL_VENTE.csv');