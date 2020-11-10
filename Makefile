# -*-makefile-*-

F90=gfortran   # Compiler

all: constants.o error_report.o read_input.o potential.o write_data.o main.o
	${F90} -o constants.o error_report.o read_input.o potential.o write_data.o main.o -o planetsim
	@rm -f *.o *.mod

constants.o: src/constants.f90
	${F90} -c src/constants.f90

error_report.o: src/error_report.f90
	${F90} -c src/error_report.f90

read_input.o: src/read_input.f90
	${F90} -c src/read_input.f90

potential.o: src/potential.f90
	${F90} -c src/potential.f90

write_data.o: src/write_data.f90
	${F90} -c src/write_data.f90

main.o: src/main.f90
	${F90} -c src/main.f90

clean:
	rm -f *.o *.mod
