#!/bin/bash
# Script: comptes.sh
# Compte le nombre de Locations pour chaque année.

echo "Nombre de Locations par Année :"

# Compte pour 2016
COUNT_2016=$(grep -r "Location" ../Exercice1/ann/2016/*.ann | wc -l)
echo "2016: $COUNT_2016"

# Compte pour 2017
COUNT_2017=$(grep -r "Location" ../Exercice1/ann/2017/*.ann | wc -l)
echo "2017: $COUNT_2017"

# Compte pour 2018
COUNT_2018=$(grep -r "Location" ../Exercice1/ann/2018/*.ann | wc -l)
echo "2018: $COUNT_2018"
