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
  echo "sq-overlay.sh /path/to/input /path/to/overlay /path/to/output posX posY alpha0 alpha1 mode1"
  echo "modes are:"
  echo "NORMAL-MODE (0), DISSOLVE-MODE (1), BEHIND-MODE (2), MULTIPLY-MODE (3), SCREEN-MODE (4), OVERLAY-MODE (5), DIFFERENCE-MODE (6), ADDITION-MODE (7), SUBTRACT-MODE (8), DARKEN-ONLY-MODE (9), LIGHTEN-ONLY-MODE (10), HUE-MODE (11), SATURATION-MODE (12), COLOR-MODE (13), VALUE-MODE (14), DIVIDE-MODE (15), DODGE-MODE (16), BURN-MODE (17), HARDLIGHT-MODE (18), SOFTLIGHT-MODE (19), GRAIN-EXTRACT-MODE (20), GRAIN-MERGE-MODE (21), COLOR-ERASE-MODE (22), ERASE-MODE (23), REPLACE-MODE (24), ANTI-ERASE-MODE (25)"
  echo ""
  exit -1
fi

INPUT=$1
OVERLAY=$2
OUTPUT=$3
POSX=$4
POSY=$5
A0=$6
A1=$7
M1=$8

if [[ -z "$POSX" ]]
then
  POSX=0
fi
if [[ -z "$POSY" ]]
then
  POSY=0
fi
if [[ -z "$A0" ]]
then
  A0=100
fi
if [[ -z "$A1" ]]
then
  A1=100
fi
if [[ -z "$M1" ]]
then
  M1=0
fi

gimp -i -b "(sq-overlay \"$INPUT\" \"$OVERLAY\" \"$OUTPUT\" \"$POSX\" \"$POSY\" \"$A0\" \"$A1\" \"$M1\")" -b "(gimp-quit 0)"
