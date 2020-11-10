! This is an error reporting module; it displays a message & kills the simulation
module error_report
    use constants
contains

    subroutine errors(err, ios)
        implicit none
        integer(ik), intent(in) :: err, ios

        ! Select & show corresponding error message
        select case (err)
        case (1)
            print '(/a,a,5x,i0/)', '[***ERROR:] Problem in opening input file ', trim(infile), ios
        case (2)
            print '(/a/)', '[***ERROR:] Check input parameters; all times and intervals muste be > 0'
        case (3)
            print '(/a/)', '[***ERROR:] Time step is larger than the total simulation time'
        case (4)
            print '(/a/)', '[***ERROR:] Number of inital coordinates < N_obj'
        case (5)
            print '(/a,5x,i0/)', '[***ERROR:] Problem in creating output file ', ios
        case (6)
            print '(a,5x,i0)', '[***ERROR:] Problem in creating movie file ', ios
        case (7)
            print '(/a,a,5x,i0/)', '[***ERROR:] Problem in opening file ', trim(outfile), ios
        case (8)
            print '(/a,a,5x,i0/)', '[***ERROR:] Problem in opening file ', trim(moviefile), ios

        end select

        ! Stop simulation
        stop

    end subroutine errors
end module error_report
