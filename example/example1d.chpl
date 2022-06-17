use ForwardModeAD;

proc f(x) {return 3;}
proc h(x) {return x + 1;}

var x = 1;

writeln(derivative(lambda(x : DualNumber) {return f(x);}, x));
writeln(derivative(lambda(x : DualNumber) {return h(x);}, x));