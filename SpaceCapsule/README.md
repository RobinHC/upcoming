Space Capsule Atmospheric Entry Simulation in OpenFOAM  

All code can be found at:  
https://github.com/rlee32/openfoam_tutorials/tree/master/SpaceCapsule  

DESCRIPTION:  
Here we simulate hypersonic reentry of a generically-shaped space capsule. 
Supersonic typically refers to speeds between Mach 1 and 5, while hypersonic 
usually refers to speeds above Mach 5. This simulation will handle Mach 8.  

OUTLINE:  
-Create mesh in Gmsh.  
-Convert the mesh and change the boundary file.  
-Run the simulation and view post-processed results.  

COMMANDS:  
gmsh mesh.geo -3 -o test.msh  
gmshToFoam test.msh -case case  
# Modify boundary file  
rhoCentralFoam  

This tutorial was run successfully on:  
-Ubuntu 14.04 64-bit  
-OpenFOAM 3.0.0  
-Gmsh 2.11  