module arithmetic {
    use ForwardModeAD;
    
    operator +(a : DualNumber) { return a; }

    operator -(a : DualNumber) { return new DualNumber(-prim(a), -dual(a)); }

    operator +(a, b) where isEitherDualNumberType(a.type, b.type) {
        return new DualNumber(prim(a) + prim(b), dual(a) + dual(b));
    }

    operator -(a, b) where isEitherDualNumberType(a.type, b.type) {
        return new DualNumber(prim(a) - prim(b), dual(a) - dual(b));
    }

    operator *(a, b) where isEitherDualNumberType(a.type, b.type) {
        return new DualNumber(prim(a) * prim(b), dual(a) * prim(b) + prim(a) * dual(b));
    }

    operator /(a, b) where isEitherDualNumberType(a.type, b.type) {
        var f = prim(a) / prim(b);
        var df = (dual(a) * prim(b) - prim(a) * dual(b)) / prim(b) ** 2;
        return new DualNumber(f, df); 
    }

    operator **(a : DualNumber, b : real) {
        return new DualNumber(prim(a) ** b, b * (prim(a) ** (b - 1)) * dual(a));
    }

    proc sqrt(a : DualNumber) {
        return new DualNumber(sqrt(prim(a)), 0.5 * dual(a) / sqrt(prim(a)));
    }

    proc cbrt(a : DualNumber) {
        return new DualNumber(cbrt(prim(a)), 1.0 / 3.0 * dual(a) / cbrt(prim(a) ** 2));
    }
}