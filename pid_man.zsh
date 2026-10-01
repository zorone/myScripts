#! /bin/zsh

floor=10485760

while [[ -n "$(ls -A /mnt/smb)" ]]
do
  avail=$(df --output=avail /mnt/smb | tail -n1)
  if [[ $avail -lt $floor ]]
  then
    echo "\$avail=$avail"
    echo "$avail < 5242880"

    echo "Stop 7z with PID $(pgrep 7z)"
    kill -s STOP "$(pgrep 7z)"

    while [[ $avail -lt $floor ]]
    do
      echo "$avail < 15728640"
      sleep 1m
      avail=$(df --output=avail /mnt/smb | tail -n1)
    done

    echo "Resume 7z operation (PID $(pgrep 7z))"
    kill -s CONT "$(pgrep 7z)"
  fi

  sleep 1m
done

