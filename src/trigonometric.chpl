module trigonometric {
    use ForwardModeAD;
    
    proc sin(a) where isDualType(a.type) {
        var f = sin(primalPart(a)),
            df = cos(primalPart(a)) * dualPart(a);
        return todual(f, df);
    }

    proc cos(a) where isDualType(a.type) {
        var f = cos(primalPart(a)),
            df = -sin(primalPart(a)) * dualPart(a);
        return todual(f, df);
    }

    proc tan(a) where isDualType(a.type) {
        var f = tan(primalPart(a)),
            df = dualPart(a) / (cos(primalPart(a)) ** 2);
        return todual(f, df);
    }

    proc asin(a) where isDualType(a.type) {
        var f = asin(primalPart(a)),
            df = dualPart(a) / sqrt(1 - primalPart(a)**2);
        return todual(f, df);
    }

    proc acos(a) where isDualType(a.type) {
        var f = acos(primalPart(a)),
            df = -dualPart(a) / sqrt(1 - primalPart(a)**2);
        return todual(f, df);
    }

    proc atan(a) where isDualType(a.type) {
        var f = atan(primalPart(a)),
            df = dualPart(a) / (1 + primalPart(a)**2);
        return todual(f, df);
    }
}