program main
        
        use bounds

        implicit none

        double precision, parameter :: alphax = 0.5D0
        double precision, parameter :: betav = 0.7D0
        double precision, parameter :: deltat = 0.05D0


        double precision :: ndf, uf, Tf

        double precision, allocatable, dimension (:,:,:) :: phif
        double precision, allocatable, dimension(:,:,:,:) :: phi

        allocate(phif(-15:15, -15:15, -15:15)) 
        allocate(phi(-15:15, -15:15, -15:15, 500)) 
        ndf = 1D0
        uf = -1D0
        Tf = 1D0


        call maxwell_1D(betav, ndf, uf, Tf, phif)
        write(6,*) sum(phif)
        call convect(alphax, betav, deltat, phif, phi) 
        write(6,*) sum(phi)
        deallocate(phif)
        deallocate(phi)


end program main
