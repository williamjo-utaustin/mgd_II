program main
        
use bounds
use constants

implicit none

! declare 1D inputs (maybe make a separate module)
double precision, parameter :: alphax = 0.5D0   ! scaled x-distance between discrete points
double precision, parameter :: betav = 0.7D0    ! scaled velocity space between discrete points
double precision, parameter :: deltat = 0.05D0  !scaled discrete timestep

double precision, parameter :: ndf = 1D0        ! scaled freestream density
double precision, parameter :: uf = -2D0        ! scaled freestream velocity
double precision, parameter :: Tf = 1D0         ! scaled freestream temperature

integer, parameter :: ntstep = 1000     ! number of timesteps
integer, parameter :: nsplot = 25       ! location of phi to be plotted

logical, parameter :: bgk_reg = .False. ! turn on BGK Regular Mode
logical, parameter :: bgk_hs = .False. ! turn on BGK for Hard Spheres
logical, parameter :: es_bgk = .True. ! turn on ES-BGK

double precision, allocatable, dimension(:) :: nd, ux, vy, wz, T, tauxx, tauxy, qx
double precision, allocatable, dimension(:,:) :: ndm, uxm, vym, Tm, tauxxm, tauxym, qxm

! create allocatable arrays 
double precision, allocatable, dimension (:,:,:) :: phif
double precision, allocatable, dimension(:,:,:,:) :: phi
double precision, allocatable, dimension(:,:,:,:) :: psi

double precision, dimension(11) :: timestamp

! declare looping variables
integer :: i, j, ns, ntime, ipr

integer :: ipcount, ipindx
double precision :: t_exec, t_start, t_end

double precision :: vxmax, vxmin, vymin, vymax, vzmax, vzmin 

integer :: npr ! print interval

character(len=23) :: file_output, file_status
logical, parameter :: write2file = .True.
logical :: file_exist
double precision :: xx
double precision, dimension(nspace,3) :: M_ij, lambda_ij

npr = 100         ! print interval in timesteps

! allocate arrays
allocate(phif(-15:15, -15:15, -15:15)) 
allocate(phi(-15:15, -15:15, -15:15, 500))
allocate(psi(-15:15, -15:15, -15:15, 500))
allocate(nd(500)) 
allocate(ux(500)) 
allocate(vy(500)) 
allocate(wz(500)) 
allocate(T(500))
allocate(tauxx(500)) 
allocate(tauxy(500)) 
allocate(qx(500)) 
allocate(ndm(500,11))
allocate(uxm(500,11))
allocate(vym(500,11))
allocate(Tm(500,11))
allocate(tauxxm(500,11))
allocate(tauxym(500,11))
allocate(qxm(500,11))


if(write2file.eqv..True.) then

        write(file_output, 212)
        inquire(file = file_output, exist = file_exist)
        if(file_exist.eqv..True.) then
                file_status = "replace"
        else
                file_status = "new"
        end if

        open(unit = 12, file = file_output, form = "formatted", & 
                status = file_status, action = "write")
        
        write(file_output, 213)
        inquire(file = file_output, exist = file_exist)
        if(file_exist.eqv..True.) then
                file_status = "replace"
        else
                file_status = "new"
        end if
        open(unit = 13, file = file_output, form = "formatted", & 
                status = file_status, action = "write")

        
        write(file_output, 214)
        inquire(file = file_output, exist = file_exist)
        if(file_exist.eqv..True.) then
                file_status = "replace"
        else
                file_status = "new"
        end if
        open(unit = 14, file = file_output, form = "formatted", & 
                status = file_status, action = "write")
        
        write(file_output, 215)
        inquire(file = file_output, exist = file_exist)
        if(file_exist.eqv..True.) then
                file_status = "replace"
        else
                file_status = "new"
        end if
        open(unit = 15, file = file_output, form = "formatted", & 
                status = file_status, action = "write")

        write(file_output, 216)
        inquire(file = file_output, exist = file_exist)
        if(file_exist.eqv..True.) then
                file_status = "replace"
        else
                file_status = "new"
        end if
        open(unit = 16, file = file_output, form = "formatted", & 
                status = file_status, action = "write")
        
        write(file_output, 217)
        inquire(file = file_output, exist = file_exist)
        if(file_exist.eqv..True.) then
                file_status = "replace"
        else
                file_status = "new"
        end if
        open(unit = 17, file = file_output, form = "formatted", & 
                status = file_status, action = "write")

        write(file_output, 218)
        inquire(file = file_output, exist = file_exist)
        if(file_exist.eqv..True.) then
                file_status = "replace"
        else
                file_status = "new"
        end if
        open(unit = 18, file = file_output, form = "formatted", & 
                status = file_status, action = "write")

        write(file_output, 219)
        inquire(file = file_output, exist = file_exist)
        if(file_exist.eqv..True.) then
                file_status = "replace"
        else
                file_status = "new"
        end if
        open(unit = 219, file = file_output, form = "formatted", & 
                status = file_status, action = "write")
        
        write(file_output, 220)
        inquire(file = file_output, exist = file_exist)
        if(file_exist.eqv..True.) then
                file_status = "replace"
        else
                file_status = "new"
        end if
        open(unit = 220, file = file_output, form = "formatted", & 
                status = file_status, action = "write")

