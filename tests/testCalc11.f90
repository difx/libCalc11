program testCalc11
implicit none


!INCLUDE 'cuser11.i'
INCLUDE 'd_input.i'
!INCLUDE 'cmxut11.i'

!      Character*132 rmIM
!      CHARACTER*128 Calcfiles(2000), IMfiles(2000)
!      Integer*4 ILU, I, J, Num_scans, K, ierr, Kjob
!      Integer*4 lu_out, fd_out
!
Integer*4 Kjob, Num_scans, J

Logical  exist

!
! 1.2.8 PROGRAM VARIABLES -
!           ILU  - The message LU, set to 6. [Not used anywhere?]
!  Define the calc mode:

!
Kjob = 1
!

      
!   Initialize calc 
CALL calcinit()

call load_ant('AK01', 'AZEL', 0.00000d0, -2556088.476234d0,   5097405.971301d0,   -2848428.398018d0)
call load_ant('AK02', 'AZEL', 0.00000d0, -2556109.97953037d0, 5097388.70113492d0, -2848440.13354315d0)
call load_ant('AK03', 'AZEL', 0.00000d0, -2556121.90976612d0, 5097392.35165232d0, -2848421.53643228d0)

call load_eop(60252, 37, 0.2672, 0.2618,  0.01248)
call load_eop(60253, 37, 0.2654, 0.2600,  0.01287)
call load_eop(60254, 37, 0.2636, 0.2583,  0.01312)
call load_eop(60255, 37, 0.2618, 0.2567,  0.01318)
call load_eop(60256, 37, 0.2599, 0.2550,  0.01304)
call load_eop(60257, 37, 0.2581, 0.2534,  0.01272)
     
!   Initialize the model modules and the necessary utilities.
CALL dINITL(Kjob)

call load_source(1, '1934-638', 5.1d0, -1.0d0)
call runcalc(60255.68715277778d0, 60255.6875d0)

call load_source(1, 'Test', 4.9d0, -1.0d0)
call runcalc(60255.78715277778d0, 60255.7875d0)

end program testCalc11
