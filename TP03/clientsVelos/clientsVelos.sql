-- ============================================================================
-- Fichier : clientsVelos.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Afficher la liste des clients avec leurs vélos déposés
-- Schéma résultat : RES (nom, prenom, email, num_velo, marque, type, categorie, taille)
-- ============================================================================

SELECT 
    c.nom,
    c.prenom,
    c.email,
    v.num_velo,
    m.libelle  AS marque,
    t.libelle  AS type,
    cat.libelle AS categorie,
    ta.libelle  AS taille
FROM client c
JOIN depot       d   ON c.id_client  = d.id_client
JOIN velo        v   ON d.id_velo    = v.id_velo
JOIN detail_velo dv  ON v.id_velo    = dv.id_velo
JOIN marque_velo m   ON dv.id_marque = m.id_marque
JOIN type_velo   t   ON dv.id_type   = t.id_type
JOIN categ_velo  cat ON dv.id_categ  = cat.id_categ
JOIN taille_velo ta  ON dv.id_taille = ta.id_taille
ORDER BY c.nom, c.prenom;
