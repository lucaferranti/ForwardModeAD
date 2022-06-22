module hyperbolic {
    use ForwardModeAD;

    proc sinh(a) where isDualType(a.type) {
        var f = sinh(prim(a)), 
        df = dual(a) * cosh(prim(a));
        return todual(f, df);
    }

    proc cosh(a) where isDualType(a.type) {
        var f = cosh(prim(a)), 
            df = dual(a) * sinh(prim(a));
        return todual(f, df);
    }

    proc tanh(a) where isDualType(a.type) {
        var f = tanh(prim(a)), 
            df = dual(a) * (1 - tanh(prim(a))**2);
        return todual(f, df);
    }

    proc asinh(a) where isDualType(a.type) {
        var f = asinh(prim(a)), 
            df = dual(a) / sqrt(prim(a)**2 + 1);
        return todual(f, df);
    }

    proc acosh(a) where isDualType(a.type) {
        var f = acosh(prim(a)), 
            df = dual(a) / sqrt(prim(a)**2 - 1);
        return todual(f, df);
    }

    proc atanh(a) where isDualType(a.type) {
        var f = atanh(prim(a)), 
            df = dual(a) / (1 - prim(a) ** 2);
        return todual(f, df);
    }
}