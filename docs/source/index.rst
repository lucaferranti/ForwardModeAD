ForwardModeAD
=============

**NOTE**: project at early stages, everything can change overnight!

`ForwardModeAD <https://github.com/lucaferranti/ForwardModeAD>`_ is a lightweight library for forward-mode automatic differentiation using dual numbers and functions overloading.
It can compute the derivative, gradient and jacobian of any function, as long as it is written as a combination of :ref:`overloaded functions <overloaded>`.

As a showcase, in a few lines we can implement the Newton method for root finding.

.. code-block:: chapel

   use ForwardModeAD;

   proc f(x) {
      return exp(-x) * sin(x) - log(x);
   }

   var tol = 1e-6, // tolerance to find the root
      cnt = 0, // to count number of iterations
      x0 = initdual(0.5), // initial guess
      valder = f(initdual(x0)); // initial function value and derivative

   while abs(value(valder)) > tol {
      x0 -= value(valder) / derivative(valder);
      valder = f(x0);
      cnt += 1;
      writeln("Iteration ", cnt, " x = ", value(x0), " residual = ", value(valder));
   }

To get started with the package, check out the :ref:`tutorial`. If you want to learn about solving real-world problems, check out the :ref:`applications` section.
To read about the theory behind the package, check the :ref:`background` section. A detailed reference of the functionalities of the package can be found in the :ref:`API docs <api>` section.

Contributing
************

If you encounter bugs or have feature requests, feel free to `open an issue <https://github.com/lucaferranti/ForwardModeAD/issues/new>`_.
Pull requests are also welcome. More details in the :ref:`contributing guidelines <contributing>`.

License
*******

MIT (c) Luca Ferranti

Contents
********

.. toctree::
   :maxdepth: 2

   self
   Quickstart Tutorial <tutorial>
   Applications <applications/index>
   Background <background/index>
   API <api/index>
   contributing
   references
