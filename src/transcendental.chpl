module transcendental {
    use ForwardModeAD;

    operator **(a : real, b) where isDualType(b.type) {
        var f = a ** prim(b),
            df = log(a) * (a ** prim(b)) * dual(b);
        return todual(f, df);
    }


    operator **(a, b) where isDualType(a.type) && a.type == b.type {
        var f = prim(a) ** prim(b);
        var df = f * (dual(b) * log(prim(a)) + prim(b) * dual(a) / prim(a)); 
        return todual(f, df);
    }

    proc exp(a) where isDualType(a.type) {
        var f = exp(prim(a)),
            df = dual(a) * exp(prim(a));
        return todual(f, df);
    }

    proc exp2(a) where isDualType(a.type) {
        var f = exp2(prim(a)), 
            df = ln_2 * exp2(prim(a)) * dual(a);
        return todual(f, df);
    }

    proc expm1(a) where isDualType(a.type) {
        var f = expm1(prim(a)), 
            df = exp(prim(a)) * dual(a);
        return todual(f, df);
    }

    proc log(a) where isDualType(a.type) {
        var f = log(prim(a)), 
            df = dual(a) / prim(a);
        return todual(f, df);
    }
    
    proc log2(a) where isDualType(a.type) {
        var f = log2(prim(a)), 
            df = dual(a)/(prim(a) * ln_2);
        return todual(f, df);
    }

    proc log10(a) where isDualType(a.type) {
        var f = log10(prim(a)), 
            df = dual(a) / (prim(a) * ln_10);
        return todual(f, df);
    }

    proc log1p(a) where isDualType(a.type) {
        var f = log1p(prim(a)), 
            df = dual(a) / (prim(a) + 1);
        return todual(f, df);
    }
}