subroutine convect(alphax, betav, deltat, phif, phi)

       
        use bounds

        implicit none
       
        double precision, intent(in) :: alphax, betav, deltat
        double precision, dimension(-15:15,-15:15,-15:15),intent(in) :: phif
        double precision, dimension(-15:15,-15:15,-15:15,500),intent(inout) :: phi
        
        double precision, dimension(-15:15,-15:15,-15:15,500) :: phi1
        double precision :: cfl, delphi
        integer :: i, j, k, ns


        cfl = betav * deltat/alphax

        do ns = 2, nspace-1
                do k = ivzmin, ivzmax

                        do j = ivymin, ivymax

                                do i = ivxmin, -1
                                        delphi = cfl * dble(i) *(phi(i,j,k,ns+1) - phi(i,j,k,ns))
                                        phi1(i,j,k,ns) = phi(i,j,k,ns) - delphi 
                                end do

                                phi1(0,j,k,ns) = phi(0,j,k,ns)

                                do i = 1, ivymax
                                        delphi = cfl * dble(i) *(phi(i,j,k,ns) - phi(i,j,k,ns-1))
                                        phi1(i,j,k,ns) = phi(i,j,k,ns) - delphi 
                                end do 

                        end do

                end do
        end do

        ! Left side boundary condition - for i>0 specular reflection of incoming (i<0) phi
        ! Normal convective update for i<0      
        ! We overwrite phi values at first space point for i>0 using -i values
        do k=ivzmin,ivzmax
                do j=ivymin,ivymax
                        do i=ivxmin,0
        
                                ! For i<0 upwind is on the right (ns+1)
                                delphi=cfl*float(i)*(phi(i,j,k,2)-phi(i,j,k,1))
                                phi1(i,j,k,1)=phi(i,j,k,1)-delphi
                        enddo
                       
                        do i=1,ivxmax
                                phi1(i,j,k,1)=phi(-i,j,k,1)
                        enddo
                enddo
        enddo
        

        ! Right side BC - Freestream inflow for i<0
        ! Normal Convective Update for i>0 
        do k=ivzmin,ivzmax
                do j=ivymin,ivymax
                        do i=ivxmin,0
                                phi1(i,j,k,nspace) = phif(i,j,k)
                        end do
                        do i = 1, ivxmax
                                delphi = cfl * dble(i) * (phi(i,j,k,nspace) - phi(i,j,k,nspace-1))
                                phi1(i,j,k,nspace) = phi(i,j,k,nspace) - delphi
                        end do

                end do

        end do

        ! Update dist funct at all poionts after convectionstep except for i = 0
        do ns = 1, nspace
                do k = ivzmin, ivzmax
                        do j = ivymin, ivymax
                                do i = ivxmin, -1
                        
                                        phi(i,j,k,ns) = phi1(i,j,k,ns)

                                end do
              
                                do i = 1, ivxmax

                                        
                                        phi(i,j,k,ns) = phi1(i,j,k,ns)

                                end do

                        end do
                end do
        end do



end subroutine convect
