! Main program file

program main
    use constants
    use read_input
    use potential
    use write_data
    implicit none
    integer(ik) :: frame = 0, i, j, niter = 0, nwrite = 0, printint, saveint, N
    real(rk) :: t = 0, dt, maxtime, v_new(3), pos_new(3), pos_old(3), t1, t2
    real(rk), allocatable :: v(:, :), a(:, :), pos(:, :), Fpot(:, :), mass(:), a_new(:, :)

    ! Get initial system time (used for measuring execution time)
    call cpu_time(t1)

    ! Parse input data
    call get_input(param, obj_data, names)
    Nobj = param(1)                  ! number of planets
    dt = param(2)                    ! time step
    maxtime = param(3)               ! Total simulation time
    saveint = param(4)               ! Time between writing data to file
    printint = param(5)              ! Time between printing data to screen
    allocate (v(Nobj, 3), pos(Nobj, 3), a(Nobj, 3), Fpot(Nobj, 3), mass(Nobj), a_new(Nobj, 3))
    mass = obj_data(1:Nobj, 1)       ! masses of all objects
    pos = obj_data(1:Nobj, 2:4)      ! positions  --||--
    v = obj_data(1:Nobj, 5:7)        ! velocities --||--

    ! Print initial data to screen
    call printinitdata(pos, v, t, dt, maxtime, saveint, mass, Nobj, names)

    ! Initiate simulation
    N = nobj
    a = acc(pos, mass, N)    ! get initial accelerations for all objects

    main_loop: do while (t < maxtime)
        ! Update positions x(t+dt), y(t+dt), ...
        pos(1:N, 1:3) = pos(1:N, 1:3) + v(1:N, 1:3)*dt + 0.5*a(1:N, 1:3)*dt**2
        ! Update accelerations, a(t+dt)
        a_new = acc(pos, mass, N)
        ! Update velocities v(t+dt)
        v(1:N, 1:3) = v(1:N, 1:3) + 0.5*(a_new(1:N, 1:3) + a(1:N, 1:3))*dt

        a = a_new
        t = t + dt          ! Increase time passed
        niter = niter + 1   ! Increment iteration count

        ! Write data to file (every saveint:th iteration)
        if (mod(niter, saveint) == 0) then
            frame = frame + 1
            call writedata(pos, v, t, mass, N, frame)
            nwrite = nwrite + 1
        end if

        ! Print data to screen (every printint:th iteration)
        if (mod(niter, printint) == 0) then
            call printdata(pos, v, t, mass, N, niter, nwrite, maxtime, names)
        end if

    end do main_loop

    ! Print final positions to screen
    call cpu_time(t2)
    print '(/50(''='')/,12x,A,/50(''=''))', '[ SIMULATION COMPLETED! ]'
    print '(/A,E15.5,A)', 'Total simulation time: ', t, ' s'
    print '(A,F10.5,A)', 'Elapsed CPU time: ', t2 - t1, ' s'
    call printdata(pos, v, t, mass, N, niter, nwrite, maxtime, names)

end program main
