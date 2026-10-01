cd ~/DMZ/5i/
mkdir -p $(date +%Y%m%d_T%H%M)_partial/root/sdcard/
file_list=(${(f)"$(ls -tr ~/DMZ/5i/)"})
cd "$file_list[-1]"

filepaths=(
  "Bluetooth"
  "DCIM"
  "Documents"
  "Download"
  "Movies"
  "Music"
  "Pictures"
)
for filepath in ${filepaths[@]}
do
  adb pull -a /sdcard/$filepath .
done
adb kill-server
