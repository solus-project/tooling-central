PROJECT_ROOT := src/
VERSION = 0.0.1
PROJECT_NAME = dummyproject

.DEFAULT_GOAL := all

# The resulting binaries map to the subproject names
BINARIES = \
	dummyproject

# Run tests for the following packages
GO_TESTS = \
	dummyproject.test

include Makefile.gobuild

# All pkgs which are in the tree that will need to run through
# the compliance check.
_PKGS = \
	dummyproject

# We want to add compliance for all built binaries
_CHECK_COMPLIANCE = $(addsuffix .compliant,$(_PKGS))

# Build all binaries now
BINS = $(addsuffix .build,$(BINARIES))

# Ensure our own code is compliant..
compliant: $(_CHECK_COMPLIANCE)

# Install binaries
install: $(BINS)
	test -d $(DESTDIR)/usr/bin || install -D -d -m 00755 $(DESTDIR)/usr/bin; \
	install -m 00755 bin/* $(DESTDIR)/usr/bin/.;

# Ensure any src/vendor git submodules are present
ensure_modules:
	@ ( \
		git submodule init; \
		git submodule update; \
	);

# See: https://github.com/meitar/git-archive-all.sh/blob/master/git-archive-all.sh
# Create a new complete tarball
release: ensure_modules
	git-archive-all.sh --format tar.gz --prefix $(PROJECT_NAME)-$(VERSION)/ --verbose -t HEAD $(PROJECT_NAME)-$(VERSION).tar.gz

all: $(BINS)
