-- ============================================================================
-- SCRIPT COMPLET D'INITIALISATION - Base Magasin Réparation Vélos
-- A exécuter UNE SEULE FOIS sur une base vierge
-- SQL> @INIT_COMPLET.sql
-- ============================================================================

ALTER SESSION SET nls_date_format='dd/mm/yyyy';

-- ============================================================================
-- ETAPE 1 : CREATION DES TABLES
-- ============================================================================

CREATE TABLE adresse
(
  id_adresse  NUMBER        NOT NULL,
  intitule    VARCHAR2(500) NOT NULL,
  commune     VARCHAR2(50)  NOT NULL,
  code_postal VARCHAR2(10)  NOT NULL,
  CONSTRAINT PK_adresse PRIMARY KEY (id_adresse)
);

CREATE TABLE taille_velo
(
  id_taille NUMBER       NOT NULL,
  libelle   VARCHAR2(20) NOT NULL,
  CONSTRAINT PK_taille_velo PRIMARY KEY (id_taille),
  CONSTRAINT UQ_taille_velo UNIQUE(libelle)
);

CREATE TABLE type_velo
(
  id_type NUMBER       NOT NULL,
  libelle VARCHAR2(20) NOT NULL,
  CONSTRAINT PK_type_velo PRIMARY KEY (id_type),
  CONSTRAINT UQ_type_velo UNIQUE(libelle)
);

CREATE TABLE categ_velo
(
  id_categ NUMBER       NOT NULL,
  libelle  VARCHAR2(20) NOT NULL,
  CONSTRAINT PK_categ_velo PRIMARY KEY (id_categ),
  CONSTRAINT UQ_categ_velo UNIQUE(libelle)
);

CREATE TABLE marque_velo
(
  id_marque NUMBER       NOT NULL,
  libelle   VARCHAR2(20) NOT NULL,
  CONSTRAINT PK_marque_velo PRIMARY KEY (id_marque),
  CONSTRAINT UQ_marque_velo UNIQUE(libelle)
);

CREATE TABLE reparateur
(
  id_reparateur NUMBER       NOT NULL,
  login         VARCHAR2(20) NOT NULL,
  CONSTRAINT PK_reparateur PRIMARY KEY (id_reparateur)
);

CREATE TABLE client
(
  id_client  NUMBER        NOT NULL,
  nom        VARCHAR2(20)  NOT NULL,
  prenom     VARCHAR2(20)  NOT NULL,
  email      VARCHAR2(100) NOT NULL,
  tel        CHAR(10)      NOT NULL,
  id_adresse NUMBER        NOT NULL,
  CONSTRAINT PK_client PRIMARY KEY (id_client),
  CONSTRAINT UQ_client_email UNIQUE (email)
);

CREATE TABLE velo
(
  id_velo  NUMBER        NOT NULL,
  num_velo VARCHAR2(100) NOT NULL,
  CONSTRAINT PK_velo PRIMARY KEY (id_velo),
  CONSTRAINT UQ_velo_num UNIQUE (num_velo)
);

CREATE TABLE detail_velo
(
  id_detail_velo   NUMBER NOT NULL,
  id_velo          NUMBER NOT NULL,
  id_marque        NUMBER NOT NULL,
  id_type          NUMBER NOT NULL,
  id_categ         NUMBER NOT NULL,
  id_taille        NUMBER NOT NULL,
  date_fabrication DATE,
  CONSTRAINT PK_detail_velo PRIMARY KEY (id_detail_velo)
);

CREATE TABLE depot
(
  id_depot   NUMBER NOT NULL,
  id_client  NUMBER NOT NULL,
  id_velo    NUMBER NOT NULL,
  date_depot DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT PK_depot PRIMARY KEY (id_depot)
);

CREATE TABLE reparation
(
  id_reparation     NUMBER   NOT NULL,
  duree_prevue      NUMBER   NOT NULL,
  date_debut_prevue DATE     NOT NULL,
  date_debut_reelle DATE,
  date_fin_prevue   DATE     NOT NULL,
  date_fin_reelle   DATE,
  etat              CHAR(10) NOT NULL,
  cout_total        NUMBER,
  id_velo           NUMBER   NOT NULL,
  CONSTRAINT PK_reparation PRIMARY KEY (id_reparation)
);

CREATE TABLE operation
(
  id_operation      NUMBER       NOT NULL,
  intitule          VARCHAR2(50) NOT NULL,
  duree_prevue      NUMBER       NOT NULL,
  date_debut_reelle DATE,
  date_fin_reelle   DATE,
  etat              CHAR(10)     NOT NULL,
  cout              NUMBER,
  id_reparation     NUMBER       NOT NULL,
  id_reparateur     NUMBER       NOT NULL,
  CONSTRAINT PK_operation PRIMARY KEY (id_operation)
);

CREATE TABLE facture
(
  id_facture    NUMBER NOT NULL,
  date_emission DATE   NOT NULL,
  montant       NUMBER NOT NULL,
  id_reparation NUMBER NOT NULL,
  CONSTRAINT PK_facture PRIMARY KEY (id_facture)
);

