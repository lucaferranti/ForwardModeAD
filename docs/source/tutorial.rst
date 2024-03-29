.. _tutorial:

Quickstart Tutorial
===================

This tutorial will guide you through the basic functionalities of ``ForwardModeAD``.
The library allows to compute derivatives of functions using forward mode `automatic differentiation <https://en.wikipedia.org/wiki/Automatic_differentiation>`_.
Particularly, it achieves this by implementing `dual numbers <https://en.wikipedia.org/wiki/Dual_number>`_ and overloading arithmetic operations and elementary functions for them.

Setup
*****

Using Mason
~~~~~~~~~~~

If you are writing you application with Mason, all you have to do is run

.. code-block::

    mason add ForwardModeAD

to add the library as dependency.

To use the library you will need to import it with

.. code-block:: chapel

    use ForwardModeAD;

and you are ready to go.

Installing manually
~~~~~~~~~~~~~~~~~~~

First, `clone the repository <https://github.com/lucaferranti/ForwardModeAD>`_.

You can use the library in your chapel code with

.. code-block:: chapel

    use ForwardModeAD;

Finally, compile your code as

.. code-block::

    chpl mycode.chpl -M $prefix/ForwardModeAD/src/

where ``prefix`` is the path where you cloned the repository in.


Derivatives in one dimension
****************************

Suppose we have a function

.. code-block:: chapel

    proc f(x) {
        return x**2 + 2*x + 1;
    }

And we want to evaluate the function at a point :math:`x_0=0`. We can convert the point to the appropriate dual number using the ``initdual`` function and evaluate ``f``
at the resulting dual number.

.. code-block:: chapel

    var valder = f(initdual(0.0));

The resulting variable ``valder`` is an object of type ``dual`` and the function value and derivative can be accessed with the functions ``value``
and ``derivative``, respectively.

.. code-block:: chapel

    writeln(value(valder)); // value of f(0)
    writeln(derivative(valder)) // value of f'(0)

.. code-block::

    1.0
    2.0

Alternatively, you can pass to ``derivative`` a function and value (the point where to evaluate the derivative) directly.
It is important to notice that the function passed to ``derivative`` must be a concrete function (type signature specified) that takes as input a ``dual``. If your function is generic (as in the example above), you can
achieve this passing a lambda function, as the example below demonstrates.

.. code-block:: chapel

    var dfx0 = derivative(proc(x : dual) {return f(x);}, 0.0);
    writeln(dfx0);

.. code-block::

    2.0

Computing the gradient
**********************

The gradient of a multivariate function :math:`f : \mathbb{R}^n \rightarrow \mathbb{R}`, can be computed the same way of the derivative using ``initdual``.
The only difference is that the input is now initialized to an array of ``multidual`` and the gradient is extracted using ``gradient``.
In the following example, we compute the gradient of :math:`h(x, y) = x^2 + 3xy+1` at the point :math:`(1, 2)`. Note in the implementation below that
**the function should accept a single array as input**.

.. code-block:: chapel

    proc h(x) {
        return x[0] ** 2 + 3 * x[0] * x[1];
    }

    var valgrad = h(initdual([1.0, 2.0]));
    writeln(value(valgrad) // prints the value of h(1.0, 2.0)
    writeln(gradient(valgrad)) // prints the value of ∇h(1.0, 2.0)

.. code-block::

    7.0
    8.0 3.0

Similarly to the previous example, ``gradient`` can also take a function as input.
In this case, you will need to first specify the domain as a type alias.
If your function has :math:`n` variables, then this can be achieved with the line

.. code-block:: chapel

    type D = [0..#2] multidual

Next, we can compute the gradient similarly to before

.. code-block:: chapel

    var dh = gradient(proc(x : D){return h(x);}, [1.0, 2.0]);
    writeln(dh);

.. code-block::

    8.0 3.0

Computing the Jacobian
**********************

For many-variables manyvalued functions :math:`F:\mathbb{R}^m\rightarrow\mathbb{R}^n` we can compute the Jacobian :math:`J_F`. Both methods described so far still apply.

Using ``initdual`` the strategy is very similar to before, except that now the Jacobian should be extracted using the ``jacobian`` function.


.. code-block:: chapel

   proc F(x) {
    return [x[0] ** 2 + x[1] + 1, x[0] + x[1] ** 2 + x[0] * x[1]];
   }

   var valjac = F(initdual([1.0, 2.0]));
   writeln(value(valjac), "\n");
   writeln(jacobian(valjac));

.. code-block::

    4.0 7.0

    2.0 1.0
    3.0 5.0

Note that the function should take an array an input and return an array as output.

Alternatively, ``jacobian`` can take as input the function and the point and it returns the jacobian at that point.
The same restrictions of ``gradient`` apply:

  - The function should be concrete with input ``[D] multidual``
  - The domain ``[D] multidual`` should be explicitly written as type alias.

Using the example function above

.. code-block:: chapel

    type D = [0..#2] multidual

    var J = jacobian(proc(x : D){return F(x);}, [1.0, 2.0]);
    writeln(J);

.. code-block::

    2.0 1.0
    3.0 5.0

Computing directional derivative and Jacobian-vector product
************************************************************

In some applications, instead of the gradient, one may need to compute the directional derivative, that is, the dot product :math:`\nabla f(\mathbf{x})\cdot \mathbf{v}`, where :math:`\mathbf{v}` is the direction vector.
Instead of computing the gradient and dot product separately, one can directly compute the directional derivative by evaluating :math:`f` over the vector of dual numbers :math:`[x_1+v_1\epsilon,\ldots,x_n+v_n\epsilon]^T` and taking the dual number of the result.

In practice, this is achieved by passing both the point ``x`` and the direction ``v`` to ``initdual``.
The directional derivative can be extracted using ``directionalDerivative``.

.. code-block:: chapel

   proc f(x) {
    return x[0] ** 2 + 3 * x[0] * x[1];
   }

   var dirder = f(initdual([1, 2], [0.5, 2.0]));

   writeln(value(dirder));
   writeln(directionalDerivative(dirder));

.. code-block::

   7.0
   10.0

Similarly, for many-valued functions, one may compute the Jacobian-vector product (VJP) :math:`J_F\mathbf{v}` directly using the same strategy. The JVP can be extracted using the ``jvp`` function.

.. code-block:: chapel

  proc F(x) {
    return [x[0] ** 2 + x[1] + 1, x[0] + x[1] ** 2 + x[0] * x[1]];
  }

  var valjvp = F(initdual([1, 2], [0.5, 2.0]));

  writeln(value(valjvp), "\n");
  writeln(jvp(valjvp));

.. code-block::

   4.0 7.0

   3.0 11.5

As for the previous cases, ``directionalDerivative`` and ``jvp`` can also take a function as input.
Similarly to ``gradient`` and ``jacobian``, the function passed cannot be generic and the domain must be written down as a type variable.

.. code-block:: chapel

   type D = [0..#2] dual;

   var dirder = directionalDerivative(proc(x: D) {return f(x);}, [1, 2], [0.5, 2.0]);
       Jv     = jvp(proc(x: D) {return F(x);}, [1, 2], [0.5, 2.0]);

   writeln(dirder, "\n");
   writeln(Jv);

.. code-block::

   10.0

   3.0 11.5


