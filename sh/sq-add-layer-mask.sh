#!/bin/bash
#    ____    _ ___________  ______
#   / __/___(_) ___/  _/  |/  / _ \
#  _\ \/ __/ / (_ // // /|_/ / ___/
# /___/\__/_/\___/___/_/  /_/_/
#
# Copyright 2016 Burlen Loring

if [[ $# -lt 3 ]]
then
  echo "usage:"
  echo "sq-add-layer-mask.sh [input] [mask] [output]"
  echo ""
  exit -1
fi

INPUT=$1
MASK=$2
OUTPUT=$3

gimp -i -b "(sq-add-layer-mask \"$INPUT\" \"$MASK\" \"$OUTPUT\")" -b "(gimp-quit 0)"
