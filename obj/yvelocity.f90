subroutine yvelocity(betav, phi, nd, yvel)

        use bounds

        implicit none

        double precision, intent(in) :: betav
        double precision, intent(in), dimension(-15:15, -15:15, -15:15, 500) :: phi
        double precision, intent(in), dimension(500) :: nd
        double precision, intent(inout), dimension(500) :: yvel


        integer :: i, j, k, ns
        double precision :: betacub

        
        betacub = betav**3

        do ns = 1, 500

                yvel(ns) = 0

                do k = ivzmin, ivzmax

                        do j = ivymin, ivymax

                                do i = ivxmin, ivxmax

                                        yvel(ns) = yvel(ns) + phi(i,j,k,ns) * betav * dble(j) 
                                end do
                                
                        end do
                end do
                yvel(ns) = yvel(ns) * betacub/nd(ns)
        end do
end subroutine yvelocity
