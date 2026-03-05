-- ============================================================================
-- Fichier          : test_vue_reparations_en_cours.sql
-- Auteur           : Mennal Mael
-- Date             : Février 2026
-- Role             : Tester la vue vue_reparations_en_cours
-- Fichier résultat : test_vue_reparations_en_cours.out
-- ============================================================================

ALTER SESSION SET nls_date_format='dd/mm/yyyy';

-- Vider la base
@../utilitaires/vide-contenu-base-Magasin-Reparation-Velos.sql

-- ============================================================================
-- Jeu de test DOMAINE VALIDE
-- ============================================================================

-- cas 1 : données de référence minimales
INSERT INTO taille_velo  VALUES (1, 'M');
INSERT INTO type_velo    VALUES (1, 'VTT');
INSERT INTO categ_velo   VALUES (1, 'HOMME');
INSERT INTO marque_velo  VALUES (1, 'BTWIN');
INSERT INTO adresse      VALUES (1, '10 rue des Fleurs', 'La Rochelle', '17000');

-- cas 2 : un client
INSERT INTO client VALUES (1, 'Dupont', 'Jean', 'jean.dupont@email.com', '0612345678', 1);

-- cas 3 : trois vélos
INSERT INTO velo VALUES (1, 'VELO001');
INSERT INTO velo VALUES (2, 'VELO002');
INSERT INTO velo VALUES (3, 'VELO003');

INSERT INTO detail_velo VALUES (1, 1, 1, 1, 1, 1, TO_DATE('01/01/2020','dd/mm/yyyy'));
INSERT INTO detail_velo VALUES (2, 2, 1, 1, 1, 1, TO_DATE('01/01/2021','dd/mm/yyyy'));
INSERT INTO detail_velo VALUES (3, 3, 1, 1, 1, 1, TO_DATE('01/01/2022','dd/mm/yyyy'));

INSERT INTO depot VALUES (1, 1, 1, TO_DATE('01/01/2026','dd/mm/yyyy'));
INSERT INTO depot VALUES (2, 1, 2, TO_DATE('02/01/2026','dd/mm/yyyy'));
INSERT INTO depot VALUES (3, 1, 3, TO_DATE('03/01/2026','dd/mm/yyyy'));

-- cas 4 : réparation en cours (etat = 'encours')
--         → DOIT apparaître dans la vue
INSERT INTO reparation VALUES (
    1, 3,
    TO_DATE('05/01/2026','dd/mm/yyyy'),
    TO_DATE('05/01/2026','dd/mm/yyyy'),
    TO_DATE('08/01/2026','dd/mm/yyyy'),
    NULL,
    'encours', NULL, 1
);

-- cas 5 : réparation ouverte, non débutée (etat = 'ouverte')
--         → DOIT apparaître dans la vue
INSERT INTO reparation VALUES (
    2, 5,
    TO_DATE('10/01/2026','dd/mm/yyyy'),
    NULL,
    TO_DATE('15/01/2026','dd/mm/yyyy'),
    NULL,
    'ouverte', NULL, 2
);

-- ============================================================================
-- Jeu de test DOMAINE INVALIDE
-- ============================================================================

-- cas 6 : réparation terminée → NE DOIT PAS apparaître dans la vue
INSERT INTO reparation VALUES (
    3, 2,
    TO_DATE('01/01/2026','dd/mm/yyyy'),
    TO_DATE('01/01/2026','dd/mm/yyyy'),
    TO_DATE('03/01/2026','dd/mm/yyyy'),
    TO_DATE('03/01/2026','dd/mm/yyyy'),
    'terminee', 120, 3
);

COMMIT;

-- ============================================================================
-- Écriture du fichier résultat
-- ============================================================================
SPOOL test_vue_reparations_en_cours.out
PROMPT fichier résultat du test : test_vue_reparations_en_cours.out

PROMPT Contenu de la base :
@../utilitaires/affiche-contenu-base-Magasin-Reparation-Velos.sql

PROMPT 'Contenu de la vue vue_reparations_en_cours :'
SET ECHO ON
@vue_reparations_en_cours.sql

SELECT * FROM vue_reparations_en_cours ORDER BY id_reparation;
SET ECHO OFF

SPOOL OFF
-- ============================================================================
-- Fin du programme de test
-- ============================================================================
