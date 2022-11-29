subroutine density(betav, phi, nd)

        use bounds

        implicit none

        double precision, intent(in) :: betav
        double precision, intent(in), dimension(-15:15, -15:15, -15:15, 500) :: phi
        double precision, intent(out), dimension(500) :: nd


        integer :: i, j, k, ns
        double precision :: betacub

        
        betacub = betav**3

        do ns = 1, nspace

                nd(ns) = 0

                do k = ivzmin, ivzmax

                        do j = ivymin, ivymax

                                do i = ivxmin, ivxmax

                                        nd(ns) = nd(ns) + phi(i,j,k,ns) 
                                end do
                                
                        end do
                end do
                nd(ns) = nd(ns) * betacub
        end do
end subroutine density
