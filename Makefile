# -*-makefile-*-

F90=gfortran   # Compiler

all: constants.o error_handler.o input_parser.o potential.o data_writer.o main.o
	${F90} -o constants.o error_handler.o input_parser.o potential.o data_writer.o main.o -o planetSim
	@rm -f *.o *.mod

constants.o: src/constants.f90
	${F90} -c src/constants.f90

error_handler.o: src/error_handler.f90
	${F90} -c src/error_handler.f90

input_parser.o: src/input_parser.f90
	${F90} -c src/input_parser.f90

potential.o: src/potential.f90
	${F90} -c src/potential.f90

data_writer.o: src/data_writer.f90
	${F90} -c src/data_writer.f90

main.o: src/main.f90
	${F90} -c src/main.f90

clean:
	rm -f *.o *.mod src/*.mod
