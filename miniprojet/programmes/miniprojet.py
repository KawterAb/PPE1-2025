# Collez le code ci-dessous (tout le script Python corrigé) :

import sys
import requests
from bs4 import BeautifulSoup
import re

# =======================================================
HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
}
# =======================================================

try:
    url_file_path = sys.argv[1]
except IndexError:
    sys.exit(1)

def count_words(text):
    words = re.findall(r'\b\w+\b', text.lower())
    return len(words)

try:
    with open(url_file_path, 'r', encoding='utf-8') as f:
        urls = [line.strip() for line in f if line.strip()]
except FileNotFoundError:
    sys.exit(1)

line_number = 0

for url in urls:
    line_number += 1
    
    http_code = "N/A"
    encoding = "N/A"
    word_count = "N/A"
    processed_url = url
    
    if not url.startswith('http'):
        processed_url = 'https://' + url
    
    try:
        # Requête HTTP avec le User-Agent corrigé
        response = requests.get(processed_url, headers=HEADERS, timeout=10)
        http_code = str(response.status_code)

        if 200 <= response.status_code < 300:
            encoding = response.encoding if response.encoding else "UTF-8_DEFAULT"
            html_content = response.text
            
            soup = BeautifulSoup(html_content, 'html.parser')
            for script_or_style in soup(['script', 'style', 'header', 'footer']):
                script_or_style.decompose()
                
            text_content = soup.get_text()
            word_count = str(count_words(text_content))
            
    except requests.exceptions.RequestException:
        http_code = "ERREUR CONNEXION"
    except Exception:
        http_code = "ERREUR INCONNUE"

    output_line = f"{line_number}\t{url}\t{http_code}\t{encoding}\t{word_count}"
    print(output_line)

