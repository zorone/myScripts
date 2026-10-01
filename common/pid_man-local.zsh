#! /bin/zsh

floor=5242880

while [[ -n "$(ls -A /media/kali/4A72269B72268BAF/shared/)" ]]
do
  avail=$(df --output=avail /media/kali/4A72269B72268BAF/shared/ | tail -n1)
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
      avail=$(df --output=avail /mnt/smb | tail -n1)
    done

    echo "Resume 7z operation (PID $(pgrep 7z))"
    kill -s CONT "$(pgrep 7z)"
  fi

  sleep 1m
done

