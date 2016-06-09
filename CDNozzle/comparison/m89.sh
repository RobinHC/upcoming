#!/bin/bash

gnuplot -persist > /dev/null 2>&1 << EOF
	set title "Mach Number vs. Axial Position at Pressure Ratio of 0.89 (sonicFoam)"
	set xlabel "x (in)"
	set ylabel "M"

	plot	"analytical/axial.Mex.p89.gen" using 1:2 title 'Analytical' \
      with linespoints,\
    "processed/p89_120x60_M.xy" using 1:2 title \
      'Present OpenFOAM (120x60)' \
      with lines,\
    "processed/p89_200x120_M.xy" using 1:2 title \
      'Present OpenFOAM (200x120)' \
      with lines,\
    "processed/p89_51x31_M.xy" using 1:2 title \
      'Present OpenFOAM (51x31)' \
      with lines,\
    "processed/axial_M.xy" using 1:2 title \
      'Present OpenFOAM (test)' \
      with lines
EOF
