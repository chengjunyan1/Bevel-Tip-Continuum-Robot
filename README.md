# Bevel-Tip-Continuum-Robot
Dynamical modeling for Bevel Tip Continuum Robot and a RRT* 3D Trajectory Planner

*by Cheng Jun-Yan*

**Prerequisite:** MATLAB

This repository contains a Dynamical Modeling for the Bevel Tip Continuum Robot and a 3D Trajectory Planner based on RRT* and their simulation runs on MATLAB. 

This is my contribution for term project in WPI RBE501 Robot Dynamics. The Project Report folder contains my part in the written final report, presentation ppt, and my voice recordings of the final presentation.

**The Dynamical Modeling method comes from:** 
Rossa, C., Sloboda, R., Usmani, N. et al. Estimating needle tip deflection in biological tissue from a single transverse ultrasound image: application to brachytherapy. Int J CARS 11, 1347–1359 (2016). https://doi.org/10.1007/s11548-015-1329-4
*PDF available in: https://www.researchgate.net/publication/284901182_Estimating_Needle_Tip_Deflection_in_Biological_Tissue_from_a_Single_Transverse_Ultrasound_Image_Application_to_Brachytherapy

## How to use:

Just run beveltip.m to see the demo.

Modify CONFIG.m to change the simulation environment.

Modify drawTrajectory.m to run the curve simulation.

## Sample

Dynamical Modeling

![image](https://github.com/chengjunyan1/Bevel-Tip-Continuum-Robot/raw/master/DM.png)

Trajectory Planning

![image](https://github.com/chengjunyan1/Bevel-Tip-Continuum-Robot/raw/master/RRT.png)
