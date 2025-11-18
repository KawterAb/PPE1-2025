#!/usr/bin/env bash

# Validation 1 : Vérification du nombre d'arguments
if [ $# -ne 1 ]; then
    echo "ERREUR : Le script attend exactement un argument (le fichier d'URLs)." >&2
    echo "Usage: $0 <fichier_urls>" >&2
    exit 1
fi

FICHIER_URLS="$1"

# Validation 2 : Vérification de l'existence du fichier (ajouté pour être plus robuste)
if [ ! -f "$FICHIER_URLS" ]; then
    echo "ERREUR : Le fichier '$FICHIER_URLS' est introuvable." >&2
    exit 1
fi

# Affichage de l'en-tête (pour le TSV, l'en-tête est une ligne simple)
echo -e "numero\tURL\tcode\tencodage\tnombre de mots"

lineno=1
while read -r line
do
    # 1. Utilisation de cURL pour récupérer les données et les métadonnées
    # -s: Silent (silencieux), -i: Inclure les en-têtes, -L: Suivre les redirections
    # -w: Afficher le code HTTP et le Content-Type
    # -o: Sauvegarder le corps de la page dans un fichier temporaire
    data=$(curl -s -i -L -w "%{http_code}\n%{content_type}" -o ./.data.tmp "$line")
    http_code=$(echo "$data" | head -1)
    
    encoding=$(echo "$data" | tail -1 | grep -oP "charset=\K\S+" | tr -d '";')

    # Si l'encodage est vide (n'a pas pu être détecté), on met "N/A"
    if [ -z "$encoding" ]; then
        encoding="N/A"
    fi

    # 2. Comptage des mots : Utilisation de lynx (pour extraire le texte) puis wc (pour compter les mots)
    nbmots=$(cat ./.data.tmp | lynx -dump -nolist -stdin | wc -w)
    
    # Gérer les échecs de connexion (où nbmots serait 0 car .data.tmp serait vide ou erreur)
    if [ "$http_code" -ge 400 ] || [ "$http_code" -eq 0 ]; then
        nbmots="N/A"
        if [ "$http_code" -eq 0 ]; then
            http_code="ERREUR CONNEXION"
        fi
        encoding="N/A"
    fi
    
    # Affichage du résultat au format TSV (Séparé par des tabulations)
    echo -e "$lineno\t$line\t$http_code\t$encoding\t$nbmots"

    lineno=$(expr $lineno + 1)
done < "$FICHIER_URLS"

# Nettoyage du fichier temporaire à la fin
rm -f ./.data.tmp
