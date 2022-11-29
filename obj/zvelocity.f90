subroutine zvelocity(betav, phi, nd, zvel)

        use bounds

        implicit none

        double precision, intent(in) :: betav
        double precision, intent(in), dimension(-15:15, -15:15, -15:15, 500) :: phi
        double precision, intent(in), dimension(500) :: nd
        double precision, intent(inout), dimension(500) :: zvel


        integer :: i, j, k, ns
        double precision :: betacub

        
        betacub = betav**3

        do ns = 1, nspace

                zvel(ns) = 0

                do k = ivzmin, ivzmax

                        do j = ivymin, ivymax

                                do i = ivxmin, ivxmax
                                        
                                        zvel(ns) = zvel(ns) + phi(i,j,k,ns) * betav * dble(k) 
                                end do
                                
                        end do
                end do
                zvel(ns) = zvel(ns) * betacub/nd(ns)
        end do
end subroutine zvelocity
