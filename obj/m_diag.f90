subroutine m_diag(betav, nd, xvel, yvel, zvel, phi, M_ij)

use constants
use bounds

implicit none

double precision, intent(in), dimension(500) :: nd, xvel, yvel, zvel
double precision, intent(in) :: betav
double precision, intent(in), dimension(-15:15, -15:15, -15:15, 500) :: phi

double precision, intent(out), dimension(nspace,3) :: M_ij

integer :: i, j, k, ns
double precision :: Cxsq, Cysq, Czsq, betavcubed

M_ij = 0
betavcubed = betav**3

do ns = 1, nspace
        
        do k = ivzmin, ivzmax

                do j = ivymin, ivymax
                        
                        do i = ivxmin, ivxmax
        
                                Cxsq = (betav*dble(i)-xvel(ns))**2
                                Cysq = (betav*dble(j)-yvel(ns))**2
                                Czsq = (betav*dble(k)-zvel(ns))**2                

                                M_ij(ns,1) = M_ij(ns,1) + Cxsq * phi(i,j,k,ns)
                                M_ij(ns,2) = M_ij(ns,2) + Cysq * phi(i,j,k,ns)
                                M_ij(ns,3) = M_ij(ns,3) + Czsq * phi(i,j,k,ns)
                        
                        end do
                end do
        end do

        M_ij(ns,:) = M_ij(ns,:) * betavcubed / nd(ns)

end do 

end subroutine m_diag
