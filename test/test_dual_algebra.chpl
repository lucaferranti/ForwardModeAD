use UnitTest;
use ForwardModeAD;

proc test_arithmetic_operations(test : borrowed Test) throws {
    var x = new dual(1, 2),
        y = new dual(3, 4),
        c = 2;

    var z = new dual(1: int(32), 2: int(32));
    test.assertTrue(z.T == real(32));
    test.assertEqual(primalPart(c), 2.0);
    test.assertEqual(dualPart(c), 0.0);
    test.assertEqual(primalPart(x), 1.0);
    test.assertEqual(dualPart(x), 2.0);

    test.assertEqual(+x, x);
    test.assertEqual(-x, new dual(-1, -2));

    test.assertEqual(x + y, new dual(4, 6));
    test.assertEqual(x - y, new dual(-2, -2));
    test.assertEqual(x * y, new dual(3, 10));
    test.assertEqual(x / y, new dual(1.0 / 3, 2.0 / 9));

    test.assertEqual(x + c, new dual(3, 2));
    test.assertEqual(c + x, new dual(3, 2));
    test.assertEqual(x - c, new dual(-1, 2));
    test.assertEqual(c - x, new dual(1, -2));
    test.assertEqual(c * x, new dual(2, 4));
    test.assertEqual(x * c, new dual(2, 4));
    test.assertEqual(x / c, new dual(0.5, 1));
    test.assertEqual(c / x, new dual(2, -4));

    test.assertEqual(y ** 3, new dual(27, 108));
    test.assertEqual(y ** 0.4, new dual(1.5518455739153598, 0.8276509727548587));

    test.assertEqual(sqrt(y), new dual(sqrt(3), 2.0 / sqrt(3)));
    test.assertEqual(cbrt(y), new dual(cbrt(3), 4.0 / 3.0 / cbrt(9)));
}


proc test_trigonometric_operations(test : borrowed Test) throws {
    var x = new dual(pi, 1);
    var y = new dual(half_pi, 1);
    var z = new dual(sqrt(2) / 2.0, 2);

    // TODO: use isclose with e.g. atol=1e-10 and rtol=1e-5
    test.assertEqual(sin(x), new dual(1.2246467991473532e-16, -1));
    test.assertEqual(cos(x), new dual(-1.0, -1.2246467991473532e-16));
    test.assertEqual(tan(x), new dual(-1.2246467991473532e-16, 1));
    //test.assertEqual(tan(y), new dual(1.633123935319537e16, 2.6670937881135714e32));

    test.assertEqual(asin(z), new dual(asin(sqrt(2)/2), 2*sqrt(2)));
    test.assertEqual(acos(z), new dual(acos(sqrt(2)/2), -2*sqrt(2)));
    test.assertEqual(atan(z), new dual(atan(sqrt(2)/2), 4.0 / 3.0));
}

proc test_transcendental_functions(test : borrowed Test) throws {
    var x = new dual(2, 3);

    test.assertEqual(2 ** x, new dual(4.0, 12 * ln_2));

    test.assertEqual(x ** x, new dual(4.0, 12 * (ln_2 + 1)));

    test.assertEqual(exp(x), new dual(exp(2), 3 * exp(2)));

    test.assertEqual(exp2(x), new dual(4.0, 12 * ln_2));

    test.assertEqual(expm1(x), new dual(expm1(2), 3 * exp(2)));

    test.assertEqual(log(x), new dual(ln_2, 1.5));

    test.assertEqual(log2(x), new dual(1.0, 1.5 / ln_2));

    test.assertEqual(log1p(x), new dual(log1p(2), 1.0));
}

proc test_hyperbolic_functions(test : borrowed Test) throws {
    var x = new dual(2, 3);
    var y = new dual(0.5, 3);
    var z = new dual(1.5, 3);
    test.assertEqual(sinh(x), new dual(sinh(2), 3*cosh(2)));
    test.assertEqual(cosh(x), new dual(cosh(2), 3*sinh(2)));
    test.assertEqual(tanh(x), new dual(tanh(2), 3 * (1 - tanh(2)**2)));

    test.assertEqual(asinh(y), new dual(asinh(0.5), 6/sqrt(5)));
    test.assertEqual(acosh(z), new dual(acosh(1.5), 6/sqrt(5)));
    test.assertEqual(atanh(y), new dual(atanh(0.5), 4.0));
}

UnitTest.main();
