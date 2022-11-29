subroutine temp(betav, phi, dens, xvel,Tcal)

        use bounds

        implicit none

        double precision, intent(in) :: betav
        double precision, intent(in), dimension(-15:15, -15:15, -15:15, 500) :: phi
        double precision, intent(in), dimension(500) :: dens, xvel
        double precision, intent(out), dimension(500) :: Tcal


        integer :: i, j, k, ns
        double precision :: betasq, betacub, Cxsq, Cysq, Czsq, Csq
        
        betasq = betav**2D0
        betacub = betav**3D0

        do ns = 1, nspace

                Tcal(ns) = 0D0

                do k = ivzmin, ivzmax

                        do j = ivymin, ivymax

                                do i = ivxmin, ivxmax

                                        Cxsq = (betav*dble(i)-xvel(ns))**2D0
                                        Cysq = betasq*dble(j*j)
                                        Czsq = betasq*dble(k*k)
                                        Csq = Cxsq + Cysq + Czsq 
                                                             
                                        Tcal(ns) = Tcal(ns) + phi(i,j,k,ns) * Csq
                                end do
                                
                        end do
                end do
                Tcal(ns) = Tcal(ns) * betacub / (3D0 * dens(ns))
        end do
end subroutine temp
