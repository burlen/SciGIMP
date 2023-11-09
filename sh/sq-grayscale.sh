#!/bin/bash
#   ____    _ __           ____               __    ____
#  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
# _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
#/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
#
#Copyright 2010 SciberQuest Inc.

if [[ $# -lt 3 ]]
then
  echo "usage:"
  echo "sq-grayscale.sh [input] [output] [mode]"
  echo "DESATURATE-LIGHTNESS (0), DESATURATE-LUMINOSITY (1), DESATURATE-AVERAGE (2)"
  echo ""
  exit -1
fi

INPUT=$1
OUTPUT=$2
MODE=$3

if [[ -z "$MODE" ]]
then
  MODE=2
fi

gimp -i -b "(sq-grayscale \"$INPUT\" \"$OUTPUT\" \"$MODE\")" -b "(gimp-quit 0)"

