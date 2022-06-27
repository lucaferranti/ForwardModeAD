.. default-domain:: chpl

.. module:: ForwardModeAD

Dual Types
==========

.. record:: DualNumber

   
   A dual number is a number in the form :math:`a + b\epsilon`, for which :math:`\epsilon^2 = 0`.
   Via the algebra induced by this definition one can show that :math:`f(a + b\epsilon) = f(a) + bf'(a)\epsilon`
   and hence dual numbers can be used for forward mode automatic differentiation by operators overloading.
   


   .. attribute:: var value: real

      primal part of the dual number 

   .. attribute:: var derivative: real

      dual part of the dual number 

.. record:: MultiDual

   A multidual number is a number if the form :math:`a + \sum_{i=1}^nb_i\epsilon_i`,
   for which it holds :math:`\epsilon_i^2=0` and :math:`\epsilon_i\epsilon_j=0` for any indices :math:`i, j`. 


   .. attribute:: var dom: domain(1)

      domain for the array of dual parts

   .. attribute:: var value: real

      primal part 

   .. attribute:: var derivative: [dom] real

      dual parts 
      

.. function:: proc todual(val: real, der: real)

   Converts a pair of real numbers to dual number 

.. function:: proc todual(val: real, grad: [?D])

   Converts a real number and array of reals to a multidual number. 

.. function:: proc isDualType(type t) param

   Returns ``true`` if ``t`` is ``DualNumber`` or ``MultiDual``. 

.. function:: proc isEitherDualNumberType(type t, type s) param

   Returns ``true`` if either ``t`` or ``s`` is a dual type (``DualNumber`` or ``MultiDual``). 

.. function:: proc prim(a)

   
   For dual numbers, it returns the primal part. For real numbers, it returns the number itself.
   

.. function:: proc dual(a)

   
   For dual numbers, it returns the dual part, for real numbers it returns zero.