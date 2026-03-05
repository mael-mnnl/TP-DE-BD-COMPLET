-- ============================================================================
-- Fichier          : testReparationsOuvertes.sql
-- Auteur           : Mennal Mael
-- Date             : Février 2026
-- Role             : Tester l'ordre SQL reparationsOuvertes.sql
-- Fichier résultat : testReparationsOuvertes.out
-- ============================================================================

ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy';

@../utilitaires/vide-contenu-base-Magasin-Reparation-Velos.sql

-- cas 1 : données de référence
INSERT INTO taille_velo VALUES (1, 'M');
INSERT INTO type_velo   VALUES (1, 'VTT');
INSERT INTO categ_velo  VALUES (1, 'HOMME');
INSERT INTO marque_velo VALUES (1, 'BTWIN');
INSERT INTO adresse     VALUES (1, '10 rue des Fleurs', 'La Rochelle', '17000');
INSERT INTO adresse     VALUES (2, '25 avenue du Port', 'La Rochelle', '17000');
INSERT INTO client      VALUES (1, 'Dupont',  'Jean',   'jean.dupont@email.com',   '0612345678', 1);
INSERT INTO client      VALUES (2, 'Martin',  'Sophie', 'sophie.martin@email.com', '0623456789', 2);

-- cas 2 : deux vélos
INSERT INTO velo        VALUES (1, 'VELO001');
INSERT INTO velo        VALUES (2, 'VELO002');
INSERT INTO detail_velo VALUES (1, 1, 1, 1, 1, 1, TO_DATE('01/01/2020','dd/mm/yyyy'));
INSERT INTO detail_velo VALUES (2, 2, 1, 1, 1, 1, TO_DATE('15/06/2021','dd/mm/yyyy'));
INSERT INTO depot       VALUES (1, 1, 1, TO_DATE('01/02/2026','dd/mm/yyyy'));
INSERT INTO depot       VALUES (2, 2, 2, TO_DATE('02/02/2026','dd/mm/yyyy'));

-- cas 3 : réparation en cours → DOIT apparaître
INSERT INTO reparation VALUES (1, 5, TO_DATE('05/02/2026','dd/mm/yyyy'), TO_DATE('05/02/2026','dd/mm/yyyy'),
    TO_DATE('10/02/2026','dd/mm/yyyy'), NULL, 'encours', NULL, 1);

-- cas 4 : réparation ouverte, non commencée → DOIT apparaître
INSERT INTO reparation VALUES (2, 3, TO_DATE('08/02/2026','dd/mm/yyyy'), NULL,
    TO_DATE('11/02/2026','dd/mm/yyyy'), NULL, 'ouverte', NULL, 2);

-- ============================================================================
-- Jeu de test DOMAINE INVALIDE
-- ============================================================================

-- cas 5 : réparation terminée → NE DOIT PAS apparaître
INSERT INTO reparation VALUES (3, 2, TO_DATE('01/02/2026','dd/mm/yyyy'), TO_DATE('01/02/2026','dd/mm/yyyy'),
    TO_DATE('03/02/2026','dd/mm/yyyy'), TO_DATE('03/02/2026','dd/mm/yyyy'), 'terminee', 150, 1);

COMMIT;

SPOOL testReparationsOuvertes.out
PROMPT fichier résultat du test : testReparationsOuvertes.out

PROMPT Contenu de la base :
@../utilitaires/affiche-contenu-base-Magasin-Reparation-Velos.sql

PROMPT 'Résultat de la requête:'
SET ECHO ON
@reparationsOuvertes.sql
SET ECHO OFF

SPOOL OFF
