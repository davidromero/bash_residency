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

check_aws_config(){
  aws configure list | grep 'access_key\|region' | awk '{ print " " $1 ": " $2 }'
}


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
    printf ''
  else
    echo 'Routine for this OS is not implemented (yet)'
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

	if ![[ command -v $1 &> /dev/null -eq 0 || alias $1 &>/dev/null -eq 0 ]]; then
		echo -e $RED_COLOR 'Error: '$1' is not installed.'
	else
		case $1 in 					# unique checker, multiple launch, just add HERE future
			idea)
				echo -e $GREEN_COLOR 'Launching idea\n'
				/home/david/Documents/idea-IC-201.8538.31/bin/idea.sh &
				;;
			firefox)
				echo -e $GREEN_COLOR 'Launching firefox\n'
				firefox mail.google.com trello.com dev.to linuxacademy.com news.ycombinator.com docs.aws.amazon.com &
				;;
			calibre)
				echo -e $GREEN_COLOR 'Launching calibre\n'
				calibre &
				;;
			aws)
				check_aws_config
                		;;
            		pycharm)
                		/home/david/Documents/pycharm-community-2020.1.3/bin/pycharm.sh &
                		;;
			*)
				echo -e $RED_COLOR 'ERROR - not able to launch'$1
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

print_del_lin_nc(){   # print del line No Color 
  echo $LINE_DEL
}

log_() {
	echo -e $CYAN_COLOR 'ID {$HOSTNAME}' >> launch.log
	printf $RED_COLOR >> launch.log
	my_date=$(date +"%H-%M-%S.%d/%m/%Y")
	printf "$my_date " >> launch.log
	uname -noi >> launch.log
}

# This (.sh) MUST be the main entry point if for some reason something is already running it should check it, before trying to run

echo 'Welcome ' $HOSTNAME # no color till arch check

check_weather

print_del_lin_nc
check_corona_cases
print_del_lin_nc

check_arch

log_

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

echo -e $WHITE_COLOR 'Starting pycharm'
start_process pycharm # TODO: resolve the weird alias quick-fix not hardcoded .sh file
print_del_lin

echo -e $WHITE_COLOR 'Starting Web Browser'
check_is_running firefox
print_del_lin

echo -e $WHITE_COLOR 'Starting BookShelf'
check_is_running calibre
print_del_lin

echo -e $WHITE_COLOR 'Cheking AWS-CLI config'
start_process aws
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

