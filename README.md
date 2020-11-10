# Planetary Motion Simulator

## Compilation:

### Using the provided Makefile:
From within the project root, execute
```
make
```

### Manually:
1. Compile modules:
```
gfortran -c src/constants.f90 src/read_input.f90 src/potential.f90 src/write_data.f90 src/main.f90
```
2. Link produced binaries:
```
gfortran constants.o read_input.o potential.o write_data.o main.o -o planetSim
```
3. (Optional) Clean main folder by running: `rm -f *.o *.mod`


## Usage:

To run the simulator, copy the executable `planetSim` to `run/` and execute it using
```
./planetSim
```
### Input
The input file `input.dat` contains the initial parameters in the following format:
```
Number_of_planets
Length_of_timestep
Length_of_simulation
Time_between_data_writes
Time_between_data_to_screen
mass1 x1 y1 z1 vx1 vy1 vz1 [Name1]
mass2 x2 y2 z2 vx2 vy2 vz2 [Name2]
...
```
where the masses are given in solar masses, the coordinates are given in astronomical units and the velocities in AU/s. The names are optional and can be up to 50 characters in length.

The sample input, input_nasa.dat has the actual positions of the planets as of December 4th 2017, according to data from NASA.


### Output
A typical simulation produces two output files:

**output.dat**
A XYZ coordinate file containing all coordinates in astronomical units and the time in seconds. All objects are given an identifying number, beginning from 1, which usually is the star.
Format:
```
<ID> <x>  <y>  <z>  <time>
```

**output.movie**
A XYZ-file separated into frames, each containing a set of coordinates for all objects. 
Format:
```
<Number_of_objects>
Frame number; <number>  Time: <time>
<ID>  <x> <y>  <z>
...
```

### Visualization
The produced movie file can be easily visulized as an animation using e.g. [Ovito](https://www.ovito.org/) and setting particle size of ~0.1. The trajectory utility of Ovito can also be used for visualizing orbits.