end if

212 FORMAT("../output/phistart.dat")
213 FORMAT("../output/phimid.dat")
214 FORMAT("../output/phiend.dat")
215 FORMAT("../output/Dprof.dat")
216 FORMAT("../output/Uprof.dat")
217 FORMAT("../output/Tprof.dat")
218 FORMAT("../output/Tau_xx.dat")
219 FORMAT("../output/Tau_xy.dat")
220 FORMAT("../output/Q_x.dat")

if(nspace.gt.500) then
        write(6,9003) nspace
end if

9003 format('# space points ',i3,'> max value 500. Reset!')

vxmax = betav*float(ivxmax)
vxmin = betav*float(ivxmin)
vymax = betav*float(ivymax)
vymin = betav*float(ivymin)
vzmax = betav*float(ivzmax)
vzmin = betav*float(ivzmin)

t_exec = 0D0

! if the number of timesteps specified is greater than 10
! npr (print interval) is set to 10
! if the number of timesteps is less than 10
! the print interval is set to 1

if(ntstep.gt.10) then
        npr = int(ntstep/10)
else
        npr = 1
end if

ipcount = int(ntstep/10)

if(ipcount.gt.11) then
        npr = int(ntstep/10)
end if
ipcount = npr
ipindx = 1

call cpu_time(t_start)

! Initialize phif from input conditions density (ndf), velocity (uf), temperature (Tf), output nondimensionalized distribution phif.
! Note that phif is in 3 dimensions (x,y,z)

call maxwell_1D(betav, ndf, uf, Tf, phif)


! Initialize the flowfeld with phif for ns = 1 to 100
do ns = 1, nspace
        phi(:,:,:,ns) = phif
end do

! output i, j, and phi at 0 at nsplot = 25
!do k = ivzmin, ivzmax
!        do j = ivymin, ivymax
!                do i = ivxmin, ivxmax
!                        write(6,2000) i, j, k, phi(i,j,k,nsplot)
!                end do
!        end do
!end do
!
2000 format(2i4,2x,1pe15.6)



!  Begin solution of BGK Equation

do ntime = 1, ntstep

        ! compute from phi the number density, velocity in x, y, z, temp, stresses, and heat transfer.
        ! array size will be 500 but will only need 100.
        call compute(betav, phi, nd, ux, vy, wz, T, tauxx, tauxy, qx)
        
        write(6,*) ntime,"ux", ux(1:100)
        pause
        !write(6,*) "vy", vy
        !write(6,*) "wz", wz
        !write(6,*) "T", T
        !write(6,*) "tauxx", tauxx
        !write(6,*) "tauxy", tauxy
        !write(6,*) "qx", qx
      
        ! if the count = 10 then store the data on a matrix at that timestep 
        ! this is stupid
        if(ipcount.eq.npr) then
                
                ! store data on matrix
                do ns = 1, nspace
                        
                        call prop_matrices(ns, ipindx, nd, ndm, ux, uxm, vy, vym, T, Tm, &
                                tauxx, tauxxm, tauxy, tauxym, qx, qxm)

                end do

                write(6,9002) ipindx, ntime
                
                ! reset counter
                ipcount = 1
                ipindx = ipindx + 1
        else
                ipcount = ipcount + 1
        end if
        
        if(bgk_reg.eqv..True.) then
                call krookcoll_1D(nd, ux, vy, wz, T, betav, deltat, phi)
        end if

        if(bgk_hs.eqv..True.) then
                call krookcoll_1D_hs(nd, ux, vy, wz, T, betav, deltat, phi)
        end if
        
        ! running ESBGK approximation
        if(es_bgk.eqv..True.) then
                call m_diag(betav, nd, ux, vy, wz, phi, M_ij)
                call lambda_diag(M_ij, T, lambda_ij)
                call psi_esbgk(betav, nd, ux, vy, wz, lambda_ij, psi)
                call es_bgk_1D(deltat, nd, psi, phi)
        end if

        if(ntime.eq.(ntstep/2)) then
                do j = ivymin, ivymax
                        do i = ivxmin, ivxmax
                                write(13,2000) i, j, phi(i, j, 0, nsplot)
                        end do
                end do
        end if

        call convect(alphax, betav, deltat, phif, phi)

