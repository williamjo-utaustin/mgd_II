subroutine visc_str_xy(betav, phi, xvel, yvel, tauxy)

        use bounds

        implicit none

        double precision, intent(in) :: betav
        double precision, intent(in), dimension(-15:15, -15:15, -15:15, 500) :: phi
        double precision, intent(in), dimension(500) :: xvel, yvel
        double precision, intent(out), dimension(500) :: tauxy

        integer :: i, j, k, ns
        double precision :: betacub, Cx, Cy
        
        betacub = betav**3D0

        do ns = 1, nspace

                tauxy(ns) = 0D0

                do k = ivzmin, ivzmax

                        do j = ivymin, ivymax

                                do i = ivxmin, ivxmax

                                        Cx = (betav*dble(i)-xvel(ns))
                                        Cy = (betav*dble(j)-yvel(ns)) 
                                                             
                                        tauxy(ns) = tauxy(ns) + phi(i,j,k,ns) * (-Cx*Cy)
                                end do
                                
                        end do
                end do
                tauxy(ns) = tauxy(ns) * betacub
        end do
end subroutine visc_str_xy
