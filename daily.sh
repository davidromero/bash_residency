#!/bin/bash

# Daily Routine

LINE_DEL='-----------------------------------------'
ESPACES='             '

# Color for Output -e flag
WHITE_COLOR='\E[1;37m'
BLUE_COLOR='\E[0;34m'
GREEN_COLOR='\E[0;32m'
YELLOW_COLOR='\E[1;33m'
RED_COLOR='\E[0;31m'
CYAN_COLOR='\E[0;36m'
PURPLE_COLOR='\E[0;35m'

check_health_status() {
	curl -s --HEAD $1 | grep -q "200"
	health_status=$?
	
	if [[ health_status -eq 0 ]]; then
		echo -e $GREEN_COLOR"$ESPACES"'....  GOOD ....'

	else
		echo -e $RED_COLOR"$ESPACES"'....  BAD ....'
	fi
}

print_del_lin(){
	echo -e $BLUE_COLOR $LINE_DEL
}


echo -e $WHITE_COLOR 'Daily Starting Process'
print_del_lin

echo -e $WHITE_COLOR 'Starting IDEA'
if ! [ -x "$(command -v idea)" ]; then
	echo -e  $RED_COLOR'Error: idea is not installed.'
else
	echo -e $CYAN_COLOR 'Launching idea\n'
	#idea &
	#sleep 45s
fi

print_del_lin

echo -e $WHITE_COLOR 'Staring Web Browser'
if ! [ -x "$(command -v firefox)" ]; then
	echo -e $RED_COLOR 'Error: firefox is not installed.'
else
	#firefox mail.google.com github.com twitter.com
	echo -e $CYAN_COLOR 'Launching firefox\n'
fi

print_del_lin

echo -e $WHITE_COLOR 'Starting BookShelf'
if ! [ -x "$(command -v calibre)" ]; then
	echo -e $RED_COLOR 'Error: calibre is not installed.'
else
	echo -e $CYAN_COLOR 'Launching calibre\n'
	#calibre &
fi

print_del_lin

echo -e $WHITE_COLOR '**** Checking Website Health Status  ****'

echo -e $CYAN_COLOR"$ESPACES"'Personal'

check_health_status dromero.xyz

echo -e $CYAN_COLOR"$ESPACES"'Raspberry'

check_health_status raspberry.dromero.xyz

print_del_lin

echo -e $PURPLE_COLOR '>>>> Starting SubRoutines'
# TODO other subroutines
#gnome-terminal

echo -e $CYAN_COLOR 'Conecting DB Server ...\n'
# launch db_server.sh
#  TODO get PID to manting status or check services!!
echo -e $CYAN_COLOR 'Conecting Java Application Server ...\n'
# launch java_app_server.sh

#echo -e $WHITE_COLOR 'testing'

