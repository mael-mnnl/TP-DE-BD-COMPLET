-- ============================================================================
-- Fichier : pairesReparations.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Afficher les paires de réparations pour un même vélo
--           (auto-jointure avec r1.id_reparation < r2.id_reparation pour éviter les doublons)
-- Schéma résultat : RES (reparation1, reparation2, num_velo, nom, prenom, date_rep1, date_rep2)
-- ============================================================================

SELECT 
    r1.id_reparation AS reparation1,
    r2.id_reparation AS reparation2,
    v.num_velo,
    c.nom,
    c.prenom,
    r1.date_debut_prevue AS date_rep1,
    r2.date_debut_prevue AS date_rep2
FROM reparation r1
JOIN reparation r2 ON r1.id_velo = r2.id_velo
                   AND r1.id_reparation < r2.id_reparation
JOIN velo   v ON r1.id_velo    = v.id_velo
JOIN depot  d ON v.id_velo     = d.id_velo
JOIN client c ON d.id_client   = c.id_client
ORDER BY v.num_velo, r1.date_debut_prevue;
