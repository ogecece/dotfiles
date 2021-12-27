#!/usr/bin/env python3

import csv
import json
import re
import subprocess
import unicodedata

INPUT_FILE = 'tgb_1.csv'
OUTPUT_FILE = 'enriched_book_meta_fiction.csv'
LIMITER = 100

with open(OUTPUT_FILE, 'w') as f:
    f.write('Title,Author,Publisher,Year,ISBN\n')

with open(INPUT_FILE) as f:
    source_books = list(csv.reader(f))[1:]

for book in source_books[:LIMITER or -1]:
    source_title = book[1].strip()
    source_author = book[2].strip()
    source_year = book[3].strip()

    print(f'Searching: {source_title}')

    query = unicodedata.normalize('NFKD', f'{source_title} {source_author} {source_year}').encode('ascii', 'ignore').decode('ascii')
    results = subprocess.getoutput(f'isbn_goom "{query}" json')

    processed = ''
    for line in results.strip().split('\n'):
        processed += line.strip()
    most_probable = processed.split('}{', maxsplit=1)[0] + '}' 

    s = most_probable
    while True:
        try:
            result = json.loads(s)   # try to parse...
            break                    # parsing worked -> exit loop
        except Exception as e:
            print(s)
            # "Expecting , delimiter: line 34 column 54 (char 1158)"
            # position of unexpected character after '"'
            unexp = int(re.findall(r'\(char (\d+)\)', str(e))[0])
            # position of unescaped '"' before that
            unesc = s.rfind(r'"', 0, unexp)
            s = s[:unesc] + r'\"' + s[unesc+1:]
            # position of correspondig closing '"' (+2 for inserted '\')
            closg = s.find(r'"', unesc + 2)
            s = s[:closg] + r'\"' + s[closg+1:]

    most_probable = result

    with open(OUTPUT_FILE, 'a') as f:
        title = most_probable['title']
        authors = [author['name'] for author in most_probable['author']]
        publisher = most_probable['publisher']
        year = most_probable['year']

        isbn = [id_['id'] for id_ in most_probable['identifier'] if id_['type'] == 'ISBN']
        if isbn:
            isbn = isbn[0]
        else:
            isbn = ''
            print('ISBN not found')

        f.write(f'{title},{";".join(authors)},{publisher},{year},{isbn}\n')
