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
}


proc test_trigonometric_operations(test : borrowed Test) throws {
    var x = new DualNumber(pi, 1);
    var y = new DualNumber(half_pi, 1);
    var z = sqrt(2) / 2.0;

    // TODO: use isclose with e.g. atol=1e-10 and rtol=1e-5
    test.assertEqual(sin(x), new DualNumber(1.2246467991473532e-16, -1));
    test.assertEqual(cos(x), new DualNumber(-1, -1.2246467991473532e-16));
    test.assertEqual(tan(x), new DualNumber(-1.2246467991473532e-16, 1));
    //test.assertEqual(tan(y), new DualNumber(1.633123935319537e16, 2.6670937881135714e32));
}

proc test_transcendental_functions(test : borrowed Test) throws {
    
}

proc test_hyperbolic_functions(test : borrowed Test) throws {

}

UnitTest.main();