-- ============================================================================
-- fichier : ddl-Magasin-Reparation-Velos.sql
-- auteur : Jamal MALKI
-- date : janvier 2026
-- role : creation des tables de la base de donnees
-- ============================================================================

CREATE TABLE adresse
(
  id_adresse  NUMBER        NOT NULL,
  intitule     VARCHAR2(500) NOT NULL,
  commune     VARCHAR2(50)  NOT NULL,
  code_postal VARCHAR2(10)  NOT NULL,
  CONSTRAINT PK_adresse PRIMARY KEY (id_adresse)
);

CREATE TABLE taille_velo
(
  id_taille NUMBER NOT NULL,
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
  id_reparation     NUMBER      NOT NULL,
  duree_prevue      NUMBER      NOT NULL,
  date_debut_prevue DATE        NOT NULL,
  date_debut_reelle DATE,
  date_fin_prevue   DATE        NOT NULL,
  date_fin_reelle   DATE,
  etat              CHAR(10)    NOT NULL,
  cout_total        NUMBER,
  id_velo           NUMBER      NOT NULL,
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
