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

while [[ -n $("ls -A $file_path") ]]
do
  avail=$(df --output=avail $file_path | tail -n1)
