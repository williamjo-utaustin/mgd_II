subroutine heat_flux_z(betav, phi, xvel, yvel, zvel, qz)

        use bounds

        implicit none

        double precision, intent(in) :: betav
        double precision, intent(in), dimension(-15:15, -15:15, -15:15, 500) :: phi
        double precision, intent(in), dimension(500) :: xvel, yvel, zvel
        double precision, intent(out), dimension(500) :: qz

        integer :: i, j, k, ns
        double precision :: betacub, Cx, Cy, Cz, Csq
        
        betacub = betav**3D0

        do ns = 1, nspace

                qz(ns) = 0D0

                do k = ivzmin, ivzmax

                        do j = ivymin, ivymax

                                do i = ivxmin, ivxmax

                                        Cx = (betav*dble(i)-xvel(ns))
                                        Cy = (betav*dble(j)-yvel(ns)) 
                                        Cz = (betav*dble(k)-zvel(ns)) 
                                        Csq = Cx**2D0 + Cy**2D0 + Cz**2D0 
                                                             
                                        qz(ns) = qz(ns) + phi(i,j,k,ns) * Cz * Csq
                                end do
                                
                        end do
                end do
                qz(ns) = qz(ns) * 0.5 * betacub
        end do
end subroutine heat_flux_z
