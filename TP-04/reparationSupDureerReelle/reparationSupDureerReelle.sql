-- ============================================================================
-- Fichier : reparationSupDureerReelle.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Réparations débutées en 2023, terminées,
--           dont la durée réelle est supérieure à la durée prévue.
-- Schéma résultat : RES (r.id_reparation, r.duree_prevue,
--                        r.date_debut_prevue, r.date_fin_prevue,
--                        (r.date_fin_reelle - r.date_debut_reelle) AS "DureeRel(J)")
-- ============================================================================

SELECT
    r.id_reparation,
    r.duree_prevue,
    r.date_debut_prevue,
    r.date_fin_prevue,
    (r.date_fin_reelle - r.date_debut_reelle) AS "DureeRel(J)"
FROM reparation r
WHERE r.etat = 'terminee'
  AND EXTRACT(YEAR FROM r.date_debut_reelle) = 2023
  AND (r.date_fin_reelle - r.date_debut_reelle) > r.duree_prevue
ORDER BY r.id_reparation;
