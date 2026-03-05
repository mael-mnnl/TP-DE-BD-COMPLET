-- ============================================================================
-- Fichier : testdelete_vue_reparations_en_cours.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Tester la suppression via la vue vue_reparations_en_cours
-- Fichier résultat : testdelete_vue_reparations_en_cours.out
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
INSERT INTO velo         VALUES (2, 'VELO002');
INSERT INTO detail_velo  VALUES (1, 1, 1, 1, 1, 1, TO_DATE('01/01/2020','dd/mm/yyyy'));
INSERT INTO detail_velo  VALUES (2, 2, 1, 1, 1, 1, TO_DATE('01/01/2021','dd/mm/yyyy'));
INSERT INTO depot        VALUES (1, 1, 1, TO_DATE('01/01/2026','dd/mm/yyyy'));
INSERT INTO depot        VALUES (2, 1, 2, TO_DATE('02/01/2026','dd/mm/yyyy'));

-- réparation en cours → visible dans la vue, supprimable
INSERT INTO reparation VALUES (
    1, 3,
    TO_DATE('05/01/2026','dd/mm/yyyy'),
    TO_DATE('05/01/2026','dd/mm/yyyy'),
    TO_DATE('08/01/2026','dd/mm/yyyy'),
    NULL,
    'encours', NULL, 1
);

-- réparation ouverte → visible dans la vue, supprimable
INSERT INTO reparation VALUES (
    2, 5,
    TO_DATE('10/01/2026','dd/mm/yyyy'),
    NULL,
    TO_DATE('15/01/2026','dd/mm/yyyy'),
    NULL,
    'ouverte', NULL, 2
);

-- Créer la vue
@vue_reparations_en_cours.sql

COMMIT;

-- ============================================================================
-- Fichier résultat
-- ============================================================================
SPOOL testdelete_vue_reparations_en_cours.out
PROMPT fichier résultat du test : testdelete_vue_reparations_en_cours.out

PROMPT --- Contenu de la vue AVANT DELETE ---
SELECT * FROM vue_reparations_en_cours ORDER BY id_reparation;

SET ECHO ON

-- cas 1 : DELETE d'une réparation visible dans la vue (etat = 'encours')
--         → DOIT RÉUSSIR : la suppression via une vue jointure est autorisée
--           en Oracle lorsqu'elle ne porte que sur la table préservée par clé
DELETE FROM vue_reparations_en_cours
WHERE id_reparation = 1;

SET ECHO OFF

COMMIT;

PROMPT --- Contenu de la vue APRÈS DELETE ---
SELECT * FROM vue_reparations_en_cours ORDER BY id_reparation;

PROMPT --- Vérification : la table REPARATION ---
SELECT * FROM reparation ORDER BY id_reparation;

SPOOL OFF
-- ============================================================================
-- Fin du programme de test
-- ============================================================================
