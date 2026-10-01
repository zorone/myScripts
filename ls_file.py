#! /bin/python3

import os

scan_path = '/media/kali/4A72269B72268BAF/shared/upload_tmp/'

def main():
    with os.scandir(scan_path) as file_list:
        for file in file_list:
            if not file.name.endswith('.tmp') and file.is_file():
                print(file.name)
            else:
                print(f'temp file: {file.name}')

if __name__ == '__main__':
    main()
