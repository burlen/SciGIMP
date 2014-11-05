#!/bin/bash
#   ____    _ __           ____               __    ____
#  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
# _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
#/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
#
#Copyright 2010 SciberQuest Inc.

if [ $# -lt 5 ]
then
  exe=`basename $0`
  echo "Error: $exe /path/to/input /path/to/output red green blue threshold feather_radius" 1>&2
  exit -1
fi

INPUT=$1
OUTPUT=$2
RED=$3
GREEN=$4
BLUE=$5
THRESHOLD=$6
RADIUS=$7

if [[ -z "$THRESHOLD" ]]
then
  THRESHOLD=10
fi

if [[ -z "$RADIUS" ]]
then
  RADIUS=0
fi

gimp -i -b "(sq-transparent \"$INPUT\" \"$OUTPUT\" \"$RED\" \"$GREEN\" \"$BLUE\" \"$THRESHOLD\" \"$RADIUS\")" -b "(gimp-quit 0)"
