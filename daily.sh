#!/bin/bash

# Daily Routine

LINE_DEL='-----------------------------------------'
ESPACES='                    '

# Color for Output -e flag
WHITE_COLOR='\E[1;37m'
BLUE_COLOR='\E[0;34m'
GREEN_COLOR='\E[0;32m'
ORANGE_COLOR='\E[0;33m'
RED_COLOR='\E[0;31m'
CYAN_COLOR='\E[0;36m'
PURPLE_COLOR='\E[0;35m'

# This (.sh) MUST be the main entry point if for some reason something is already running it should check it, before trying to run

check_weather(){
  # based on localtion just print minimal weather option
  printf ' '
  curl wttr.in/?0q 
}

check_corona_cases(){
  curl -s https://corona-stats.online/GT?minimal=true | head -n 3 | awk '{ print $2 $3 "     "$5 " "$6 "    " $7 " " $8 $9 "   " $10 $11  }'
  #echo 'are we f#!^ up?'
}

check_arch(){
  uname -s | grep -q "Linux"
  ARCH=$?

  if [[ ARCH -eq 0 ]]; then
    echo ''
  else
    echo 'Routine for this OS is not implemented (yet)' # Colors not supported
    exit
  fi
}

check_is_running(){
	if [[ -z $(pgrep $1) ]]; then				# check if return value is ZERO
		start_process $1				# Starting sequence
	else
		echo -e $ORANGE_COLOR $1 'is already running'   # Ops,  already running
	fi
}

start_process(){

	if ! [ -x "$(command -v $1)" ]; then
		echo -e $RED_COLOR 'Error: '$1' is not installed.'
	else
		case $1 in 					# unique checker, multiple launch, just add HERE future
			idea)
				echo -e $GREEN_COLOR 'Launching idea\n'
				idea &
				sleep 45s
				;;
			firefox)
				echo -e $GREEN_COLOR 'Launching firefox\n'
				firefox mail.google.com &
				;;
			calibre)
				echo -e $GREEN_COLOR 'Launching calibre\n'
				calibre &
				;;
			*)
				echo -e $RED_COLOR 'ERROR - no able to launch'$1
				;;
		esac
	fi
}

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

log_() {
	echo -e $CYAN_COLOR 'ID {$HOSTNAME}' >> launch.log
	printf $RED_COLOR >> launch.log
	my_date=$(date +"%H-%M-%S.%d/%m/%Y")
	printf "$my_date " >> launch.log
	uname -noi >> launch.log
}

echo 'Welcome ' $HOSTNAME # no color till arch check
check_weather

print_del_lin
check_corona_cases
print_del_lin

check_arch

_log

echo -e $WHITE_COLOR '~~~~ Checking Website Health Status  ~~~~'

echo -e $CYAN_COLOR"$ESPACES"'Personal'
check_health_status dromero.xyz

echo -e $CYAN_COLOR"$ESPACES"'Raspberry'
check_health_status raspberry.dromero.xyz

echo -e $WHITE_COLOR 'Daily Starting Process'
print_del_lin

echo -e $WHITE_COLOR 'Starting IDEA'
check_is_running idea
print_del_lin

echo -e $WHITE_COLOR 'Starting Web Browser'
check_is_running firefox
print_del_lin

echo -e $WHITE_COLOR 'Starting BookShelf'
check_is_running calibre
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

