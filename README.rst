tooling-central
===============

This repository will be used to mandate core requirements for all new Solus
tooling projects, and aspects that existing tools should then adapt to in due
course.


Test Driven Development
^^^^^^^^^^^^^^^^^^^^^^^

All new tools should ideally follow a Test Driven Development (TDD) approach, to
ensure that at every stage of the project each new function and behaviour is acting as
one would expect. This mightn't always be possible or suitable, however it should
be considered when starting a new project. If there are elements to your project
that **can** be tested, then **test them**.

Ideally you should strive for a **high code coverage rate** (75%+). Additionally, the
GitHub project should be integrated with a Continuous Integration service if it
provides a test suite, i.e. Travis + Coveralls.io. Understandably high coverage
isn't always possible, but it should be a goal for testable components.

Standards
^^^^^^^^^

Code hygiene is very important! Make sure you pick and stick to a coding style.
Resources are available in this repository to help you add testing to your
projects, notably ``Makefile.gobuild``

Many of the integration steps make use of `misspell <https://github.com/client9/misspell>`_ to ensure there are no
typos in the codebase.

C
-

For C projects, ensure you make use of a `.clang-format` file and enforce a
fixed style on the codebase. Many Solus projects have example files that you
can use, and an example is included in this repository.

Go
--

While not mandatory, it is recommended to use or base your build around the
provided ``Makefile.gobuild``. This will add some default targets, such as::

    make check
    make compliant

At minimum, you should look to replicate the basic functions of the ``make compliant``
target::

    cd somepkg
    go fmt
    golint
    go vet

Add integration to your ``README`` with the Go Report Card and ensure you're
attaining an A+ rating.

Python
------

Pythonic projects should use ``pep8`` and ``flake8`` to ensure the code is
conformant with specifications and free of obvious errors. Add test suites
if possible to confirm.

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

Please ensure your repository includes a ``LICENSE`` file, and that all source
files clearly indicate both copyright and license choice. Please use **short form**
standard license headers. It is not necessary to include the full terms in a header.

For sample files, tutorials, demos, etc, it is advisable to place them under the
MIT license, to remove constraints from developers who may be reusing your code
in their work.

**DISCLAIMER**: I Am Not A Lawyer, And Likely Neither Are You. Always ensure
you are license compliant when linking or importing!

Languages
^^^^^^^^^

The preferred tooling language for Solus is Go. However for those providing
a public API/ABI, it may be deemed suitable to use C. Likewise, some legacy
projects continue to use Python due to some artificial constraint, such as
the package manager still being Python.

Using Git
^^^^^^^^^

Always try to remember that your git commits may serve as documentation to
others, and indeed, even yourself, later down the road. Two years later you
may find yourself bisecting a change and having not a clue why you made that
change, or what regressions it may cause by altering it.

Give a very brief summary in the first line of your commit message, as a very
very high level overview of what this change is achieving. Then write another
paragraph (doesn't need to be a story) describing the rationale and results
of the change itself.

Also remember that the vast majority of git users will be viewing your changes
on the terminal, so please respect the 80x24 rules! Try not to wrap your lines,
rather, manually line break them. Your first line should ideally be no longer
than 60 characters, and each line in the next paragraph shouldn't exceed 70.
This will ensure the message is readable on all terminals, without enforced
line wrapping.


Here is an example of a good commit message::

    postinstall: Remove all GRUB_BACKGROUND handling
    
    We now no longer utilise a default background for GRUB in Solus, purely
    because its very tacky and hard to get the image placement correct on a
    multitude of resolutions. Thus we simplify the GRUB code and let CBM
    handle all the heavy lifting.
    
    Signed-off-by: Ikey Doherty <ikey@solus-project.com>


An atrocious commit message::

    Another quick fix..
    
    Signed-off-by: Ikey Doherty <ikey@solus-project.com>

It is terrible because it hasn't explained anything that has changed, nor the
rationale.

A badly formatted message::

    This change should fix the styling on the GtkBox that was present in Gtk 3.12 but was later removed due to CSS class changes upstream as of the last sync.

Try to get out of the habit of using ``git commit -m 'My changes'``, instead make
use of an interactive editor. If you're not comfortable with the default editor,
then switch it to one that is simpler, such as nano (like I do)::

    git config --global core.editor nano

It is advisable to use your public GPG key to sign all commits and tags::

    git config --global commit.gpgsign true
    git config --global user.signingkey YOURKEYID

Signing your changes (signing off and GPG signing) is highly recommended, as it
indeed proves the change was really by you, and not anybody else. It allows you
to own your changes completely, and is a good practice to get into.

Releasing Projects
^^^^^^^^^^^^^^^^^^

Relying on automatically generated tarballs is no longer sufficient. Using autotools,
you should be using ``make distcheck`` to create a proper tarball for your tagged
release, including all required assets/sources. For the Go projects you can use
the provided Makefile, or create your own script to generate tarballs using the
following::

    git submodule init
    git submodule update
    git-archive-all.sh --format tar.gz --prefix ${PROJECT_NAME}-${VERSION}/ --verbose -t HEAD ${PROJECT_NAME)-${VERSION}.tar.gz

You can find ``git-archive-all.sh`` `here <https://github.com/meitar/git-archive-all.sh/blob/master/git-archive-all.sh>`_.

Once your tarball is created, upload it to your GitHub releases page (on the relevant
tag). Now ensure you sign your tarball and upload the accompanying ``.asc`` file to
verify that this tarball is indeed the one that you created::

    gpg --armor --detach-sign solbuild-1.3.1.tar.gz

Please note that when using ``autotools`` or ``meson``, you must bump your version
number PRIOR to tagging, in ``configure.ac`` or ``meson.build`` respectively.
When tagging, ensure to GPG sign it::

    git tag -s v1.3.1
    git push --tags
