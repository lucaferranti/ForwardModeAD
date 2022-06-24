.. _contributing:

Contributing
============

Thank you a lot for the interest!

If you encounter bugs or have feature requests or just comments / feedback, do not hesitate to [open an issue](https://github.com/lucaferranti/ForwardModeAD/issues/new)

Pull requests fixing bugs, improving docs or adding features are also welcome! For bigger changes, it is recommendable to open an issue first to discuss.

Git workflow
************

1. Fork the repository and clone your fork

2. Add the original repository as remote
   
   .. code-block:: bash
   
      git remote add upstream https://github.com/lucaferranti/ForwardModeAD.git
   
3. **Changes should always go via branches, never directly commit to main**. First create a new branch, you can name the new branch as you prefer, but it's good practice to start the name with your initials and a short descriptive name. For example if my name is John Doe and I want to fix a bug in the gradient compuation I would 
   
   .. code-block:: bash
   
      git switch -c branchname

4. Do the changes you want to do. You can run the tests locally with ``mason test``.

5. If you have added new files, add them with ``git add filename``. Then commit your changed files with ``git commit -a -m "commit message"``. The commit message should be short but descriptive

6. Push to the new branch with ``git push -u origin branchname``. This will set the remote branch, so next time you push to the same branch you can just do ``git push``

7. Go to [the main repo](https://github.com/lucaferranti/ForwardModeAD) and open a PR

Coding guidelines
*****************

COMING SOON!

Documentation guidelines
************************

COMING SOON!