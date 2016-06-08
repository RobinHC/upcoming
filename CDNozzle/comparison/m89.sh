#!/bin/bash

gnuplot -persist > /dev/null 2>&1 << EOF
	set title "Mach Number vs. Axial Position at Pressure Ratio of 0.89"
	set xlabel "x (in)"
	set ylabel "M"

	plot	"analytical/axial.Mex.p89.gen" using 1:2 title 'Analytical' \
      with linespoints,\
    "processed/p89_100x20_upwind_M.xy" using 1:2 title \
      'Present OpenFOAM (100x20, 1st-Order Upwind)' \
      with lines,\
    "processed/p89_201x121_upwind_M.xy" using 1:2 title \
      'Present OpenFOAM (201x121, 1st-Order Upwind)' \
      with lines,\
    "processed/p89_201x121_linearupwind_M.xy" using 1:2 title \
      'Present OpenFOAM (201x121, 2nd-Order Upwind)' \
      with lines,\
    "processed/p89_201x121_limitedlinear1_M.xy" using 1:2 title \
      'Present OpenFOAM (201x121, limitedLinear1)' \
      with lines,\
    "processed/p89_201x121_limitedlinear0_M.xy" using 1:2 title \
      'Present OpenFOAM (201x121, limitedLinear0)' \
      with lines,\
    "processed/p89_201x121_linear_M.xy" using 1:2 title \
      'Present OpenFOAM (201x121, linear)' \
      with lines
EOF
