#!/bin/bash
#
# Script: compte_lieux.sh
# Objectif: Classe les lieux (Locations) les plus cités dans les fichiers ANN.
# Arguments: $1 = Année (* accepte), $2 = Mois (* accepte), $3 = Nombre_Lieux

# --- EXERCICE 3 : Validation des arguments ---
if [ $# -ne 3 ]; then
    echo "Erreur : Ce script nécessite 3 arguments."
    echo "Usage: $0 <Annee|*> <Mois|*> <Nombre_Lieux_a_afficher>"
    exit 1
fi

ANNEE=$1
MOIS=$2
NOMBRE=$3

# --- EXERCICE 2.b : Détermination du chemin d'accès ---
# Nous construisons le chemin en utilisant la structure AAAA/ mise en place.

if [ "$ANNEE" == "*" ]; then
    # Cas 1: Année = * (Recherche dans toutes les années triées)
    CHEMIN="../Exercice1/ann/*/*.ann"
    TITRE="Classement des Lieux (Toutes années confondues) :"
else
    # Cas 2: Année spécifique (Le mois est ignoré dans le chemin car trié uniquement par AAAA)
    CHEMIN="../Exercice1/ann/$ANNEE/*.ann"
    TITRE="Classement des Lieux pour l'année $ANNEE :"
    
    # Si le tri complet AAAA/MM était nécessaire, la ligne suivante serait utilisée :
    # if [ "$MOIS" != "*" ]; then CHEMIN="../Exercice1/ann/$ANNEE/$MOIS/*.ann"; fi
fi

# --- EXERCICE 2.b : Pipeline d'analyse et de classement ---
echo "$TITRE"

grep "Location" $CHEMIN | \
    cut -f 3 | \
    sort | \
    uniq -c | \
    sort -nr | \
    head -n $NOMBRE
