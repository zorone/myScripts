#! /bin/zsh

floor=5242880
# Don't use $path !!!
file_path="/mnt/smb"
if [[ "$2" ]]
then
  file_path="$2"
fi

if [[ "$1" ]]
then
  floor=$1
fi

echo "path = $file_path"
echo "floor = $floor kilobytes"

while [[ -n "$(ls -A $file_path)" ]]
do
  avail=$(df --output=avail $file_path | tail -n1)
  if [[ $avail -lt $floor ]]
  then
    echo "\$avail=$avail"
    echo "$avail < $floor"

    echo "Stop 7z with PID $(pgrep 7z)"
    kill -s STOP "$(pgrep 7z)"

    while [[ $avail -lt $floor ]]
    do
      echo "$avail < $floor"
      sleep 1m
      avail=$(df --output=avail $file_path | tail -n1)
    done

    echo "Resume 7z operation (PID $(pgrep 7z))"
    kill -s CONT "$(pgrep 7z)"
  fi

  sleep 30s
done
