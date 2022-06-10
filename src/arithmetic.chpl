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

}