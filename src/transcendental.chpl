module transcendental {
    use ForwardModeAD;

    proc exp(a : DualNumber) { return new DualNumber(exp(prim(a)), dual(a) * exp(prim(a))); }

    proc exp2(a : DualNumber) {}

    proc expm1(a : DualNumber) {}

    proc log(a : DualNumber) { return new DualNumber(log(prim(a)), dual(a) / prim(a)); }
    
    proc log2(a : DualNumber) {}

    proc log10(a : DualNumber) {}

    proc log1p(a : DualNumber) {}
}