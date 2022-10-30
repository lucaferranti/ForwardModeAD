module differentiation {
  
  use ForwardModeAD;

  /*
  Initializes the input to the appropriate dual number to evalute the derivative.

  :arg x: point where to evaluate the derivative
  :type x: real or [dom] real

  :returns:    If ``x`` is a real number, then it is initialized to :math:`x+\epsilon`. If ``x`` is a vector of reals, it is initialized to the vector of multiduals :math:`\begin{bmatrix}x_1+\epsilon_1\\\vdots\\x_n+\epsilon_n\end{bmatrix}`.
  :rtype: ``dual`` if ``x`` is ``real`` or ``[dom] multidual`` if ``x`` is ``[dom] real``.
  */
  proc initdual(x : real) {
    return new dual(x, 1.0);
  }

  pragma "no doc"
  proc initdual(x : [?D] ?t) {
    var x0 : [D] multidual;
    forall i in D {
      var eps : [D] real = 0.0;
      eps[i] = 1.0;
      x0[i] = todual(x[i], eps);                    
    }
    return x0;
  }

  /*
  Given a vector ``x`` and a vector ``v``, creates a vector of duals ``[x_i + \epsilon v_i]``.
  Used to compute directional derivative and Jacobian-vector product (JVP).

  :arg x: point where to evaluate the directional derivative / JVP
  :type x: [D] real

  :arg v: direction
  :type v: [D] real

  :returns: Vector of dual numbers
  :rtype: [D] dual
  */
  proc initdual(x: [?D] ?t, v: [D] ?s) {
    return [(xi, vi) in zip(x, v)] todual(xi, vi);
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
     
    var dfx = derivative(lambda(x : dual){return f(x);}, 1.0);
    //outputs
    //4.0
  */
  proc derivative(f, x : real) {
    return dualPart(f(initdual(x)));
  }

  /* Extracts the derivative from a dual number. */
  proc derivative(x: dual) {return dualPart(x);}

  pragma "no doc"
  proc derivative(x: real) {return 0.0;}

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

    type D = [0..#2] multidual; // domain for the lambda function
    var dh = gradient(lambda(x : D){return h(x);}, [1.0, 2.0]);
    //outputs
    //8.0 3.0
  */
  proc gradient(f, x : [?D] real) {
    var res : [D] real;
    res = dualPart(f(initdual(x)));
    return res;
  }

  /* Extracts the gradient from a multidual number. */
  proc gradient(x: multidual) {return dualPart(x);}
  
  /*
  Evaluates the jacobian of ``f`` at ``x``.

  :arg f: Function, note that this must be a concrete function. 
  :type f: Function

  :arg x: point at which the jacobian is evaluated
  :type x: [ ] real

  :returns: value of :math:`J_f`
  :rtype: [Dout, Din] real

  Note that `f` must be a concrete function, if it's written as a generic function, you can pass ``jacobian`` a lambda as follows

  .. code-block:: chapel

    proc F(x) {
        return [x[0] ** 2 + x[1] + 1, x[0] + x[1] ** 2 + x[0] * x[1]];
    }

    type D = [0..#2] multidual; // domain for the lambda function

    var Jf = jacobian(lambda(x : D){return F(x);}, [1.0, 2.0]);

    writeln(Jf, "\n");
    //outputs
    //2.0 1.0
    //3.0 5.0
  */
  proc jacobian(f, x : [?D]) {
    var valjac = f(initdual(x));
    var jac : [valjac.domain.dim(0), D.dim(0)] real;
    jac = dualPart(valjac);
    return jac;
  }

  /* Extracts the Jacobian from an array of multidual numbers. */
  proc jacobian(x: [?D] multidual) { return dualPart(x);}

  /* Extracts the function value.

  :arg x: result of computations using dual numbers.
  :type x: dual, multidual or [] multidual.
  */
  proc value(x) {return primalPart(x);}

  proc directionalDerivative(x: dual) {
    return dualPart(x);
  }

  proc jvp(x: [] dual) {
    return [xi in x] dualPart(xi);
  }
}
