subroutine makePoly(maxStation, delay)
  implicit none
  integer, intent(in) :: maxStation ! Total number of stations in array
  real*8, intent(inout) :: delay(6,maxStation)
  
  include 'cmxsr11.i'

  Real*8 Delay6(10), Atmdry6(10), Atmwet6(10), Ubase6(10),          &
       &       Vbase6(10), Wbase6(10), Acoef(10), delta, El6(10), Az6(10)

  Real*8 JDY2K
  Integer*4 I, J, K, I1, I6, UTCsec, ierr, MJD, Isec, N, M, II, L, ISRC
  Integer*4 Numtel
  Integer*4 fitPoly
  include 'cmxst11.i'
  include 'c2poly.i'
  include 'd_input.i'

  Numtel = Numsite - 1

  N = 6
  M = 1
  delta = 24.
  iSrc = 1

! MJD and seconds (out of 86400) at I1 time
  MJD = JDY2K(Iymdhms_f(1,1),Iymdhms_f(1,2),Iymdhms_f(1,3)) - 2400000.D0 
  Isec = Iymdhms_f(1,6) + Iymdhms_f(1,5)*60. + Iymdhms_f(1,4)*3600. 
!
!       write(*,*) "SCAN", Iscan-1, "POLY", J2m-1," MJD:", MJD
!       write(*,*) "SCAN", Iscan-1, " POLY", J2m-1, " SEC:", Isec
!     
  do J = 1, Numtel         ! Station loop 
     do K = 1, N 
        Delay6(K)  = -Delay_f(K,1,J,ISRC) * 1.D6
        Atmdry6(K) = Atmdryd_f(1,K,1,J,ISRC) * 1.D6
        Atmwet6(K) = Atmwetd_f(1,K,1,J,ISRC) * 1.D6
        Ubase6(K)  = Ubase_f(K,1,J,ISRC)
        Vbase6(K)  = Vbase_f(K,1,J,ISRC)
        Wbase6(K)  = Wbase_f(K,1,J,ISRC)
        El6(K)     = El_f(1,K,1,J,ISRC)
        Az6(K)     = Az_f(1,K,1,J,ISRC)
     enddo
         
!    Use to C routine fitPoly to compute polynomial coefficients

     ierr = fitPoly(Acoef, Delay6, %VAL(n), %VAL(m), %VAL(delta))
     do I = 1,N
        delay(I,J) = Acoef(I)
     enddo
     
     ierr = fitPoly(Acoef, Atmdry6, %VAL(n), %VAL(m), %VAL(delta))
     ierr = fitPoly(Acoef, Atmwet6, %VAL(n), %VAL(m), %VAL(delta))
     ierr = fitPoly(Acoef, Az6, %VAL(n), %VAL(m), %VAL(delta))
     ierr = fitPoly(Acoef, El6, %VAL(n), %VAL(m), %VAL(delta))
     ierr = fitPoly(Acoef, Ubase6, %VAL(n), %VAL(m), %VAL(delta))
     ierr = fitPoly(Acoef, Vbase6, %VAL(n), %VAL(m), %VAL(delta))
     ierr = fitPoly(Acoef, Wbase6, %VAL(n), %VAL(m), %VAL(delta))
  enddo                  ! Station loop
end subroutine makePoly
