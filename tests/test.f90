PROGRAM MainProgram
  ! Include file with common block declaration
  INCLUDE 'cmxut11.i'

   ! Call subroutine that uses common block
  CALL SubA
  Write(6,'("*2*UT1IF(4) ",4F15.6)') UT1IF

  call SubB
  Write(6,'("*2*UT1IF(4) ",4F15.6)') UT1IF

  
END PROGRAM MainProgram
