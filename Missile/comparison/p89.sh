#!/bin/bash

gnuplot -persist > /dev/null 2>&1 << EOF
	set title "Static Pressure vs. Axial Position at Pressure Ratio of 0.89"
	set xlabel "x (in)"
	set ylabel "p (psi)"

	plot	"analytical/axial.Pex.p89.gen" using 1:2 title 'Analytical' \
      with linespoints,\
    "processed/p89_100x20_P.xy" using 1:2 title 'Present OpenFOAM (100x20)' \
      with lines
EOF
