-- ============================================================================
-- Fichier : def-dict-tables-cols-MagasinRepVelo.sql
-- Auteur : Jamal MALKI
-- Date : janvier 2026
-- Role : Definition du dictionnaire des colonnes des tables
-- ============================================================================

COMMENT ON COLUMN CATEG_VELO.ID_CATEG  IS 'Identifiant de la catégorie du vélo (PK)';
COMMENT ON COLUMN CATEG_VELO.LIBELLE   IS 'Libellé de la catégorie du vélo : HOMME, FEMME, ENFANT (CK)';

COMMENT ON COLUMN MARQUE_VELO.ID_MARQUE IS 'Identifiant de la marque du vélo (PK)';
COMMENT ON COLUMN MARQUE_VELO.LIBELLE   IS 'Libellé de la marque du vélo : BTWIN, GITANE, NAKAMURA, TREK (CK)';

COMMENT ON COLUMN TAILLE_VELO.ID_TAILLE IS 'Identifiant de la taille du vélo (PK)';
COMMENT ON COLUMN TAILLE_VELO.LIBELLE   IS 'Libellé de la taille du vélo : XS, S, M, M/L, L/XL, XL/XXL (CK)';

COMMENT ON COLUMN TYPE_VELO.ID_TYPE IS 'Identifiant du type du vélo (PK)';
COMMENT ON COLUMN TYPE_VELO.LIBELLE IS 'Libellé du type du vélo : VTT, VTC, VAE, CARGO, HOLLANDAIS, PLIANT (CK)';

COMMENT ON COLUMN ADRESSE.ID_ADRESSE  IS 'Identifiant d''une adresse postale (PK)';
COMMENT ON COLUMN ADRESSE.INTITULE    IS 'Désignation complète d''une adresse : numéro, rue, etc.';
COMMENT ON COLUMN ADRESSE.COMMUNE     IS 'Commune de l''adresse';
COMMENT ON COLUMN ADRESSE.CODE_POSTAL IS 'Code postal de l''adresse';

COMMENT ON COLUMN CLIENT.ID_CLIENT  IS 'Identifiant du client (PK)';
COMMENT ON COLUMN CLIENT.NOM        IS 'Nom du client';
COMMENT ON COLUMN CLIENT.PRENOM     IS 'Prénom du client';
COMMENT ON COLUMN CLIENT.EMAIL      IS 'Email du client (CK)';
COMMENT ON COLUMN CLIENT.TEL        IS 'Numéro de téléphone du client';
COMMENT ON COLUMN CLIENT.ID_ADRESSE IS 'Référence à l''adresse du client (FK)';

COMMENT ON COLUMN VELO.ID_VELO   IS 'Identifiant du vélo (PK)';
COMMENT ON COLUMN VELO.NUM_VELO  IS 'Numéro du vélo (UQ)';

COMMENT ON COLUMN REPARATEUR.ID_REPARATEUR IS 'Identifiant du réparateur (PK)';
COMMENT ON COLUMN REPARATEUR.LOGIN         IS 'Login du réparateur';

COMMENT ON COLUMN REPARATION.ID_REPARATION     IS 'Identifiant de la réparation (PK)';
COMMENT ON COLUMN REPARATION.DUREE_PREVUE      IS 'Durée prévue de la réparation (en jours)';
COMMENT ON COLUMN REPARATION.DATE_DEBUT_PREVUE IS 'Date de début prévue de la réparation';
COMMENT ON COLUMN REPARATION.DATE_DEBUT_REELLE IS 'Date de début réelle de la réparation';
COMMENT ON COLUMN REPARATION.DATE_FIN_PREVUE   IS 'Date de fin prévue de la réparation';
COMMENT ON COLUMN REPARATION.DATE_FIN_REELLE   IS 'Date de fin réelle de la réparation';
COMMENT ON COLUMN REPARATION.ETAT              IS 'État de la réparation : ouverte, encours, terminee';
COMMENT ON COLUMN REPARATION.COUT_TOTAL        IS 'Coût total de la réparation';
COMMENT ON COLUMN REPARATION.ID_VELO           IS 'Référence au vélo concerné (FK)';
