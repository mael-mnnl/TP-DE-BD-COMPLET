-- ============================================================================
-- Fichier          : test_vue_reparations_clients.sql
-- Auteur           : Mennal Mael
-- Date             : Février 2026
-- Role             : Tester la vue vue_reparations_clients
-- Fichier résultat : test_vue_reparations_clients.out
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

-- cas 2 : deux adresses et deux clients
INSERT INTO adresse VALUES (1, '10 rue des Fleurs',  'La Rochelle', '17000');
INSERT INTO adresse VALUES (2, '25 avenue du Port',  'La Rochelle', '17000');
INSERT INTO client  VALUES (1, 'Dupont',  'Jean',   'jean.dupont@email.com',   '0612345678', 1);
INSERT INTO client  VALUES (2, 'Martin',  'Sophie', 'sophie.martin@email.com', '0623456789', 2);

-- cas 3 : deux vélos
INSERT INTO velo        VALUES (1, 'VELO001');
INSERT INTO velo        VALUES (2, 'VELO002');
INSERT INTO detail_velo VALUES (1, 1, 1, 1, 1, 1, TO_DATE('01/01/2020','dd/mm/yyyy'));
INSERT INTO detail_velo VALUES (2, 2, 1, 1, 1, 1, TO_DATE('15/06/2021','dd/mm/yyyy'));

-- cas 4 : dépôts
--         Dupont dépose VELO001, Martin dépose VELO002
INSERT INTO depot VALUES (1, 1, 1, TO_DATE('01/01/2026','dd/mm/yyyy'));
INSERT INTO depot VALUES (2, 2, 2, TO_DATE('02/01/2026','dd/mm/yyyy'));

-- cas 5 : réparations associées aux vélos
--         → les deux doivent apparaître dans la vue avec le bon client
INSERT INTO reparation VALUES (
    1, 3,
    TO_DATE('05/01/2026','dd/mm/yyyy'),
    TO_DATE('05/01/2026','dd/mm/yyyy'),
    TO_DATE('08/01/2026','dd/mm/yyyy'),
    NULL,
    'encours', NULL, 1
);
INSERT INTO reparation VALUES (
    2, 5,
    TO_DATE('10/01/2026','dd/mm/yyyy'),
    NULL,
    TO_DATE('15/01/2026','dd/mm/yyyy'),
    TO_DATE('14/01/2026','dd/mm/yyyy'),
    'terminee', 150, 2
);

-- ============================================================================
-- Jeu de test DOMAINE INVALIDE
-- ============================================================================

-- cas 6 : vélo sans dépôt → sa réparation n'apparaît PAS dans la vue
--         (pas de jointure possible avec client via depot)
INSERT INTO velo        VALUES (3, 'VELO003');
INSERT INTO detail_velo VALUES (3, 3, 1, 1, 1, 1, TO_DATE('01/01/2022','dd/mm/yyyy'));
INSERT INTO reparation VALUES (
    3, 2,
    TO_DATE('12/01/2026','dd/mm/yyyy'),
    NULL,
    TO_DATE('14/01/2026','dd/mm/yyyy'),
    NULL,
    'ouverte', NULL, 3
);

COMMIT;

-- ============================================================================
-- Écriture du fichier résultat
-- ============================================================================
SPOOL test_vue_reparations_clients.out
PROMPT fichier résultat du test : test_vue_reparations_clients.out

PROMPT Contenu de la base :
@../utilitaires/affiche-contenu-base-Magasin-Reparation-Velos.sql

PROMPT 'Contenu de la vue vue_reparations_clients :'
SET ECHO ON
@vue_reparations_clients.sql

SELECT * FROM vue_reparations_clients;
SET ECHO OFF

SPOOL OFF
-- ============================================================================
-- Fin du programme de test
-- ============================================================================
