#!/bin/bash
set -e

# This script will forcibly rewrite all .c & .h files in place to comply with
# the .clang-format file.
clang-format -i $(find . -name '*.[ch]')

# Check we have no typos.
which misspell 2>/dev/null >/dev/null
if [[ $? -eq 0 ]]; then
    misspell -error `find . -name '*.[ch]'`
fi
