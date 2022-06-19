use ForwardModeAD;

proc f(x) {
    return x ** 2 + 2 * x + 1;
}


var y = derivative(lambda(x : DualNumber) {return f(x);}, 1.0);
writeln(y);

proc df(x) {
    return derivative(lambda(t : DualNumber) {return f(t);}, x);
}

var z = df(1.0);