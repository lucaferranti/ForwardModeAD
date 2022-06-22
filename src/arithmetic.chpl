module arithmetic {
    use ForwardModeAD;
    
    operator +(a) where isDualType(a.type) { return a; }

    operator -(a) where isDualType(a.type) { 
        var f = -prim(a),
            df = -dual(a);
        return todual(f, df); 
    }

    operator +(a, b) where isEitherDualNumberType(a.type, b.type) {
        var f = prim(a) + prim(b);
        var df = dual(a) + dual(b);
        return todual(f, df);
    }

    operator -(a, b) where isEitherDualNumberType(a.type, b.type) {
        var f = prim(a) - prim(b);
        var df = dual(a) - dual(b);
        return todual(f, df);
    }

    operator *(a, b) where isEitherDualNumberType(a.type, b.type) {
        var f = prim(a) * prim(b),
            df = dual(a) * prim(b) + prim(a) * dual(b);
        return todual(f, df);
    }

    operator /(a, b) where isEitherDualNumberType(a.type, b.type) {
        var f = prim(a) / prim(b),
            df = (dual(a) * prim(b) - prim(a) * dual(b)) / prim(b) ** 2;
        return todual(f, df); 
    }

    operator **(a, b : real) where isDualType(a.type) {
        var f = prim(a) ** b,
            df = b * (prim(a) ** (b - 1)) * dual(a);
        return todual(f, df);
    }

    proc sqrt(a) where isDualType(a.type) {
        var f = sqrt(prim(a)),
            df = 0.5 * dual(a) / sqrt(prim(a));
        return todual(f, df);
    }

    proc cbrt(a) where isDualType(a.type) {
        var f = cbrt(prim(a)),
            df =  1.0 / 3.0 * dual(a) / cbrt(prim(a) ** 2);
        return todual(f, df);
    }
}