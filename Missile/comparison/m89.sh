#!/bin/bash

gnuplot -persist > /dev/null 2>&1 << EOF
	set title "Mach Number vs. Axial Position at Pressure Ratio of 0.89"
	set xlabel "x (in)"
	set ylabel "M"

	plot	"analytical/axial.Mex.p89.gen" using 1:2 title 'Analytical' \
      with linespoints,\
    "processed/p89_100x20_M.xy" using 1:2 title 'Present OpenFOAM' \
      with lines
EOF
