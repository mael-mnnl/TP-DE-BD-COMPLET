-- ============================================================================
-- Fichier : testupdate_vue_reparations_en_cours.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Tester la mise à jour via la vue vue_reparations_en_cours
-- Fichier résultat : testupdate_vue_reparations_en_cours.out
-- ============================================================================

ALTER SESSION SET nls_date_format='dd/mm/yyyy';

-- Vider la base
@../utilitaires/vide-contenu-base-Magasin-Reparation-Velos.sql

-- ============================================================================
-- Insertion des données de référence nécessaires
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

INSERT INTO reparation VALUES (
    1, 3,
    TO_DATE('05/01/2026','dd/mm/yyyy'),
    TO_DATE('05/01/2026','dd/mm/yyyy'),
    TO_DATE('08/01/2026','dd/mm/yyyy'),
    NULL,
    'encours', NULL, 1
);

-- Créer la vue
@vue_reparations_en_cours.sql

COMMIT;

-- ============================================================================
-- Fichier résultat
-- ============================================================================
SPOOL testupdate_vue_reparations_en_cours.out
PROMPT fichier résultat du test : testupdate_vue_reparations_en_cours.out

PROMPT --- Contenu de la vue AVANT UPDATE ---
SELECT * FROM vue_reparations_en_cours ORDER BY id_reparation;

SET ECHO ON

-- cas 1 : UPDATE d'une colonne de REPARATION (cout_total)
--         → DOIT RÉUSSIR : colonne appartenant à la table de base REPARATION
UPDATE vue_reparations_en_cours
SET cout_total = 95.00
WHERE id_reparation = 1;

-- cas 2 : UPDATE de la colonne num_velo (colonne de VELO, non modifiable)
--         → DOIT ÉCHOUER : num_velo est une colonne de la table VELO (non updatable via jointure)
UPDATE vue_reparations_en_cours
SET num_velo = 'VELO_MODIF'
WHERE id_reparation = 1;

SET ECHO OFF

COMMIT;

PROMPT --- Contenu de la vue APRÈS UPDATE ---
SELECT * FROM vue_reparations_en_cours ORDER BY id_reparation;

SPOOL OFF
-- ============================================================================
-- Fin du programme de test
-- ============================================================================
