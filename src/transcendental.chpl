module transcendental {
    use ForwardModeAD;

    operator **(a : real, b : DualNumber) {
        return new DualNumber(a ** prim(b), log(a) * (a ** prim(b)) * dual(b));
    }


    operator **(a : DualNumber, b : DualNumber) {
        var f = prim(a) ** prim(b);
        var df = f * (dual(b) * log(prim(a)) + prim(b) * dual(a) / prim(a)); 
        return new DualNumber(f, df);
    }

    proc exp(a : DualNumber) { return new DualNumber(exp(prim(a)), dual(a) * exp(prim(a))); }

    proc exp2(a : DualNumber) {return new DualNumber(exp2(prim(a)), ln_2 * exp2(prim(a)) * dual(a));}

    proc expm1(a : DualNumber) {return new DualNumber(expm1(prim(a)), exp(prim(a)) * dual(a));}

    proc log(a : DualNumber) { return new DualNumber(log(prim(a)), dual(a) / prim(a)); }
    
    proc log2(a : DualNumber) {return new DualNumber(log2(prim(a)), dual(a)/(prim(a) * ln_2));}

    proc log10(a : DualNumber) {return new DualNumber(log10(prim(a)), dual(a) / (prim(a) * ln_10));}

    proc log1p(a : DualNumber) {return new DualNumber(log1p(prim(a)), dual(a) / (prim(a) + 1));}
}