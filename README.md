# Orbital Motion Simulator

A velocity Verlet algorithm integrator for simulating the motion of celestial objects

| <img src="./assets/render.png" width="400"/> | <img src="./assets/xy-chart.png" width="400"/> |
|:--:|:--:|

## Compilation:

### Using the provided Makefile:
From within the project root, execute
```
make
```

### Manually:
1. Compile modules:
```
gfortran -c src/constants.f90 src/input_parser.f90 src/potential.f90 src/data_writer.f90 src/main.f90
```
2. Link produced binaries:
```
gfortran constants.o input_parser.o potential.o data_writer.o main.o -o planetSim
```
3. (Optional) Clean main folder by running: `rm -f *.o *.mod`


## Usage:

To run the simulator, copy the executable `planetSim` to `run/` and execute it using
```
./planetSim
```
### Input
The input file should be named `input.dat` and contain initial simulation parameters in the following format:
```
<Number_of_planets>
<Length_of_timestep>
<Length_of_simulation>
Time_between_data_writes
<Time_between_data_to_screen>
<mass1> <x1> <y1> <z1> <vx1> <vy1> <vz1> [Name1]
<mass2> <x2> <y2> <z2> <vx2> <vy2> <vz2> [Name2]
...
```
where the masses are given in solar masses, the coordinates are given in astronomical units and the velocities in AU/s. The names are optional and can be up to 50 characters in length.

The sample input, `input_nasa.dat` has the actual positions of the planets as of December 4th 2017, according to data from NASA.


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

This repo contains sample outputs (`output_inner_planets.dat` and `output_inner_planets.movie`) for the four innermost planets, simulated for roughly one orbital period of Mars.

### Visualization
The produced movie file can be easily visulized as an animation using e.g. [Ovito](https://www.ovito.org/) and reading the movie file columns as particle type and the three spatial coordinates, respectively. The trajectory utility of Ovito can also be used for visualizing orbits.

The `*.dat` files can be visualized using the attached Python script. Make sure to first install the dependencies using e.g.
```
pip3 install -r utils/requirements.txt
```
after which plotting works as
```
python3 utils/plot_orbits.py <output-file>
```
