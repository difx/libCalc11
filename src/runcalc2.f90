integer(c_int) function runcalc2_c(mjdstart, delay, U, V, W, maxStation) bind(C, name="runcalc2_c")
  use, intrinsic :: iso_c_binding, only: c_int, c_double
  implicit none
  real(c_double), intent(in), value :: mjdstart
  real(c_double), intent(inout) :: delay(6,maxStation)
  real(c_double), intent(inout) :: U(6,maxStation)
  real(c_double), intent(inout) :: V(6,maxStation)
  real(c_double), intent(inout) :: W(6,maxStation)
  integer(c_int), intent(in), value :: maxStation
  include 'd_input.i'
  integer :: J

  runcalc2_c = 0
  call set_times(mjdstart, mjdstart+1.0d0/(60*24))
      
  call dSCAN(1, 1)

  ! If too many polynomials will be generated
  if (Intrvls2min>1) then
     runcalc2_c = -2
     return
  end if

  !   Begin the 2-minute interval processing loop
  do J = 1, Intrvls2min     ! 2-minute interval loop
     call dDRIVR(1,J)

     !  Fit polynomial to coefficents and store values
     call makePoly(maxStation, delay, U, V, W)

  enddo
  
end function runcalc2_c


