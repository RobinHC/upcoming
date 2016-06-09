#!/bin/bash

gnuplot -persist > /dev/null 2>&1 << EOF
	set title "Static Pressure vs. Axial Position at Pressure Ratio of 0.89"
	set xlabel "x (in)"
	set ylabel "p (psi)"

	plot	"analytical/axial.Pex.p16.gen" using 1:2 title 'Analytical' \
      with linespoints,\
    "processed/axial_P.xy" using 1:2 title \
      'Present OpenFOAM (test)' \
      with lines
EOF
