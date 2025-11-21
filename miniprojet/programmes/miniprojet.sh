#!/usr/bin/env bash

# Validation 1 : Vérification du nombre d'arguments
if [ $# -ne 1 ]; then
    echo "ERREUR : Le script attend exactement un argument (le fichier d'URLs)." >&2
    echo "Usage: $0 <fichier_urls>" >&2
    exit 1
fi

FICHIER_URLS="$1"

# Validation 2 : Vérification de l'existence du fichier
if [ ! -f "$FICHIER_URLS" ]; then
    echo "ERREUR : Le fichier '$FICHIER_URLS' est introuvable." >&2
    exit 1
fi

# 1. Écrire l'entête du document HTML avec Bulma
echo "<!DOCTYPE html>"
echo "<html>"
echo "<head>"
echo "<meta charset=\"UTF-8\">"
echo "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
echo "<title>Résultats Web Scraping - Bulma Style</title>"
echo "<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css\">"
echo "</head>"
echo "<body>"
echo "<section class=\"section\">"
echo "<div class=\"container\">"
echo "<h1 class=\"title is-2\">Rapport de Web Scraping - Résultats</h1>"
echo "<table class=\"table is-bordered is-striped is-narrow is-hoverable is-fullwidth\">"
# 2. Écrire la ligne d'en-tête du tableau (<th>)
echo "<tr><th>numero</th><th>URL</th><th>code</th><th>encodage</th><th>nombre de mots</th></tr>"

lineno=1
while read -r line
do
    # LA LOGIQUE DE TRAITEMENT
    # Ajout du User-Agent pour contourner le 403 (méthode -A)
    data=$(curl -s -i -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" -w "%{http_code}\n%{content_type}" -o ./.data.tmp "$line")
    http_code=$(echo "$data" | head -1)
    
    encoding=$(echo "$data" | tail -1 | grep -oP "charset=\K\S+" | tr -d '";')

    if [ -z "$encoding" ]; then
        encoding="N/A"
    fi

    nbmots=$(cat ./.data.tmp | lynx -dump -nolist -stdin | wc -w)
    
    if [ "$http_code" -ge 400 ] || [ "$http_code" -eq 0 ]; then
        nbmots="N/A"
        if [ "$http_code" -eq 0 ]; then
            http_code="ERREUR CONNEXION"
        fi
        encoding="N/A"
    fi
    # FIN DE LA LOGIQUE DE TRAITEMENT
    
    # 3. Écrire la ligne de résultat au format HTML (<td>)
    echo "<tr>"
    echo "<td>$lineno</td>"
    echo "<td><a href=\"$line\">$line</a></td>"
    echo "<td>$http_code</td>"
    echo "<td>$encoding</td>"
    echo "<td>$nbmots</td>"
    echo "</tr>"

    lineno=$(expr $lineno + 1)
done < "$FICHIER_URLS"

# 4. Fermer les balises HTML
# 4. Fermer les balises HTML et Bulma
echo "</table>"
echo "</div>"
echo "</section>"
echo "</body>"
echo "</html>"
# Nettoyage
rm -f ./.data.tmp
