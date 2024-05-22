module ElementaryFunctions {
    require "src/ForwardModeAD/DualType.chpl";
    use DualType;
    use Math;

    // Arithmetic operations
    operator +(a) where isDualType(a.type) { return a; }

    operator -(a) where isDualType(a.type) { 
        var f = -primalPart(a),
            df = -dualPart(a);
        return todual(f, df); 
    }

    operator +(a, b) where isEitherDualType(a.type, b.type) {
        var f = primalPart(a) + primalPart(b);
        var df = dualPart(a) + dualPart(b);
        return todual(f, df);
    }

    operator -(a, b) where isEitherDualType(a.type, b.type) {
        var f = primalPart(a) - primalPart(b);
        var df = dualPart(a) - dualPart(b);
        return todual(f, df);
    }

    operator *(a, b) where isEitherDualType(a.type, b.type) {
        var f = primalPart(a) * primalPart(b),
            df = dualPart(a) * primalPart(b) + primalPart(a) * dualPart(b);
        return todual(f, df);
    }

    operator /(a, b) where isEitherDualType(a.type, b.type) {
        var f = primalPart(a) / primalPart(b),
            df = (dualPart(a) * primalPart(b) - primalPart(a) * dualPart(b)) / primalPart(b) ** 2;
        return todual(f, df); 
    }

    operator **(a, b : real) where isDualType(a.type) {
        var f = primalPart(a) ** b,
            df = b * (primalPart(a) ** (b - 1)) * dualPart(a);
        return todual(f, df);
    }

    proc sqrt(a) where isDualType(a.type) {
        var f = sqrt(primalPart(a)),
            df = 0.5 * dualPart(a) / sqrt(primalPart(a));
        return todual(f, df);
    }

    proc cbrt(a) where isDualType(a.type) {
        var f = cbrt(primalPart(a)),
            df =  1.0 / 3.0 * dualPart(a) / cbrt(primalPart(a) ** 2);
        return todual(f, df);
    }

    // Trigonometric functions
    proc sin(a) where isDualType(a.type) {
        var f = sin(primalPart(a)),
            df = cos(primalPart(a)) * dualPart(a);
        return todual(f, df);
    }

    proc cos(a) where isDualType(a.type) {
        var f = cos(primalPart(a)),
            df = -sin(primalPart(a)) * dualPart(a);
        return todual(f, df);
    }

    proc tan(a) where isDualType(a.type) {
        var f = tan(primalPart(a)),
            df = dualPart(a) / (cos(primalPart(a)) ** 2);
        return todual(f, df);
    }

    proc asin(a) where isDualType(a.type) {
        var f = asin(primalPart(a)),
            df = dualPart(a) / sqrt(1 - primalPart(a)**2);
        return todual(f, df);
    }

    proc acos(a) where isDualType(a.type) {
        var f = acos(primalPart(a)),
            df = -dualPart(a) / sqrt(1 - primalPart(a)**2);
        return todual(f, df);
    }

    proc atan(a) where isDualType(a.type) {
        var f = atan(primalPart(a)),
            df = dualPart(a) / (1 + primalPart(a)**2);
        return todual(f, df);
    }

    // Trascendental functions
    operator **(a : real, b) where isDualType(b.type) {
        var f = a ** primalPart(b),
            df = log(a) * (a ** primalPart(b)) * dualPart(b);
        return todual(f, df);
    }

    operator **(a, b) where isDualType(a.type) && a.type == b.type {
        var f = primalPart(a) ** primalPart(b);
        var df = f * (dualPart(b) * log(primalPart(a)) + primalPart(b) * dualPart(a) / primalPart(a)); 
        return todual(f, df);
    }

    proc exp(a) where isDualType(a.type) {
        var f = exp(primalPart(a)),
            df = dualPart(a) * exp(primalPart(a));
        return todual(f, df);
    }

    proc exp2(a) where isDualType(a.type) {
        var f = exp2(primalPart(a)), 
            df = ln2 * exp2(primalPart(a)) * dualPart(a);
        return todual(f, df);
    }

    proc expm1(a) where isDualType(a.type) {
        var f = expm1(primalPart(a)), 
            df = exp(primalPart(a)) * dualPart(a);
        return todual(f, df);
    }

    proc log(a) where isDualType(a.type) {
        var f = log(primalPart(a)), 
            df = dualPart(a) / primalPart(a);
        return todual(f, df);
    }
    
    proc log2(a) where isDualType(a.type) {
        var f = log2(primalPart(a)), 
            df = dualPart(a)/(primalPart(a) * ln2);
        return todual(f, df);
    }

    proc log10(a) where isDualType(a.type) {
        var f = log10(primalPart(a)), 
            df = dualPart(a) / (primalPart(a) * ln10);
        return todual(f, df);
    }

    proc log1p(a) where isDualType(a.type) {
        var f = log1p(primalPart(a)), 
            df = dualPart(a) / (primalPart(a) + 1);
        return todual(f, df);
    }

    // Hyperbolic functions
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
