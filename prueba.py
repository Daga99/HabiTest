import re
from urllib.parse import urlparse
import docx

doc = docx.Document('muestraentrada.docx')

text = []
for paragraph in doc.paragraphs:
    text.append(paragraph.text)
text = ' '.join(text)

urls = re.findall('https?://[\w.-]+\.[a-zA-Z]{2,}', text)

domains = []
for url in urls:
    domain = re.findall('https?://([\w.-]+\.[a-zA-Z]{2,})', url)[0]
    domain = re.sub(r'^https?://(?:www\d*\.)?', '', url)
    domains.append(domain)

print(domains)