Dual Numbers
============

A dual number is a number in the form :math:`a + b \epsilon`, where :math:`a, b\in\mathbb{R}` and :math:`\epsilon` is the
`dual unit` (or `infinitesimal`), which has the property :math:`\epsilon^2=0`. In this tutorial, we will review the theory of dual number, define their algebra
and discuss why dual numbers are useful for automatic differentiation.

Arithmetic operations
*********************

Let us consider two dual numbers :math:`F=f+f'\epsilon` and :math:`G=g+g'\epsilon` (the choice for this notation will become clear in a moment). First, addition and subtraction
on dual numbers can be written as

.. math::

   (f+f'\epsilon) + (g+g'\epsilon) = (f+g)+(f'+g')\epsilon

.. math::
  
   (f+f'\epsilon) - (g+g'\epsilon) = (f+g)+(f'-g')\epsilon

For multiplication and division, recalling :math:`\epsilon^2=0` we have

.. math::
 
   (f+f'\epsilon)(g+g'\epsilon) = fg+f'g\epsilon+fg'\epsilon+\underbrace{f'g'\epsilon^2}_{=0}=fg+(f'g+fg')\epsilon

.. math::

   \frac{f+f'\epsilon}{g+g'\epsilon}=\frac{(f+f'\epsilon)(g-g'\epsilon)}{(g+g'\epsilon)(g-g'\epsilon)}=\frac{fg+(f'g-fg')\epsilon}{g^2}=\frac{f}{g}+\frac{f'g-fg'}{g^2}\epsilon

If you observe the expressions for the dual part, you may notice they are the formulae for the derivative of addition, subtraction, multiplication and division of functions. 

Finally, using the rule for multiplication and the induction principle, we can show that 

.. math::
    
    (f+f'\epsilon)^n=f^n+nf^{n-1}f'\epsilon

again, we can see how the dual part corresponds to the derivation rule for the power :math:`nf^{n-1}`, multiplied by the derivative of the inner function :math:`f'`, as expected
by the `chain rule <https://en.wikipedia.org/wiki/Chain_rule>`_. 

Polynomials
***********

Let us start by considering a polynomial :math:`P(x)=\sum_{i=0}^nc_ix^i`. Let us see what happens when this polynomial is evaluated at the dual number :math:`a+\epsilon`.

.. math::
    \begin{align}
    P(a+\epsilon)&=\sum_{i=0}^nc_i(a+\epsilon)^i=c_0+\sum_{i=1}^nc_i(a^i+ia^{i-1}\epsilon)\\&=c_0+\sum_{i=1}^nc_ia^i+\epsilon\sum_{i=1}^nic_ia^{i-1}\\&=P(a)+P'(a)\epsilon
    \end{align}

Hence when computing :math:`P(a+\epsilon)`, the primal part will be the value of the polynomial at :math:`a` and the dual part the value of the derivative.

The same calculations can be repeated for the more generic case :math:`P(f+f'\epsilon)` leading to

.. math::

    P(f+f'\epsilon)=P(f)+P(f)f'\epsilon

hence the primal part is the composition of functions and the dual part is the derivative of the composition, computed as expected by the chain rule.

Elementary Functions
********************

So far we have seen how evaluating a polynomial over a dual number can be used to compute the derivative of the polynomial. What about an arbitrary elementary function :math:`f`?
If it is infinitely many times differentiable over its domain, then it has a Taylor series around :math:`a`

.. math::

    f(a+h) = \sum_{i=0}^\infty\frac{f^{(i)}(x)h^i}{i!},

where :math:`f^{(i)}` is the ith derivative of :math:`f`. 
Now replacing :math:`h` by the dual unit :math:`\epsilon` and recalling that :math:`\epsilon^2=0` (and hence also all the higher powers) we get

.. math::
    f(a+\epsilon) = \sum_{i=0}^\infty\frac{f^{(i)}(x)\epsilon^i}{i!}=f(a)+f'(a)\epsilon

that is, the dual part is the derivative of the function. Considering the more generic case we get

.. math::
    f(g+g'\epsilon) = \sum_{i=0}^\infty\frac{f^{(i)}(g)g'^i\epsilon^i}{i!}=f(g)+f'(g)g'\epsilon

and hence the primal part is the composition of the functions and the dual part the derivative of the composition by the chain rule.

We have those shown that the algebra of dual numbers is the algebra of derivatives. Given a function :math:`f`, its derivative at :math:`a` can be extracted from the dual part of
:math:`f(a+\epsilon)`.

This can be easily implementing in a programming language via function (and operator) overloading. First, define a type ``dual`` and overload arithmetic operations as described here
and elementary functions using the derivation rules. If the function is written as a composition of the available overloaded elementary functions, 
the derivative can be computed automatically using dual numbers. This is exactly what is done in ``ForwardModeAD``. 