tooling-central (WIP)
=====================

This repository will be used to mandate core requirements for all new Solus
tooling projects, and aspects that existing tools should then adapt to in due
course.


Test Driven Development
^^^^^^^^^^^^^^^^^^^^^^^

All new tools should follow a Test Driven Development (TDD) approach, to ensure
that at every stage of the project each new function and behaviour is acting as
one would expect.

When using Go, ensure to use the standard Solus ``Makefile.gobuild`` mechanism
and ensure the ``make check`` target is available. For C you should try to ensure
that a check target is also available, leveraging the ``check`` (``check-devel``)
framework where possible.

Ideally you should strive for a **high code coverage rate** (75%+). Additionally, the
GitHub project should be integrated with a Continuous Integration service if it
provides a test suite, i.e. Travis + Coveralls.io.

Standards
^^^^^^^^^

Code hygiene is very important! Make sure you pick and stick to a coding style.
When using Go, make sure to use the Solus ``Makefile.gobuild`` target and that
your entire project passes ``make compliant``. For Python projects, you should
ensure your project is ``pep8`` and ``flake8`` compliant.

For C projects, ensure you make use of a `.clang-format` file and enforce a
fixed style on the codebase. Many Solus projects have example files that you
can use.

Lastly, for Go projects, your GitHub project should be integrated with the Go
Report Card, and have an A+ rating.

Documentation
^^^^^^^^^^^^^

All binary tools shall provide at minimum:

 * A manual page for the main binary (``man(1)``)
 * A manual page for any configuration formats (``man(5)``)

Any projects providing a public API/ABI should be fully documented internally.
For Golang this should be in the godoc format, and for C projects this should
either be gtk-doc or doxygen.


Licensing
^^^^^^^^^

The preferred license depends on the language in use and other factors, such
as snippets/libraries/linking involved.

Typically, C libraries will be LGPL-2.1, potentially with a Linking Exception
for OpenSSL. C binaries will usually be GPL-2.0 (not GPL-3.0), as can be seen
with the Budgie Desktop.

Where other code is used, or there is little concern for project mixing, it
may be appropriate to use GPL-3.0, such as seen with ypkg, an entirely self
contained Python tool, which is mixed with GPL-3.0 snippet imports.

For Go projects, unless unavoidable, it is preferable for the project to
use the Apache-2.0 license. Consult any library licenses that may inadvertently
relicense the resulting binary when using cgo, i.e. linking to the GPL-3.0
readline.

**DISCLAIMER**: I Am Not A Lawyer, And Likely Neither Are You. Always ensure
you are license compliant when linking or importing!

Languages
^^^^^^^^^

The preferred tooling language for Solus is Go. However for those providing
a public API/ABI, it may be deemed suitable to use C. Likewise, some legacy
projects continue to use Python due to some artificial constraint, such as
the package manager still being Python.
