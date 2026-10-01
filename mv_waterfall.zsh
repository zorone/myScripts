#! /bin/env zsh

floor=5242880
file_path=

integer floor_tmp=$1
integer first_dest_idx=3
if [[ $floor_tmp -gt 0 ]]
then
  first_dest_idx=3
  if [[ -n "$2" ]]
  then
    floor=$1
    file_path=$2
  else
    file_path=$1
  fi
else
  first_dest_idx=2
fi

for dst_path in ${@:$first_dest_idx:$#}
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
