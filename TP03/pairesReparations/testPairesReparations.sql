-- ============================================================================
-- Fichier          : testPairesReparations.sql
-- Auteur           : Mennal Mael
-- Date             : Février 2026
-- Role             : Tester l'ordre SQL pairesReparations.sql
-- Fichier résultat : testPairesReparations.out
-- ============================================================================

ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy';

@../utilitaires/vide-contenu-base-Magasin-Reparation-Velos.sql

-- cas 1 : données de référence
INSERT INTO taille_velo VALUES (1, 'M');
INSERT INTO type_velo   VALUES (1, 'VTT');
INSERT INTO categ_velo  VALUES (1, 'HOMME');
INSERT INTO marque_velo VALUES (1, 'BTWIN');
INSERT INTO adresse     VALUES (1, '10 rue des Fleurs', 'La Rochelle', '17000');
INSERT INTO client      VALUES (1, 'Dupont', 'Jean', 'jean.dupont@email.com', '0612345678', 1);

-- cas 2 : deux vélos
INSERT INTO velo        VALUES (1, 'VELO001');
INSERT INTO velo        VALUES (2, 'VELO002');
INSERT INTO detail_velo VALUES (1, 1, 1, 1, 1, 1, TO_DATE('01/01/2020','dd/mm/yyyy'));
INSERT INTO detail_velo VALUES (2, 2, 1, 1, 1, 1, TO_DATE('15/06/2021','dd/mm/yyyy'));

-- cas 3 : dépôts
INSERT INTO depot VALUES (1, 1, 1, TO_DATE('01/02/2026','dd/mm/yyyy'));
INSERT INTO depot VALUES (2, 1, 2, TO_DATE('02/02/2026','dd/mm/yyyy'));

-- cas 4 : 3 réparations sur VELO001 → 3 paires (1,2), (1,3), (2,3)
INSERT INTO reparation VALUES (1, 5, TO_DATE('05/02/2026','dd/mm/yyyy'), TO_DATE('05/02/2026','dd/mm/yyyy'),
    TO_DATE('10/02/2026','dd/mm/yyyy'), NULL, 'encours', NULL, 1);
INSERT INTO reparation VALUES (2, 3, TO_DATE('15/02/2026','dd/mm/yyyy'), NULL,
    TO_DATE('18/02/2026','dd/mm/yyyy'), NULL, 'ouverte', NULL, 1);
INSERT INTO reparation VALUES (3, 2, TO_DATE('25/02/2026','dd/mm/yyyy'), NULL,
    TO_DATE('27/02/2026','dd/mm/yyyy'), NULL, 'ouverte', NULL, 1);

-- cas 5 : 1 seule réparation pour VELO002 → NE FORME PAS de paire
INSERT INTO reparation VALUES (4, 4, TO_DATE('10/02/2026','dd/mm/yyyy'), NULL,
    TO_DATE('14/02/2026','dd/mm/yyyy'), NULL, 'ouverte', NULL, 2);

COMMIT;

SPOOL testPairesReparations.out
PROMPT fichier résultat du test : testPairesReparations.out

PROMPT Contenu de la base :
@../utilitaires/affiche-contenu-base-Magasin-Reparation-Velos.sql

PROMPT 'Résultat de la requête:'
SET ECHO ON
@pairesReparations.sql
SET ECHO OFF

SPOOL OFF
