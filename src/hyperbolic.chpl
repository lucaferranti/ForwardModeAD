module hyperbolic {
    use ForwardModeAD;

    proc sinh(a) where isDualType(a.type) {
        var f = sinh(primalPart(a)), 
        df = dualPart(a) * cosh(primalPart(a));
        return todual(f, df);
    }

    proc cosh(a) where isDualType(a.type) {
        var f = cosh(primalPart(a)), 
            df = dualPart(a) * sinh(primalPart(a));
        return todual(f, df);
    }

    proc tanh(a) where isDualType(a.type) {
        var f = tanh(primalPart(a)), 
            df = dualPart(a) * (1 - tanh(primalPart(a))**2);
        return todual(f, df);
    }

    proc asinh(a) where isDualType(a.type) {
        var f = asinh(primalPart(a)), 
            df = dualPart(a) / sqrt(primalPart(a)**2 + 1);
        return todual(f, df);
    }

    proc acosh(a) where isDualType(a.type) {
        var f = acosh(primalPart(a)), 
            df = dualPart(a) / sqrt(primalPart(a)**2 - 1);
        return todual(f, df);
    }

    proc atanh(a) where isDualType(a.type) {
        var f = atanh(primalPart(a)), 
            df = dualPart(a) / (1 - primalPart(a) ** 2);
        return todual(f, df);
    }
}