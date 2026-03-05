-- ============================================================================
-- Fichier : testinsert_vue_reparations_clients.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Tester l'insertion via la vue vue_reparations_clients
--           (vue en lecture seule → doit échouer)
-- Fichier résultat : testinsert_vue_reparations_clients.out
-- ============================================================================

ALTER SESSION SET nls_date_format='dd/mm/yyyy';

-- Vider la base
@../utilitaires/vide-contenu-base-Magasin-Reparation-Velos.sql

-- ============================================================================
-- Données de référence minimales
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

-- Créer la vue
@vue_reparations_clients.sql

COMMIT;

-- ============================================================================
-- Fichier résultat
-- ============================================================================
SPOOL testinsert_vue_reparations_clients.out
PROMPT fichier résultat du test : testinsert_vue_reparations_clients.out

PROMPT --- Contenu de la vue AVANT insertion ---
SELECT * FROM vue_reparations_clients;

SET ECHO ON

-- cas 1 : tentative d'INSERT dans une vue en lecture seule (jointure sur 4 tables)
--         → DOIT ÉCHOUER : la vue est non modifiable (pas de table préservée par clé unique)
INSERT INTO vue_reparations_clients
    (id_reparation, etat, duree_prevue, date_debut_prevue, date_fin_prevue, num_velo, nom, prenom, email, tel)
VALUES
    (99, 'encours', 3, TO_DATE('20/01/2026','dd/mm/yyyy'), TO_DATE('23/01/2026','dd/mm/yyyy'),
     'VELO001', 'Dupont', 'Jean', 'jean.dupont@email.com', '0612345678');

SET ECHO OFF

PROMPT --- Contenu de la vue APRÈS tentative d'insertion ---
SELECT * FROM vue_reparations_clients;

SPOOL OFF
-- ============================================================================
-- Fin du programme de test
-- ============================================================================
