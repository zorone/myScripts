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
