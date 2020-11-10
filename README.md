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
gfortran constants.o read_input.o potential.o write_data.o main.o
```
3. (Optional) Clean main folder by running: `rm -f *.o *.mod`
