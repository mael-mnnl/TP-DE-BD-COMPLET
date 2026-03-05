-- ============================================================================
-- Fichier          : testReparationSupDureerReelle.sql
-- Auteur           : Mennal Mael
-- Date             : Février 2026
-- Role             : Tester l'ordre SQL reparationSupDureerReelle.sql
-- Fichier résultat : testReparationSupDureerReelle.out
-- ============================================================================

ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy';

@../utilitaires/vide-contenu-base-Magasin-Reparation-Velos.sql

-- ============================================================================
-- Jeu de test DOMAINE VALIDE
-- ============================================================================

-- cas 1 : données de référence minimales
INSERT INTO taille_velo VALUES (1, 'M');
INSERT INTO type_velo   VALUES (1, 'VTT');
INSERT INTO categ_velo  VALUES (1, 'homme');
INSERT INTO marque_velo VALUES (1, 'btwin');
INSERT INTO adresse     VALUES (1, '10 rue des Fleurs', 'La Rochelle', '17000');
INSERT INTO client      VALUES (1, 'Dupont', 'Jean', 'jean.dupont@email.com', '0612345678', 1);

INSERT INTO velo        VALUES (1, 'VELO001');
INSERT INTO velo        VALUES (2, 'VELO002');
INSERT INTO velo        VALUES (3, 'VELO003');

INSERT INTO detail_velo VALUES (1, 1, 1, 1, 1, 1, TO_DATE('01/01/2020','dd/mm/yyyy'));
INSERT INTO detail_velo VALUES (2, 2, 1, 1, 1, 1, TO_DATE('01/01/2020','dd/mm/yyyy'));
INSERT INTO detail_velo VALUES (3, 3, 1, 1, 1, 1, TO_DATE('01/01/2020','dd/mm/yyyy'));

-- cas 2 : réparation débutée en 2023, terminée, durée réelle (5j) > durée prévue (3j)
--         → DOIT apparaître
INSERT INTO reparation VALUES (
    1, 3,
    TO_DATE('10/03/2023','dd/mm/yyyy'), TO_DATE('10/03/2023','dd/mm/yyyy'),
    TO_DATE('13/03/2023','dd/mm/yyyy'), TO_DATE('15/03/2023','dd/mm/yyyy'),
    'terminee', 120, 1
);

-- cas 3 : réparation débutée en 2023, terminée, durée réelle (2j) < durée prévue (5j)
--         → NE DOIT PAS apparaître
INSERT INTO reparation VALUES (
    2, 5,
    TO_DATE('20/04/2023','dd/mm/yyyy'), TO_DATE('20/04/2023','dd/mm/yyyy'),
    TO_DATE('25/04/2023','dd/mm/yyyy'), TO_DATE('22/04/2023','dd/mm/yyyy'),
    'terminee', 80, 2
);

-- cas 4 : réparation débutée en 2023, terminée, durée réelle (4j) = durée prévue (4j)
--         → NE DOIT PAS apparaître (STRICTEMENT supérieure)
INSERT INTO reparation VALUES (
    3, 4,
    TO_DATE('01/06/2023','dd/mm/yyyy'), TO_DATE('01/06/2023','dd/mm/yyyy'),
    TO_DATE('05/06/2023','dd/mm/yyyy'), TO_DATE('05/06/2023','dd/mm/yyyy'),
    'terminee', 60, 3
);

-- ============================================================================
-- Jeu de test DOMAINE INVALIDE
-- ============================================================================

-- cas 5 : réparation débutée en 2022, terminée, durée réelle > durée prévue
--         → NE DOIT PAS apparaître (année ≠ 2023)
INSERT INTO reparation VALUES (
    4, 2,
    TO_DATE('05/05/2022','dd/mm/yyyy'), TO_DATE('05/05/2022','dd/mm/yyyy'),
    TO_DATE('07/05/2022','dd/mm/yyyy'), TO_DATE('10/05/2022','dd/mm/yyyy'),
    'terminee', 90, 1
);

-- cas 6 : réparation débutée en 2023, NON terminée (encours), durée réelle > durée prévue
--         → NE DOIT PAS apparaître (pas terminée)
INSERT INTO reparation VALUES (
    5, 1,
    TO_DATE('15/09/2023','dd/mm/yyyy'), TO_DATE('15/09/2023','dd/mm/yyyy'),
    TO_DATE('16/09/2023','dd/mm/yyyy'), NULL,
    'encours', NULL, 2
);

COMMIT;

SPOOL testReparationSupDureerReelle.out
PROMPT fichier résultat du test : testReparationSupDureerReelle.out

PROMPT Contenu de la base :
@../utilitaires/affiche-contenu-base-Magasin-Reparation-Velos.sql

PROMPT 'Résultat de la requête:'
SET ECHO ON
@reparationSupDureerReelle.sql
SET ECHO OFF

SPOOL OFF
