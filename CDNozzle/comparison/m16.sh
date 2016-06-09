#!/bin/bash

gnuplot -persist > /dev/null 2>&1 << EOF
	set title "Mach Number vs. Axial Position at Pressure Ratio of 0.89"
	set xlabel "x (in)"
	set ylabel "M"

	plot	"analytical/axial.Mex.p16.gen" using 1:2 title 'Analytical' \
      with linespoints,\
    "processed/axial_M.xy" using 1:2 title \
      'Present OpenFOAM (test)' \
      with lines
EOF
