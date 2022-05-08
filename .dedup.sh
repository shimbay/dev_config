#! /bin/bash

OLD_IFS=$IFS
IFS=":"

arr=(${!1})
narr=()
for item in "${arr[@]}"; do
  if [[ ! " ${narr[@]} " =~ " ${item} " ]]; then
    narr+=(${item})
  fi
done

IFS=$OLD_IFS

nvar=""
for item in "${narr[@]}"; do
  if test "$nvar" == ""; then
    nvar="$item"
  else
    nvar="${nvar}:${item}"
  fi
done

echo $nvar
