tooling-central (WIP)
=====================

This repository will be used to mandate core requirements for all new Solus
tooling projects, and aspects that existing tools should then adapt to in due
course.


Test Driven Development
^^^^^^^^^^^^^^^^^^^^^^^

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

Languages
^^^^^^^^^

The preferred tooling language for Solus is Go. However for those providing
a public API/ABI, it may be deemed suitable to use C. Likewise, some legacy
projects continue to use Python due to some artificial constraint, such as
the package manager still being Python.
