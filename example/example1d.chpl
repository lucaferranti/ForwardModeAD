use ForwardModeAD;

proc f(x) {
    return x ** 2 + 2 * x + 1;
}


var df = derivative(lambda(x : DualNumber) {return f(x);}, 1.0);
writeln(df, "\n");

var df1 = f(initdual(1.0)).derivative;
writeln(df1, "\n");

// proc df(x) {
//     return derivative(lambda(t : DualNumber) {return f(t);}, x);
// }

// var z = df(1.0);

proc g(x) {
    return 2.0;
}

type D = [0..#2] MultiDual;

var dg = gradient(lambda(x : D) {return g(x);}, [1.0, 2.0]);
writeln(dg, "\n");

proc h(x) {
    return x[0] ** 2 + 3 * x[0] * x[1];
}

var dh = gradient(lambda(x : D){return h(x);}, [1.0, 2.0]);
writeln(dh, "\n");

var dh1 = h(initdual([1.0, 2.0])).derivative;
writeln(dh1, "\n");

proc F(x) {
    return [x[0] ** 2 + x[1] + 1, x[0] + x[1] ** 2 + x[0] * x[1]];
}

var Jf = jacobian(lambda(x : D){return F(x);}, [1.0, 2.0]);
writeln(Jf, "\n");

writeln(dual(F(initdual([1.0, 2.0]))), "\n");

proc G(x) {return [1, 2, 3];}

var Jg = jacobian(lambda(x : D) {return G(x);}, [1.0, 2.0]);
writeln(Jg, "\n");