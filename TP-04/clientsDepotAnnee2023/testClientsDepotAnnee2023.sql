-- ============================================================================
-- Fichier          : testClientsDepotAnnee2023.sql
-- Auteur           : Mennal Mael
-- Date             : Février 2026
-- Role             : Tester l'ordre SQL clientsDepotAnnee2023.sql
-- Fichier résultat : testClientsDepotAnnee2023.out
-- ============================================================================

ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy';

@../utilitaires/vide-contenu-base-Magasin-Reparation-Velos.sql

-- ============================================================================
-- Jeu de test DOMAINE VALIDE
-- ============================================================================

-- cas 1 : adresses
INSERT INTO adresse VALUES (1, '10 rue des Fleurs',  'La Rochelle', '17000');
INSERT INTO adresse VALUES (2, '25 avenue du Port',  'La Rochelle', '17000');
INSERT INTO adresse VALUES (3, '5 place de la Mairie', 'Rochefort', '17300');

-- cas 2 : clients
INSERT INTO client VALUES (1, 'Dupont',  'Jean',   'jean.dupont@email.com',   '0612345678', 1);
INSERT INTO client VALUES (2, 'Martin',  'Sophie', 'sophie.martin@email.com', '0623456789', 2);
INSERT INTO client VALUES (3, 'Bernard', 'Luc',    'luc.bernard@email.com',   '0634567890', 3);

-- cas 3 : vélos
INSERT INTO velo VALUES (1, 'VELO001');
INSERT INTO velo VALUES (2, 'VELO002');
INSERT INTO velo VALUES (3, 'VELO003');
INSERT INTO velo VALUES (4, 'VELO004');

-- cas 4 : dépôt en 2023 pour Dupont Jean → DOIT apparaître
INSERT INTO depot VALUES (1, 1, 1, TO_DATE('15/03/2023','dd/mm/yyyy'));

-- cas 5 : dépôt en 2023 pour Martin Sophie → DOIT apparaître
INSERT INTO depot VALUES (2, 2, 2, TO_DATE('20/06/2023','dd/mm/yyyy'));

-- cas 6 : dépôt en 2023 ET en 2022 pour Bernard Luc → DOIT apparaître UNE SEULE FOIS (DISTINCT)
INSERT INTO depot VALUES (3, 3, 3, TO_DATE('10/07/2023','dd/mm/yyyy'));
INSERT INTO depot VALUES (4, 3, 3, TO_DATE('05/11/2022','dd/mm/yyyy'));

-- ============================================================================
-- Jeu de test DOMAINE INVALIDE
-- ============================================================================

-- cas 7 : client ayant déposé uniquement en 2022 → NE DOIT PAS apparaître
INSERT INTO adresse VALUES (4, '12 rue du Commerce', 'Saintes', '17100');
INSERT INTO client  VALUES (4, 'Durand', 'Marie', 'marie.durand@email.com', '0645678901', 4);
INSERT INTO depot   VALUES (5, 4, 4, TO_DATE('01/04/2022','dd/mm/yyyy'));

-- cas 8 : client sans aucun dépôt → NE DOIT PAS apparaître
INSERT INTO client VALUES (5, 'Petit', 'Paul', 'paul.petit@email.com', '0656789012', 1);

COMMIT;

SPOOL testClientsDepotAnnee2023.out
PROMPT fichier résultat du test : testClientsDepotAnnee2023.out

PROMPT Contenu de la base :
@../utilitaires/affiche-contenu-base-Magasin-Reparation-Velos.sql

PROMPT 'Résultat de la requête:'
SET ECHO ON
@clientsDepotAnnee2023.sql
SET ECHO OFF

SPOOL OFF
