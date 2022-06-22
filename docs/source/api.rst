.. default-domain:: chpl

.. module:: ForwardModeAD
   :synopsis: API Documentation

API Documentation
=================

Dual Numbers
************

.. record:: DualNumber

   
   A dual number is a number in the form :math:`a + b\epsilon`, for which :math:`\epsilon^2 = 0`.
   Via the algebra induced by this definition one can show that :math:`f(a + b\epsilon) = f(a) + bf'(a)\epsilon`
   and hence dual numbers can be used for forward mode automatic differentiation by operators overloading.
   


   .. attribute:: var prim: real

      primal part of the dual number 

   .. attribute:: var dual: real

      dual part of the dual number 

.. record:: MultiDual

   A multidual number is a number if the form :math:`a + \sum_{i=1}^nb_i\epsilon_i`,
   for which it holds :math:`\epsilon_i^2=0` and :math:`\epsilon_i\epsilon_j=0` for any indices :math:`i, j`. 


   .. attribute:: var dom: domain(1)

      domain for the array of dual parts

   .. attribute:: var prim: real

      primal part 

   .. attribute:: var dual: [dom] real

      dual parts 

   .. method:: proc init(val: real, grad: [?dom])

      
      constructor to create the multidual number from the primal part and array of dual parts, automatically inferring the domain.
      

.. function:: proc todual(val: real, der: real)

   Converts a pair of real numbers to dual number 

.. function:: proc todual(val: real, grad: [?D] real)

   Converts a real number and array of reals to a multidual number. 

.. function:: proc prim(a)

   
   For dual numbers, it returns the primal part. For real numbers, it returns the number itself.
   

.. function:: proc dual(a)

   
   For dual numbers, it returns the dual part, for real numbers it returns zero.
   

Differentiation
***************

.. function:: proc derivative(f, x: real)

   
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
   

