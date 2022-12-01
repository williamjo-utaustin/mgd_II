subroutine xvelocity(betav, phi, nd, xvel)

        use bounds

        implicit none

        double precision, intent(in) :: betav
        double precision, intent(in), dimension(-15:15, -15:15, -15:15, 500) :: phi
        double precision, intent(in), dimension(500) :: nd
        double precision, intent(inout), dimension(500) :: xvel

        integer :: i, j, k, ns
        double precision :: betacub

        
        betacub = betav**3

        do ns = 1, 500

                xvel(ns) = 0

                do k = ivzmin, ivzmax

                        do j = ivymin, ivymax

                                do i = ivxmin, ivxmax

                                        xvel(ns) = xvel(ns) + phi(i,j,k,ns) * betav * dble(i) 
                                end do
                                
                        end do
                end do
                xvel(ns) = xvel(ns) * betacub/nd(ns)
                
        end do
end subroutine xvelocity
