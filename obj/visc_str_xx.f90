subroutine visc_str_xx(betav, phi, xvel, yvel, zvel, tauxx)

        use bounds

        implicit none

        double precision, intent(in) :: betav
        double precision, intent(in), dimension(-15:15, -15:15, -15:15, 500) :: phi
        double precision, intent(in), dimension(500) :: xvel, yvel, zvel
        double precision, intent(out), dimension(500) :: tauxx

        integer :: i, j, k, ns
        double precision :: betacub, Cx, Cy, Cz, Csq
        
        betacub = betav**3D0

        do ns = 1, 500

                tauxx(ns) = 0D0

                do k = ivzmin, ivzmax

                        do j = ivymin, ivymax

                                do i = ivxmin, ivxmax

                                        Cx = (betav*dble(i)-xvel(ns))
                                        Cy = (betav*dble(j)-yvel(ns)) 
                                        Cz = (betav*dble(k)-zvel(ns)) 
                                        Csq = Cx**2D0 + Cy**2D0 + Cz**2D0 
                                                             
                                        tauxx(ns) = tauxx(ns) + phi(i,j,k,ns) * (-Cx*Cx+Csq/3D0)
                                end do
                                
                        end do
                end do
                tauxx(ns) = tauxx(ns) * betacub
        end do
end subroutine visc_str_xx
