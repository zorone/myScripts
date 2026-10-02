from pathlib import Path

p = Path('./test')
if not p.exists():
	p.mkdir()

with open(Path('./result-dedup.txt')) as f:
	for line in f:
		line_strip = line.strip().replace('"', '')
		(p/line.strip()).mkdir(exist_ok=True)
		(p/line.strip()/'.gitkeep').touch()

