! Module for reading input data & creating output files

module input_parser
    use constants
    use error_handler
    implicit none
    real(rk) :: param(5) = 0
    real(rk), allocatable :: obj_data(:, :)
    integer(ik) :: ios, ii, jj, Nobj, Ncols = 7
    character(len=maxlen), allocatable :: names(:)

contains

    subroutine get_input(param, obj_data, names)
        real(rk), intent(out) :: param(:)
        real(rk), allocatable, intent(out) :: obj_data(:, :)
        character(len=maxlen), allocatable, intent(out) :: names(:)

        ! Open input file (On error: show message & stop)
        open (unit=1, file=infile, iostat=ios, status='old')
        if (ios /= 0) call throw('INPUT_FILE_ERR', ios)

        ! Read simulation parameters (five first rows of input file)
        do ii = 1, 5
            read (1, *) param(ii)
        end do

        ! Stop if any parameter is 0 or timestep is larger the total time
        if (any(param == 0)) call throw('INPUT_PARAM_ERR', 0_ik)
        if (param(2) > param(3)) call throw('TOO_LARGE_TIMESTEP_ERR', 0_ik)

        Nobj = param(1)
        allocate (obj_data(Nobj, Ncols), names(Nobj))

        ! Read object coordinates etc.
        do ii = 1, Nobj
            read (1, *, iostat=ios) (obj_data(ii, jj), jj=1, Ncols), names(ii)
            if (ios < 0) call throw('TOO_FEW_COORDS_ERR', 0_ik)    ! stop if Nobj > number of inital coord.
            names(ii) = trim(names(ii))
        end do
        close (1)

        ! Create ouput files
        open (unit=2, file=outfile, iostat=ios, status='replace')
        if (ios /= 0) call throw('OUTPUT_FILE_ERR', ios)
        close (2)

        open (unit=3, file=moviefile, iostat=ios, status='replace')
        if (ios /= 0) call throw('MOVIE_FILE_ERR', ios)
        close (3)

    end subroutine get_input
end module input_parser
