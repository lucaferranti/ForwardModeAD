use ForwardModeAD;

proc f(x) {
    return exp(-x) * sin(x) - log(x);
}

var tol = 1e-6, // tolerance to find the root
    cnt = 0, // to count number of iterations
    x0 = initdual(0.5), // initial guess
    valder = f(x0); // initial function value and derivative

while abs(value(valder)) > tol {
    x0 -= value(valder) / derivative(valder);
    valder = f(x0);
    cnt += 1;
    writeln("Iteration ", cnt, " x = ", value(x0), " residual = ", value(valder));
}

proc g(vd) {
    return 1e-9 * (exp(40 * vd) - 1) + vd - 5;
}

var Vd = initdual(0.0),
    Id = g(Vd);

while abs(value(Id)) > tol {
    Vd -= value(Id) / derivative(Id);
    Id = g(Vd);
}

writeln("V = ", value(Vd), "\n");

use LinearAlgebra;

proc F(x) {
    return [log(x[0]) - x[1] + 0.5, x[0]**2 - x[0]*x[1] - 0.7];
}

cnt = 0; // to count number of iterations
var X0 = [3.0, 3.0], // initial guess
    valjac = F(initdual(X0)), // initial function value and derivative
    res = norm(value(valjac));

writeln("Iteration ", cnt, " x = ", X0, " residual = ", res);

while res > tol {
    X0 -= solve(jacobian(valjac), value(valjac));
    valjac = F(initdual(X0));
    res = norm(value(valjac));
    cnt += 1;
    writeln("Iteration ", cnt, " x = ", X0, " residual = ", res);
}
