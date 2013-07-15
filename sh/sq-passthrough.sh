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
  echo "passthrough.sh /path/to/input /path/to/output"
  exit -1
fi

INPUT=$1
OUTPUT=$2

gimp -i -b "(sq-passthrough \"$INPUT\" \"$OUTPUT\")" -b "(gimp-quit 0)"
