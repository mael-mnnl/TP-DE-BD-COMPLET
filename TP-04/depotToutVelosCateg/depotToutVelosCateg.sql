-- ============================================================================
-- Fichier : depotToutVelosCateg.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Clients ayant déposé des vélos de TOUTES les catégories
--           (division relationnelle via double NOT EXISTS)
-- Schéma résultat : RES (c.nom, c.prenom)
-- ============================================================================

SELECT DISTINCT
    c.nom,
    c.prenom
FROM client c
WHERE NOT EXISTS (
    -- Il n'existe pas de catégorie...
    SELECT 1
    FROM categ_velo cv
    WHERE NOT EXISTS (
        -- ...pour laquelle ce client n'a PAS déposé un vélo de cette catégorie
        SELECT 1
        FROM depot d
        JOIN detail_velo dv ON dv.id_velo = d.id_velo
        WHERE d.id_client = c.id_client
          AND dv.id_categ = cv.id_categ
    )
)
ORDER BY c.nom, c.prenom;
