module ForwardModeAD {

  public use dual;
  
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
