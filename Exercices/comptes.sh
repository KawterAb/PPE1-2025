#!/bin/bash
# Script: comptes.sh (Version avec boucle)
# Compte le nombre de Locations pour chaque année en utilisant une boucle.

echo "Nombre de Locations par Année :"

for ANNEE in 2016 2017 2018
do
    # Compte les lignes contenant le terme "Location" pour l'année courante
    COUNT=$(grep -r "Location" ../Exercice1/ann/$ANNEE/*.ann | wc -l)
    echo "$ANNEE: $COUNT"
done
