use UnitTest;
use ForwardModeAD;

type D = [0..#2] MultiDual;

proc testUnivariateFunctions(test: borrowed Test) throws {
  proc f(x) {
    return x ** 2 + 2 * x + 1;
  }

  var df = derivative(lambda(x : DualNumber) {return f(x);}, 1);
  test.assertEqual(df, 4.0);

  var valder = f(initdual(1));
  test.assertEqual(valder.value, 4.0);
  test.assertEqual(valder.derivative, 4.0);
}

proc testGradient(test: borrowed Test) throws {
  proc g(x) {
      return 2.0;
  }

  var dg = gradient(lambda(x : D) {return g(x);}, [1.0, 2.0]);
  test.assertEqual(dg, [0.0, 0.0]);

  proc h(x) {
    return x[0] ** 2 + 3 * x[0] * x[1];
  }

  // TODO: debug why doesn't work with integer input
  var valgradh = h(initdual([1.0, 2.0]));
  test.assertEqual(valgradh.value, 7);
  test.assertEqual(valgradh.derivative, [8.0, 3.0]);
}

proc testJacobian(test: borrowed Test) throws {
  proc F(x) {
    return [x[0] ** 2 + x[1] + 1, x[0] + x[1] ** 2 + x[0] * x[1]];
  }

  var valjac = F(initdual([1.0, 2.0])),
      _jac: [0..1, 0..1] real = ((2.0, 1.0), (3.0, 5.0));

  // TODO: revisit once API is updated
  test.assertEqual(prim(valjac), [4.0, 7.0]);
  test.assertEqual(dual(valjac), _jac);

  proc G(x) {return [1, 2, 3];}

  var Jg = jacobian(lambda(x : D) {return G(x);}, [1.0, 2.0]),
      _Jg: [0..2, 0..1] real;

  test.assertEqual(Jg, _Jg);
}

UnitTest.main();
