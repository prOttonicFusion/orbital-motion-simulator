! This module contains global variables & constants which can be used in
! any other module or in the main file
module constants
  implicit none
  ! Natural & conversion constants
  real, parameter :: G=3.963381e-14  ! AU^3/(M_sun*s^2); Gravit. const.
  real, parameter :: AU2KM=149597871 ! Km/AU;
  real, parameter :: KM2AU=6.684587e-9 ! AU/km
  Real, parameter :: AU=149.5979E9   ! m; Astronomical Unit
  real, parameter :: m_sun=1.9891E30 ! kg; Mass of the Sun

  ! System parameters
  integer, parameter :: rk=selected_real_kind(10,40)
  integer, parameter :: ik=selected_int_kind(12)
  integer, parameter :: maxlen=50   ! max. length of object names

  ! Input & output file names & paths
  character(*), parameter :: infile = "run/input.dat"
  character(*), parameter :: outfile = "run/output.dat"
  character(*), parameter :: moviefile = "run/output.movie"

end module constants
