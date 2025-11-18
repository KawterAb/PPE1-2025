#!/bin/bash
# Script: compte_par_type_par_an.sh
# Arguments: $1 = Type_Entite
# Lance compte_par_type.sh pour chaque année.

TYPE_ENTITE=$1

echo "Nombre de $TYPE_ENTITE par Année :"

for ANNEE in 2016 2017 2018
do
    COUNT=$(./compte_par_type.sh $ANNEE $TYPE_ENTITE)
    echo "$ANNEE: $COUNT"
done
