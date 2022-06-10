/* Documentation for ForwardModeAD */
module ForwardModeAD {
  record DualNumber {
    var prim : real;
    var dual : real;
  }

  proc prim(a : DualNumber) {return a.prim;}
  proc dual(a : DualNumber) {return a.dual;}
  
  proc prim(a : real) {return a;}
  proc dual(a : real) {return 0.0;}

  proc isDualNumberType(type t : DualNumber) param {return true;}
  proc isDualNumberType(type t) param {return false;}
  proc isEitherDualNumberType(type t, type s) param {return isDualNumberType(t) || isDualNumberType(s);}

  proc isclose(a, b, rtol=1e-5, atol=0.0) where isEitherDualNumberType(a.type, b.type) {
      return isclose(prim(a), prim(b), rtol=rtol, atol=atol) && isclose(dual(a), dual(b), rtol=rtol, atol=atol);
  }
  
  public use arithmetic;

  public use trigonometric;

  public use transcendental;

  public use hyperbolic;

  proc derivative(f, x : real) {
    var x0 = new DualNumber(x, 1);
    return dual(f(x0));
  }

  proc main() {
    var x = new DualNumber(0.0, 0.0);
    var y = new DualNumber(1e-16, -1e-16);
    writeln(isclose(0.0, 1e-16, atol=1e-10));
    writeln(isclose(x, y, atol=1e-10));
  }
}
