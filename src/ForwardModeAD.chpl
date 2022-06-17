module ForwardModeAD {
  /*
  A dual number is a number in the form :math:`a + b\epsilon`, for which :math:`\epsilon^2 = 0`.
  Via the algebra induced by this definition one can show that :math:`f(a + b\epsilon) = f(a) + bf'(a)\epsilon`
  and hence dual numbers can be used for forward mode automatic differentiation by operators overloading.
  */
  record DualNumber {
    /* primal part of the dual number */
    var prim : real;
    /* dual part of the dual number */
    var dual : real;
  }

  /*
  For dual numbers, it returns the primal part. For real numbers, it returns the number itself.
  */
  proc prim(a : DualNumber) {return a.prim;}

  /*
  For dual numbers, it returns the dual part, for real numbers it returns zero.
  */
  proc dual(a : DualNumber) {return a.dual;}
  
  pragma "no doc"
  proc prim(a : real) {return a;}
  
  pragma "no doc"
  proc dual(a : real) {return 0.0;}

  pragma "no doc"
  proc isDualNumberType(type t : DualNumber) param {return true;}
  
  pragma "no doc"
  proc isDualNumberType(type t) param {return false;}
  
  pragma "no doc"
  proc isEitherDualNumberType(type t, type s) param {return isDualNumberType(t) || isDualNumberType(s);}


  pragma "no doc"
  proc isclose(a, b, rtol=1e-5, atol=0.0) where isEitherDualNumberType(a.type, b.type) {
      return isclose(prim(a), prim(b), rtol=rtol, atol=atol) && isclose(dual(a), dual(b), rtol=rtol, atol=atol);
  }
  
  public use arithmetic;

  public use trigonometric;

  public use transcendental;

  public use hyperbolic;

  /*
  Evaluates the derivative of ``f`` at ``x``.

  :arg f: Function, note that this must be a concrete function. 
  :type f: Function

  :arg x: point at which the derivative is evaluated
  :type x: real

  :returns: value of f'(x)
  :rtype: real

  Note that `f` must be a concrete function, if it's written as a generic function, you can pass ``derivative`` a lambda as follows

  .. code-block:: chapel

    proc f(x) {
      return x**2 + 2*x + 1;
    }
     
    var dfx = derivative(lambda(x : DualNumber){return f(x);}, 1.0);
    //outputs
    //4.0
  */
  proc derivative(f, x : real) {
    var x0 = new DualNumber(x, 1);
    return dual(f(x0));
  }
}
