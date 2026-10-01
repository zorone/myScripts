#! /bin/python3

import os

scan_path = '/media/kali/4A72269B72268BAF/shared/upload_tmp/'
dst_path = '/media/kali/4A72269B72268BAF/shared/upload/'

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
        os.rename(src=file_name, dst=file_name, src_dir_fd=scan_path, dst_dir_fd=dst_path)

if __name__ == '__main__':
    main()
