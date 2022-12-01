subroutine lambda_diag(M_ij, T, lambda_ij)

use constants
use bounds

implicit none

double precision, intent(in), dimension(500) :: T
double precision, intent(in), dimension(500,3) :: M_ij

double precision, intent(out), dimension(500,3) :: lambda_ij
integer :: ns, i
double precision :: lam_esbgk

lam_esbgk = -0.5D0

!lambda_esbgk = -0.5 (stored in constants)

do ns = 1, 500
        
        do i = 1, 3
                
                lambda_ij(ns,i) = (1D0-lam_esbgk) * T(ns)  + lam_esbgk * M_ij(ns,i)

        end do

end do


end subroutine lambda_diag
