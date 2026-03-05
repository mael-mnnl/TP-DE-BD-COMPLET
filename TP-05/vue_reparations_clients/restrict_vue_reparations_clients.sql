-- ============================================================================
-- Fichier : restrict_vue_reparations_clients.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Afficher les restrictions d'utilisation de la vue
--           vue_reparations_clients (INSERT, UPDATE, DELETE)
-- ============================================================================

COLUMN COLUMN_NAME FORMAT A25;
COLUMN UPDATABLE   FORMAT A10;
COLUMN INSERTABLE  FORMAT A10;
COLUMN DELETABLE   FORMAT A10;

SPOOL restrict_vue_reparations_clients.out
PROMPT fichier résultat du test : restrict_vue_reparations_clients.out

SELECT
    COLUMN_NAME,
    UPDATABLE,
    INSERTABLE,
    DELETABLE
FROM USER_UPDATABLE_COLUMNS
WHERE UPPER(TABLE_NAME) = 'VUE_REPARATIONS_CLIENTS'
ORDER BY COLUMN_NAME;

SPOOL OFF
