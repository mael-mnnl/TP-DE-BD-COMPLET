-- ============================================================================
-- Fichier : clientsDepotAnnee2023.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Clients ayant déposé au moins un vélo durant l'année 2023
-- Schéma résultat : RES (c.nom, c.prenom)
-- ============================================================================

SELECT DISTINCT
    c.nom,
    c.prenom
FROM client c
JOIN depot d ON d.id_client = c.id_client
WHERE EXTRACT(YEAR FROM d.date_depot) = 2023
ORDER BY c.nom, c.prenom;
