# Using a Hybrid Structured-Unstructured Mesh to Simulate an 
  Axisymmetric Missile Body in OpenFOAM  

All code can be found at:  
https://github.com/rlee32/openfoam_tutorials/tree/master/Missile 

## Description  
Here we simulate external supersonic flow on a missile-shaped body 
using a hybrid structured-unstructured axisymmetric mesh written in Gmsh. 
The geometry and computational domain follow the specifications here: 
http://turbmodels.larc.nasa.gov/axiswblim7_val.html  

## Outline  
-Describe how to generate a structured and unstructured mesh in Gmsh.  
-Convert the mesh and change the boundary file.  
-Run the simulation.  

## Commands
gmsh mesh.geo -3 -o test.msh  
gmshToFoam test.msh -case case  
changeDictionary  
sonicFoam  

## Software
-Ubuntu 14.04 64-bit  
-OpenFOAM 3.0.0  
-Gmsh 2.12  