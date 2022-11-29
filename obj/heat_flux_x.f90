subroutine heat_flux_x(betav, phi, xvel,yvel,zvel,qx)

        use bounds

        implicit none

        double precision, intent(in) :: betav
        double precision, intent(in), dimension(-15:15, -15:15, -15:15, 500) :: phi
        double precision, intent(in), dimension(500) :: xvel, yvel, zvel
        double precision, intent(out), dimension(500) :: qx

        integer :: i, j, k, ns
        double precision :: betacub, Cx, Cy, Cz, Csq
        
        betacub = betav**3D0

        do ns = 1, nspace

                qx(ns) = 0D0

                do k = ivzmin, ivzmax

                        do j = ivymin, ivymax

                                do i = ivxmin, ivxmax

                                        Cx = (betav*dble(i)-xvel(ns))
                                        Cy = (betav*dble(j)-yvel(ns)) 
                                        Cz = (betav*dble(k)-zvel(ns)) 
                                        Csq = Cx**2D0 + Cy**2D0 + Cz**2D0 
                                                             
                                        qx(ns) = qx(ns) + phi(i,j,k,ns) * Cx * Csq
                                end do
                                
                        end do
                end do
                qx(ns) = qx(ns) * 0.5 * betacub
        end do
end subroutine heat_flux_x
