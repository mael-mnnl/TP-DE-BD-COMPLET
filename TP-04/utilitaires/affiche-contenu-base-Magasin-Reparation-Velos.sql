-- ============================================================================
-- Fichier : affiche-contenu-base-Magasin-Reparation-Velos.sql
-- Auteur  : J. Malki
-- Date    : Janvier 2026
-- Role    : Afficher le contenu complet de la base de données
-- ============================================================================

SET LINESIZE 200
SET PAGESIZE 100

PROMPT --- TABLE : ADRESSE ---
SELECT * FROM adresse ORDER BY id_adresse;

PROMPT --- TABLE : CATEG_VELO ---
SELECT * FROM categ_velo ORDER BY id_categ;

PROMPT --- TABLE : MARQUE_VELO ---
SELECT * FROM marque_velo ORDER BY id_marque;

PROMPT --- TABLE : TAILLE_VELO ---
SELECT * FROM taille_velo ORDER BY id_taille;

PROMPT --- TABLE : TYPE_VELO ---
SELECT * FROM type_velo ORDER BY id_type;

PROMPT --- TABLE : REPARATEUR ---
SELECT * FROM reparateur ORDER BY id_reparateur;

PROMPT --- TABLE : CLIENT ---
SELECT * FROM client ORDER BY id_client;

PROMPT --- TABLE : VELO ---
SELECT * FROM velo ORDER BY id_velo;

PROMPT --- TABLE : DETAIL_VELO ---
SELECT * FROM detail_velo ORDER BY id_detail_velo;

PROMPT --- TABLE : DEPOT ---
SELECT * FROM depot ORDER BY id_depot;

PROMPT --- TABLE : REPARATION ---
SELECT * FROM reparation ORDER BY id_reparation;

PROMPT --- TABLE : OPERATION ---
SELECT * FROM operation ORDER BY id_operation;

PROMPT --- TABLE : FACTURE ---
SELECT * FROM facture ORDER BY id_facture;

PROMPT --- TABLE : REGLEMENT ---
SELECT * FROM reglement ORDER BY id_reglement;
