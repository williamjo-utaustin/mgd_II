! ---------------------------------------------------------
! 
! maxwell_1D :: Compute the 1D Maxwellian with Subroutine
!
!
! This subroutine is defined using eta_ref=sqrt(k*T_ref/m) 
! instead of sqrt(2*k*T_ref/m)
!
!
!
! ---------------------------------------------------------
subroutine maxwell_1D(betav, ndf, uf, Tf, phif)

        ! this subroutine is cleared

        use bounds
        use constants

        implicit none

        ! input/output variables
        double precision, intent(in) :: betav, ndf, uf, Tf
        double precision, intent(out), dimension(-15:15, -15:15, -15:15) :: phif

        ! internal variables
        double precision :: Cx, Cy, Cz, Csq, norm
        double precision :: T_denom
        integer :: i, j, k

        T_denom = 0.5D0/Tf
        norm = ndf/sqrt((2D0 * pi * Tf)**3)


        ! loop through velocity space
        do k = ivzmin, ivzmax

                do j = ivymin, ivymax

                        do i = ivxmin, ivxmax


                                Cx = betav * dble(i) - uf   ! Cx = eta_x - u_x
                                Cy = betav * dble(j)        ! Cy = eta_y - u_y = eta_y
                                Cz = betav * dble(k)        ! Cz = eta_z - u_z = eta_z

                                Csq = Cx**2 + Cy**2 + Cz**2

                                phif(i,j,k) = norm * exp(-Csq * T_denom)
                                
                        end do
                end do

        end do

end subroutine maxwell_1D
