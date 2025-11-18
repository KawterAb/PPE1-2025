# Journal de bord du projet encadré
## Travail du jour 
Aujourd'hui, j'ai appris à configurer ma clé SSH, cloner le dépôt, et utiliser git add/commit/push.

- Création du dépôt GitHub `PPE1-2025`
- Configuration de la clé SSH et clonage du dépôt en local
- Création du fichier `journal.md`
- Ajout, commit et push du fichier vers GitHub
- Ajout du fichier `.gitignore` pour ignorer `.DS_Store`


## Scripts Bash
4ème exercice :
Lire le code de la dernière diapo et décrire son fonctionnement dans votre journal de bord:

Le code utilise un pipeline (enchaînement de commandes via |) dans le script compte_lieux.sh pour effectuer le classement des entités "Location".

1. grep "Location" : Filtre les lignes des fichiers ANN pour n'obtenir que les entités de lieu.
2. cut -f 3 : Extrait le nom du lieu (le troisième champ) en supposant un format standard.
3. sort : Trie la liste des noms de lieux pour regrouper les doublons.
4. uniq -c : Compte le nombre d'occurrences pour chaque lieu unique (le plus important).
5. sort -nr : Trie numériquement (-n) et dans l'ordre décroissant (-r) les résultats de comptage.
6. head -n $NOMBRE : Affiche les N premiers résultats pour présenter le classement demandé.
