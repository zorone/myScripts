#! /usr/bin/env python3

from pathlib import Path

with open(Path('/home/zorone/git/dotnet/json/result.json')) as f:
	with open(Path('./result-dedup.txt'), 'w') as f2:
		paths = set()
		for line in f:
			line_strip = line.strip()
			if line_strip == 'null':
				continue
			if not line_strip in paths:
				paths.add(line_strip)
				f2.write(line)
