-- ============================================================================
-- Fichier          : testClientsVelos.sql
-- Auteur           : Mennal Mael
-- Date             : Février 2026
-- Role             : Tester l'ordre SQL clientsVelos.sql
-- Fichier résultat : testClientsVelos.out
-- ============================================================================

ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy';

@../utilitaires/vide-contenu-base-Magasin-Reparation-Velos.sql

-- ============================================================================
-- Jeu de test DOMAINE VALIDE
-- ============================================================================

-- cas 1 : tailles
INSERT INTO taille_velo VALUES (1, 'S');
INSERT INTO taille_velo VALUES (2, 'M');
INSERT INTO taille_velo VALUES (3, 'L');

-- cas 2 : types
INSERT INTO type_velo VALUES (1, 'VTT');
INSERT INTO type_velo VALUES (2, 'VTC');
INSERT INTO type_velo VALUES (3, 'VAE');

-- cas 3 : catégories
INSERT INTO categ_velo VALUES (1, 'HOMME');
INSERT INTO categ_velo VALUES (2, 'FEMME');
INSERT INTO categ_velo VALUES (3, 'ENFANT');

-- cas 4 : marques
INSERT INTO marque_velo VALUES (1, 'BTWIN');
INSERT INTO marque_velo VALUES (2, 'GITANE');
INSERT INTO marque_velo VALUES (3, 'NAKAMURA');

-- cas 5 : adresses
INSERT INTO adresse VALUES (1, '10 rue des Fleurs',   'La Rochelle', '17000');
INSERT INTO adresse VALUES (2, '25 avenue du Port',   'La Rochelle', '17000');
INSERT INTO adresse VALUES (3, '5 place de la Mairie','Rochefort',   '17300');

-- cas 6 : clients
INSERT INTO client VALUES (1, 'Dupont',  'Jean',   'jean.dupont@email.com',   '0612345678', 1);
INSERT INTO client VALUES (2, 'Martin',  'Sophie', 'sophie.martin@email.com', '0623456789', 2);
INSERT INTO client VALUES (3, 'Bernard', 'Luc',    'luc.bernard@email.com',   '0634567890', 3);

-- cas 7 : vélos
INSERT INTO velo VALUES (1, 'VELO001');
INSERT INTO velo VALUES (2, 'VELO002');
INSERT INTO velo VALUES (3, 'VELO003');

-- cas 8 : détails des vélos
INSERT INTO detail_velo VALUES (1, 1, 1, 1, 1, 2, TO_DATE('01/01/2020','dd/mm/yyyy'));
INSERT INTO detail_velo VALUES (2, 2, 2, 2, 2, 1, TO_DATE('15/06/2021','dd/mm/yyyy'));
INSERT INTO detail_velo VALUES (3, 3, 3, 3, 3, 3, TO_DATE('20/03/2022','dd/mm/yyyy'));

-- cas 9 : dépôts → liaison client-vélo
--         Chaque client dépose un vélo → doit apparaître dans le résultat
INSERT INTO depot VALUES (1, 1, 1, TO_DATE('01/02/2026','dd/mm/yyyy'));
INSERT INTO depot VALUES (2, 2, 2, TO_DATE('02/02/2026','dd/mm/yyyy'));
INSERT INTO depot VALUES (3, 3, 3, TO_DATE('03/02/2026','dd/mm/yyyy'));

COMMIT;

-- ============================================================================
-- Jeu de test DOMAINE INVALIDE
-- ============================================================================

-- cas 10 : client sans vélo déposé → NE DOIT PAS apparaître
INSERT INTO adresse VALUES (4, '12 rue du Commerce', 'Saintes', '17100');
INSERT INTO client VALUES (4, 'Durand', 'Marie', 'marie.durand@email.com', '0645678901', 4);

COMMIT;

SPOOL testClientsVelos.out
PROMPT fichier résultat du test : testClientsVelos.out

PROMPT Contenu de la base :
@../utilitaires/affiche-contenu-base-Magasin-Reparation-Velos.sql

PROMPT 'Résultat de la requête:'
SET ECHO ON
@clientsVelos.sql
SET ECHO OFF

SPOOL OFF
