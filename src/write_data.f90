! This module contains subroutines for writing data to output files & screen
module write_data
  use constants
  use potential
  use error_report
contains
  subroutine writedata(pos,v,t,mass,Nobj,Frame)
    implicit none
    real(rk),intent(in) :: pos(:,:), v(:,:), t, mass(:)
    integer(ik),intent(in) :: Nobj, Frame
    integer(ik) :: i, ios

    ! write data to output file
    open(unit=2,file=outfile,iostat=ios,status='old',position='append')
    if (ios/=0) call errors(7_ik,ios)  ! stop if errors occur
    do i=1,Nobj
       write(2,'(I3,4(ES15.6))') i,pos(i,1:3),t
    end do
    close(2)

    ! write data to movie file
    open(unit=3,file=moviefile,iostat=ios,status='old',position='append')
    if (ios/=0) call errors(8_ik,ios) ! stop if errors occur
    write(3,'(I5)') Nobj
    write(3,'(A,I7,A,ES15.6,A)') 'Frame number:',Frame,'; Time: ',t,' s'
    do i=1,Nobj
       write(3,'(I3,x,3(ES15.6,x))') i,pos(i,1:3)
    end do
        close(3)
  end subroutine writedata


  ! Print mass, distance to sun etc. to screen
  subroutine printdata(p,v,t,mass,Nobj,niter,nwrite,maxtime,names)
    implicit none
    real(rk),intent(in) :: p(:,:), v(:,:), t, mass(:), maxtime
    integer(ik),intent(in) :: Nobj, niter, nwrite
    character(*),intent(in) :: names(:)
    integer(ik) :: i, ios

    print '(/''Time '',ES15.6,'' s'',8x,''('',F5.1,'' %)'')', t, 100*t/maxtime
    print '(''E_tot '',ES15.6)', Etot(p,v,mass,Nobj)
    print '(I12,A,A,I2,A)', niter, ' iterations', ' for ',Nobj,' objects'
    print '(I5,A,A)', nwrite,' times written to ', outfile
    print '(/A,/50(''-''))', 'M_sols      Dist. to origin [AU]'
    do i=1,Nobj
       print '(ES10.3,ES15.5,4x,A)', mass(i), sqrt((p(i,1)-p(1,1))**2+(p(i,2)-p(1,2))**2+(p(i,3)-p(1,3))**2),names(i)
    end do
    print '(/8(A,3x))', 'ID','M_sols',' x [AU]','y [AU]','z [AU]','v_x [AU/s]','v_y [AU/s]','v_z [AU/s]'
    print '(85(''-''))'
    do i=1,Nobj
       print '(I2,x,ES10.3,3(F9.3),3x,3(ES10.3,2x),A)', i,mass(i),p(i,1:3),v(i,1:3), names(i)
    end do
        print *,
  end subroutine printdata


  ! Print inital parameters and data to screen
  subroutine printinitdata(pos,v,t,dt,maxtime,saveint,mass,Nobj,names)
    implicit none
    real(rk),intent(in) :: pos(:,:), v(:,:), t, dt, maxtime ,mass(:)
    integer(ik),intent(in) :: Nobj, saveint
    character(*),intent(in) :: names(:)
    integer(ik) :: i

    print '(/50(''='')/,10x,A,/50(''=''))', '[ STARTING SIMULATION... ]'
    print '(A,I0,/A,F10.4)', 'Number of objects: ',Nobj,'Time step [s]: ',dt
    print '(A,ES15.4,/A,I10/)', 'Simulation length [s] :',maxtime,'Time between data writes [s] :',saveint
    print '(/8(A,3x))', 'ID','M_sols',' x [AU]','y [AU]','z [AU]','v_x [AU/s]','v_y [AU/s]','v_z [AU/s]'
    print '(85(''-''))'
    do i=1,Nobj
       print '(I2,x,ES10.3,3(F9.3),3x,3(ES10.3,2x),A)', i,mass(i),pos(i,1:3),v(i,1:3),names(i)
    end do
    print *,
  end subroutine printinitdata

end module write_data
