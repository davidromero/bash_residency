#!/bin/bash

#Daily Routine

LINE_DEL='-----------------------------------------'

# Color for Output -e flag
WHITE_COLOR='\E[1;37m'
BLUE_COLOR='\E[0;34m'
GREEN_COLOR='\E[0;32m'
YELLOW_COLOR='\E[1;33m'
RED_COLOR='\E[0;31m'
CYAN_COLOR='\E[0;36m'

echo -e $WHITE_COLOR 'Daily Starting Process'
echo -e $BLUE_COLOR $LINE_DEL

echo -e $WHITE_COLOR 'Starting IDEA'
if ! [ -x "$(command -v idea)" ]; then
	echo -e  $RED_COLOR'Error: idea is not installed.'
else
	echo ''
	#idea &
	#sleep 45s
fi

echo -e $BLUE_COLOR $LINE_DEL

echo -e $WHITE_COLOR 'Staring Web Browser'
if ! [ -x "$(command -v firefox)" ]; then
	echo -e $RED_COLOR 'Error: firefox is not installed.'
else
	#firefox mail.google.com github.com twitter.com
	echo -e $CYAN_COLOR 'Launching firefox'
fi

echo -e $BLUE_COLOR $LINE_DEL

echo -e $WHITE_COLOR 'Starting BookStore'
# calibre &
echo -e $BLUE_COLOR $LINE_DEL

echo -e $WHITE_COLOR '**** Checking Website Health Status  ****'

curl -s --HEAD dromero.xyz | grep -q "200"
health_status=$?

if [[ health_status -eq 0 ]]; then
	echo -e $GREEN_COLOR '....  GOOD .... personal'
else
	echo -e $RED_COLOR ' ....  BAD .... personal'
fi

curl -s --HEAD raspberry.dromero.xyz | grep -q "200"
health_status=$?

if [[ health_status -eq 0 ]]; then
	echo -e $GREEN_COLOR '....  GOOD .... raspberry'
else
	echo -e $RED_COLOR '....  BAD .... raspberry'
fi


echo -e $BLUE_COLOR $LINE_DEL

echo -e '\E[0;37m Starting SubRoutines'
# TODO other subroutines
#gnome-terminal

echo -e $WHITE_COLOR 'testing'

