subroutine es_bgk_1D(deltat, nd, psi, phi)

        use constants
        use bounds
       
        implicit none

        double precision, intent(in), dimension(500) :: nd
        double precision, intent(in) :: deltat
        double precision, intent(in), dimension(-15:15, -15:15, -15:15, 500) :: psi
        double precision, intent(inout), dimension(-15:15, -15:15, -15:15, 500) :: phi

        integer :: i, j, k, ns
        double precision :: delphi
        
        do ns = 1, 500

                do k = ivzmin, ivzmax

                        do j = ivymin, ivymax
                                
                                do i = ivxmin, ivxmax
                                        
                                        delphi = deltat * nd(ns) * (4D0/(3D0*sqrt(pi))) * (psi(i,j,k,ns) - phi(i,j,k,ns)) 
                                        phi(i,j,k,ns) = phi(i,j,k,ns) + delphi

                                end do
                        end do

                end do
        end do





end subroutine es_bgk_1D
