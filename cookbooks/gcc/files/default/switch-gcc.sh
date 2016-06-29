#!/bin/bash

if [ -z "$1" ]; then
    echo "usage: $0 version" 1>&2
    exit 1
fi

VERSIONS=($(update-alternatives --list gcc))
LIST=()
for index in "${!VERSIONS[@]}"; do
  LIST[$index]=${VERSIONS[$index]: -3}
done

function join { d=$1; shift; echo -n "$1"; shift; printf "%s" "${@/#/$d}"; }

if [ ! -f "/usr/bin/gcc-$1" ]; then
    echo "The provided version isn't available! Choose from the list below: $(join ", " ${LIST[@]})"
    exit 1
fi

update-alternatives --set gcc "/usr/bin/gcc-$1" > /dev/null
if [ $? -eq 0 ]
then
  echo "Now using GCC $1!"
else
  echo "Something wrong. Check your permissions..."
fi