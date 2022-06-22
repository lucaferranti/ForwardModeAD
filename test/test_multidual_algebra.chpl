use UnitTest;
use ForwardModeAD;


proc test_arithmetic_operations(test : borrowed Test) throws {
    var x = new MultiDual(1, [2, 3]),
        y = new MultiDual(3, [3, 4]),
        c = 2;

    test.assertEqual(prim(x), 1.0);
    test.assertEqual(dual(x), [2.0, 3.0]);

    test.assertTrue(+x == x);
    test.assertEqual(-x, new MultiDual(-1, [-2, -3]));

    test.assertEqual(x + y, new MultiDual(4, [5, 7]));
    test.assertEqual(x - y, new MultiDual(-2, [-1, -1]));
    test.assertEqual(x * y, new MultiDual(3, [9, 13]));
    test.assertEqual(x / y, new MultiDual(1.0 / 3, [1.0 / 3, 5.0 / 9]));

    test.assertEqual(x + c, new MultiDual(3, [2, 3]));
    test.assertEqual(c + x, new MultiDual(3, [2, 3]));
    test.assertEqual(x - c, new MultiDual(-1, [2, 3]));
    test.assertEqual(c - x, new MultiDual(1, [-2, -3]));
    test.assertEqual(c * x, new MultiDual(2, [4, 6]));
    test.assertEqual(x * c, new MultiDual(2, [4, 6]));
    test.assertEqual(x / c, new MultiDual(0.5, [1.0, 1.5]));
    test.assertEqual(c / x, new MultiDual(2, [-4, -6]));

    test.assertEqual(y ** 3, new MultiDual(27, [81, 108]));
    test.assertEqual(y ** 0.4, new MultiDual(1.5518455739153598, [0.620738229566144, 0.8276509727548587]));

    test.assertEqual(sqrt(y), new MultiDual(sqrt(3), [3.0 / (2.0 * sqrt(3)), 2.0 / sqrt(3)]));
    test.assertEqual(cbrt(y), new MultiDual(cbrt(3), [1.0 / cbrt(9), 4.0 / 3.0 / cbrt(9)]));
}


proc test_trigonometric_operations(test : borrowed Test) throws {
    var x = new MultiDual(pi, [1.0, 2.0]);
    var z = new MultiDual(sqrt(2) / 2.0, [2, 3]);

    test.assertEqual(sin(x), new MultiDual(sin(pi), [-1.0, -2.0]));
    test.assertEqual(cos(x), new MultiDual(-1, [-sin(pi), -2.0*sin(pi)]));
    test.assertEqual(tan(x), new MultiDual(tan(pi), [1.0, 2.0]));

    test.assertEqual(asin(z), new MultiDual(asin(sqrt(2)/2), [2*sqrt(2), 3*sqrt(2)]));
    test.assertEqual(acos(z), new MultiDual(acos(sqrt(2)/2), [-2*sqrt(2), -3*sqrt(2)]));
    test.assertEqual(atan(z), new MultiDual(atan(sqrt(2)/2), [4.0 / 3.0, 2.0]));
}

proc test_transcendental_functions(test : borrowed Test) throws {
    var x = new MultiDual(2, [2, 3]);

    test.assertEqual(2 ** x, new MultiDual(4, [8 * ln_2, 12 * ln_2]));

    test.assertEqual(x ** x, new MultiDual(4, [8 * (ln_2 + 1), 12 * (ln_2 + 1)]));

    test.assertEqual(exp(x), new MultiDual(exp(2), [2 * exp(2), 3 * exp(2)]));

    test.assertEqual(exp2(x), new MultiDual(4, [8 * ln_2, 12 * ln_2]));

    test.assertEqual(expm1(x), new MultiDual(expm1(2), [2 * exp(2), 3 * exp(2)]));

    test.assertEqual(log(x), new MultiDual(ln_2, [1.0, 1.5]));

    test.assertEqual(log2(x), new MultiDual(1, [1.0 / ln_2, 1.5 / ln_2]));

    test.assertEqual(log1p(x), new MultiDual(log1p(2), [2.0 / 3.0, 1.0]));
}

proc test_hyperbolic_functions(test : borrowed Test) throws {
    var x = new MultiDual(2, [2, 3]);
    var y = new MultiDual(0.5, [2, 3]);
    var z = new MultiDual(1.5, [2, 3]);

    test.assertEqual(sinh(x), new MultiDual(sinh(2), [2*cosh(2), 3*cosh(2)]));
    test.assertEqual(cosh(x), new MultiDual(cosh(2), [2*sinh(2), 3*sinh(2)]));
    test.assertEqual(tanh(x), new MultiDual(tanh(2), [2*(1 - tanh(2)**2), 3*(1 - tanh(2)**2)]));

    test.assertEqual(asinh(y), new MultiDual(asinh(0.5), [4/sqrt(5), 6/sqrt(5)]));
    test.assertEqual(acosh(z), new MultiDual(acosh(1.5), [4/sqrt(5), 6/sqrt(5)]));
    test.assertEqual(atanh(y), new MultiDual(atanh(0.5), [8.0/3, 4.0]));
}

UnitTest.main();