#! /usr/bin/env zsh

floor=5242880
file_path=

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

echo "floor = $floor"
for dst_path in ${@:$first_dest_idx:$#}
  do
  avail=$(df --output=avail $dst_path | tail -n1)
  echo "dst_path = $dst_path"

  files_list=("${(@f)$(ls -I "*.tmp" -I ".tmp" -A $file_path)}")
  while [[ $avail -ge $floor ]]
  do
    if [[ -z $files_list ]]
    then
      break 2
    fi
    echo "Moving $file_path/${files_list[1]} -> $dst_path/${files_list[1]}"
    mv -- "$file_path/$files_list[1]" "$dst_path/$files_list[1]"
    files_list=(${files_list:1:$#files_list})
    new_avail=$(df --output=avail $dst_path | tail -n1)
    if [[ $avail -le $new_avail ]]
    then
      break
    fi
    avail=$new_avail
  done
done
