module trigonometric {
    use ForwardModeAD;
    
    proc sin(a : DualNumber) {
        return new DualNumber(sin(prim(a)), cos(prim(a)) * dual(a));
    }

    proc cos(a : DualNumber) {
        return new DualNumber(cos(prim(a)), -sin(prim(a)) * dual(a));
    }

    proc tan(a : DualNumber) {
        return new DualNumber(tan(prim(a)), dual(a)/(cos(prim(a))**2));
    }

    proc asin(a : DualNumber) {

    }

    proc acos(a : DualNumber) {

    }

    proc atan(a : DualNumber) {

    }
}