-- ============================================================================
-- Fichier : vue_stats_reparateur_types_velos.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Vue statistique : pour chaque réparateur et chaque type de vélo,
--           affiche le nombre d'opérations réalisées et le coût total.
-- Schéma  : VUE (login, type_velo, nb_operations, cout_total)
-- ============================================================================

CREATE OR REPLACE VIEW vue_stats_reparateur_types_velos AS
SELECT
    rep.login,
    tv.libelle       AS type_velo,
    COUNT(op.id_operation)  AS nb_operations,
    SUM(op.cout)            AS cout_total
FROM reparateur rep
JOIN operation   op  ON rep.id_reparateur = op.id_reparateur
JOIN reparation  r   ON op.id_reparation  = r.id_reparation
JOIN velo        v   ON r.id_velo         = v.id_velo
JOIN detail_velo dv  ON v.id_velo         = dv.id_velo
JOIN type_velo   tv  ON dv.id_type        = tv.id_type
GROUP BY rep.login, tv.libelle
ORDER BY rep.login, tv.libelle;
