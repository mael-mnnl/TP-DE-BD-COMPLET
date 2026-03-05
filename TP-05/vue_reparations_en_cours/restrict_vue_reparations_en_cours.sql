-- ============================================================================
-- Fichier : restrict_vue_reparations_en_cours.sql
-- Auteur  : Mennal Mael
-- Date    : Février 2026
-- Role    : Afficher les restrictions d'utilisation de la vue
--           vue_reparations_en_cours (INSERT, UPDATE, DELETE)
-- ============================================================================

COLUMN COLUMN_NAME FORMAT A25;
COLUMN UPDATABLE   FORMAT A10;
COLUMN INSERTABLE  FORMAT A10;
COLUMN DELETABLE   FORMAT A10;

SPOOL restrict_vue_reparations_en_cours.out
PROMPT fichier résultat du test : restrict_vue_reparations_en_cours.out

SELECT
    COLUMN_NAME,
    UPDATABLE,
    INSERTABLE,
    DELETABLE
FROM USER_UPDATABLE_COLUMNS
WHERE UPPER(TABLE_NAME) = 'VUE_REPARATIONS_EN_COURS'
ORDER BY COLUMN_NAME;

SPOOL OFF
