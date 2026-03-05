# BD2 - Magasin Réparation Vélos

## Mise en place de la base de données

### Prérequis
- Être connecté à la base **INFO1** via SQL*Plus ou SQLcl
- Se placer dans le dossier `PROJET_COMPLET/`

---

### Étape 1 — Initialisation complète (base vierge)

Exécuter **une seule fois** le script d'initialisation :

```sql
SQL> @INIT_COMPLET.sql
```

Ce script fait tout dans l'ordre :
1. Crée les 14 tables
2. Crée les 10 séquences (IDs automatiques)
3. Ajoute les 13 clés étrangères
4. Crée les 3 vues du TP-05
5. Insère les données de référence (marques, types, catégories, tailles)

---

### Étape 2 — Exécuter les TPs

Chaque TP est indépendant. Se placer dans le bon dossier puis lancer le test.

**TP-03**
```
cd TP03/clientsVelos
SQL> @testClientsVelos.sql

cd TP03/pairesReparations
SQL> @testPairesReparations.sql

cd TP03/reparationsOuvertes
SQL> @testReparationsOuvertes.sql
```

**TP-04**
```
cd TP-04/clientsDepotAnnee2023
SQL> @testClientsDepotAnnee2023.sql

cd TP-04/depotToutVelosCateg
SQL> @testDepotToutVelosCateg.sql

cd TP-04/reparationSupDureerReelle
SQL> @testReparationSupDureerReelle.sql
```

**TP-05** — dans chaque sous-dossier, toujours dans cet ordre :
```
SQL> @test_vue_XXX.sql
SQL> @restrict_vue_XXX.sql
SQL> @testinsert_vue_XXX.sql
SQL> @testupdate_vue_XXX.sql   (seulement pour vue_reparations_en_cours)
SQL> @testdelete_vue_XXX.sql   (seulement pour vue_reparations_en_cours)
```

---

### En cas de problème

Si la base est dans un état incohérent, vider toutes les tables :
```sql
SQL> @TP-05/utilitaires/vide-contenu-base-Magasin-Reparation-Velos.sql
```

> Les fichiers `.out` présents dans chaque dossier sont les résultats attendus,  
> ils servent de référence pour vérifier que vos exécutions sont correctes.
