#!/usr/bin/env python3

import os
import re
import sys


with open(sys.argv[1]) as f:
    find_and_replace = f.read().split("----\n")
    find, replace = find_and_replace[0], find_and_replace[1]

match = re.compile(re.escape(find), re.MULTILINE)

filenames = sys.argv[2:]
for filename in filenames:
    with open(filename) as f:
        data = match.sub(replace, f.read())
    with open(filename, 'w') as f:
        f.write(data)
