.. default-domain:: chpl

.. module:: ForwardModeAD

Functions for differentiation
=============================

.. function:: proc initdual(x: real)


   Initializes the input to the appropriate dual number to evalute the derivative.

   :arg x: point where to evaluate the derivative
   :type x: real or [dom] real

   :returns:    If ``x`` is a real number, then it is initialized to :math:`x+\epsilon`. If ``x`` is a vector of reals, it is initialized to the vector of multiduals :math:`\begin{bmatrix}x_1+\epsilon_1\\\vdots\\x_n+\epsilon_n\end{bmatrix}`.
   :rtype: ``dual`` if ``x`` is ``real`` or ``[dom] multidual`` if ``x`` is ``[dom] real``.

.. function:: proc initdual(x: [?D] ?t, v: [D] ?s)


   Given a vector ``x`` and a vector ``v``, creates a vector of duals :math:`[x_i + \epsilon v_i]`.
   Used to compute directional derivative and Jacobian-vector product (JVP).

   :arg x: point where to evaluate the directional derivative / JVP
   :type x: [D] real

   :arg v: direction
   :type v: [D] real

   :returns: Vector of dual numbers
   :rtype: [D] dual

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
      
     var dfx = derivative(lambda(x : dual){return f(x);}, 1.0);
     //outputs
     //4.0
   

.. function:: proc derivative(x: dual)

   Extracts the derivative from a dual number.

.. function:: proc gradient(f, x: [?D] real)

   
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
   

.. function:: proc gradient(x: multidual)

   Extracts the gradient from a multidual number. 

.. function:: proc jacobian(f, x: [?D])

   
   Evaluates the jacobian of ``f`` at ``x``.
   
   :arg f: Function, note that this must be a concrete function. 
   :type f: Function
   
   :arg x: point at which the jacobian is evaluated
   :type x: [ ] real
   
   :returns: value of :math:`J_f`
   :rtype: [Dout, Din] real
   
   Note that ``f`` must be a concrete function, if it's written as a generic function, you can pass ``jacobian`` a lambda as follows
   
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
   

.. function:: proc jacobian(x: [?D] multidual)

   Extracts the Jacobian from an array of multidual numbers. 

.. function:: proc value(x)

   Extracts the function value.

   :arg x: result of computations using dual numbers.
   :type x: dual, multidual or [] multidual.

.. function:: proc directionalDerivative(x: dual)

   Extracts the directional derivative from a dual number.

.. function:: proc directionalDerivative(f, x: [?D], v: [D])

   Computes the directional derivative of ``f`` at ``x`` in the direction of ``v``.

.. function:: proc jvp(x: [] dual)

   Extracts the Jacobian-vector product from a vector of dual numbers.

.. function:: proc jvp(f, x: [?D], v: [D])

   Computes the Jacobian-vector product of the Jacobian of ``f`` at ``x`` and vector ``v``.