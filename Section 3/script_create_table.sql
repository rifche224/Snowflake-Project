/*----------------------------------------------------------------------------------
-------------------- Script de création des différentes tables -------------------
----------------------------------------------------------------------------------*/

-- Définir la base de données à utiliser 
USE DATABASE ICOMMERCE;

-- Définir le schéma à utiliser 
USE SCHEMA I_OPE;

-- 	Afficher la liste des tables
SHOW TABLES;



/*----------------------------------------------------------------------------------
------------------ Table N°1 : ICOMMERCE.I_OPE.TB_TYPE_CLIENT --------------------
----------------------------------------------------------------------------------*/

-- DROP TABLE IF EXISTS TB_TYPE_CLIENT CASCADE;
CREATE TABLE TB_TYPE_CLIENT 
(
	CD_TYPE_CLIENT VARCHAR(50) NOT NULL,
	LB_TYPE_CLIENT VARCHAR(100) NOT NULL,
	CONSTRAINT TB_TYPE_CLIENT_PKEY PRIMARY KEY(CD_TYPE_CLIENT)
);



/*----------------------------------------------------------------------------------
--------------------- Table N°2 : ICOMMERCE.I_OPE.TB_CLIENT ----------------------
----------------------------------------------------------------------------------*/

-- DROP TABLE IF EXISTS TB_CLIENT CASCADE;
CREATE TABLE TB_CLIENT 
(
	ID_CLIENT VARCHAR(50) NOT NULL,
	NOM_CLIENT VARCHAR(100) NOT NULL,
	PREN_CLIENT VARCHAR(100) NOT NULL,
	CD_POSTAL_CLIENT VARCHAR(100) ,
	VILLE_CLIENT VARCHAR(100) NOT NULL,
	PAYS_CLIENT VARCHAR(100) NOT NULL,
	REGION_CLIENT VARCHAR(100) NOT NULL,
	CD_TYPE_CLIENT VARCHAR(50) NOT NULL,
	CONSTRAINT TB_CLIENT_PKEY PRIMARY KEY(ID_CLIENT),
	CONSTRAINT TB_CLIENT_FKEY FOREIGN KEY (CD_TYPE_CLIENT) 
		REFERENCES TB_TYPE_CLIENT(CD_TYPE_CLIENT)
);



/*----------------------------------------------------------------------------------
-------------------- Table N°3 : ICOMMERCE.I_OPE.TB_CATEGORIE --------------------
----------------------------------------------------------------------------------*/

-- DROP TABLE IF EXISTS TB_CATEGORIE CASCADE;
CREATE TABLE TB_CATEGORIE 
(
	CD_CATEGORIE VARCHAR(50) NOT NULL,
	LB_CATEGORIE VARCHAR(100) NOT NULL,
	CONSTRAINT TB_CATEGORIE_PKEY PRIMARY KEY(CD_CATEGORIE)
);



/*----------------------------------------------------------------------------------
------------------ Table N°4 : ICOMMERCE.I_OPE.TB_SOUS_CATEGORIE -----------------
----------------------------------------------------------------------------------*/

-- DROP TABLE IF EXISTS TB_SOUS_CATEGORIE CASCADE;
CREATE TABLE TB_SOUS_CATEGORIE 
(
	CD_SOUS_CATEGORIE VARCHAR(50) NOT NULL,
	LB_SOUS_CATEGORIE VARCHAR(100) NOT NULL,
	CD_CATEGORIE VARCHAR(50) NOT NULL,
	CONSTRAINT TB_SOUS_CATEGORIE_PKEY PRIMARY KEY(CD_SOUS_CATEGORIE), 											
	CONSTRAINT TB_CATEGORIE_FKEY FOREIGN KEY (CD_CATEGORIE) 
		REFERENCES TB_CATEGORIE(CD_CATEGORIE)
);



/*----------------------------------------------------------------------------------
--------------------- Table N°5 : ICOMMERCE.I_OPE.TB_PRODUIT ---------------------
----------------------------------------------------------------------------------*/

-- DROP TABLE IF EXISTS TB_PRODUIT CASCADE;
CREATE TABLE TB_PRODUIT 
(
	CD_PRODUIT VARCHAR(50) NOT NULL,
	NOM_PRODUIT VARCHAR(100) NOT NULL,
	PRIX_ACHAT_PRODUIT NUMBER(38,4) NOT NULL,
	PRIX_VENTE_PRODUIT NUMBER(38,4) NOT NULL,
	CD_SOUS_CATEGORIE VARCHAR(50) NOT NULL,
	CONSTRAINT TB_PRODUIT_PKEY PRIMARY KEY(CD_PRODUIT), 											
	CONSTRAINT TB_PRODUIT_FKEY FOREIGN KEY (CD_SOUS_CATEGORIE) 
		REFERENCES TB_SOUS_CATEGORIE(CD_SOUS_CATEGORIE)
);



/*----------------------------------------------------------------------------------
---------------------- Table N°6 : ICOMMERCE.I_OPE.TB_VENTE ----------------------
----------------------------------------------------------------------------------*/

-- DROP TABLE IF EXISTS TB_VENTE CASCADE;
CREATE TABLE TB_VENTE 
(
	ID_VENTE VARCHAR(50) NOT NULL,
	DT_VENTE TIMESTAMP NOT NULL,
	ID_CLIENT VARCHAR(50) NOT NULL,
	CONSTRAINT TB_VENTE_PKEY PRIMARY KEY(ID_VENTE), 											
	CONSTRAINT TB_VENTE_FKEY FOREIGN KEY (ID_CLIENT) 
		REFERENCES TB_CLIENT(ID_CLIENT)
);



/*----------------------------------------------------------------------------------
------------------ Table N°7 : ICOMMERCE.I_OPE.TB_DETAIL_VENTE -------------------
----------------------------------------------------------------------------------*/

-- DROP TABLE IF EXISTS TB_DETAIL_VENTE ;
CREATE TABLE TB_DETAIL_VENTE 
(
	ID_VENTE VARCHAR(50) NOT NULL,
	CD_PRODUIT VARCHAR(50) NOT NULL,	
	QTE_VENTE NUMBER(38,0) NOT NULL,
	PRIX_VENTE NUMBER(38,4) NOT NULL,
	PRIX_ACHAT NUMBER(38,4) NOT NULL,
	CONSTRAINT TB_DETAIL_VENTE_PKEY PRIMARY KEY(ID_VENTE,CD_PRODUIT), 											
	CONSTRAINT TB_VENTE_DETAIL_VTE_FKEY FOREIGN KEY (ID_VENTE) 
		REFERENCES TB_VENTE(ID_VENTE), 
	CONSTRAINT TB_VENTE_DETAIL_PRODUIT_FKEY FOREIGN KEY (CD_PRODUIT) 
		REFERENCES TB_PRODUIT(CD_PRODUIT)
);