end do

9002 FORMAT ('ipindx =',i3,5x,'ntime =',i5)

do j = ivymin, ivymax
        do i = ivxmin, ivxmax
                write(14,2000) i, j, phi(i,j,0,nsplot)
        end do
end do

call compute(betav, phi, nd, ux, vy, wz, T, tauxx, tauxy, qx)

do ns = 1, nspace
        call prop_matrices(ns, ipindx, nd, ndm, ux, uxm, vy, vym, T, Tm, tauxx, tauxxm, & 
                tauxy, tauxym, qx, qxm)
end do
call cpu_time(t_end)
t_exec = t_end - t_start

do ipr = 1, ipindx - 1
        timestamp(ipr) = float(ipr - 1) * npr * deltat
end do
timestamp(ipindx) = float(ntstep) * deltat
write(6,*) t_exec

write(*,3900) alphax,betav,deltat,ndf,uf,Tf,t_exec
write(*,3901)vxmax,vxmin,vymax,vymin,vzmax,vzmin

3900 format('alpha(x) = ',f6.3,2x,'beta(v) = ',f6.3,2x, 'delta (t) =', f6.3, &
     'Free stream: density = ',f6.3,2x, 'velocity = ',f6.3,2x,'temperature = ',f6.3, 2x, & 
     'Execution time = ',f8.2, ' s')

3901 format('vxmax=',f7.2,2x,'vxmin=',f7.2,2x,'vymax=',f7.2,2x,'vymin=', & 
        f7.2,2x,'vzmax=',f7.2,2x,'vzmin=',f7.2,2x)

write(15,3900)alphax,betav,deltat,ndf,uf,Tf,t_exec
write(16,3900)alphax,betav,deltat,ndf,uf,Tf,t_exec
write(17,3900)alphax,betav,deltat,ndf,uf,Tf,t_exec
write(18,3900)alphax,betav,deltat,ndf,uf,Tf,t_exec
write(19,3900)alphax,betav,deltat,ndf,uf,Tf,t_exec
write(20,3900)alphax,betav,deltat,ndf,uf,Tf,t_exec

write(15,3901)vxmax,vxmin,vymax,vymin,vzmax,vzmin
write(16,3901)vxmax,vxmin,vymax,vymin,vzmax,vzmin
write(17,3901)vxmax,vxmin,vymax,vymin,vzmax,vzmin
write(18,3901)vxmax,vxmin,vymax,vymin,vzmax,vzmin
write(19,3901)vxmax,vxmin,vymax,vymin,vzmax,vzmin
write(20,3901)vxmax,vxmin,vymax,vymin,vzmax,vzmin


write(15,4001)(timestamp(ipr),ipr = 1, ipindx)
write(16,4001)(timestamp(ipr),ipr = 1, ipindx)
write(17,4001)(timestamp(ipr),ipr = 1, ipindx)
write(18,4001)(timestamp(ipr),ipr = 1, ipindx)
write(19,4001)(timestamp(ipr),ipr = 1, ipindx)
write(20,4001)(timestamp(ipr),ipr = 1, ipindx)

4001 format('x',', ',11('t= ',f8.1,",",1x))          

do ns = 1, nspace
        xx=float(ns-1) * alphax
        write(15,4002) xx,(ndm(ns,ipr),ipr=1,ipindx)
        write(16,4002) xx,(uxm(ns,ipr),ipr=1,ipindx)
        write(17,4002) xx,(Tm(ns,ipr),ipr=1,ipindx)
        write(18,4002) xx,(tauxxm(ns,ipr),ipr=1,ipindx)
        write(19,4002) xx,(tauxym(ns,ipr),ipr=1,ipindx)
        write(20,4002) xx,(qxm(ns,ipr),ipr=1,ipindx)
end do

4002 format(12(f12.6,",",3x))


close(15)
close(16)
close(17)
close(18)
close(19)
close(20)



deallocate(phif)
deallocate(phi)
deallocate(psi)
deallocate(nd)
deallocate(ux)
deallocate(vy)
deallocate(wz)
deallocate(T)
deallocate(tauxx)
deallocate(tauxy)
deallocate(qx)

deallocate(ndm)
deallocate(uxm)
deallocate(vym)
deallocate(Tm)
deallocate(tauxxm)
deallocate(tauxym)
deallocate(qxm)

end program main
