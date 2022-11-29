subroutine compute(betav, phi, nd, ux, vy, wz, T, tauxx, tauxy, qx)

        implicit none
        double precision :: betav
        double precision, dimension(-15:15,-15:15,-15:15, 500) :: phi
        double precision, dimension(500) :: nd, ux, vy, wz, T, tauxx, tauxy, qx

        call density(betav, phi, nd)
        call xvelocity(betav, phi, nd, ux)
        call yvelocity(betav, phi, nd, vy)
        call zvelocity(betav, phi, nd, wz)
        call temp(betav, phi, nd, ux, T)
        call visc_str_xx(betav, phi, ux, vy, wz, tauxx)
        call visc_str_xy(betav, phi, ux, vy, tauxy)
        call heat_flux_x(betav, phi, ux, vy, wz, qx)        

end subroutine compute


subroutine prop_matrices(ns, ipindx, nd, ndm, ux, uxm, vy, vym, T, Tm, tauxx, tauxxm, tauxy, tauxym, qx, qxm)
        
        implicit none

        integer, intent(in) :: ns, ipindx

        double precision, dimension(500), intent(in) :: nd, ux, vy, T, tauxx, tauxy, qx
        double precision, dimension(500, 11), intent(inout) :: ndm, uxm, vym, Tm, tauxxm, tauxym, qxm

        ndm(ns, ipindx) = nd(ns)
        uxm(ns, ipindx) = ux(ns) 
        vym(ns, ipindx) = vy(ns)
        Tm (ns, ipindx) = T(ns)
        tauxxm (ns, ipindx) = tauxx(ns)
        tauxym (ns, ipindx) = tauxy(ns)
        qxm (ns, ipindx) = qx(ns)

end subroutine prop_matrices
