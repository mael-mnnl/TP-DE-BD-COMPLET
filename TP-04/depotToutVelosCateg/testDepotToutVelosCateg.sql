-- ============================================================================
-- Fichier          : testDepotToutVelosCateg.sql
-- Auteur           : Mennal Mael
-- Date             : Février 2026
-- Role             : Tester l'ordre SQL depotToutVelosCateg.sql
-- Fichier résultat : testDepotToutVelosCateg.out
-- ============================================================================

ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy';

@../utilitaires/vide-contenu-base-Magasin-Reparation-Velos.sql

-- ============================================================================
-- Jeu de test DOMAINE VALIDE
-- ============================================================================

-- cas 1 : 3 catégories de vélos → la division porte sur ces 3 catégories
INSERT INTO categ_velo VALUES (1, 'homme');
INSERT INTO categ_velo VALUES (2, 'femme');
INSERT INTO categ_velo VALUES (3, 'enfant');

-- cas 2 : données de référence minimales
INSERT INTO taille_velo VALUES (1, 'M');
INSERT INTO type_velo   VALUES (1, 'VTT');
INSERT INTO marque_velo VALUES (1, 'btwin');
INSERT INTO adresse     VALUES (1, '10 rue des Fleurs',   'La Rochelle', '17000');
INSERT INTO adresse     VALUES (2, '25 avenue du Port',   'La Rochelle', '17000');
INSERT INTO adresse     VALUES (3, '5 place de la Mairie','Rochefort',   '17300');

-- cas 3 : clients
INSERT INTO client VALUES (1, 'Dupont',  'Jean',   'jean.dupont@email.com',   '0612345678', 1);
INSERT INTO client VALUES (2, 'Martin',  'Sophie', 'sophie.martin@email.com', '0623456789', 2);
INSERT INTO client VALUES (3, 'Bernard', 'Luc',    'luc.bernard@email.com',   '0634567890', 3);

-- cas 4 : vélos dans chacune des 3 catégories
INSERT INTO velo VALUES (1, 'VELO001');  -- catégorie homme
INSERT INTO velo VALUES (2, 'VELO002');  -- catégorie femme
INSERT INTO velo VALUES (3, 'VELO003');  -- catégorie enfant
INSERT INTO velo VALUES (4, 'VELO004');  -- catégorie homme (pour Martin)
INSERT INTO velo VALUES (5, 'VELO005');  -- catégorie femme (pour Martin)

INSERT INTO detail_velo VALUES (1, 1, 1, 1, 1, 1, NULL);  -- VELO001 → homme
INSERT INTO detail_velo VALUES (2, 2, 1, 1, 2, 1, NULL);  -- VELO002 → femme
INSERT INTO detail_velo VALUES (3, 3, 1, 1, 3, 1, NULL);  -- VELO003 → enfant
INSERT INTO detail_velo VALUES (4, 4, 1, 1, 1, 1, NULL);  -- VELO004 → homme
INSERT INTO detail_velo VALUES (5, 5, 1, 1, 2, 1, NULL);  -- VELO005 → femme

-- cas 5 : Dupont dépose les 3 catégories → DOIT apparaître
INSERT INTO depot VALUES (1, 1, 1, TO_DATE('10/01/2023','dd/mm/yyyy'));  -- homme
INSERT INTO depot VALUES (2, 1, 2, TO_DATE('11/01/2023','dd/mm/yyyy'));  -- femme
INSERT INTO depot VALUES (3, 1, 3, TO_DATE('12/01/2023','dd/mm/yyyy'));  -- enfant

-- cas 6 : Martin dépose seulement 2 catégories (homme + femme) → NE DOIT PAS apparaître
INSERT INTO depot VALUES (4, 2, 4, TO_DATE('10/01/2023','dd/mm/yyyy'));  -- homme
INSERT INTO depot VALUES (5, 2, 5, TO_DATE('11/01/2023','dd/mm/yyyy'));  -- femme

-- ============================================================================
-- Jeu de test DOMAINE INVALIDE
-- ============================================================================

-- cas 7 : Bernard sans aucun dépôt → NE DOIT PAS apparaître

COMMIT;

SPOOL testDepotToutVelosCateg.out
PROMPT fichier résultat du test : testDepotToutVelosCateg.out

PROMPT Contenu de la base :
@../utilitaires/affiche-contenu-base-Magasin-Reparation-Velos.sql

PROMPT 'Résultat de la requête:'
SET ECHO ON
@depotToutVelosCateg.sql
SET ECHO OFF

SPOOL OFF
