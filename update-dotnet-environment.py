#!/usr/bin/env python

from pathlib import Path
import subprocess
parent = Path('/usr/share/dotnet/sdk')
if(not parent.exists()):
    parent.mkdir()
p = list(parent.glob('*'))
p = [path.name for path in p]
pp = bytes('\n'.join(p), encoding='utf-8')

proc = subprocess.run(['sort', '-V'], input=pp, capture_output=True)
    
with Path('/home/zorone/.config/environment.d/dotnet-path.conf').open('w') as f:
    f.write(f'MSBuildSDKsPath="{str(parent)}/{proc.stdout.split()[-1].decode()}/Sdks"')
