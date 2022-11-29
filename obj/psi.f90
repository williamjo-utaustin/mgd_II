subroutine psi_esbgk(betav, nd, xvel, yvel, zvel, lambda_ij, psi)

use bounds
use constants

implicit none

double precision, intent(in) :: betav
double precision, intent(in), dimension(500) :: nd, xvel, yvel, zvel
double precision, intent(in), dimension(nspace, 3) :: lambda_ij
double precision, intent(out), dimension(-15:15, -15:15, -15:15, 500) :: psi



integer :: ns, i, j, k
double precision :: Ci_Eij_Cj, det_lambda, Cxsq, Cysq, Czsq

do ns = 1, nspace

        det_lambda = lambda_ij(ns,1) * lambda_ij(ns,2) *lambda_ij(ns,3)
        
        do k = ivzmin, ivzmax

                do j = ivymin, ivymax

                        do i = ivxmin, ivxmax
                                
                                Cxsq = (betav * dble(i) - xvel(ns))**2
                                Cysq = (betav * dble(j) - yvel(ns))**2
                                Czsq = (betav * dble(k) - zvel(ns))**2

                                Ci_Eij_Cj = Cxsq/lambda_ij(ns,1) + & 
                                        Cysq/lambda_ij(ns,2) + Czsq/lambda_ij(ns,3)
                                
                                psi(i,j,k,ns) = nd(ns)/((2D0*pi)**(3D0/2D0)) * & 
                                        (1D0/sqrt(det_lambda)) * exp(-0.5 * Ci_Eij_Cj)

                        end do



                end do


        end do
         


end do



end subroutine psi_esbgk
