#! /usr/bin/env zsh

floor=5242880
file_path=
abort_flag=""

integer floor_tmp=$1
integer first_dest_idx=3
if [[ $floor_tmp -gt 0 ]]
then
  first_dest_idx=3
  floor=$1
  file_path=$2
else
  first_dest_idx=2
  file_path=$1
fi

for dst_path in ${@:$first_dest_idx:$#}
  do
  avail=$(df --output=avail $dst_path | tail -n1)
  while [[ -n "${(@f)$(ls -I *.tmp -A $file_path)}" ]] \
        && [[ $avail -ge $floor ]]
  do
    files=("${(@f)$(ls -I *.tmp -A $file_path)}")
    if [[ -z $files ]]
    then
      break 2
    fi
    mv -- "$file_path/$files[1]" "$dst_path/$files[1]"
    new_avail=$(df --output=avail $dst_path | tail -n1)
    if [[ $avail -le $new_avail ]]
    then
      break 2
    fi
    avail=$new_avail
  done
  if [[ "$abort_flag" ]]
  then
    break
  fi
done
