#! /bin/python3

import os
import sys
from time import sleep

scan_path = str()
dst_path = str()

def main():
    file_list = list()
    with os.scandir(scan_path) as entry_list:
        for entry in entry_list:
            if not entry.name.endswith('.tmp') and entry.is_file():
                file_list += [entry.name]
                print(file_list)
            elif entry.is_dir():
                print(f'folder: {entry.name}')
                print('Not move!')
            else:
                print(f'temp file: {entry.name}')
                print('Not move!')

    print(f'Final file_list: {file_list}')
    for file_name in file_list:
        print(f'Moving from {scan_path}{file_name} to {dst_path}{file_name}')
        os.rename(src=f'{scan_path}{file_name}', dst=f'{dst_path}{file_name}')

if __name__ == '__main__':
    argc = len(sys.argv[1:])
    if argc != 2:
        print(f'Error: Unknown arguments')
        print(f'       Expected 2, but got {argc}')
        sys.exit(1)

    scan_path = sys.argv[1]
    dst_path = sys.argv[2]
    print(f'scan_path = {scan_path}')
    print(f'dst_path = {dst_path}')
    sleep(5)

    main()
