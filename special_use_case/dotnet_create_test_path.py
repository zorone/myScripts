from pathlib import Path

p = Path('./test')
if not p.exists():
	p.mkdir()

with open(Path('./result-dedup.txt')) as f:
	for line in f:
		(p/line.strip()).mkdir()

