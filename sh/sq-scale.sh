#!/bin/bash
#   ____    _ __           ____               __    ____
#  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
# _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
#/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
#
#Copyright 2010 SciberQuest Inc.

if [ $# -lt 2 ]
then
  exe=`basename $0`
  echo "Error: $exe /path/to/input /path/to/output %-width %-height" 1>&2
  exit -1
fi

INPUT=$1
OUTPUT=$2
WIDTH_FACTOR=$3
HEIGHT_FACTOR=$4

if [[ -z "$WIDTH_FACTOR" ]]
then
  WIDTH_FACTOR=0.5
fi

if [[ -z "$HEIGHT_FACTOR" ]]
then
  HEIGHT_FACTOR=0.5
fi

gimp -i -b "(sq-scale \"$INPUT\" \"$OUTPUT\" \"$WIDTH_FACTOR\" \"$HEIGHT_FACTOR\")" -b "(gimp-quit 0)"
