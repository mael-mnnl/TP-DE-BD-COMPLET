-- ============================================================================
-- Fichier          : test_vue_stats_reparateur_types_velos.sql
-- Auteur           : Mennal Mael
-- Date             : Février 2026
-- Role             : Tester la vue vue_stats_reparateur_types_velos
-- Fichier résultat : test_vue_stats_reparateur_types_velos.out
-- ============================================================================

ALTER SESSION SET nls_date_format='dd/mm/yyyy';

-- Vider la base
@../utilitaires/vide-contenu-base-Magasin-Reparation-Velos.sql

-- ============================================================================
-- Jeu de test DOMAINE VALIDE
-- ============================================================================

-- cas 1 : données de référence minimales
INSERT INTO taille_velo  VALUES (1, 'M');
INSERT INTO categ_velo   VALUES (1, 'HOMME');
INSERT INTO marque_velo  VALUES (1, 'BTWIN');

-- cas 2 : deux types de vélo
INSERT INTO type_velo VALUES (1, 'VTT');
INSERT INTO type_velo VALUES (2, 'VTC');

-- cas 3 : deux réparateurs
INSERT INTO reparateur VALUES (1, 'michelo');
INSERT INTO reparateur VALUES (2, 'julie_b');

-- cas 4 : adresse et client (nécessaires pour les dépôts)
INSERT INTO adresse VALUES (1, '10 rue des Fleurs', 'La Rochelle', '17000');
INSERT INTO client  VALUES (1, 'Dupont', 'Jean', 'jean.dupont@email.com', '0612345678', 1);

-- cas 5 : trois vélos de types différents
INSERT INTO velo        VALUES (1, 'VELO001');   -- type VTT
INSERT INTO velo        VALUES (2, 'VELO002');   -- type VTC
INSERT INTO velo        VALUES (3, 'VELO003');   -- type VTT
INSERT INTO detail_velo VALUES (1, 1, 1, 1, 1, 1, NULL);  -- VTT
INSERT INTO detail_velo VALUES (2, 2, 1, 2, 1, 1, NULL);  -- VTC
INSERT INTO detail_velo VALUES (3, 3, 1, 1, 1, 1, NULL);  -- VTT

-- cas 6 : dépôts
INSERT INTO depot VALUES (1, 1, 1, TO_DATE('01/01/2026','dd/mm/yyyy'));
INSERT INTO depot VALUES (2, 1, 2, TO_DATE('02/01/2026','dd/mm/yyyy'));
INSERT INTO depot VALUES (3, 1, 3, TO_DATE('03/01/2026','dd/mm/yyyy'));

-- cas 7 : réparations
INSERT INTO reparation VALUES (1, 3, TO_DATE('05/01/2026','dd/mm/yyyy'), TO_DATE('05/01/2026','dd/mm/yyyy'),
    TO_DATE('08/01/2026','dd/mm/yyyy'), TO_DATE('09/01/2026','dd/mm/yyyy'), 'terminee', 80, 1);
INSERT INTO reparation VALUES (2, 2, TO_DATE('06/01/2026','dd/mm/yyyy'), TO_DATE('06/01/2026','dd/mm/yyyy'),
    TO_DATE('08/01/2026','dd/mm/yyyy'), TO_DATE('08/01/2026','dd/mm/yyyy'), 'terminee', 60, 2);
INSERT INTO reparation VALUES (3, 1, TO_DATE('07/01/2026','dd/mm/yyyy'), TO_DATE('07/01/2026','dd/mm/yyyy'),
    TO_DATE('08/01/2026','dd/mm/yyyy'), TO_DATE('08/01/2026','dd/mm/yyyy'), 'terminee', 40, 3);

-- cas 8 : opérations
-- michelo fait 2 opérations sur des VTT (réparations 1 et 3)
INSERT INTO operation VALUES (1, 'Changement roue AR', 1, TO_DATE('05/01/2026','dd/mm/yyyy'),
    TO_DATE('06/01/2026','dd/mm/yyyy'), 'terminee', 50, 1, 1);
INSERT INTO operation VALUES (2, 'Réglage freins',     1, TO_DATE('07/01/2026','dd/mm/yyyy'),
    TO_DATE('08/01/2026','dd/mm/yyyy'), 'terminee', 30, 3, 1);
-- julie_b fait 1 opération sur un VTC (réparation 2) et 1 opération sur un VTT (réparation 1)
INSERT INTO operation VALUES (3, 'Remplacement câble', 1, TO_DATE('06/01/2026','dd/mm/yyyy'),
    TO_DATE('07/01/2026','dd/mm/yyyy'), 'terminee', 40, 2, 2);
INSERT INTO operation VALUES (4, 'Graissage chaîne',   1, TO_DATE('05/01/2026','dd/mm/yyyy'),
    TO_DATE('06/01/2026','dd/mm/yyyy'), 'terminee', 20, 1, 2);

-- ============================================================================
-- Jeu de test DOMAINE INVALIDE
-- ============================================================================

-- cas 9 : réparateur sans aucune opération → NE DOIT PAS apparaître dans la vue
--         (pas de GROUP BY sans lignes)
-- (aucun reparateur supplémentaire ajouté ici, michelo et julie_b ont tous les deux des ops)

COMMIT;

-- ============================================================================
-- Écriture du fichier résultat
-- ============================================================================
SPOOL test_vue_stats_reparateur_types_velos.out
PROMPT fichier résultat du test : test_vue_stats_reparateur_types_velos.out

PROMPT Contenu de la base :
@../utilitaires/affiche-contenu-base-Magasin-Reparation-Velos.sql

PROMPT 'Contenu de la vue vue_stats_reparateur_types_velos :'
SET ECHO ON
@vue_stats_reparateur_types_velos.sql

SELECT * FROM vue_stats_reparateur_types_velos;
SET ECHO OFF

SPOOL OFF
-- ============================================================================
-- Fin du programme de test
-- ============================================================================
