use UnitTest;
use ForwardModeAD;


proc test_arithmetic_operations(test : borrowed Test) throws {
    var x = todual(1, [2, 3]),
        y = todual(3, [3, 4]),
        c = 2;

    test.assertEqual(prim(x), 1.0);
    test.assertEqual(dual(x), [2.0, 3.0]);

    test.assertTrue(+x == x);
    test.assertEqual(-x, todual(-1, [-2, -3]));

    test.assertEqual(x + y, todual(4, [5, 7]));
    test.assertEqual(x - y, todual(-2, [-1, -1]));
    test.assertEqual(x * y, todual(3, [9, 13]));
    test.assertEqual(x / y, todual(1.0 / 3, [1.0 / 3, 5.0 / 9]));

    test.assertEqual(x + c, todual(3, [2, 3]));
    test.assertEqual(c + x, todual(3, [2, 3]));
    test.assertEqual(x - c, todual(-1, [2, 3]));
    test.assertEqual(c - x, todual(1, [-2, -3]));
    test.assertEqual(c * x, todual(2, [4, 6]));
    test.assertEqual(x * c, todual(2, [4, 6]));
    test.assertEqual(x / c, todual(0.5, [1.0, 1.5]));
    test.assertEqual(c / x, todual(2, [-4, -6]));

    test.assertEqual(y ** 3, todual(27, [81, 108]));
    test.assertEqual(y ** 0.4, todual(1.5518455739153598, [0.620738229566144, 0.8276509727548587]));

    test.assertEqual(sqrt(y), todual(sqrt(3), [3.0 / (2.0 * sqrt(3)), 2.0 / sqrt(3)]));
    test.assertEqual(cbrt(y), todual(cbrt(3), [1.0 / cbrt(9), 4.0 / 3.0 / cbrt(9)]));
}


proc test_trigonometric_operations(test : borrowed Test) throws {
    var x = todual(pi, [1.0, 2.0]);
    var z = todual(sqrt(2) / 2.0, [2, 3]);

    test.assertEqual(sin(x), todual(sin(pi), [-1.0, -2.0]));
    test.assertEqual(cos(x), todual(-1, [-sin(pi), -2.0*sin(pi)]));
    test.assertEqual(tan(x), todual(tan(pi), [1.0, 2.0]));

    test.assertEqual(asin(z), todual(asin(sqrt(2)/2), [2*sqrt(2), 3*sqrt(2)]));
    test.assertEqual(acos(z), todual(acos(sqrt(2)/2), [-2*sqrt(2), -3*sqrt(2)]));
    test.assertEqual(atan(z), todual(atan(sqrt(2)/2), [4.0 / 3.0, 2.0]));
}

proc test_transcendental_functions(test : borrowed Test) throws {
    var x = todual(2, [2, 3]);

    test.assertEqual(2 ** x, todual(4, [8 * ln_2, 12 * ln_2]));

    test.assertEqual(x ** x, todual(4, [8 * (ln_2 + 1), 12 * (ln_2 + 1)]));

    test.assertEqual(exp(x), todual(exp(2), [2 * exp(2), 3 * exp(2)]));

    test.assertEqual(exp2(x), todual(4, [8 * ln_2, 12 * ln_2]));

    test.assertEqual(expm1(x), todual(expm1(2), [2 * exp(2), 3 * exp(2)]));

    test.assertEqual(log(x), todual(ln_2, [1.0, 1.5]));

    test.assertEqual(log2(x), todual(1, [1.0 / ln_2, 1.5 / ln_2]));

    test.assertEqual(log1p(x), todual(log1p(2), [2.0 / 3.0, 1.0]));
}

proc test_hyperbolic_functions(test : borrowed Test) throws {
    var x = todual(2, [2, 3]);
    var y = todual(0.5, [2, 3]);
    var z = todual(1.5, [2, 3]);

    test.assertEqual(sinh(x), todual(sinh(2), [2*cosh(2), 3*cosh(2)]));
    test.assertEqual(cosh(x), todual(cosh(2), [2*sinh(2), 3*sinh(2)]));
    test.assertEqual(tanh(x), todual(tanh(2), [2*(1 - tanh(2)**2), 3*(1 - tanh(2)**2)]));

    test.assertEqual(asinh(y), todual(asinh(0.5), [4/sqrt(5), 6/sqrt(5)]));
    test.assertEqual(acosh(z), todual(acosh(1.5), [4/sqrt(5), 6/sqrt(5)]));
    test.assertEqual(atanh(y), todual(atanh(0.5), [8.0/3, 4.0]));
}

UnitTest.main();
