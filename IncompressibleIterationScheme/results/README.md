## residuals1.png, coeffs1.png

SIMPLE, relaxation factors all 0.5.  

## residuals2.png, coeffs2.png, p_20000_2.png, U_20000_2.png

SIMPLE, relaxation factors all 0.25. Residuals flatline a bit due to the absolute tolerances of 1e-12 (k, omega) and 1e-9 (pressure, velocity) reached.  

## residuals3.png, coeffs3.png

PISO, max Courant of 5. Residuals flatline a bit due to the absolute tolerances of 1e-12 (k, omega) and 1e-9 (pressure, velocity) reached.  

Also tested was PISO, max Courant of 1 Absolute tolerances reduced to 1e-16 (k, omega, pressure, velocity). Relative tolerances remain 1e-3. There was little difference in forces, so no figures were produced.  






