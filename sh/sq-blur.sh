#!/bin/bash
#   ____    _ __           ____               __    ____
#  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
# _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
#/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
#
#Copyright 2010 SciberQuest Inc.

if [[ $# -lt 2 ]]
then
  echo "usage:"
  echo "sq-blur.sh /path/to/input /path/to/output radius"
  echo ""
  exit -1
fi

INPUT=$1
OUTPUT=$2
RAD=$3

if [[ -z "$RAD" ]]
then
  RAD=1
fi

gimp -i -b "(sq-blur \"$INPUT\" \"$OUTPUT\" \"$RAD\")" -b "(gimp-quit 0)"
