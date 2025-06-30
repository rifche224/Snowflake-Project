-- 1/ Création de la table TB_FOURNISSEUR_XML
-- DROP TABLE IF EXISTS TB_FOURNISSEUR_XML;
CREATE TABLE TB_FOURNISSEUR_XML
(
    FRSXML VARIANT
);


-- 2/ Affichage des données présentes dans la table TB_FOURNISSEUR_XML
select * from TB_FOURNISSEUR_XML;


-- 3/ Extraction des données sur le type fournisseur présentes table TB_FOURNISSEUR_XML
SELECT
    XMLGET(FRSXML, 'type_fournisseur_code' ):"$"::STRING AS CD_TYPE_FOURNISSEUR,
    XMLGET(FRSXML, 'type_fournisseur_libelle' ):"$"::STRING AS LB_TYPE_FOURNISSEUR
FROM TB_FOURNISSEUR_XML;


-- 4/ Extraction des données sur le fournisseur présentes table TB_FOURNISSEUR_XML
SELECT
    XMLGET( FRSXML, 'type_fournisseur_code' ):"$"::STRING AS CD_TYPE_FOURNISSEUR,
    XMLGET( FRSXML, 'type_fournisseur_libelle' ):"$"::STRING AS LB_TYPE_FOURNISSEUR,
    XMLGET( frs.value, 'fournisseur_code' ):"$"::STRING as CD_FOURNISSEUR,
    XMLGET( frs.value, 'fournisseur_rsociale' ):"$"::STRING as LB_FOURNISSEUR
FROM
    TB_FOURNISSEUR_XML
    ,  lateral FLATTEN(FRSXML:"$") frs
WHERE frs.value like '<fournisseur>%'
ORDER BY CD_TYPE_FOURNISSEUR, CD_FOURNISSEUR;


-- 5/ Création et insertion des données dans la table TB_FOURNISSEUR à partir des données de la table TB_FOURNISSEUR_XML
CREATE TABLE TB_FOURNISSEUR AS
SELECT
    XMLGET( frs.value, 'fournisseur_code' ):"$"::STRING as CD_FOURNISSEUR,
    XMLGET( frs.value, 'fournisseur_rsociale' ):"$"::STRING as LB_FOURNISSEUR,
    XMLGET( FRSXML, 'type_fournisseur_code' ):"$"::STRING AS CD_TYPE_FOURNISSEUR
FROM
    TB_FOURNISSEUR_XML
    ,  lateral FLATTEN(FRSXML:"$") frs
WHERE frs.value like '<fournisseur>%'
ORDER BY CD_TYPE_FOURNISSEUR, CD_FOURNISSEUR;

---Vétrifiation de notre nouvelle table TB_FOURNISSEUR crée à partir des données de la table TB_FOURNISSEUR_XML
select * from TB_FOURNISSEUR;