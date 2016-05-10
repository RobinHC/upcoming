# Airfoil Thickness

All code can be found at:  
https://github.com/rlee32/openfoam_tutorials/tree/master/AirfoilThickness

## Description  
Here we simulate a simple single-bend cambered airfoil geometry in 
incompressible flow. Then we compare it to the same geometry, but with the 
leading and trailing edges connected by a surface. This changes the relative 
camber and thickness, but keeps the top surface geometry. The aim of this 
study is to compare a  

## Outline  
-Create mesh in Gmsh.  
-Convert the mesh and change the boundary file.  
-Run the simulation and view post-processed results.  

## Commands
Change into desired directory, thin or thick.  
gmsh mesh/main.geo -3 -o test.msh  
gmshToFoam test.msh -case case  
gmshToFoam test.msh -case case_piso  
changeDictionary  
pimpleFoam > log &

## Software
-Ubuntu 14.04 64-bit  
-OpenFOAM 3.0.0  
-Gmsh 2.11  