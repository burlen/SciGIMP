#!/bin/bash
#    ____    _ ___________  ______
#   / __/___(_) ___/  _/  |/  / _ \
#  _\ \/ __/ / (_ // // /|_/ / ___/
# /___/\__/_/\___/___/_/  /_/_/
#
#Copyright 2014 Burlen Loring
if [ $# -lt 3 ]
then
  exe=`basename $0`
  echo "Error: $exe [in|left image] [in|right image] [out|packed image] [in:half res flag = 1]" 1>&2
  exit -1
fi

LEFT=$1
RIGHT=$2
OUT=$3
HALF=$4
if [ -z "$HALF" ]
then
  HALF=1
fi

gimp -i -b "(sq-pack-stereo-tb \"$LEFT\" \"$RIGHT\" \"$OUT\" \"$HALF\")" -b "(gimp-quit 0)"
