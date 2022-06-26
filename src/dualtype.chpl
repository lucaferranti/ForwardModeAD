module dualtype {  

  /*
  A dual number is a number in the form :math:`a + b\epsilon`, for which :math:`\epsilon^2 = 0`.
  Via the algebra induced by this definition one can show that :math:`f(a + b\epsilon) = f(a) + bf'(a)\epsilon`
  and hence dual numbers can be used for forward mode automatic differentiation by operators overloading.
  */
  record DualNumber {

    /* primal part of the dual number */
    var value : real;
    
    /* dual part of the dual number */
    var derivative : real;
  }

  /* A multidual number is a number if the form :math:`a + \sum_{i=1}^nb_i\epsilon_i`,
     for which it holds :math:`\epsilon_i^2=0` and :math:`\epsilon_i\epsilon_j=0` for any indices :math:`i, j`. */
  record MultiDual {
    
    /* domain for the array of dual parts*/
    var dom: domain(1);

    /* primal part */
    var value: real;

    /* dual parts */
    var derivative: [dom] real;

  }

  /* Converts a pair of real numbers to dual number */
  proc todual(val : real, der : real) {return new DualNumber(val, der);}

  /* Converts a real number and array of reals to a multidual number. */
  proc todual(val : real, grad : [?D]) {return new MultiDual(D, val, [g in grad] g : real);}

  pragma "no doc"
  proc isDualType(type t : DualNumber) param {return true;}

  pragma "no doc"
  proc isDualType(type t : MultiDual) param {return true;}
  
  /* Returns ``true`` if ``t`` is ``DualNumber`` or ``MultiDual``. */
  proc isDualType(type t) param {return false;}
  
  /* Returns ``true`` if either ``t`` or ``s`` is a dual type (``DualNumber`` or ``MultiDual``). */
  proc isEitherDualNumberType(type t, type s) param {return isDualType(t) || isDualType(s);}

  /*
  For dual numbers, it returns the primal part. For real numbers, it returns the number itself.
  */
  proc prim(a) where isDualType(a.type) {return a.value;}

  /*
  For dual numbers, it returns the dual part, for real numbers it returns zero.
  */
  proc dual(a) where isDualType(a.type) {return a.derivative;}
  
  proc dual(a : [?Dout] MultiDual, Din : domain(1) = a(0).dom) {
    var res : [Dout.dim(0), Din.dim(0)] real;
    [i in Dout] res(i, Din) = dual(a(i));
    return res;
  }

  pragma "no doc"
  proc prim(a) {return a;}
  
  pragma "no doc"
  proc dual(a) {return 0.0;}

  proc isclose(a, b, rtol=1e-5, atol=0.0) where isEitherDualNumberType(a.type, b.type) {
      return isclose(prim(a), prim(b), rtol=rtol, atol=atol) && isclose(dual(a), dual(b), rtol=rtol, atol=atol);
  }
}