subroutine krookcoll_1D(dens, xvel, yvel, zvel, temp, betav, deltat, phi)

        use constants
        use bounds
       
        implicit none

        double precision, intent(in), dimension(500) :: dens, xvel, yvel, zvel, temp
        double precision, intent(in) :: betav, deltat
        double precision, intent(inout), dimension(-15:15, -15:15, -15:15, 500) :: phi

        double precision :: Cxsq, Cysq, Czsq, Csq, phieq, delphi, normfac, T_denom
        integer :: i, j, k, ns


        do ns = 1, nspace

                normfac = dens(ns)/sqrt((2D0 * pi * temp(ns))**3)
                T_denom = 0.5/temp(ns)

                do k = ivzmin, ivzmax

                        do j = ivymin, ivymax
                                
                                do i = ivxmin, ivxmax

                                        Cxsq = (betav*dble(i)-xvel(ns))**2
                                        Cysq = (betav*dble(j)-yvel(ns))**2
                                        Czsq = (betav*dble(k)-zvel(ns))**2

                                        Csq = Cxsq + Cysq + Czsq

                                        phieq = normfac * exp(-Csq * T_denom)
                                        delphi = deltat * (2D0/sqrt(pi)) * dens(ns) * (phieq - phi(i,j,k,ns))
                                        phi(i,j,k,ns) = phi(i,j,k,ns) + delphi

                                end do
                        end do

                end do
        end do





end subroutine krookcoll_1D
