# Single-Bend Airfoil in Incompressible Flow: Steady vs. Unsteady

All code can be found at:  
https://github.com/rlee32/openfoam_tutorials/tree/master/IncompressibleIterationScheme  

## Description  
Here we simulate a simple airfoil geometry in incompressible flow. We compare the use of simpleFoam vs. pisoFoam. Both of these solvers can be realized by changing settings in pimpleFoam, which merges the 2 aforementioned solvers.  

## Outline  
-Create mesh in Gmsh.  
-Convert the mesh and change the boundary file.  
-Run the simulation and view post-processed results.  

## Commands
gmsh mesh/main.geo -3 -o test.msh  
gmshToFoam test.msh -case case  
gmshToFoam test.msh -case case_piso  
changeDictionary  
pimpleFoam  

## Software
-Ubuntu 14.04 64-bit  
-OpenFOAM 3.0.0  
-Gmsh 2.11  