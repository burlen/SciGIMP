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
  echo "sq-unsharp.sh /path/to/input /path/to/output radius(>1.0) ammount(0.0 - 10.0) threshold(0 - 255)"
  echo ""
  exit -1
fi

INPUT=$1
OUTPUT=$2
RAD=$3
AMT=$4
THR=$5

if [[ -z "$RAD" ]]
then
  RAD=3.0
fi

if [[ -z "$AMT" ]]
then
  AMT=1.0
fi

if [[ -z "$THR" ]]
then
  THR=0
fi

gimp -i -b "(sq-unsharp \"$INPUT\" \"$OUTPUT\" \"$RAD\" \"$AMT\" \"$THR\")" -b "(gimp-quit 0)"

