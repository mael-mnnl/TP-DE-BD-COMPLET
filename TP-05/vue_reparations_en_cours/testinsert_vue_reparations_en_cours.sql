-- ============================================================================
-- Fichier : testinsert_vue_reparations_en_cours.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Tester l'insertion via la vue vue_reparations_en_cours
-- Fichier résultat : testinsert_vue_reparations_en_cours.out
-- ============================================================================

ALTER SESSION SET nls_date_format='dd/mm/yyyy';

-- Vider la base
@../utilitaires/vide-contenu-base-Magasin-Reparation-Velos.sql

-- ============================================================================
-- Insertion des données de référence nécessaires aux FK
-- ============================================================================
INSERT INTO taille_velo  VALUES (1, 'M');
INSERT INTO type_velo    VALUES (1, 'VTT');
INSERT INTO categ_velo   VALUES (1, 'HOMME');
INSERT INTO marque_velo  VALUES (1, 'BTWIN');
INSERT INTO adresse      VALUES (1, '10 rue des Fleurs', 'La Rochelle', '17000');
INSERT INTO client       VALUES (1, 'Dupont', 'Jean', 'jean.dupont@email.com', '0612345678', 1);
INSERT INTO velo         VALUES (1, 'VELO001');
INSERT INTO detail_velo  VALUES (1, 1, 1, 1, 1, 1, TO_DATE('01/01/2020','dd/mm/yyyy'));
INSERT INTO depot        VALUES (1, 1, 1, TO_DATE('01/01/2026','dd/mm/yyyy'));

-- Créer la vue
@vue_reparations_en_cours.sql

COMMIT;

-- ============================================================================
-- Fichier résultat
-- ============================================================================
SPOOL testinsert_vue_reparations_en_cours.out
PROMPT fichier résultat du test : testinsert_vue_reparations_en_cours.out

PROMPT --- Contenu de la vue AVANT insertion ---
SELECT * FROM vue_reparations_en_cours ORDER BY id_reparation;

SET ECHO ON

-- cas 1 : INSERT via la vue en fournissant uniquement les colonnes de REPARATION
--         → DOIT RÉUSSIR : la vue est basée sur la table REPARATION (colonnes insertables)
--           id_velo = 1 est une FK valide vers VELO
INSERT INTO vue_reparations_en_cours
    (id_reparation, etat, duree_prevue, date_debut_prevue, date_fin_prevue, id_velo)
VALUES
    (10, 'encours', 4, TO_DATE('20/01/2026','dd/mm/yyyy'), TO_DATE('24/01/2026','dd/mm/yyyy'), 1);

-- cas 2 : INSERT en tentant de fournir num_velo (colonne de VELO, non insertable)
--         → DOIT ÉCHOUER : num_velo vient de la table VELO, non insertable via cette vue
INSERT INTO vue_reparations_en_cours
    (id_reparation, etat, duree_prevue, date_debut_prevue, date_fin_prevue, id_velo, num_velo)
VALUES
    (11, 'encours', 2, TO_DATE('21/01/2026','dd/mm/yyyy'), TO_DATE('23/01/2026','dd/mm/yyyy'), 1, 'VELOTEST');

SET ECHO OFF

COMMIT;

PROMPT --- Contenu de la vue APRÈS insertion ---
SELECT * FROM vue_reparations_en_cours ORDER BY id_reparation;

SPOOL OFF
-- ============================================================================
-- Fin du programme de test
-- ============================================================================
