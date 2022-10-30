use UnitTest;
use ForwardModeAD;

type D = [0..#2] multidual;

proc testUnivariateFunctions(test: borrowed Test) throws {
  proc f(x) {
    return x ** 2 + 2 * x + 1;
  }

  var df = derivative(lambda(x : dual) {return f(x);}, 1);
  test.assertEqual(df, 4.0);

  var valder = f(initdual(1));
  test.assertEqual(value(valder), 4.0);
  test.assertEqual(derivative(valder), 4.0);
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

  var valgradh = h(initdual([1, 2]));
  test.assertEqual(value(valgradh), 7);
  test.assertEqual(gradient(valgradh), [8.0, 3.0]);
}

proc testJacobian(test: borrowed Test) throws {
  proc F(x) {
    return [x[0] ** 2 + x[1] + 1, x[0] + x[1] ** 2 + x[0] * x[1]];
  }

  var valjac = F(initdual([1.0, 2.0])),
      _jac: [0..1, 0..1] real = ((2.0, 1.0), (3.0, 5.0));

  test.assertEqual(value(valjac), [4.0, 7.0]);
  test.assertEqual(jacobian(valjac), _jac);

  proc G(x) {return [1, 2, 3];}

  var Jg = jacobian(lambda(x : D) {return G(x);}, [1.0, 2.0]),
      _Jg: [0..2, 0..1] real;

  test.assertEqual(Jg, _Jg);
}

proc testDirectionalAndJvp(test: borrowed Test) throws {
  proc f(x) {
    return x[0] ** 2 + 3 * x[0] * x[1];
  }

  var dirder = f(initdual([1, 2], [0.5, 2.0]));

  test.assertEqual(value(dirder), 7);
  test.assertEqual(directionalDerivative(dirder), 10);

  proc F(x) {
    return [x[0] ** 2 + x[1] + 1, x[0] + x[1] ** 2 + x[0] * x[1]];
  }

  var valjvp = F(initdual([1, 2], [0.5, 2.0]));
  test.assertEqual(value(valjvp), [4.0, 7.0]);
  test.assertEqual(jvp(valjvp), [3.0, 11.5]);
}

UnitTest.main();
