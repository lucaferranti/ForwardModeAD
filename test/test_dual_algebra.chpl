use UnitTest;
use ForwardModeAD;

proc test_arithmetic_operations(test : borrowed Test) throws {
    var x = new DualNumber(1, 2),
        y = new DualNumber(3, 4),
        c = 2;

    test.assertEqual(prim(c), 2.0);
    test.assertEqual(dual(c), 0.0);
    test.assertEqual(prim(x), 1.0);
    test.assertEqual(dual(x), 2.0);

    test.assertEqual(+x, x);
    test.assertEqual(-x, new DualNumber(-1, -2));

    test.assertEqual(x + y, new DualNumber(4, 6));
    test.assertEqual(x - y, new DualNumber(-2, -2));
    test.assertEqual(x * y, new DualNumber(3, 10));
    test.assertEqual(x / y, new DualNumber(1.0 / 3, 2.0 / 9));

    test.assertEqual(x + c, new DualNumber(3, 2));
    test.assertEqual(c + x, new DualNumber(3, 2));
    test.assertEqual(x - c, new DualNumber(-1, 2));
    test.assertEqual(c - x, new DualNumber(1, -2));
    test.assertEqual(c * x, new DualNumber(2, 4));
    test.assertEqual(x * c, new DualNumber(2, 4));
    test.assertEqual(x / c, new DualNumber(0.5, 1));
    test.assertEqual(c / x, new DualNumber(2, -4));

    test.assertEqual(y ** 3, new DualNumber(27, 108));
    test.assertEqual(y ** 0.4, new DualNumber(1.5518455739153598, 0.8276509727548587));

    test.assertEqual(sqrt(y), new DualNumber(sqrt(3), 2.0 / sqrt(3)));
    test.assertEqual(cbrt(y), new DualNumber(cbrt(3), 4.0 / 3.0 / cbrt(9)));
}


proc test_trigonometric_operations(test : borrowed Test) throws {
    var x = new DualNumber(pi, 1);
    var y = new DualNumber(half_pi, 1);
    var z = new DualNumber(sqrt(2) / 2.0, 2);

    // TODO: use isclose with e.g. atol=1e-10 and rtol=1e-5
    test.assertEqual(sin(x), new DualNumber(1.2246467991473532e-16, -1));
    test.assertEqual(cos(x), new DualNumber(-1, -1.2246467991473532e-16));
    test.assertEqual(tan(x), new DualNumber(-1.2246467991473532e-16, 1));
    //test.assertEqual(tan(y), new DualNumber(1.633123935319537e16, 2.6670937881135714e32));

    test.assertEqual(asin(z), new DualNumber(asin(sqrt(2)/2), 2*sqrt(2)));
    test.assertEqual(acos(z), new DualNumber(acos(sqrt(2)/2), -2*sqrt(2)));
    test.assertEqual(atan(z), new DualNumber(atan(sqrt(2)/2), 4.0 / 3.0));
}

proc test_transcendental_functions(test : borrowed Test) throws {
    var x = new DualNumber(2, 3);

    test.assertEqual(2 ** x, new DualNumber(4, 12 * ln_2));

    test.assertEqual(x ** x, new DualNumber(4, 12 * (ln_2 + 1)));

    test.assertEqual(exp(x), new DualNumber(exp(2), 3 * exp(2)));

    test.assertEqual(exp2(x), new DualNumber(4, 12 * ln_2));

    test.assertEqual(expm1(x), new DualNumber(expm1(2), 3 * exp(2)));

    test.assertEqual(log(x), new DualNumber(ln_2, 1.5));

    test.assertEqual(log2(x), new DualNumber(1, 1.5 / ln_2));

    test.assertEqual(log1p(x), new DualNumber(log1p(2), 1));
}

proc test_hyperbolic_functions(test : borrowed Test) throws {
    var x = new DualNumber(2, 3);
    var y = new DualNumber(0.5, 3);
    var z = new DualNumber(1.5, 3);
    test.assertEqual(sinh(x), new DualNumber(sinh(2), 3*cosh(2)));
    test.assertEqual(cosh(x), new DualNumber(cosh(2), 3*sinh(2)));
    test.assertEqual(tanh(x), new DualNumber(tanh(2), 3 * (1 - tanh(2)**2)));

    test.assertEqual(asinh(y), new DualNumber(asinh(0.5), 6/sqrt(5)));
    test.assertEqual(acosh(z), new DualNumber(acosh(1.5), 6/sqrt(5)));
    test.assertEqual(atanh(y), new DualNumber(atanh(0.5), 4.0));
}

UnitTest.main();