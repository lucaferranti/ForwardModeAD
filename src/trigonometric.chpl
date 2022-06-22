module trigonometric {
    use ForwardModeAD;
    
    proc sin(a) where isDualType(a.type) {
        var f = sin(prim(a)),
            df = cos(prim(a)) * dual(a);
        return todual(f, df);
    }

    proc cos(a) where isDualType(a.type) {
        var f = cos(prim(a)),
            df = -sin(prim(a)) * dual(a);
        return todual(f, df);
    }

    proc tan(a) where isDualType(a.type) {
        var f = tan(prim(a)),
            df = dual(a) / (cos(prim(a)) ** 2);
        return todual(f, df);
    }

    proc asin(a) where isDualType(a.type) {
        var f = asin(prim(a)),
            df = dual(a) / sqrt(1 - prim(a)**2);
        return todual(f, df);
    }

    proc acos(a) where isDualType(a.type) {
        var f = acos(prim(a)),
            df = -dual(a) / sqrt(1 - prim(a)**2);
        return todual(f, df);
    }

    proc atan(a) where isDualType(a.type) {
        var f = atan(prim(a)),
            df = dual(a) / (1 + prim(a)**2);
        return todual(f, df);
    }
}