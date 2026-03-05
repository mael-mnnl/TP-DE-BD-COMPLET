-- ============================================================================
-- Fichier : vue_reparations_clients.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Vue associant chaque réparation au client propriétaire du vélo,
--           via le dépôt. Affiche les informations de la réparation,
--           du vélo et du client.
-- Schéma  : VUE (id_reparation, etat, duree_prevue,
--                date_debut_prevue, date_fin_prevue, cout_total,
--                num_velo, nom, prenom, email, tel)
-- ============================================================================

CREATE OR REPLACE VIEW vue_reparations_clients AS
SELECT
    r.id_reparation,
    r.etat,
    r.duree_prevue,
    r.date_debut_prevue,
    r.date_fin_prevue,
    r.cout_total,
    v.num_velo,
    c.nom,
    c.prenom,
    c.email,
    c.tel
FROM reparation r
JOIN velo v      ON r.id_velo    = v.id_velo
JOIN depot d     ON v.id_velo    = d.id_velo
JOIN client c    ON d.id_client  = c.id_client
ORDER BY r.id_reparation;
