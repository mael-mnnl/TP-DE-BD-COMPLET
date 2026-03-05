-- ============================================================================
-- Fichier : restrict_vue_stats_reparateur_types_velos.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Afficher les restrictions d'utilisation de la vue
--           vue_stats_reparateur_types_velos (INSERT, UPDATE, DELETE)
-- ============================================================================

COLUMN COLUMN_NAME FORMAT A25;
COLUMN UPDATABLE   FORMAT A10;
COLUMN INSERTABLE  FORMAT A10;
COLUMN DELETABLE   FORMAT A10;

SPOOL restrict_vue_stats_reparateur_types_velos.out
PROMPT fichier résultat du test : restrict_vue_stats_reparateur_types_velos.out

SELECT
    COLUMN_NAME,
    UPDATABLE,
    INSERTABLE,
    DELETABLE
FROM USER_UPDATABLE_COLUMNS
WHERE UPPER(TABLE_NAME) = 'VUE_STATS_REPARATEUR_TYPES_VELOS'
ORDER BY COLUMN_NAME;

SPOOL OFF
