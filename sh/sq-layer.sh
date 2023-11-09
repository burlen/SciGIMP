#!/bin/bash
#    ____    _ ___________  ______
#   / __/___(_) ___/  _/  |/  / _ \
#  _\ \/ __/ / (_ // // /|_/ / ___/
# /___/\__/_/\___/___/_/  /_/_/
#
# Copyright 2016 Burlen Loring

if [[ $# -ne 6 ]]
then
  echo "usage:"
  echo "sq-layer.sh [(layers)] [(xpos)] [(ypos)] [(alphas)] [(modes)] [out]"
  echo ""
  echo "notes:"
  echo "   these are all lists except out, lists are cretaed like '(elem_1 elem_2 elem_n)"
  echo "   file names must be quoted to make the strings like \"file\""
  echo "   the mode enumerations are:"
  echo "       NORMAL-MODE (0), DISSOLVE-MODE (1), BEHIND-MODE (2), MULTIPLY-MODE (3),"
  echo "       SCREEN-MODE (4), OVERLAY-MODE (5), DIFFERENCE-MODE (6), ADDITION-MODE (7),"
  echo "       SUBTRACT-MODE (8), DARKEN-ONLY-MODE (9), LIGHTEN-ONLY-MODE (10), HUE-MODE (11),"
  echo "       SATURATION-MODE (12), COLOR-MODE (13), VALUE-MODE (14), DIVIDE-MODE (15),"
  echo "       DODGE-MODE (16), BURN-MODE (17), HARDLIGHT-MODE (18), SOFTLIGHT-MODE (19),"
  echo "       GRAIN-EXTRACT-MODE (20), GRAIN-MERGE-MODE (21), COLOR-ERASE-MODE (22),"
  echo "       ERASE-MODE (23), REPLACE-MODE (24), ANTI-ERASE-MODE (25)"
  echo ""
  exit -1
fi

gimp -i -b "(sq-layer $1 $2 $3 $4 $5 $6)" -b "(gimp-quit 0)"
