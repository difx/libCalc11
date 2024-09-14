integer(c_int) function return_double(test, N) bind(C, name="return_double")
  use, intrinsic :: iso_c_binding, only: c_double, c_int
  implicit none
  integer(c_int), intent(in), value :: N
  real(c_double), intent(out) :: test(N,2)

  return_double = 0
  test(1,1) = 2.5
  test(1,2) = 3.5
  test(2,1) = 4.5
  test(2,2) = 5.5

end function return_double

