! This module contains functions for planetary acceleration & total energy calculations
module potential
  use constants
contains
  ! Calculate the acceleration due to gravity on all objects
  function acc(pos,mass,Nobj) result(a)
    implicit none
    real(rk), dimension(:), intent(in) :: mass
    integer(ik), intent(in) :: Nobj
    real(rk), dimension(:,:), intent(in) :: pos
    real(rk), allocatable :: a(:,:)
    integer(ik) :: i, j, k
    real(rk) :: r

    allocate(a(Nobj,3))
    a=0
       do i=1,Nobj
          do j=1,Nobj
             if (i.eq.j) cycle  ! No need to calculate effect on oneself
             r=((pos(i,1)-pos(j,1))**2 + (pos(i,2)-pos(j,2))**2 + (pos(i,3)-pos(j,3))**2)**(1.5)
             a(i,1)=a(i,1)+G*mass(j)*(pos(j,1)-pos(i,1))/(r)
             a(i,2)=a(i,2)+G*mass(j)*(pos(j,2)-pos(i,2))/(r)
             a(i,3)=a(i,3)+G*mass(j)*(pos(j,3)-pos(i,3))/(r)
          end do
       end do
     end function acc


     ! Calculate total energy of the system
     real(rk) function Etot(p,v,m,Nobj)
       implicit none
       real(rk), dimension(:), intent(in) :: m
       real(rk), dimension(:,:), intent(in) :: p, v
       integer(ik), intent(in) :: Nobj
       real(rk) :: r_len
       integer(ik) :: j, k

       Etot=0
       do k=1,Nobj
          do j=1,Nobj
             if (k .eq. j) cycle
             r_len=sqrt( (p(k,1)-p(j,1))**2 + (p(k,2)-p(j,2))**2 + (p(k,3)-p(j,3))**2)
             Etot = Etot - 0.5*G*m(k)*m(j)/r_len  ! Potential energy
          end do
          Etot = Etot + 0.5*m(k)*(v(k,1)**2+v(k,2)**2+v(k,3)**2)  ! Kinetic energy
       end do
     end function Etot

   end module potential
