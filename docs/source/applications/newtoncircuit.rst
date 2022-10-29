Newton method to solve nonlinear circuits
=========================================

In this tutorial we will see how ForwardModeAD can be used to easily implement the `Newton method <https://en.wikipedia.org/wiki/Newton%27s_method>`_ to solve nonlinear equations.
As an application, we will demo how this can be used to solve nonlinear electric circuits.

Newton method
*************

Suppose we want to solve a nonlinear equation :math:`f(x)=0`. The Newton rule is an iterative algorithm that starts with an initial guess of the root :math:`x_0` and uses the
following update rule

.. math::

   x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}.

In general, but with some pathological exceptions, the update rule will converge quadratically to a root of the function.
As we need the derivative of the function, the algorithm is easily implemented with ``ForwardModeAD``.

We also need a stopping criteria for the update rule, here we choose to stop when :math:`|f(x_n)|<tol`. Where :math:`tol` is a chosen tolerance.

Now we have everything we need to implement, the algorithm, let us demo it by finding the root of the function

.. math::
    
    f(x) = e^{-x}\sin(x) - \log(x)

using initial guess :math:`x_0=0.5` and tolerance :math:`10^{-6}`.

.. code-block:: chapel

    use ForwardModeAD;

    proc f(x) {
        return exp(-x) * sin(x) - log(x);
    }

    var tol = 1e-6, // tolerance to find the root
        cnt = 0, // to count number of iterations
        x0 = 0.5, // initial guess
        valder = f(initdual(x0)); // initial function value and derivative

    writeln("Iteration ", cnt, " x = ", x0, " residual = ", valder.value);

    while abs(valder.value) > tol {
        x0 -= valder.value / valder.derivative;
        valder = f(initdual(x0));
        cnt += 1;
        writeln("Iteration ", cnt, " x = ", x0, " residual = ", valder.value);
    }

.. code-block::

    Iteration 0 x = 0.5 residual = 0.983933
    Iteration 1 x = 1.05953 residual = 0.244472
    Iteration 2 x = 1.28662 residual = 0.0131033
    Iteration 3 x = 1.3002 residual = 4.13149e-05
    Iteration 4 x = 1.30025 residual = 4.13897e-10

As you can see, the algorithm quickly converges to :math:`x \approx 1.30025`, which `is the correct root <https://www.wolframalpha.com/input?i=exp%28-x%29*sin%28x%29+-+ln%28x%29+%3D+0>`_.

Nonlinear circuit example
*************************

Solving nonlinear equations is very common in most if not all scientific computing applications.
To make our example more concrete, let us demo how the previous algorithm can be used to analyze the following nolinear circuit, 
using values :math:`R=1~\textrm{k}\Omega` and :math:`E=5~\textrm{V}`.

.. image:: circuit.png

The resistor is modeled via Ohm law :math:`U_R=RI` and the diode via Schockley equation :math:`I=I_S\left(e^\frac{V_D}{V_T}-1\right)`, with :math:`I_S\approx10^{-1}` and :math:`V_T\approx25~\textrm{mV}`.

By Kirchoff voltage law we have

.. math::

    U_R + U_D - E = 0

Subsituting the previous values and equations we get

.. math::
    g(V_D) = 10^{-9}\left(e^{40V_D}-1\right) + V_D - 5 = 0

this can be now solved with our previously developed Newton method

.. code-block:: chapel

    proc g(vd) {
        return 1e-9 * (exp(40 * vd) - 1) + vd - 5;
    }

    var x0 = 0.0,
        valder = g(initdual(x0));

    while abs(valder.value) > tol {
        x0 -= valder.value / valder.derivative;
        valder = g(initdual(x0));
    }

    writeln("x0 = ", x0);

.. code-block::

    x0 = 0.555374

which is indeed a typical voltage value for a diode.

Newton method in higher dimension
*********************************

In the previous example we considered one equation in one unknown. The Newton method can also be applied to the case of :math:`n` equations in :math:`n` unknowns,
that is to solve the nonlinear system of equations :math:`F(X)=\mathbf{0}` with :math:`F:\mathbb{R}^n\rightarrow\mathbb{R}^n`.

The update rule for this higher dimension problem becomes

.. math::

    X_{n+1}=X_n - J_F(X_n)^{-1}F(X_n)

Note that the derivative has now been replaced by the Jacobian. Note also that the quantity :math:`J_F(X_n)^{-1}F(X_n)` can be computed by solving the linear system
:math:`J_F(X_n)Y=F(X_n)`, using the function ``solve`` from the ``LinearAlgebra`` module, no need to explicitly invert the matrix.

Finally, in 1D our stopping criterion was :math:`|x_n|<tol` for some predefined tolerance. In higher dimensions this generalizes to :math:`\Vert X_n\Vert<tol`,
where :math:`\Vert\cdot\Vert` is some vector norm. In this example we choose the classical Euclidean norm, computed with the Chapel ``norm`` function from ``LinearAlgebra``.

We now have all the ingredients to program the higher dimension Newton method, let's do it with the following example

.. math::

    \begin{cases}\log(x)-y+0.5=0\\x^2-xy-0.7=0\end{cases}

using as initial guess :math:`X_0=[3, 3]`.

.. code-block:: chapel

    use LinearAlgebra; // needed for solve and norm

    proc F(x) {
        return [log(x[0]) - x[1] + 0.5, x[0]**2 - x[0]*x[1] - 0.7];
    }

    var cnt = 0, // to count number of iterations
        X0 = [3.0, 3.0], // initial guess
        valjac = F(initdual(X0)), // initial function value and derivative
        res = norm(prim(valjac)); // initial residue residual ||F(X_0)||

    writeln("Iteration ", cnt, " x = ", X0, " residual = ", res);

    while res > tol {
        X0 -= solve(dual(valjac), prim(valjac))
        valjac = F(initdual(X0));
        res = norm(prim(valjac));
        cnt += 1;
        writeln("Iteration ", cnt, " x = ", X0, " residual = ", res);
    }

.. code-block::

    Iteration 0 x = 3.0 3.0 residual = 1.56649
    Iteration 1 x = 1.24792 1.01459 residual = 0.503036
    Iteration 2 x = 1.33736 0.79315 residual = 0.0279132
    Iteration 3 x = 1.3021 0.764332 residual = 0.000420461
    Iteration 4 x = 1.30128 0.763349 residual = 2.39082e-07
