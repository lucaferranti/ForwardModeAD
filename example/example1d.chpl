use ForwardModeAD;

proc f(x) {
    return x ** 2 + 2 * x + 1;
}


var df = derivative(lambda(x : DualNumber) {return f(x);}, 1.0);
writeln(df);

var df1 = f(initdual(1.0)).derivative;
writeln(df1);

// proc df(x) {
//     return derivative(lambda(t : DualNumber) {return f(t);}, x);
// }

// var z = df(1.0);

proc g(x) {
    return 2.0;
}

type D = [0..#2] MultiDual;

var dg = gradient(lambda(x : D) {return g(x);}, [1.0, 2.0]);
writeln(dg);

proc h(x) {
    return x[0] ** 2 + 3 * x[0] * x[1];
}

var dh = gradient(lambda(x : D){return h(x);}, [1.0, 2.0]);
writeln(dh);

var dh1 = h(initdual([1.0, 2.0])).derivative;
writeln(dh1);