CREATE TABLE reglement
(
  id_reglement   NUMBER NOT NULL,
  date_reglement DATE   NOT NULL,
  montant        NUMBER NOT NULL,
  id_facture     NUMBER NOT NULL,
  CONSTRAINT PK_reglement PRIMARY KEY (id_reglement)
);

-- ============================================================================
-- ETAPE 2 : CREATION DES SEQUENCES
-- ============================================================================

CREATE SEQUENCE seq_ADRESSE     START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_CLIENT      START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_REPARATEUR  START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_VELO        START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_DETAIL_VELO START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_DEPOT       START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_REPARATION  START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_OPERATION   START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_FACTURE     START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_REGLEMENT   START WITH 1 INCREMENT BY 1 NOCYCLE;

-- ============================================================================
-- ETAPE 3 : LIAISON SEQUENCES AUX TABLES
-- ============================================================================

ALTER TABLE adresse     MODIFY id_adresse     DEFAULT seq_ADRESSE.nextval;
ALTER TABLE client      MODIFY id_client      DEFAULT seq_CLIENT.nextval;
ALTER TABLE reparateur  MODIFY id_reparateur  DEFAULT seq_REPARATEUR.nextval;
ALTER TABLE velo        MODIFY id_velo        DEFAULT seq_VELO.nextval;
ALTER TABLE detail_velo MODIFY id_detail_velo DEFAULT seq_DETAIL_VELO.nextval;
ALTER TABLE depot       MODIFY id_depot       DEFAULT seq_DEPOT.nextval;
ALTER TABLE reparation  MODIFY id_reparation  DEFAULT seq_REPARATION.nextval;
ALTER TABLE operation   MODIFY id_operation   DEFAULT seq_OPERATION.nextval;
ALTER TABLE facture     MODIFY id_facture     DEFAULT seq_FACTURE.nextval;
ALTER TABLE reglement   MODIFY id_reglement   DEFAULT seq_REGLEMENT.nextval;

-- ============================================================================
-- ETAPE 4 : CLES ETRANGERES (FK)
-- ============================================================================

ALTER TABLE client
  ADD CONSTRAINT FK_adresse_TO_client
  FOREIGN KEY (id_adresse) REFERENCES adresse (id_adresse);

ALTER TABLE detail_velo
  ADD CONSTRAINT FK_detail_velo_velo
  FOREIGN KEY (id_velo) REFERENCES velo (id_velo);
ALTER TABLE detail_velo
  ADD CONSTRAINT FK_detail_velo_marque
  FOREIGN KEY (id_marque) REFERENCES marque_velo (id_marque);
ALTER TABLE detail_velo
  ADD CONSTRAINT FK_detail_velo_type
  FOREIGN KEY (id_type) REFERENCES type_velo (id_type);
ALTER TABLE detail_velo
  ADD CONSTRAINT FK_detail_velo_categ
  FOREIGN KEY (id_categ) REFERENCES categ_velo (id_categ);
ALTER TABLE detail_velo
  ADD CONSTRAINT FK_detail_velo_taille
  FOREIGN KEY (id_taille) REFERENCES taille_velo (id_taille);

ALTER TABLE depot
  ADD CONSTRAINT FK_depot_id_client
  FOREIGN KEY (id_client) REFERENCES client (id_client);
ALTER TABLE depot
  ADD CONSTRAINT FK_depot_id_velo
  FOREIGN KEY (id_velo) REFERENCES velo (id_velo);

ALTER TABLE reparation
  ADD CONSTRAINT FK_reparation_id_velo
  FOREIGN KEY (id_velo) REFERENCES velo (id_velo);

ALTER TABLE operation
  ADD CONSTRAINT FK_operation_reparation
  FOREIGN KEY (id_reparation) REFERENCES reparation (id_reparation);
ALTER TABLE operation
  ADD CONSTRAINT FK_operation_reparateur
  FOREIGN KEY (id_reparateur) REFERENCES reparateur (id_reparateur);

ALTER TABLE facture
  ADD CONSTRAINT FK_facture_reparation
  FOREIGN KEY (id_reparation) REFERENCES reparation (id_reparation);

ALTER TABLE reglement
  ADD CONSTRAINT FK_reglement_facture
  FOREIGN KEY (id_facture) REFERENCES facture (id_facture);

-- ============================================================================
-- ETAPE 5 : COMMENTAIRES (dictionnaire)
-- ============================================================================

