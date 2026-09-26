#!/usr/bin/env python

from pathlib import Path
import subprocess
parent = Path('/usr/share/dotnet/sdk')
if(not parent.exists()):
    parent.mkdir()
p = list(parent.glob('*'))

subprocess.run(['sort', '-V'], capture_output=True)
    
with Path('/home/zorone/.config/environment.d/dotnet-path.conf').open('w') as f:
    f.write(f'MSBuildSDKsPath="{str(p[-1])}/Sdks"')
