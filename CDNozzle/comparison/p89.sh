#!/bin/bash

gnuplot -persist > /dev/null 2>&1 << EOF
	set title "Static Pressure vs. Axial Position at Pressure Ratio of 0.89"
	set xlabel "x (in)"
	set ylabel "p (psi)"

	plot	"analytical/axial.Pex.p89.gen" using 1:2 title 'Analytical' \
      with linespoints,\
    "processed/p89_120x60_P.xy" using 1:2 title \
      'Present OpenFOAM (120x60)' \
      with lines,\
    "processed/p89_200x120_P.xy" using 1:2 title \
      'Present OpenFOAM (200x120)' \
      with lines,\
    "processed/p89_51x31_P.xy" using 1:2 title \
      'Present OpenFOAM (51x31)' \
      with lines,\
    "processed/axial_P.xy" using 1:2 title \
      'Present OpenFOAM (test)' \
      with lines
EOF
