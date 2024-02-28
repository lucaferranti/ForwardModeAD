module dualtype {  

  /*
  A dual number is a number in the form :math:`a + b\epsilon`, for which :math:`\epsilon^2 = 0`.
  Via the algebra induced by this definition one can show that :math:`f(a + b\epsilon) = f(a) + bf'(a)\epsilon`
  and hence dual numbers can be used for forward mode automatic differentiation by operators overloading.
  */
  record dual {

    /* primal part of the dual number */
    var primalPart : real;
    
    /* dual part of the dual number */
    var dualPart : real;
  }

  /* A multidual number is a number if the form :math:`a + \sum_{i=1}^nb_i\epsilon_i`,
     for which it holds :math:`\epsilon_i^2=0` and :math:`\epsilon_i\epsilon_j=0` for any indices :math:`i, j`. */
  record multidual {
    
    /* domain for the array of dual parts*/
    var dom: domain(1);

    /* primal part */
    var primalPart: real;

    /* dual parts */
    var dualPart: [dom] real;

  }

  /* Converts a pair of real numbers to dual number */
  proc todual(val : real, der : real) {return new dual(val, der);}

  /* Converts a real number and array of reals to a multidual number. */
  proc todual(val : real, grad : [?D]) {return new multidual(D, val, [g in grad] g : real);}

  @chpldoc.nodoc
  proc isDualType(type t : dual) param {return true;}

  @chpldoc.nodoc
  proc isDualType(type t : multidual) param {return true;}
  
  /* Returns ``true`` if ``t`` is ``dual`` or ``multidual``. */
  proc isDualType(type t) param {return false;}
  
  /* Returns ``true`` if either ``t`` or ``s`` is a dual type (``dual`` or ``multidual``). */
  proc isEitherDualType(type t, type s) param {return isDualType(t) || isDualType(s);}

  /*
  For dual numbers, it returns the primal part. For real numbers, it returns the number itself.
  */
  proc primalPart(a) where isDualType(a.type) {return a.primalPart;}

  /*
  For dual numbers, it returns the dual part, for real numbers it returns zero.
  */
  proc dualPart(a) where isDualType(a.type) {return a.dualPart;}
  
  proc primalPart(a : [] ?t) where isDualType(t) {return [i in a] primalPart(i);}
  
  proc dualPart(a : [?Dout] multidual, Din : domain(1) = a(0).dom) {
    var res : [Dout.dim(0), Din.dim(0)] real;
    [i in Dout] res(i, Din) = dualPart(a(i));
    return res;
  }

  proc dualPart(a: [] dual) {
    return [ai in a] dualPart(ai);
  }

  @chpldoc.nodoc
  proc primalPart(a) {return a;}
  
  @chpldoc.nodoc
  proc dualPart(a) {return 0.0;}

  proc isclose(a, b, rtol=1e-5, atol=0.0) where isEitherDualType(a.type, b.type) {
      return isclose(primalPart(a), primalPart(b), rtol=rtol, atol=atol) && isclose(dualPart(a), dualPart(b), rtol=rtol, atol=atol);
  }
}
