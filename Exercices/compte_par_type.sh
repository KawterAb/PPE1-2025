#!/bin/bash
# Script: compte_par_type.sh
# Arguments: $1 = Annee, $2 = Type_Entite
# Compte un type d'entité pour une année donnée.

ANNEE=$1
TYPE_ENTITE=$2

# Compte les lignes contenant le type d'entité dans les fichiers ANN de l'année spécifiée
grep -r "$TYPE_ENTITE" ../Exercice1/ann/$ANNEE/*.ann | wc -l
