#!/bin/bash
#   ____    _ __           ____               __    ____
#  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
# _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
#/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
#
#Copyright 2010 SciberQuest Inc.

if [ $# -lt 8 ]
then
  echo "(sq-grid inFile outFile nMajorX nMajorY lineWidth lineLength lineSkip lineColor)"
  exit -1
fi

INPUT=$1
OUTPUT=$2
NX=$3
NY=$4
LWID=$5
LLEN=$6
LSK=$7
LCOL=$8

gimp -i -b "(sq-grid \"$INPUT\" \"$OUTPUT\" \"$NX\" \"$NY\" \"$LWID\" \"$LLEN\" \"$LSK\" \"$LCOL\")" -b "(gimp-quit 0)"
