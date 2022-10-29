# ForwardModeAD
[![license: MIT][mit-img]](LICENSE)[![docs-dev][dev-img]][dev-url]![lifecycle](https://img.shields.io/badge/lifecycle-maturing-orange)

**NOTE**: project at early stages, everything can change overnight!

Lightweight library for forward-mode automatic differentiation using dual numbers and functions overloading.
It can compute the derivative, gradient and jacobian of any function, as long as it is written as a combination of [overloaded functions](https://forwardmodead.readthedocs.io/en/latest/api/overloaded.html).

As a showcase, in a few lines we can implement the Newton method for root finding.

```chapel
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
```

### Documentation

- [latest][dev-url] : documentation of the latest version on main

### Contributing

If you encounter bugs or have feature requests, feel free to [open an issue](https://github.com/lucaferranti/ForwardModeAD/issues/new). Pull requests are also welcome. More details in the [contribution guidelines](https://forwardmodead.readthedocs.io/en/latest/contributing.html)

### License

MIT (c) Luca Ferranti

[mit-img]: https://img.shields.io/badge/license-MIT-yellow.svg
[dev-img]: https://img.shields.io/badge/docs-latest-blue.svg
[dev-url]: https://forwardmodead.readthedocs.io
