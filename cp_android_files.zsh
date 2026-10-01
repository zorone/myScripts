cd ~/DMZ/5i/
mkdir -p $(date +%Y%m%d_T%H%M)_partial/root/sdcard/
cd $(date +%Y%m%d_T%H%M)_partial/root/sdcard/

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
