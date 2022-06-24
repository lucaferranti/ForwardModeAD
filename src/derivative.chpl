module derivative {
  
  use ForwardModeAD;

  /*
  Initializes the input to the appropriate dual number to evalute the derivative.

  :arg x: point where to evaluate the derivative
  :type x: real or [dom] real

  :returns:    If ``x`` is a real number, then it is initialized to :math:`x+\epsilon`. If ``x`` is a vector of reals, it is initialized to the vector of multiduals :math:`\begin{bmatrix}x_1+\epsilon_1\\\vdots\\x_n+\epsilon_n\end{bmatrix}`.
  :rtype: ``DualNumber`` if ``x`` is ``real`` or ``[dom] MultiDual`` if ``x`` is ``[dom] real``.
  */
  proc initdual(x : real) {
    return new DualNumber(x, 1.0);
  }

  pragma "no doc"
  proc initdual(x : [?D] real) {
    var x0 : [D] MultiDual;
    forall i in D {
      var eps : [D] real = 0.0;
      eps[i] = 1.0;
      x0[i] = todual(x[i], eps);                    
    }
    return x0;
  }


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
    return dual(f(initdual(x)));
  }

  /*
  Evaluates the gradient of ``f`` at ``x``.

  :arg f: Function, note that this must be a concrete function. 
  :type f: Function

  :arg x: point at which the gradient is evaluated
  :type x: [ ] real

  :returns: value of :math:`\nabla f(x)`
  :rtype: [ ] real

  Note that `f` must be a concrete function, if it's written as a generic function, you can pass ``gradient`` a lambda as follows

  .. code-block:: chapel

    proc h(x) {
        return x[0] ** 2 + 3 * x[0] * x[1];
    }

    type D = [0..#2] MultiDual; // domain for the lambda function

    var dh = gradient(lambda(x : D){return h(x);}, [1.0, 2.0]);
    //outputs
    //8.0 3.0
  */
  proc gradient(f, x : [?D] real) {
    var res : [D] real;
    res = dual(f(initdual(x)));
    return res;
  }
}