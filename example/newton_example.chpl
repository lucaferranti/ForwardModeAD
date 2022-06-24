use ForwardModeAD;

proc f(x) {
    return exp(-x) * sin(x) - log(x);
}

var tol = 1e-6, // tolerance to find the root
    cnt = 0, // to count number of iterations
    x0 = 0.5, // initial guess
    valder = f(initdual(x0)); // initial function value and derivative

writeln("Iteration ", cnt, " x = ", x0, " residual = ", valder.value);

while abs(valder.value) > tol {
    x0 -= valder.value / valder.derivative;
    valder = f(initdual(x0));
    cnt += 1;
    writeln("Iteration ", cnt, " x = ", x0, " residual = ", valder.value);
}

proc g(vd) {
    return 1e-9 * (exp(40 * vd) - 1) + vd - 5;
}

x0 = 0.0;
valder = g(initdual(x0));

while abs(valder.value) > tol {
    x0 -= valder.value / valder.derivative;
    valder = g(initdual(x0));
}

writeln("x0 = ", x0);