COMMENT ON TABLE adresse     IS 'Adresse postale du client';
COMMENT ON TABLE marque_velo IS 'Marque du vélo : BTWIN, GITANE, NAKAMURA, TREK';
COMMENT ON TABLE categ_velo  IS 'Catégorie du vélo : HOMME, FEMME, ENFANT';
COMMENT ON TABLE taille_velo IS 'Taille du vélo : XS, S, M, M/L, L/XL, XL/XXL';
COMMENT ON TABLE type_velo   IS 'Type du vélo : VTT, VTC, VAE, CARGO, HOLLANDAIS, PLIANT';
COMMENT ON TABLE client      IS 'Client du magasin de réparation de vélos';
COMMENT ON TABLE velo        IS 'Vélo identifié par son numéro unique';
COMMENT ON TABLE detail_velo IS 'Détails techniques du vélo (marque, type, catégorie, taille)';
COMMENT ON TABLE depot       IS 'Dépôt d''un vélo par un client';
COMMENT ON TABLE reparateur  IS 'Réparateur intervenant sur les opérations';
COMMENT ON TABLE reparation  IS 'Réparation d''un vélo (ensemble d''opérations)';
COMMENT ON TABLE operation   IS 'Opération élémentaire dans le cadre d''une réparation';
COMMENT ON TABLE facture     IS 'Facture émise pour une réparation';
COMMENT ON TABLE reglement   IS 'Règlement d''une facture';

-- ============================================================================
-- ETAPE 6 : CREATION DES VUES (TP-05)
-- ============================================================================

-- Vue 1 : réparations en cours
CREATE OR REPLACE VIEW vue_reparations_en_cours AS
SELECT
    r.id_reparation,
    r.etat,
    r.duree_prevue,
    r.date_debut_prevue,
    r.date_fin_prevue,
    r.date_debut_reelle,
    r.date_fin_reelle,
    r.cout_total,
    v.id_velo,
    v.num_velo
FROM reparation r
JOIN velo v ON r.id_velo = v.id_velo
WHERE r.etat != 'terminee';

-- Vue 2 : réparations avec clients
CREATE OR REPLACE VIEW vue_reparations_clients AS
SELECT
    r.id_reparation,
    r.etat,
    r.duree_prevue,
    r.date_debut_prevue,
    r.date_fin_prevue,
    r.cout_total,
    v.num_velo,
    c.nom,
    c.prenom,
    c.email,
    c.tel
FROM reparation r
JOIN velo   v ON r.id_velo   = v.id_velo
JOIN depot  d ON v.id_velo   = d.id_velo
JOIN client c ON d.id_client = c.id_client
ORDER BY r.id_reparation;

-- Vue 3 : stats réparateur par type de vélo
CREATE OR REPLACE VIEW vue_stats_reparateur_types_velos AS
SELECT
    rep.login,
    tv.libelle              AS type_velo,
    COUNT(op.id_operation)  AS nb_operations,
    SUM(op.cout)            AS cout_total
FROM reparateur  rep
JOIN operation   op  ON rep.id_reparateur = op.id_reparateur
JOIN reparation  r   ON op.id_reparation  = r.id_reparation
JOIN velo        v   ON r.id_velo         = v.id_velo
JOIN detail_velo dv  ON v.id_velo         = dv.id_velo
JOIN type_velo   tv  ON dv.id_type        = tv.id_type
GROUP BY rep.login, tv.libelle
ORDER BY rep.login, tv.libelle;

-- ============================================================================
-- ETAPE 7 : DONNEES DE REFERENCE (tables de référence)
-- ============================================================================

INSERT INTO taille_velo (id_taille, libelle) VALUES (1, 'XS');
INSERT INTO taille_velo (id_taille, libelle) VALUES (2, 'S');
INSERT INTO taille_velo (id_taille, libelle) VALUES (3, 'M');
INSERT INTO taille_velo (id_taille, libelle) VALUES (4, 'M/L');
INSERT INTO taille_velo (id_taille, libelle) VALUES (5, 'L/XL');
INSERT INTO taille_velo (id_taille, libelle) VALUES (6, 'XL/XXL');

INSERT INTO type_velo (id_type, libelle) VALUES (1, 'VTT');
INSERT INTO type_velo (id_type, libelle) VALUES (2, 'VTC');
INSERT INTO type_velo (id_type, libelle) VALUES (3, 'VAE');
INSERT INTO type_velo (id_type, libelle) VALUES (4, 'CARGO');
INSERT INTO type_velo (id_type, libelle) VALUES (5, 'HOLLANDAIS');
INSERT INTO type_velo (id_type, libelle) VALUES (6, 'PLIANT');

INSERT INTO categ_velo (id_categ, libelle) VALUES (1, 'HOMME');
INSERT INTO categ_velo (id_categ, libelle) VALUES (2, 'FEMME');
INSERT INTO categ_velo (id_categ, libelle) VALUES (3, 'ENFANT');

INSERT INTO marque_velo (id_marque, libelle) VALUES (1, 'BTWIN');
INSERT INTO marque_velo (id_marque, libelle) VALUES (2, 'GITANE');
INSERT INTO marque_velo (id_marque, libelle) VALUES (3, 'NAKAMURA');
INSERT INTO marque_velo (id_marque, libelle) VALUES (4, 'TREK');

COMMIT;

PROMPT ============================================================
PROMPT  Base initialisée avec succès !
PROMPT  Tables     : 14 créées
PROMPT  Séquences  : 10 créées
PROMPT  FK         : 13 créées
PROMPT  Vues       : 3 créées (TP-05)
PROMPT  Données    : tables de référence insérées
PROMPT ============================================================
