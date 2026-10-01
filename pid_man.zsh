#! /bin/zsh

floor=5242880
path="/mnt/smb"
if [[ "$2" ]]
then
  path="$2"
fi

if [[ "$1" ]]
then
  floor=$1
fi

echo "path = $path"
echo "floor = $floor kilobytes"

while [[ -n "$(ls -A ${path})" ]]
do
  avail=$(df --output=avail ${path} | tail -n1)
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
      avail=$(df --output=avail ${path} | tail -n1)
    done

    echo "Resume 7z operation (PID $(pgrep 7z))"
    kill -s CONT "$(pgrep 7z)"
  fi

  sleep 1m
done
