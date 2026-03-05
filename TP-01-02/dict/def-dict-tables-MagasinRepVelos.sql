-- ============================================================================
-- Fichier : def-dict-tables-MagasinRepVelo.sql
-- Auteur : Jamal MALKI
-- Date : janvier 2026
-- Role : Definition du dictionnaire des tables
-- ============================================================================

COMMENT ON TABLE MARQUE_VELO IS 'Marque du vélo : BTWIN, GITANE, NAKAMURA, TREK';
COMMENT ON TABLE CATEG_VELO  IS 'Catégorie du vélo : HOMME, FEMME, ENFANT';
COMMENT ON TABLE TAILLE_VELO IS 'Taille du vélo : XS, S, M, M/L, L/XL, XL/XXL';
COMMENT ON TABLE TYPE_VELO   IS 'Type du vélo : VTT, VTC, VAE, CARGO, HOLLANDAIS, PLIANT';
COMMENT ON TABLE ADRESSE     IS 'Adresse postale du client';
COMMENT ON TABLE CLIENT      IS 'Client du magasin de réparation de vélos';
COMMENT ON TABLE VELO        IS 'Vélo identifié par son numéro unique';
COMMENT ON TABLE DETAIL_VELO IS 'Détails techniques du vélo (marque, type, catégorie, taille)';
COMMENT ON TABLE DEPOT       IS 'Dépôt d''un vélo par un client';
COMMENT ON TABLE REPARATEUR  IS 'Réparateur intervenant sur les opérations';
COMMENT ON TABLE REPARATION  IS 'Réparation d''un vélo (ensemble d''opérations)';
COMMENT ON TABLE OPERATION   IS 'Opération élémentaire effectuée dans le cadre d''une réparation';
COMMENT ON TABLE FACTURE     IS 'Facture émise pour une réparation';
COMMENT ON TABLE REGLEMENT   IS 'Règlement d''une facture';
