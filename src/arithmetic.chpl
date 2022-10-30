module arithmetic {
    use ForwardModeAD;
    
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
}