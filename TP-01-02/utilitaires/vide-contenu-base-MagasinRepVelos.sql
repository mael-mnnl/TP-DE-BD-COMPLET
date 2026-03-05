-- ============================================================================
-- Fichier : vide-contenu-base-MagasinRepVelos.sql
-- Auteur  : Jamal MALKI
-- Date    : Janvier 2026
-- Role    : Suppression des nuplets (ordre inverse des FK)
-- ============================================================================

SET ECHO OFF
SET FEEDBACK OFF

DELETE FROM reglement;
DELETE FROM facture;
DELETE FROM operation;
DELETE FROM reparation;
DELETE FROM depot;
DELETE FROM detail_velo;
DELETE FROM velo;
DELETE FROM client;
DELETE FROM reparateur;
DELETE FROM adresse;
DELETE FROM marque_velo;
DELETE FROM type_velo;
DELETE FROM categ_velo;
DELETE FROM taille_velo;

COMMIT;

SET FEEDBACK ON
PROMPT Base vidée.
