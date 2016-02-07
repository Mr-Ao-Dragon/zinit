#!/bin/zsh

#
# Do some setup
# Script can be run from arbitrary directory under zplugin/ tree
#

setopt KSH_ARRAYS
source "`pwd`/${0:h}/tinclude.zsh" "$0" || exit 1

#
# Start Dtrace
#

---start
zplugin dtrace

###
### Test body
###

MY_VAR="test variable"
MY_VAR2="test variable"
zplugin snippet -f test/a::test::plugin.zsh
my_f() { echo "Hello"; }
fpath+=( /a/b/c )

#
# Stop Dtrace
#

zplugin dstop
---stop

###
### Gather and compare results
###

zplugin dreport > "$___TEST_REPORT_FILE" 2>&1
zplugin dunload > "$___TEST_UNLOAD_FILE" 2>&1

---compare
---end
