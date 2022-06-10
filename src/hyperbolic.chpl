module hyperbolic {
    use ForwardModeAD;

    proc sinh(a : DualNumber) {return new DualNumber(sinh(prim(a)), dual(a) * cosh(prim(a)));}

    proc cosh(a : DualNumber) {return new DualNumber(cosh(prim(a)), dual(a) * sinh(prim(a)));}

    proc tanh(a : DualNumber) {return new DualNumber(tanh(prim(a)), dual(a) * (1 - tanh(prim(a))**2));}

    proc asinh(a : DualNumber) {return new DualNumber(asinh(prim(a)), dual(a) / sqrt(prim(a)**2 + 1));}

    proc acosh(a : DualNumber) {return new DualNumber(acosh(prim(a)), dual(a) / sqrt(prim(a)**2 - 1));}

    proc atanh(a : DualNumber) {return new DualNumber(atanh(prim(a)), dual(a) / (1 - prim(a) ** 2));}
}