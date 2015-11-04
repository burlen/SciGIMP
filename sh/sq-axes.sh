#!/bin/bash
#   ____    _ __           ____               __    ____
#  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
# _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
#/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
#
#Copyright 2010 SciberQuest Inc.

if [ $# -lt 3 ]
then
  exe=`basename $0`
  echo "Error: $exe" 1>&2
  echo "inFile outFile xLow xHigh nMajorX nMinorX labelFreqX yLow yHigh nMajorY nMinorY labelFreqY majorTickWidth majorTickLength minorTickWidth minorTickLength gridLineLength gridLineWidth tickPrecision tickFontSize tickFontColor tickFontFace"  1>&2
  exit -1
fi


# "Liberation Serif Bold"
# "Monospace Bold"
# "Nimbus Mono L Bold Oblique"


INPUT=$1
OUTPUT=$2
X_LOW=$3
X_HIGH=$4
N_MAJOR_X=$5
N_MINOR_X=$6
LABEL_FREQ_X=$7
Y_LOW=$8
Y_HIGH=$9
N_MAJOR_Y=${10}
N_MINOR_Y=${11}
LABEL_FREQ_Y=${12}
MAJOR_TICK_WIDTH=${13}
MAJOR_TICK_LENGTH=${14}
MINOR_TICK_WIDTH=${15}
MINOR_TICK_LENGTH=${16}
#GRID_LINE_LEN=${17}
#GRID_LINE_WID=${18}
TICK_PRECISION=${17}
TICK_FONT_SIZE=${18}
TICK_FONT_COLOR=${19}
TICK_FONT_FACE=${20}
X_LABEL=${21}
Y_LABEL=${22}
LABEL_FONT_SIZE=${23}
LABEL_FONT_COLOR=${24}
LABEL_FONT_FACE=${25}
FIGLET=${26}
FIGLET_FONT_SIZE=${27}
FIGLET_FONT_COLOR=${28}
FIGLET_FONT_FACE=${28}

# TODO -- for now
TICK_FONT_FACE="Liberation Serif Bold" #"DejaVu Sans Bold" #"Liberation Serif Bold"
LABEL_FONT_FACE="DejaVu Sans Bold" #"Liberation Serif Bold" # "Nimbus Mono L Bold Oblique" # "Monospace Bold"
FIGLET_FONT_FACE="DejaVu Sans Bold" #"Liberation Serif Bold" # "Nimbus Mono L Bold Oblique" # "Monospace Bold"

if [[ -z "$X_LOW" ]]
then
  X_LOW=-1
fi

if [[ -z "$X_HIGH" ]]
then
  X_HIGH=1
fi

if [[ -z "$N_MAJOR_X" ]]
then
  N_MAJOR_X=7
fi

if [[ -z "$N_MINOR_X" ]]
then
  N_MINOR_X=5
fi

if [[ -z "$LABEL_FREQ_X" ]]
then
  LABEL_FREQ_X=1
fi

if [[ -z "$Y_LOW" ]]
then
  Y_LOW=$X_LOW
fi

if [[ -z "$Y_HIGH" ]]
then
  Y_HIGH=$X_HIGH
fi

if [[ -z "$N_MAJOR_Y" ]]
then
  N_MAJOR_Y=$N_MAJOR_X
fi

if [[ -z "$N_MINOR_Y" ]]
then
  N_MINOR_Y=$N_MINOR_X
fi

if [[ -z "$LABEL_FREQ_Y" ]]
then
  LABEL_FREQ_Y=1
fi

if [[ -z "$MAJOR_TICK_WIDTH" ]]
then
  MAJOR_TICK_WIDTH=0.01
fi

if [[ -z "$MAJOR_TICK_LENGTH" ]]
then
  MAJOR_TICK_LENGTH=0.8
fi

if [[ -z "$MINOR_TICK_WIDTH" ]]
then
  MINOR_TICK_WIDTH=0.008
fi

if [[ -z "$MINOR_TICK_LENGTH" ]]
then
  MINOR_TICK_LENGTH=0.4
fi

if [[ -z "$GRID_LINE_LEN" ]]
then
  GRID_LINE_LEN=3
fi

if [[ -z "$GRID_LINE_WID" ]]
then
  GRID_LINE_WID=2
fi

if [[ -z "$TICK_PRECISION" ]]
then
  TICK_PRECISION=2
fi

if [[ -z "$TICK_FONT_SIZE" ]]
then
  TICK_FONT_SIZE=16
fi

if [[ -z "$TICK_FONT_COLOR" ]]
then
  TICK_FONT_COLOR="b"
fi

if [[ -z "$TICK_FONT_FACE" ]]
then
  #TICK_FONT_FACE="Nimbus Mono L Bold Oblique"
  TICK_FONT_FACE="Liberation Serif Bold"
fi

if [[ -z "$X_LABEL" ]]
then
  X_LABEL=""
fi

if [[ -z "$Y_LABEL" ]]
then
  Y_LABEL=""
fi

if [[ -z "$LABEL_FONT_SIZE" ]]
then
  LABEL_FONT_SIZE=20
fi

if [[ -z "$LABEL_FONT_COLOR" ]]
then
  LABEL_FONT_COLOR="b"
fi

if [[ -z "$LABEL_FONT_FACE" ]]
then
  #LABEL_FONT_FACE="Nimbus Mono L Bold Oblique"
  LABEL_FONT_FACE="Liberation Serif Bold"
fi

if [[ -z "$FIGLET" ]]
then
  FIGLET=""
fi

if [[ -z "$FIGLET_FONT_SIZE" ]]
then
  FIGLET_FONT_SIZE=24
fi

if [[ -z "$FIGLET_FONT_COLOR" ]]
then
  FIGLET_FONT_COLOR="b"
fi

if [[ -z "$FIGLET_FONT_FACE" ]]
then
  #FIGLET_FONT_FACE="Nimbus Mono L Bold Oblique"
  FIGLET_FONT_FACE="Liberation Serif Bold"
fi

#gimp -i -b "(sq-axes \"$INPUT\" \"$OUTPUT\" \"$X_LOW\" \"$X_HIGH\" \"$N_MAJOR_X\" \"$N_MINOR_X\" \"$LABEL_FREQ_X\" \"$Y_LOW\" \"$Y_HIGH\" \"$N_MAJOR_Y\" \"$N_MINOR_Y\" \"$LABEL_FREQ_Y\" \"$MAJOR_TICK_WIDTH\" \"$MAJOR_TICK_LENGTH\" \"$MINOR_TICK_WIDTH\" \"$MINOR_TICK_LENGTH\" \"$GRID_LINE_LEN\" \"$GRID_LINE_WID\" \"$TICK_PRECISION\" \"$TICK_FONT_FACE\" \"$TICK_FONT_SIZE\" \"$TICK_FONT_COLOR\" \"$X_LABEL\" \"$Y_LABEL\" \"$LABEL_FONT_FACE\" \"$LABEL_FONT_SIZE\" \"$LABEL_FONT_COLOR\" \"$FIGLET\" \"$FIGLET_FONT_FACE\" \"$FIGLET_FONT_SIZE\" \"$FIGLET_FONT_COLOR\")" -b "(gimp-quit 0)"

echo "gimp -i -b \"(sq-axes \\\"$INPUT\\\" \\\"$OUTPUT\\\" \\\"$X_LOW\\\" \\\"$X_HIGH\\\" \\\"$N_MAJOR_X\\\" \\\"$N_MINOR_X\\\" \\\"$LABEL_FREQ_X\\\" \\\"$Y_LOW\\\" \\\"$Y_HIGH\\\" \\\"$N_MAJOR_Y\\\" \\\"$N_MINOR_Y\\\" \\\"$LABEL_FREQ_Y\\\" \\\"$MAJOR_TICK_WIDTH\\\" \\\"$MAJOR_TICK_LENGTH\\\" \\\"$MINOR_TICK_WIDTH\\\" \\\"$MINOR_TICK_LENGTH\\\" \\\"$TICK_PRECISION\\\" \\\"$TICK_FONT_FACE\\\" \\\"$TICK_FONT_SIZE\\\" \\\"$TICK_FONT_COLOR\\\" \\\"$X_LABEL\\\" \\\"$Y_LABEL\\\" \\\"$LABEL_FONT_FACE\\\" \\\"$LABEL_FONT_SIZE\\\" \\\"$LABEL_FONT_COLOR\\\" \\\"$FIGLET\\\" \\\"$FIGLET_FONT_FACE\\\" \\\"$FIGLET_FONT_SIZE\\\" \\\"$FIGLET_FONT_COLOR\\\")\" -b \"(gimp-quit 0)\""

gimp -i -b "(sq-axes \"$INPUT\" \"$OUTPUT\" \"$X_LOW\" \"$X_HIGH\" \"$N_MAJOR_X\" \"$N_MINOR_X\" \"$LABEL_FREQ_X\" \"$Y_LOW\" \"$Y_HIGH\" \"$N_MAJOR_Y\" \"$N_MINOR_Y\" \"$LABEL_FREQ_Y\" \"$MAJOR_TICK_WIDTH\" \"$MAJOR_TICK_LENGTH\" \"$MINOR_TICK_WIDTH\" \"$MINOR_TICK_LENGTH\" \"$TICK_PRECISION\" \"$TICK_FONT_FACE\" \"$TICK_FONT_SIZE\" \"$TICK_FONT_COLOR\" \"$X_LABEL\" \"$Y_LABEL\" \"$LABEL_FONT_FACE\" \"$LABEL_FONT_SIZE\" \"$LABEL_FONT_COLOR\" \"$FIGLET\" \"$FIGLET_FONT_FACE\" \"$FIGLET_FONT_SIZE\" \"$FIGLET_FONT_COLOR\")" -b "(gimp-quit 0)"
