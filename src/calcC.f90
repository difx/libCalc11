subroutine calcinit_c () bind(c, name="calcinit_c")
  use, intrinsic :: iso_c_binding
  call calcinit()
end subroutine calcinit_c

subroutine dinitl_c () bind(c, name="dinitl_c")
  use, intrinsic :: iso_c_binding
  call dinitl(1)
end subroutine dinitl_c

integer(c_int) function load_ant_c(site_name, ant_axis, axis_off, x, y, z) bind(C, name="load_ant_c")
  use, intrinsic :: iso_c_binding
  implicit none
  character(c_char), dimension(*), intent(in) :: site_name, ant_axis
  real(c_double), intent(in), value :: axis_off, x, y, z
  character(len=8) :: site_name_f
  character(len=4) :: ant_axis_f
  integer load_ant

  call cf_str_copy(site_name_f, site_name)
  call cf_str_copy(ant_axis_f, ant_axis)
  load_ant_c =  load_ant(site_name_f, ant_axis_f, axis_off, x, y, z) 
end function load_ant_c

integer(c_int) function load_source_c(src_name, ra, dec) bind(C, name="load_source_c")
  use, intrinsic :: iso_c_binding, only: c_int, c_char, c_double
  implicit none
  character(c_char), dimension(*), intent(in) :: src_name
  real(c_double), intent(in), value :: ra, dec
  include 'cmxsr11.i'
  character(len=MAX_ARC_SRC) :: src_name_f
  integer load_source

  call cf_str_copy(src_name_f, src_name)
  load_source_c =  load_source(src_name_f, ra, dec) 
end function load_source_c

integer(c_int) function load_eop_c(mjd, taiutc, ut1utc, xpole, ypole) bind(C, name="load_eop_c")
  use, intrinsic :: iso_c_binding, only: c_int, c_float
  implicit none
  integer(c_int), intent(in), value :: mjd, taiutc
  real(c_float), intent(in), value :: ut1utc, xpole, ypole
  integer load_eop

  load_eop_c = load_eop(mjd, taiutc, ut1utc, xpole, ypole) 
end function load_eop_c

subroutine runcalc_c(mjdstart, mjdstop) bind(C, name="runcalc_c")
  use, intrinsic :: iso_c_binding, only: c_double
  implicit none
  real(c_double), intent(in), value :: mjdstart, mjdstop
  call runcalc(mjdstart, mjdstop) 
end subroutine runcalc_c


! subroutine to copy C strings to fortran strings
subroutine cf_str_copy(f_str, c_str)
  use, intrinsic :: iso_c_binding, only: c_char, c_null_char
  implicit none
  character(len=*), intent(inout) :: f_str
  character(kind=c_char), dimension(*), intent(in) :: c_str
  integer :: i, c_len

  ! How long is C str
  c_len=0
  do
     if (c_str(c_len+1) == C_NULL_CHAR) exit
     c_len = c_len + 1
  end do

  ! copy characters from the c string to the fortran string
  do i = 1, min(len(f_str), c_len)
     f_str(i:i) = c_str(i)
  end do

  ! Pad the remaining part of f_str with spaces
  if (c_len < len(f_str)) then
     f_str(c_len+1:len(f_str)) = ' '
  end if
end subroutine cf_str_copy
