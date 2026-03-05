-- ============================================================================
-- Fichier : reparationsOuvertes.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Afficher les réparations non terminées
--           avec le vélo et le client associé
-- Schéma résultat : RES (id_reparation, num_velo, nom, prenom,
--                        date_debut_prevue, date_fin_prevue, etat, cout_total)
-- ============================================================================

SELECT 
    r.id_reparation,
    v.num_velo,
    c.nom,
    c.prenom,
    r.date_debut_prevue,
    r.date_fin_prevue,
    r.etat,
    r.cout_total
FROM reparation r
JOIN velo   v ON r.id_velo    = v.id_velo
JOIN depot  d ON v.id_velo    = d.id_velo
JOIN client c ON d.id_client  = c.id_client
WHERE r.etat != 'terminee'
ORDER BY r.date_debut_prevue;
