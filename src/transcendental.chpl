module transcendental {
    use ForwardModeAD;

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
}
