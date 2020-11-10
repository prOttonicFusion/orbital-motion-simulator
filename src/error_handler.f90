! Error reporting module

module error_handler
    use constants

contains

    subroutine throw(err, ios)
        implicit none
        integer(ik), intent(in) :: ios
        character, intent(in) :: err 

        ! Select & show corresponding error message
        select case (err)
        case ('INPUT_FILE_ERR')
            print '(/a,a,5x,i0/)', '[***ERROR:] Problem in opening input file ', trim(infile), ios
        case ('INPUT_PARAM_ERR')
            print '(/a/)', '[***ERROR:] Check input parameters; all times and intervals muste be > 0'
        case ('TOO_LARGE_TIMESTEP_ERR')
            print '(/a/)', '[***ERROR:] Time step is larger than the total simulation time'
        case ('TOO_FEW_COORDS_ERR')
            print '(/a/)', '[***ERROR:] Number of inital coordinates < N_obj'
        case ('OUTPUT_FILE_ERR')
            print '(/a,5x,i0/)', '[***ERROR:] Problem in creating output file ', ios
        case ('MOVIE_FILE_ERR')
            print '(a,5x,i0)', '[***ERROR:] Problem in creating movie file ', ios
        case ('OUTPUT_READ_ERR')
            print '(/a,a,5x,i0/)', '[***ERROR:] Problem in opening file ', trim(outfile), ios
        case ('MOVIE_READ_ERR')
            print '(/a,a,5x,i0/)', '[***ERROR:] Problem in opening file ', trim(moviefile), ios

        end select

        ! Stop simulation
        stop

    end subroutine throw
end module error_handler
