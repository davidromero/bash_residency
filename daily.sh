#!/bin/bash

#Daily Routine

LINE_DEL="-----------------------------------------"

echo "Daily Starting Process"
echo $LINE_DEL

echo "Starting IDEA"
# idea &
# sleep 45s
echo $LINE_DEL

echo "Staring Web Browser"
# firefox mail.google.com github.com twitter.com
echo $LINE_DEL

echo "Starting BookStore"
# calibre &
echo $LINE_DEL

echo "**** Checking Website Health Status  ****"

curl -s --HEAD dromero.xyz | grep -q "200"
health_status=$?

if [[ health_status -eq 0 ]]; then
	echo -e '\E[0;32m ....  GOOD ....'
else
	echo -e '\E[0;31m ....  BAD ....'
fi
echo $LINE_DEL

echo "Starting SubRoutines"
# TODO other subroutines
#gnome-terminal

