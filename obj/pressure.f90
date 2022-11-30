subroutine pressure(nd, T, p)

    use bounds
    use constants

    implicit none

    double precision, intent(in), dimension(500) :: nd, T
    double precision, intent(out), dimension(500) :: p

    integer :: ns

    do ns = 1, nspace

        p(ns) = nd(ns) * T(ns)

    end do
end subroutine pressure