#!/bin/bash
#    ____    _ ___________  ______
#   / __/___(_) ___/  _/  |/  / _ \
#  _\ \/ __/ / (_ // // /|_/ / ___/
# /___/\__/_/\___/___/_/  /_/_/
#
# Copyright 2016 Burlen Loring

if [ $# -ne 5 ] ; then
  echo "Usage: $0 infile R G B outfile"
  exit 1
fi

gimp -i -b "(sq-color-to-alpha \"$1\" \"$2\" \"$3\" \"$4\" \"$5\")" -b '(gimp-quit 0)'
