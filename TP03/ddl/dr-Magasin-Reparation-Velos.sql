-- ============================================================================
-- Fichier : dr-Magasin-Reparation-Velos.sql
-- Auteur : Jamal MALKI
-- Date : Janvier 2026
-- Role : Creation des Séquences, Liaison automatique et Clés Etrangères (FK)
-- ============================================================================

-- ============================================================================
-- 1. CREATION DES SEQUENCES (Compteurs)
-- ============================================================================
CREATE SEQUENCE seq_ADRESSE    START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_CLIENT     START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_REPARATEUR START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_VELO       START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_DETAIL_VELO START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_DEPOT      START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_REPARATION START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_OPERATION  START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_FACTURE    START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE seq_REGLEMENT  START WITH 1 INCREMENT BY 1 NOCYCLE;

-- ============================================================================
-- 2. ACTIVATION DES SEQUENCES (Liaison aux Tables)
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
-- 3. DEFINITION DES CLES ETRANGERES (Relations entre les tables)
-- ============================================================================
ALTER TABLE client
  ADD CONSTRAINT FK_adresse_TO_client
  FOREIGN KEY (id_adresse) REFERENCES adresse (id_adresse);

ALTER TABLE detail_velo ADD CONSTRAINT FK_detail_velo_velo   FOREIGN KEY (id_velo)    REFERENCES velo (id_velo);
ALTER TABLE detail_velo ADD CONSTRAINT FK_detail_velo_marque FOREIGN KEY (id_marque)  REFERENCES marque_velo (id_marque);
ALTER TABLE detail_velo ADD CONSTRAINT FK_detail_velo_type   FOREIGN KEY (id_type)    REFERENCES type_velo (id_type);
ALTER TABLE detail_velo ADD CONSTRAINT FK_detail_velo_categ  FOREIGN KEY (id_categ)   REFERENCES categ_velo (id_categ);
ALTER TABLE detail_velo ADD CONSTRAINT FK_detail_velo_taille FOREIGN KEY (id_taille)  REFERENCES taille_velo (id_taille);

ALTER TABLE depot ADD CONSTRAINT FK_depot_id_client FOREIGN KEY (id_client) REFERENCES client (id_client);
ALTER TABLE depot ADD CONSTRAINT FK_depot_id_velo   FOREIGN KEY (id_velo)   REFERENCES velo (id_velo);

ALTER TABLE reparation ADD CONSTRAINT FK_reparation_id_velo   FOREIGN KEY (id_velo)        REFERENCES velo (id_velo);

ALTER TABLE operation ADD CONSTRAINT FK_operation_reparation FOREIGN KEY (id_reparation) REFERENCES reparation (id_reparation);
ALTER TABLE operation ADD CONSTRAINT FK_operation_reparateur FOREIGN KEY (id_reparateur) REFERENCES reparateur (id_reparateur);

ALTER TABLE facture ADD CONSTRAINT FK_facture_reparation FOREIGN KEY (id_reparation) REFERENCES reparation (id_reparation);

ALTER TABLE reglement ADD CONSTRAINT FK_reglement_facture FOREIGN KEY (id_facture) REFERENCES facture (id_facture);
