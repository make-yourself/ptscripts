#/bin/bash
git log --all | egrep -e '([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})' | grep 'Author: ' | sed -e 's/Author: //g' | sort -u
