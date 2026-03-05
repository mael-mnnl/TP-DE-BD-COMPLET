-- ============================================================================
-- Fichier : vue_reparations_en_cours.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Vue des réparations en cours (etat != 'terminee')
--           avec les informations du vélo associé
-- Schéma  : VUE (id_reparation, etat, duree_prevue,
--                date_debut_prevue, date_fin_prevue,
--                date_debut_reelle, date_fin_reelle,
--                cout_total, id_velo, num_velo)
-- ============================================================================

CREATE OR REPLACE VIEW vue_reparations_en_cours AS
SELECT
    r.id_reparation,
    r.etat,
    r.duree_prevue,
    r.date_debut_prevue,
    r.date_fin_prevue,
    r.date_debut_reelle,
    r.date_fin_reelle,
    r.cout_total,
    v.id_velo,
    v.num_velo
FROM reparation r
JOIN velo v ON r.id_velo = v.id_velo
WHERE r.etat != 'terminee';
