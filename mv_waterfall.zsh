#! /bin/env zsh

floor=5242880
file_path=

if [[ -n "$2" ]]
then
  floor=$1
  file_path=$2
else
  file_path=$1
fi

for dst_path in ${@:3:$#}
  do
  while [[ -n $("ls -A $file_path") ]]
  do
    avail=$(df --output=avail $dst_path | tail -n1)
    while [[ $avail -ge $floor ]]
    do
      files=("${(@f)$(ls -A $file_path)}")
      mv "$file_path/$files[1]" "$dst_path/$files[1]"
      avail=$(df --output=avail $dst_path | tail -n1)
    done
  done
done
