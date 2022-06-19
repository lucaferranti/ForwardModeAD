Computing derivatives
================================================

The derivative of univariate functions can be computed with the ``derivative`` function. For example suppose we have the function

.. code-block:: chapel

    proc f(x) {
        return x ** 2 + 2 * x + 1;
    end

The derivative at a given point, e.g. ``1.0`` can be evaluated as

.. code-block:: chapel

   var y = derivative(lambda(x : DualNumber){return f(x);}, 1.0);
   writeln(y);
   // outputs 4

Note that in Chapel only concrete functions can be passed as arguments to other function. To compute the derivative, you need to evaluate the function over dual numbers, but in
your application you probably want to evaluate your function over real numbers. Hence, you probably want to have your function as generic (as ``f`` above). To be able to pass it to
``derivative``, we wrap the function with a concrete lambda function, that takes a ``DualNumber`` as input.